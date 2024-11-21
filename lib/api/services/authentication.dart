// ignore_for_file: avoid_print

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safe_stay/api/db_details.dart';

class Authentication {
  // don't touch - regex checking for email.
  bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  Future<AuthResponse> signInWithEmail(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw 'Email and password cannot be empty';
    }

    if (!isValidEmail(email.trim())) {
      throw 'Please enter a valid email address';
    }

    if (password.length < 6) {
      throw 'Password must be at least 6 characters';
    }

    try {
      final response = await supabaseDB.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return response;
    } on AuthException catch (e) {
      print('Auth Exception: ${e.message}');
      if (e.message.contains('Invalid login credentials')) {
        signUp(email, password);
        throw 'Invalid email or password';
      }
      throw e.message;
    } catch (e) {
      print('Sign In Error: $e');
      throw 'Failed to sign in. Please try again.';
    }
  }

  Future<AuthResponse> signUp(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw 'Email and password cannot be empty';
    }

    if (!isValidEmail(email.trim())) {
      throw 'Please enter a valid email address';
    }

    if (password.length < 6) {
      throw 'Password must be at least 6 characters';
    }

    try {
      final response = await supabaseDB.auth.signUp(
        email: email.trim(),
        password: password.trim(),
        emailRedirectTo:
            'https://qpetohtluhvwrrpletja.supabase.co/auth/v1/callback', // Replace with your actual redirect URL
      );

      if (response.user == null) {
        throw 'Failed to create account';
      }

      return response;
    } on AuthException catch (e) {
      print('Auth Exception: ${e.message}'); // For debugging
      if (e.message.contains('User already registered')) {
        throw 'This email is already registered';
      } else if (e.message.contains('not authorized')) {
        throw 'This email domain is not authorized. Please use a different email address.';
      }
      throw e.message;
    } catch (e) {
      print('Sign Up Error: $e'); // For debugging
      throw 'Failed to create account. Please try again.';
    }
  }

  // Google Sign In
  Future<AuthResponse> gAppSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            "640817449565-qtk6lm0iqsd2a3sntg6das717v7coisr.apps.googleusercontent.com",
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw 'Google Sign-in was canceled';
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw 'No ID token found';
      }

      return await supabaseDB.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (e) {
      throw 'Failed to sign in with Google: $e';
    }
  }

  // Anonymous Sign In
  Future<AuthResponse> signInAnonymously() async {
    try {
      // First check if there's already an anonymous session
      if (supabaseDB.auth.currentSession != null) {
        await signOut(); // Sign out if there's an existing session
      }

      // Attempt anonymous sign-in with retry logic
      int attempts = 0;
      while (attempts < 3) {
        try {
          final response = await supabaseDB.auth.signInAnonymously();
          if (response.session != null) {
            return response;
          }
          throw 'No session created';
        } catch (e) {
          attempts++;
          if (attempts == 3) rethrow;
          await Future.delayed(Duration(milliseconds: 500 * attempts));
        }
      }
      throw 'Failed after multiple attempts';
    } on AuthException catch (e) {
      print(
          'Auth Exception Details: ${e.message}, Status: ${e.statusCode}, Error Code: ${e.code}');
      throw 'Authentication failed: ${e.message}';
    } catch (e) {
      print('Detailed error: $e');
      throw 'Failed to sign in anonymously: $e';
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await supabaseDB.auth.signOut();
    } catch (e) {
      throw 'Failed to sign out: $e';
    }
  }

  User? get currentUserLoggedIn => supabaseDB.auth.currentUser;
}
