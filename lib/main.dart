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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Make the entire body scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    'Safe Stay',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 34, 124, 29),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context).go('/Login');
                      },
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                      ),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Color.fromARGB(255, 149, 149, 149),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context)
                            .go('/Register'); // Navigate to register page
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 34, 124, 29),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                      ),
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Add some space
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  const Row(
                    children: [
                      SizedBox(width: 40),
                      SizedBox(
                        child: Column(
                          children: [
                            Text(
                              'Find your safe stay',
                              style: TextStyle(fontSize: 40),
                            ),
                            Text(
                              'near your university',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Inserted Card widget here
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16), // Rounded corners
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.green, // Green header
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                      16), // Rounded top corners
                                ),
                              ),
                              child: const Text(
                                'ADD YOUR PROPERTY IN <FROM LOCATION> ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white, // White body
                              padding: const EdgeInsets.all(16),
                              child: const Column(
                                children: [
                                  SizedBox(height: 30),
                                  Text('Sample Text'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// initialRoute: '/',
//       routes: {
//         '/': (context) => HomePage(),
//         '/login': (context) => Login(),
//         '/register': (context) => Register(), // Register page route
//       }