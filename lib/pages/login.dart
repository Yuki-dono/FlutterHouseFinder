// Routing & Backend
import 'package:carousel_slider/carousel_slider.dart';
import 'package:safe_stay/main.dart';
import 'package:safe_stay/router/router.dart';
import 'package:safe_stay/api/riverpod/authentication_state.dart';

// Flutter Imports
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final List<String> imgList = [
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/aaron-huber-s95oB2n9jng-unsplash.jpg',
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/bailey-anselme-Bkp3gLygyeA-unsplash.jpg',
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/brian-babb-XbwHrt87mQ0-unsplash%20(1).jpg',
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/dillon-kydd-2keCPb73aQY-unsplash%20(1).jpg',
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/francesca-tosolini-tHkJAMcO3QE-unsplash.jpg',
    'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/ronnie-george-9gGvNWBeOq4-unsplash.jpg'
  ];

  final userEmail = TextEditingController();
  final userPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    if (authState.status == AuthStatus.authenticating) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (authState.status == AuthStatus.error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authState.errorMessage ?? 'An error occurred'),
          ),
        );
      });
    }

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: double.infinity,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: imgList.map((imageURL) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(170.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Center(
                            child: Text(
                              "Safe Stay",
                              style: TextStyle(
                                fontFamily: 'Etna',
                                fontSize: 30,
                                color: Color.fromARGB(255, 34, 124, 29),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(34, 124, 29, 1),
                                foregroundColor: Colors.white,
                                textStyle: TextStyle(
                                  fontFamily: GoogleFonts.raleway().fontFamily,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                minimumSize: const Size(125, 60),
                              ),
                              onPressed: () {
                                GoRouter.of(context).go('/home');
                              },
                              child: const Text("BACK TO HOME"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 34, 124, 29),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Login / Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Center(
                            child: Text(
                              'Welcome to Safe Stay!',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: userEmail,
                                  decoration: InputDecoration(
                                    hintText: 'Email Address',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 34, 124, 29),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: userPass,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 34, 124, 29),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  obscureText: true,
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final email = userEmail.text.trim();
                                      final password = userPass.text.trim();

                                      if (email.isEmpty || password.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('Please fill in all fields')),
                                        );
                                        return;
                                      }

                                      try {
                                        await ref.read(authProvider.notifier).signInWithEmail(email, password);
                                      } catch (_) {
                                        try {
                                          await ref.read(authProvider.notifier).signUp(email, password);
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Error signing up: ${e.toString()}'),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    ),
                                    child: const Text(
                                      "Continue",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        "OR WITH",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      ref
                                          .read(authProvider.notifier)
                                          .signInWithGoogle();
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.google,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                    label: Text("",
                                        style: GoogleFonts.raleway(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      ref.read(authProvider.notifier).signInAnonymously();
                                    },
                                    icon: const Icon(
                                      Icons.person,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    label: Text("",
                                        style: GoogleFonts.raleway(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}