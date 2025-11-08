import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtutemplate/services/servicesapi.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final _phoneController = TextEditingController();
  final vtuService = VtuService();

  String selectedNetwork = "MTN";
  String selectedPlan = "MTN-1GB";
  bool isLoading = false;
  String result = "";

  final List<String> networks = ["MTN", "AIRTEL", "GLO", "9MOBILE"];

  final Map<String, List<Map<String, String>>> plans = {
    "MTN": [
      {"name": "1GB - ₦300", "id": "MTN-1GB"},
      {"name": "2GB - ₦500", "id": "MTN-2GB"},
      {"name": "5GB - ₦1000", "id": "MTN-5GB"},
    ],
    "AIRTEL": [
      {"name": "1GB - ₦300", "id": "AIRTEL-1GB"},
      {"name": "2GB - ₦500", "id": "AIRTEL-2GB"},
    ],
    "GLO": [
      {"name": "1GB - ₦250", "id": "GLO-1GB"},
      {"name": "3GB - ₦700", "id": "GLO-3GB"},
    ],
    "9MOBILE": [
      {"name": "1GB - ₦350", "id": "9MOBILE-1GB"},
      {"name": "2GB - ₦600", "id": "9MOBILE-2GB"},
    ],
  };

  Future<void> _buyData() async {
    setState(() => isLoading = true);
    try {
      final res = await vtuService.buyData(
        network: selectedNetwork,
        phone: _phoneController.text,
        planId: selectedPlan,
      );
      setState(() => result = "✅ Success: ${res['message'] ?? 'Data sent!'}");
    } catch (e) {
      setState(() => result = "❌ Failed: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.deepPurpleAccent;
    final availablePlans = plans[selectedNetwork]!;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "Buy Data",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            // 🟣 Card Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Network
                  Text("Select Network",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 14)),
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
                        onChanged: (v) {
                          setState(() {
                            selectedNetwork = v!;
                            selectedPlan = plans[selectedNetwork]!.first['id']!;
                          });
                        },
                        items: networks
                            .map((n) => DropdownMenuItem(
                                  value: n,
                                  child: Text(n,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ))
                            .toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Plan
                  Text("Select Data Plan",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedPlan,
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        onChanged: (v) => setState(() => selectedPlan = v!),
                        items: availablePlans
                            .map((plan) => DropdownMenuItem(
                                  value: plan["id"],
                                  child: Text(plan["name"]!,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ))
                            .toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Phone
                  Text("Phone Number",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 14)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter recipient number",
                      hintStyle: GoogleFonts.poppins(fontSize: 14),
                      prefixIcon: const Icon(Icons.phone_android_outlined),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 12),
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

            // 🟣 Buy Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
                onPressed: isLoading ? null : _buyData,
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white))
                    : Text(
                        "Buy Data",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            // Result Text
            if (result.isNotEmpty)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: 1,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
