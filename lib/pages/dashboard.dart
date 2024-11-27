import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_stay/api/models/properties.dart';
import 'package:safe_stay/api/riverpod/property_state.dart';
import 'package:safe_stay/api/riverpod/authentication_state.dart';
import 'package:safe_stay/components/product_card.dart';
import 'package:safe_stay/components/add_property_dialog.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    String getName = authState.user?.id as String;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header with app name and profile dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Safe Stay",
                    style: TextStyle(
                      fontFamily: 'Etna',
                      fontSize: 30,
                      color: Color.fromARGB(255, 34, 124, 29),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const AddPropertyDialog(),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 190, 190, 190),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          textStyle: TextStyle(
                            fontFamily: GoogleFonts.raleway().fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          minimumSize: const Size(125, 60),
                        ),
                        child: const Text('ADD A PROPERTY'),
                      ),
                      const SizedBox(width: 10),
                      PopupMenuButton<String>(
                        offset: const Offset(0, 60),
                        color: const Color.fromRGBO(34, 124, 29, 1),
                        child: TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(34, 124, 29, 1),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            minimumSize: const Size(125, 60),
                          ),
                          child: Text(
                            getName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'etna',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'profile',
                            child: const Text(
                              'My Profile',
                              style: TextStyle(
                                  fontFamily: 'etna', color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                          PopupMenuItem<String>(
                            value: 'listings',
                            child: const Text(
                              'My Listings',
                              style: TextStyle(
                                fontFamily: 'etna',
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                context.go('/my-listings');
                              });
                            },
                          ),
                          PopupMenuItem<String>(
                            value: 'account',
                            child: const Text(
                              'My Account',
                              style: TextStyle(
                                  fontFamily: 'etna', color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                          PopupMenuItem<String>(
                            value: 'logout',
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                  fontFamily: 'etna', color: Colors.white),
                            ),
                            onTap: () async {
                              await ref.read(authProvider.notifier).signOut();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildContainer(context),
            const SizedBox(height: 20),
            _buildBelowCardContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    final fetchProperties = ref.watch(fetchPropertyList);

    return fetchProperties.when(
      data: (properties) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 120),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildDashboardHeader(),
                const SizedBox(height: 20),
                // Product Card Integration using Wrap
                Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  alignment: WrapAlignment.start,
                  children: properties.map((property) {
                    return SizedBox(
                      width: 300, // Square width
                      height: 400, // Square height
                      child: ProductCard(
                        propertyList: properties,
                        index: properties.indexOf(property),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
      error: (err, stackTrace) => Text('Error fetching data from table: $err'),
      loading: () => const LinearProgressIndicator(
        backgroundColor: Color.fromRGBO(48, 203, 34, 1),
      ),
    );
  }

  Widget _buildDashboardHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(34, 124, 29, 1),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 30),
          Text(
            "Find your property here",
            style: TextStyle(
              fontFamily: GoogleFonts.raleway().fontFamily,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
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
          color: Color.fromARGB(255, 34, 124, 29),
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
                      child: Image.network(
                          'https://qpetohtluhvwrrpletja.supabase.co/storage/v1/object/public/assets/logo.png'),
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
