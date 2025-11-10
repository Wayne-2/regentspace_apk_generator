import 'package:flutter/material.dart';
import 'package:vtutemplate/constants.dart';

Future<void> addMoneyDialog(
  BuildContext context, {
  required Function(double amount, String method) onConfirm,
}) async {
  final TextEditingController amountController = TextEditingController();
  String? selectedMethod;

  final List<String> methods = [
    "Bank Transfer",
    "Card Payment",
    "USSD",
  ];

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: CanvasConfig.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          "Add Money",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Enter amount",
                  border: OutlineInputBorder(),
                  prefixText: "₦ ",
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedMethod,
                hint: const Text("Select payment method"),
                items: methods
                    .map((m) => DropdownMenuItem(
                          value: m,
                          child: Text(m),
                        ))
                    .toList(),
                onChanged: (value) {
                  selectedMethod = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: CanvasConfig.bgColor
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text);
              if (amount == null || amount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Enter a valid amount")),
                );
                return;
              }
              if (selectedMethod == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Select a payment method")),
                );
                return;
              }

              Navigator.pop(context);
              onConfirm(amount, selectedMethod!);
            },
            child: const Text("Proceed"),
          ),
        ],
      );
    },
  );
}
