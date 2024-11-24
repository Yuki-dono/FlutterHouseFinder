import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Services, Models and Calls -- PLZ DONT TOUCH BRU
import '/api/db_details.dart';
import 'package:safe_stay/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  

  @override
  Widget build(BuildContext context) {

    final List<String> districts = [
      "Agdao",
      "Baguio",
      "Buhangin",
      "Bunawan",
      "Calinan",
      "Marilog",
      "Paquibato",
      "Poblacion",
      "Talomo",
      "Toril",
      "Tugbok",
      "Toril" // This was missing!
    ];
    int sampleLoc = Random().nextInt(11);
    
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
                          color: const Color.fromARGB(255, 149, 149, 149),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  color:Color.fromARGB(255, 34, 124, 29), // Green header
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                      'ADD YOUR PROPERTY IN',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: GoogleFonts.raleway().fontFamily,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      districts[sampleLoc],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: GoogleFonts.raleway().fontFamily,
                                      ),
                                    ),
                                    const SizedBox(width: 200),
                                    IconButton(
                                      onPressed: () {}, 
                                      icon: const FaIcon(
                                        FontAwesomeIcons.house,
                                        color: Colors.white)
                                      ),
                                    ],
                                  )
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
              const SizedBox(height: 100),
              _buildBelowCardContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBelowCardContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color:  Color.fromARGB(255, 34, 124, 29),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
                Text(
                  'This website is made by\nTADAYUKI HARUYAMA\nSHAHEEN AL ADWANI',
                  style: TextStyle(color: Colors.white), 
                ),
                Row(
                  children: [
                    Icon(Icons.facebook, color: Colors.white), 
                    SizedBox(width: 10), // Spacing between icons
                    Icon(Icons.g_translate, color: Colors.white), 
                  ],
                ),
              ],
            ),
            const SizedBox(height: 115),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network('https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/logo.png'),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Safe Stay',
                      style: TextStyle(
                      fontFamily: 'Etna',
                      fontSize: 23,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    ),
                  ],
                ),
                const Text(
                  'ALL RIGHTS RESERVED. © 2024',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}