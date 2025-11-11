import 'package:flutter/material.dart';
import 'package:vtutemplate/constants.dart';
import 'package:vtutemplate/model/datamodel.dart';
import 'package:vtutemplate/services/servicesapi.dart';

class BuyDataPage extends StatefulWidget {
  final String serviceID; // e.g. "mtn-data", "airtel-data"
  const BuyDataPage({super.key, required this.serviceID});

  @override
  State<BuyDataPage> createState() => _BuyDataPageState();
}

class _BuyDataPageState extends State<BuyDataPage> {
  final _vtuService = VtuService();
  List<DataVariation> bundles = [];
  DataVariation? selectedBundle;
  bool isLoading = false;
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadBundles();
  }

Future<void> loadBundles() async {
  setState(() => isLoading = true);

  try {
    final List<DataVariation> result = await _vtuService.getDataBundles(widget.serviceID);

    setState(() {
      bundles = result;
      isLoading = false;
    });
  } catch (e) {
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error loading bundles: $e')),
    );
  }
}




  void purchaseData() async {
    if (selectedBundle == null || phoneController.text.isEmpty) return;

    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await _vtuService.buyData(
        serviceID: widget.serviceID,
        variationCode: selectedBundle!.variationCode,
        phone: phoneController.text,
        requestId: DateTime.now().millisecondsSinceEpoch.toString()
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['response_description'] ?? 'Success')),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchase failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
        final themeColor = CanvasConfig.bgColor;

    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(76, 255, 255, 255),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, size: 13),
        ),
        title: Text(
          "${widget.serviceID.toUpperCase()} Data",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 13
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Phone Number",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Enter phone number",
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Select Data Plan",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.grey.shade300, width: 1),
                          ),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: DropdownButton<DataVariation>(
                          isExpanded: true,
                          value: selectedBundle,
                          underline: const SizedBox(),
                          hint: const Text(
                            "Choose your data plan",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          items: bundles.map((bundle) {
                            return DropdownMenuItem<DataVariation>(
                              value: bundle,
                              child: Text(
                                "${bundle.name} - ₦${bundle.variationAmount.toStringAsFixed(0)}",
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedBundle = value;
                            });
                          },
                        ),

                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: purchaseData,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CanvasConfig.primaryAppTheme,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              "Buy Data",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Ensure the phone number is correct before proceeding.",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
