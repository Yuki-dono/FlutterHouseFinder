import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// Services, Models and Calls -- PLZ DONT TOUCH BRU
import '/api/db_details.dart';
import 'package:safe_stay/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Make the entire body scrollable
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                      fontWeight: FontWeight.normal,
                      fontFamily: "Etna",
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
                          borderRadius:BorderRadius.only(
                            bottomLeft: Radius.circular(12)
                          )
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                      ),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Color.fromARGB(255, 149, 149, 149),
                          fontSize: 16,
                          fontFamily: GoogleFonts.raleway().fontFamily,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context).go('/Register'); // Navigate to register page
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
                      child: Text(
                        "REGISTER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: GoogleFonts.raleway().fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
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
                  Row(
                    children: [
                      const SizedBox(width: 40),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Find your safe stay',
                              style: TextStyle(
                                fontSize: 70,
                                fontFamily: GoogleFonts.raleway().fontFamily),
                            ),
                            Text(
                              'near your university',
                              style: TextStyle(
                                  fontSize: 70, 
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.raleway().fontFamily),
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