import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Services, Models and Calls -- PLZ DONT TOUCH BRU
import '/api/db_details.dart';
import 'package:safe_stay/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgBase = [
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/aaron-huber-s95oB2n9jng-unsplash.jpg', 
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/bailey-anselme-Bkp3gLygyeA-unsplash.jpg', 
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/brian-babb-XbwHrt87mQ0-unsplash%20(1).jpg', 
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/dillon-kydd-2keCPb73aQY-unsplash%20(1).jpg', 
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/francesca-tosolini-tHkJAMcO3QE-unsplash.jpg', 
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/ronnie-george-9gGvNWBeOq4-unsplash.jpg'
    ];

    int imgCarousel = Random().nextInt(5);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              const SizedBox(height: 50),
              // Hero Section -- Don't remove, my guide
              Row(
                children: [
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 1, // Hero text takes 1/2 of the space
                    child: _buildHeroSection(context),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 600,
                      width: 1000,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(imgBase[imgCarousel]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              // const SizedBox(height: 100),
              // _buildDownloadBanner(),
              const SizedBox(height: 100),
              _buildBelowCardContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final List<String> districts = [
      "Agdao", "Baguio", "Buhangin", "Bunawan", "Calinan", "Marilog",
      "Paquibato", "Poblacion", "Talomo", "Toril", "Tugbok", "Toril"
    ];
    int sampleLoc = Random().nextInt(11);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Find your safe stay',
          style: TextStyle(
            fontSize: 70,
            fontFamily: GoogleFonts.raleway().fontFamily,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'near your university',
          style: TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.raleway().fontFamily,
          ),
        ),
        const SizedBox(height: 30),
        _buildCardSection(districts, sampleLoc),
        const SizedBox(height: 20),
        _buildMiniFooter(context),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
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
              GoRouter.of(context).go('/login');
            },
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                ),
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
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: TextButton(
            onPressed: () {
              GoRouter.of(context).go('/register');
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
    );
  }

  Widget _buildCardSection(List<String> districts, int sampleLoc) {
    return Row(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 34, 124, 29),
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
                    const SizedBox(width: 230),
                    IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.house, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMiniFooter(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).go('/register');
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
            "?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: GoogleFonts.raleway().fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 30),
        TextButton(
          onPressed: () {
            GoRouter.of(context).go('/register');
          },
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 165, 165, 165),
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
            "About Us",
            style: TextStyle(
              color: const Color.fromARGB(255, 89, 89, 89),
              fontSize: 16,
              fontFamily: GoogleFonts.raleway().fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 20),
        TextButton(
          onPressed: () {
            GoRouter.of(context).go('/register');
          },
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 165, 165, 165),
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
            "Contact",
            style: TextStyle(
              color: const Color.fromARGB(255, 89, 89, 89),
              fontSize: 16,
              fontFamily: GoogleFonts.raleway().fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDownloadBanner(){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Stack(
      children: [
        const Text(
          "DOWNLOAD",
          style: TextStyle(
            fontSize: 60,
            fontFamily: "Etna",
            fontWeight: FontWeight.bold,
          )
        ),
        Positioned(
          top: 1000, 
          left: 50, 
          right: 50,
          child: Image.network('https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/aaron-huber-s95oB2n9jng-unsplash.jpg', 
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 50, 
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Icons.android),
                    Text('Android'),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Icons.apple),
                    Text('App Store'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
    
  }

  Widget _buildBelowCardContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
