import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtutemplate/constants.dart';
import 'package:vtutemplate/services/servicesapi.dart';

class AirtimePage extends StatefulWidget {
  const AirtimePage({super.key});

  @override
  State<AirtimePage> createState() => _AirtimePageState();
}

class _AirtimePageState extends State<AirtimePage> {
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  String selectedNetwork = "MTN";
  final vtuService = VtuService();

  bool isLoading = false;
  String result = "";

  Future<void> _buyAirtime() async {
    setState(() => isLoading = true);
    try {
      final res = await vtuService.buyAirtime(
        network: selectedNetwork,
        phone: _phoneController.text,
        amount: double.parse(_amountController.text),
      );
      setState(
        () => result = "Success: ${res['message'] ?? 'Airtime sent!'}",
      );
    } catch (e) {
      setState(() => result = "Failed: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = CanvasConfig.bgColor;

    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(76, 255, 255, 255),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, size: 13),
        ),
        title: Text(
          "Buy Airtime",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            //Card Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(39, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Network",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedNetwork,
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        onChanged: (v) => setState(() => selectedNetwork = v!),
                        items: ["MTN", "Airtel", "GLO", "9Mobile"]
                            .map(
                              (n) => DropdownMenuItem(
                                value: n,
                                child: Text(
                                  n,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Phone Number",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: GoogleFonts.poppins(fontSize: 14),
                      prefixIcon: const Icon(Icons.phone_android_outlined),
                      filled: true,
                      fillColor: const Color.fromARGB(68, 245, 245, 245),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Amount",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter amount (₦)",
                      hintStyle: GoogleFonts.poppins(fontSize: 14),
                      prefixIcon: const Icon(Icons.money_outlined),
                      filled: true,
                      fillColor: const Color.fromARGB(68, 245, 245, 245),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CanvasConfig.primaryAppTheme,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
                onPressed: isLoading ? null : _buyAirtime,
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : Text(
                        "Buy Airtime",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            // 🟢 Result Text
            if (result.isNotEmpty)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: result.contains("Success")
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    result,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: result.contains("Success")
                          ? Colors.green.shade800
                          : Colors.red.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
