import 'package:flutter/material.dart';
import 'pages/login.dart'; // Import the Login page
import 'api/db_details.dart';

void main() {
  supabaseInit(); //Global Init of our Supabase DB
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key}); // Added const for compatibility with tests

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Stay',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const Login(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key}); 
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 // Added const
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                      Navigator.pushNamed(context, '/login');
                    },
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Square corners
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
                      // Add registration logic here
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 34, 124, 29),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(12.0), // Bottom-left rounded
                          topLeft: Radius.zero, // Square top-left corner
                          topRight: Radius.zero, // Square top-right corner
                          bottomRight:
                              Radius.zero, // Square bottom-right corner
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
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 150),
                    Row(children: [
                      SizedBox(width: 30),
                      SizedBox(
                        child: Column(
                          children: [
                            Text(
                              'Find your safe stay',
                              style: TextStyle(fontSize: 40),
                            ),
                            Text(
                              'near your university',
                              style: TextStyle(fontSize: 40),
                            ),
                          ],
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
