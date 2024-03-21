import 'package:flutter/material.dart';
import 'package:group_project/appconfig/icon_assets.dart';
import 'package:group_project/ui/widgets/app_icons.dart';
// import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BottomNavigationBar(
      backgroundColor: colorScheme.background,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onBackground.withOpacity(.5),
      showUnselectedLabels: true,
      unselectedFontSize: 14,
      selectedLabelStyle: textTheme.bodySmall,
      unselectedLabelStyle: textTheme.bodySmall,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        // switch (index) {
        //   case 0:
        //     context.pushNamed('home');
        //     break;
        //   case 1:
        //     context.pushNamed('search');
        //     break;
        //   case 2:
        //     context.pushNamed('cart');
        //     break;
        //   case 3:
        //     context.pushNamed('user-account');
        //     break;
        //   default:
        // }
      },
      items: const [
        BottomNavigationBarItem(
          icon: AppIcon(iconName: IconAssets.home, color: Colors.grey),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: AppIcon(
            iconName: IconAssets.heart,
            color: Colors.grey,
          ),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: AppIcon(iconName: IconAssets.calendar, color: Colors.grey),
          label: 'Reservations',
        ),
        BottomNavigationBarItem(
          icon: AppIcon(iconName: IconAssets.user, color: Colors.grey),
          label: 'Profile',
        ),
      ],
    );
  }
}
