import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/ui/pages/landing/login_page.dart';
import 'package:group_project/ui/pages/landing/signup_page.dart';
import 'package:group_project/ui/pages/home/home_page.dart';
import 'package:group_project/ui/pages/landing/brand_loading_page.dart';
import 'package:group_project/ui/pages/landing/welcome_page.dart';
import 'package:group_project/ui/pages/profile/profile_page.dart';
import 'package:group_project/ui/pages/reservation/reservation_page.dart';
import 'package:group_project/ui/pages/wishlist/wishlist_page.dart';
import 'package:group_project/ui/widgets/bottom_navbar.widget.dart';

/// The route configuration.
GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignUpPage(),
    ),

    // Routes with bottom navbar
    ShellRoute(
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/wishlist',
          name: 'wishlist',
          builder: (context, state) => WishlistPage(),
        ),
        GoRoute(
          path: '/reservation',
          name: 'reservation',
          builder: (context, state) => ReservationPage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => ProfilePage(),
        ),
      ],
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    ),
  ],
);
