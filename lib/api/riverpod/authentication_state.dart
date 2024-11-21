// auth_state.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:safe_stay/api/services/authentication.dart';

// Auth States
enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  authenticating,
  error
}

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Default Notifier - don't touch
class AuthNotifier extends StateNotifier<AuthState> {
  final Authentication _auth;

  AuthNotifier(this._auth) : super(AuthState(status: AuthStatus.initial)) {
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    final user = _auth.currentUserLoggedIn;
    if (user != null) {
      state = AuthState(status: AuthStatus.authenticated, user: user);
    } else {
      state = AuthState(status: AuthStatus.unauthenticated);
    }
  }

  // Just for signing-in
  Future<void> signInWithEmail(String email, String password) async {
    try {
      state = state.copyWith(status: AuthStatus.authenticating);
      final response = await _auth.signInWithEmail(email, password);
      if (response.user != null) {
        state = AuthState(
          status: AuthStatus.authenticated,
          user: response.user,
        );
      }
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  //sign-up et
  Future<void> signUp(String email, String password) async {
    try {
      state = state.copyWith(status: AuthStatus.authenticating);
      final response = await _auth.signUp(email, password);
      if (response.user != null) {
        state = AuthState(
          status: AuthStatus.authenticated,
          user: response.user,
        );
      }
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  //Google; to be fixed main Google Login
  Future<void> signInWithGoogle() async {
    try {
      state = state.copyWith(status: AuthStatus.authenticating);
      final response = await _auth.gAppSignIn();
      if (response.user != null) {
        state = AuthState(
          status: AuthStatus.authenticated,
          user: response.user,
        );
      }
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  //Anon
  Future<void> signInAnonymously() async {
    try {
      state = state.copyWith(status: AuthStatus.authenticating);
      final response = await _auth.signInAnonymously();
      if (response.user != null) {
        state = AuthState(
          status: AuthStatus.authenticated,
          user: response.user,
        );
      }
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  //Global signout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      state = AuthState(status: AuthStatus.unauthenticated);
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}

// Don't touch
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(Authentication());
});
