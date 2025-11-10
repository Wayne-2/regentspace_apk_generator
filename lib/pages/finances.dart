import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vtutemplate/components/usageinfo.dart';
import 'package:vtutemplate/riverpod/riverpod.dart';
class Finances extends ConsumerWidget {
  const Finances({super.key, required this.primaryapptheme, required this.bgColor,});

  final Color primaryapptheme;
  final Color bgColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userProfile = ref.watch(userProfileProvider);
    final displayName = userProfile?.username ?? "User";
    final size = MediaQuery.of(context).size;
    final height = size.height;
    // final width = size.width;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Header Card ---
              Container(
                width: double.infinity,
                height: height * 0.12, // 8% of screen height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryapptheme,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Prepaid - 5235829243',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// --- Usage Info ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Usageinfo(
                    amount: '20,000.00',
                    rating: 'Kes',
                    servicetype: 'Airtime',
                    fontsize: 12,
                  ),
                  Usageinfo(
                    amount: '4000',
                    rating: 'Mms',
                    servicetype: 'Voice Bundle',
                    fontsize: 12,
                  ),
                  Usageinfo(
                    amount: '2,903.00',
                    rating: 'Mb',
                    servicetype: 'Data Bundle',
                    fontsize: 12,
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// --- Action Buttons ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton("History"),
                  _actionButton("Schedule payments"),
                ],
              ),

              const SizedBox(height: 20),

              /// --- Section Title ---
              const Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              /// --- Transactions List ---
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Colors.black12.withOpacity(0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            /// Leading icon
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.grey[200],
                              ),
                              child: const Icon(Icons.wallet_outlined, size: 16),
                            ),
                            const SizedBox(width: 10),

                            /// Title and timestamp
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Loan payment',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '12:00 PM',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// Amount
                            const Text(
                              '+3,000',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Reusable Button Builder ---
  Widget _actionButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1),
        color: primaryapptheme,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}