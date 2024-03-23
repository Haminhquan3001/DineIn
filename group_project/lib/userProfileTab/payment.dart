import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/userProfileTab/themeProvider.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});
  @override
  State<Payment> createState() => _Payment();
}

class _Payment extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Payment",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    child: Image.asset(
                      "assets/credit-card.png",
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PaymentMethod(
                      title: "Payment Methods",
                      icon: Icons.money,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PaymentMethodPage()));
                      }),
                ],
              )),
        ));
  }
}

class PaymentMethod extends StatelessWidget {
  const PaymentMethod(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.endIcon = true,
      this.textColor});

  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var iconColor =
        Provider.of<ThemeProvider>(context).themeData.listTileTheme.iconColor;
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.lime.withOpacity(0.2)),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.lime.withOpacity(0.2)),
        child: const Icon(
          Icons.arrow_right_alt_rounded,
          color: Color.fromARGB(255, 188, 165, 231),
          size: 20,
        ),
      ),
    );
  }
}

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});
  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPage();
}

class _PaymentMethodPage extends State<PaymentMethodPage> {
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

class MethodDialog extends StatelessWidget {
  const MethodDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: Material(
            child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Method(),
          ],
        )),
      ),
    );
  }
}

class Method extends StatelessWidget {
  const Method({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          MethodBuilder(
              title: "PayPal",
              imagePath: "assets/paypal.png",
              onPressed: () {}),
          const SizedBox(
            height: 5,
          ),
          MethodBuilder(
              title: "Amazon Pay",
              imagePath: "assets/amazon-pay.png",
              onPressed: () {}),
          const SizedBox(
            height: 5,
          ),
          MethodBuilder(
              title: "Credit Card",
              imagePath: "assets/mastercard.png",
              onPressed: () {}),
        ],
      ),
    );
  }
}

class MethodBuilder extends StatelessWidget {
  const MethodBuilder(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.onPressed,
      this.endIcon = true,
      this.textColor});

  final String title;
  final String imagePath;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Image.asset(
        imagePath,
        width: 50,
        height: 50,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
