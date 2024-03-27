import 'package:flutter/material.dart';
import 'package:group_project/ui/pages/profile/widgets/method_dialog_widget.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});
  @override
  State<PaymentMethodView> createState() => _PaymentMethodPage();
}

class _PaymentMethodPage extends State<PaymentMethodView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Payment Methods",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Add and manage your payment methods.",
                style: TextStyle(fontSize: 20),
              ),
              ListTile(
                leading: const Icon(Icons.card_giftcard),
                title: const Text("VISA"),
                trailing: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder()),
                  child:
                      const Text("Edit", style: TextStyle(color: Colors.black)),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder()),
                child: const Text("Add payment method",
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  showGeneralDialog(
                    barrierLabel: "showGeneralDialog",
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.6),
                    transitionDuration: const Duration(milliseconds: 400),
                    context: context,
                    pageBuilder: (context, ani1, ani2) {
                      return const MethodDialog();
                    },
                    transitionBuilder: (context, ani1, ani2, child) {
                      return SlideTransition(
                        position: Tween(
                          begin: const Offset(0, 1),
                          end: const Offset(0, 0),
                        ).animate(ani1),
                        child: child,
                      );
                    },
                  );
                },
              )
            ])),
      ),
    );
  }
}
