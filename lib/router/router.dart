// router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_stay/api/riverpod/authentication_state.dart';

import 'package:safe_stay/main.dart';
import 'package:safe_stay/pages/home.dart';
import 'package:safe_stay/pages/login.dart';
import 'package:safe_stay/pages/register.dart';
import 'package:safe_stay/pages/dashboard.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isAuthenticating = authState.status == AuthStatus.authenticating;

      final isOnAuthPage = state.uri.path == '/login';

      // // If not authenticated and not on auth page, redirect to login
      if (!isAuthenticated && (state.uri.path != '/login')) {
         return '/login';
       }else if(isAuthenticated && ((state.uri.path == '/login') || (state.uri.path == '/home'))){
         return '/dashboard';
      }else{
         return null;
     }

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
        path: '/register',
        builder: (context, state) => const Register(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
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
