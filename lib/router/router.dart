// router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_stay/api/riverpod/authState.dart';

import 'package:safe_stay/main.dart';
import 'package:safe_stay/pages/login.dart';


final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isAuthenticating = authState.status == AuthStatus.authenticating;

      final isOnAuthPage = state.uri.path == '/login';

      // If not authenticated and not on auth page, redirect to login
      if (!isAuthenticated && !isAuthenticating && !isOnAuthPage) {
        return '/login';
      }

      // If authenticated and on auth page, redirect to home
      if (isAuthenticated && isOnAuthPage) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/Login',
        builder: (context, state) => Login(),
      ),
    // !!! Add the routes here Yuki !!!
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