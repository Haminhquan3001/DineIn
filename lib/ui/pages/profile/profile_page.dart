import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/providers/user.provider.dart';
import 'package:group_project/ui/pages/profile/widgets/menu_tab.dart';
import 'package:group_project/ui/pages/profile/widgets/switch_theme_tab.dart';
import 'package:group_project/ui/widgets/space_y.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.getUser;

    // TODO: in every hard refresh, the user_provider is cleaned up
    // leading to an error to the whole app workflow
    // This fixes temporarily.
    if (user.id == "") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/welcome');
      });
    }

    Image userPicture = user.avatarUrl != null
        ? Image.network(user.avatarUrl!, width: 80, height: 80)
        : Image.asset("assets/core/woman.png", width: 80, height: 80);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: userPicture),
              ),
              const SpaceY(10),
              Text(
                user.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                user.email,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SpaceY(20),
              const SpaceY(30),
              const Divider(),
              const SpaceY(10),
              MenuTab(
                title: "Edit Profile",
                icon: Icons.edit,
                onPressed: () => context.go('/profile/edit'),
              ),
              const SpaceY(10),
              MenuTab(
                title: "Payment",
                icon: Icons.payment_rounded,
                onPressed: () => context.push('/profile/payment'),
              ),
              const SpaceY(10),
              MenuTab(
                title: "Contact Us",
                icon: Icons.phone,
                onPressed: () => context.push('/profile/contact-us'),
              ),
              const SpaceY(10),
              MenuTab(
                title: "Owner Form",
                icon: Icons.app_registration,
                onPressed: () => context.push('/profile/owner-form'),
              ),
              const SpaceY(10),
              const SwitchThemeTab(),
              const Divider(),
              const SpaceY(20),
              MenuTab(
                title: "Log Out",
                icon: Icons.logout_rounded,
                onPressed: () {
                  userProvider.useSignOut().then((_) => context.go('/welcome'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
