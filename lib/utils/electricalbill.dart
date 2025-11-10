import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtutemplate/constants.dart';
import 'package:vtutemplate/services/servicesapi.dart';

class ElectricityBillPage extends StatefulWidget {
  const ElectricityBillPage({super.key});

  @override
  State<ElectricityBillPage> createState() => _ElectricityBillPageState();
}

class _ElectricityBillPageState extends State<ElectricityBillPage> {
  final _vtuService = VtuService();
  final TextEditingController meterNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String selectedDisco = "ikeja-electric";
  String selectedMeterType = "prepaid";
  bool isLoading = false;
  String result = "";

  final List<Map<String, String>> discos = [
    {"name": "Ikeja Electric", "code": "ikeja-electric"},
    {"name": "Eko Electric", "code": "eko-electric"},
    {"name": "Abuja Electric", "code": "abuja-electric"},
    {"name": "Kano Electric", "code": "kano-electric"},
    {"name": "Port Harcourt Electric", "code": "portharcourt-electric"},
  ];

  Future<void> payBill() async {
    if (meterNumberController.text.isEmpty || amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await _vtuService.payElectricityBill(
        disco: selectedDisco,
        meterNumber: meterNumberController.text,
        amount: double.parse(amountController.text),
        meterType: selectedMeterType,
      );

      setState(() {
        isLoading = false;
        result =
            "✅ Success — ${response['content']['Customer_Name'] ?? 'Payment Complete!'}";
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        result = "❌ Failed: $e";
      });
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
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, size: 18),
        ),
        title: Text(
          "Electricity Bill",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            // Card Container
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
                  // 🔌 Disco Selection
                  Text(
                    "Select Disco",
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
                        value: selectedDisco,
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        onChanged: (v) => setState(() => selectedDisco = v!),
                        items: discos
                            .map(
                              (d) => DropdownMenuItem(
                                value: d["code"],
                                child: Text(
                                  d["name"]!,
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

                  // ⚙️ Meter Type
                  Text(
                    "Meter Type",
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
                        value: selectedMeterType,
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        onChanged: (v) => setState(() => selectedMeterType = v!),
                        items: const [
                          DropdownMenuItem(
                              value: "prepaid", child: Text("Prepaid")),
                          DropdownMenuItem(
                              value: "postpaid", child: Text("Postpaid")),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔢 Meter Number
                  Text(
                    "Meter Number",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: meterNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter meter number",
                      hintStyle: GoogleFonts.poppins(fontSize: 14),
                      prefixIcon: const Icon(Icons.numbers_outlined),
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

                  // 💸 Amount
                  Text(
                    "Amount",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: amountController,
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

            // ⚡ Pay Button
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
                onPressed: isLoading ? null : payBill,
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : Text(
                        "Pay Bill",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            // 🟢 Result
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
