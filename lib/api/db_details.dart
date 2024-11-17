import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'global_variables.dart';

//For Supabase Initialization throughout the App - ONE INSTANCE LANG SSOB
void supabaseInit() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: returnAccessURL(),
    anonKey: returnAnonKey(),
  );
}

//For the single instance
final SupabaseClient supabaseDB = Supabase.instance.client;