// router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_stay/api/riverpod/authentication_state.dart';

import 'package:safe_stay/main.dart';
import 'package:safe_stay/pages/home.dart';
import 'package:safe_stay/pages/login.dart';
import 'package:safe_stay/pages/dashboard.dart';
import 'package:safe_stay/pages/my_listings.dart';
import 'package:safe_stay/pages/archived_dashboard.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isAuthenticating = authState.status == AuthStatus.authenticating;
      final isOnAuthPage = state.uri.path == '/login';

      // Redirect logic for authenticated users
      if (isAuthenticated) {
        if (state.uri.path == '/login' || state.uri.path == '/register' || state.uri.path.startsWith('/home')) {
          return '/dashboard'; // Redirect to dashboard if trying to access login/register
        }
      } else if(isAuthenticating) {
        if(state.uri.path == '/login' ){
          return null;
        }
      }
        else {
        // Redirect logic for unauthenticated users
        if (state.uri.path.startsWith('/dashboard') ||
            state.uri.path == '/mylistings') {
          return '/login'; // Redirect to login if trying to access protected routes
        }

       
      }

      return null; // No redirect needed
    },
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => Login(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/my-listings',
        builder: (context, state) => const MyListingScreen(),
      ),
      GoRoute(
        path: '/archived-list',
        builder: (context, state) => const ArchivedDashboard(),
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
});

// TO BE UPDATED DESIGN LMAO
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Page not found'),
      ),
    );
  }
}
