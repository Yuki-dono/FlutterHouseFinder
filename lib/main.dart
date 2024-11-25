//main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Services, Models and Calls -- PLZ DONT TOUCH BRU
import '/api/db_details.dart';
import 'package:safe_stay/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qpetohtluhvwrrpletja.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFwZXRvaHRsdWh2d3JycGxldGphIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzExNTgyODAsImV4cCI6MjA0NjczNDI4MH0.F0dsAUcR-WFxzzNyXN4paRjAUvJv7DunJftTJL9xEAY',
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      //Please naman don't forget this line at least
      debugShowCheckedModeBanner: false,
      title: 'Safe Stay',
    );
  }
}