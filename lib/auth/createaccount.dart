import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vtutemplate/components/navigator.dart';
import 'package:vtutemplate/constants.dart';
import 'package:vtutemplate/model/userdata.dart';
import 'package:vtutemplate/riverpod/riverpod.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscure = true;
  bool _isLoading = false;

  final supabase = Supabase.instance.client;

  Future<void> _createAccount() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        data: {'username': _nameController.text.trim()},
      );

      final user = response.user;

      if (user != null) {
        // Insert into user_profile table
        final insertResponse = await supabase
            .from('user_profile')
            .insert({
              'user_id': user.id,
              'username': _nameController.text.trim(),
              'email': _emailController.text.trim(),
              'password': ''
            })
            .select()
            .single();

        // Convert to UserProfile model
        final userProfile = UserProfile.fromMap(insertResponse);

        // Store in Riverpod
        if (mounted) {
          // if using ConsumerWidget context
          final container = ProviderScope.containerOf(context);
          container.read(userProfileProvider.notifier).setUser(userProfile);
        }

        _showMessage("Account created successfully!");

        // Navigate to home
        Future.delayed(const Duration(milliseconds: 700), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNav(
                appNameColor: CanvasConfig.appNameColor,
                primaryapptheme: CanvasConfig.primaryAppTheme,
                iconthemeColor: CanvasConfig.iconThemeColor,
                selectedBgImagePath: CanvasConfig.selectedBgImagePath,
                bgColor: CanvasConfig.bgColor,
              ),
            ),
          );
        });
      }
    } on AuthException catch (e) {
      print(e);
      _showMessage(e.message);
    } on PostgrestException catch (e) {
      print(e);
      _showMessage("Database error: ${e.message}");
    } catch (e) {
      print(e);
      _showMessage("Unexpected error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CanvasConfig.bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: CanvasConfig.primaryAppTheme,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Let’s get you started",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 40),

                // Full Name
                TextField(
                  controller: _nameController,
                  decoration: _inputDecoration(
                    "Full name",
                    Icons.person_outline,
                  ),
                ),
                const SizedBox(height: 16),

                // Email
                TextField(
                  controller: _emailController,
                  decoration: _inputDecoration(
                    "Email address",
                    Icons.email_outlined,
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  decoration: _inputDecoration("Password", Icons.lock_outline)
                      .copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                ),
                const SizedBox(height: 30),

                // Create Button
                GestureDetector(
                  onTap: _isLoading ? null : _createAccount,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: _isLoading
                          ? Colors.black45
                          : CanvasConfig.primaryAppTheme,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              "Create Account",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.poppins(color: Colors.grey[700]),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.black87),
      ),
    );
  }
}
