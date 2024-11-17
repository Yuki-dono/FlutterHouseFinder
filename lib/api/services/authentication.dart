import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:safe_stay/api/db_details.dart'; //Supabase - DO NOT TOUCH

class Authentication {
  //Methods for Email, GoogleOAuth yessirski katulugon nako heylllll

  User? get currentUserLoggedIn => supabaseDB.auth.currentUser;

  Future<AuthResponse> _googleSignIn() async {
    //This should be invisble
    const webClientID = '640817449565-qtk6lm0iqsd2a3sntg6das717v7coisr.apps.googleusercontent.com';
    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientID, 
    );

    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    //Notes: needs an idToken to confirm logging in
    if(accessToken == null){
      throw 'No access token';
    }

    if(idToken == null){
      throw 'No id token';
    }

    return supabaseDB.auth.signInWithIdToken(
      provider: OAuthProvider.google, 
      idToken: idToken,
      accessToken: accessToken
    );

  }

  //Signout rani - pls don't touch
  Future<void> signOut() async {
    try {
      await supabaseDB.auth.signOut();
    }catch (err){
      throw Exception('Failed to sign-out user: $err');
    }
    
  }

  //Guest Sign-up LMAO
  // Future<AuthResponse> guestSignIn() async{
  //   await supabaseDB.auth.signInAnonymously();
  // }

  //Email and Password Custom SignUP(via SP Default ra)
  Future<void> signUp (String email, String password) async { 
    try{
      final fetchResponse = await supabaseDB.auth.signUp(
        email: email, 
        password: password
      );

      if (fetchResponse.user == null){
        throw Exception("Failed to sign-up ueser");
      }
    }catch (err){
      throw Exception('Error in signing-up user: $err');
    }
  }

  //Sign-in E&P
  Future<void> signInWithEmail(String email, String password) async {
    try {
      final fetchRespose = await supabaseDB.auth.signInWithPassword(
        email: email, 
        password: password);

      if(fetchRespose.session == null){
        throw Exception('Failed to sign-in user');
      }
    }catch (err){
      throw Exception('Error in signing-in user: $err');
    }
  }
}