import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'login.dart'; // Import the Login page
import 'register.dart'; // Import the Register page
=======
import 'pages/login.dart'; // Import the Login page
import 'api/db_details.dart';
>>>>>>> 545a5dca586f220698f4805c4ec091e13147636a

void main() {
  supabaseInit(); //Global Init of our Supabase DB
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
<<<<<<< HEAD
  const MyApp({super.key});
=======

  const MyApp({super.key}); // Added const for compatibility with tests
>>>>>>> 545a5dca586f220698f4805c4ec091e13147636a

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Stay',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(), // Register page route
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                      Navigator.pushNamed(
                          context, '/login'); // Navigate to login page
                    },
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
<<<<<<< HEAD
                        borderRadius: BorderRadius.zero,
=======
                        borderRadius: BorderRadius.zero, // Square corners
>>>>>>> 545a5dca586f220698f4805c4ec091e13147636a
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
                      Navigator.pushNamed(
                          context, '/register'); // Navigate to register page
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 150),
                    const Row(children: [
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
                    ]),

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
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )
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
