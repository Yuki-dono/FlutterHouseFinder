import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// State Management
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_stay/api/riverpod/authState.dart';

// Routing
import 'package:go_router/go_router.dart';
import 'package:safe_stay/router/router.dart';

// Import the ProductCard widget
import 'package:safe_stay/components/product_card.dart'; // Import the ProductCard file

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userDetails = ref.watch(authProvider).user;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Replacing AppBar with the Row widget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Safe Stay",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 34, 124, 29),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: TextButton(
                    onPressed: () async {
                      await ref.read(authProvider.notifier).signOut();
                    },
                    child: const Text(
                      'LOGOUT',
                      style: TextStyle(
                        fontSize: 24, // You can adjust the font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // You can change the text color
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Space between row and card

            // Main Card you requested
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Card(
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
                        color: Colors.green,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: const Row(children: [
                        SizedBox(width: 30),
                        Text(
                          "Find your property here",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 20),

                    // Product Card Integration
                    ProductCard(
                      imageUrl: 'https://via.placeholder.com/150',
                      price: '\$19.99',
                      name: 'Sample Property', // Added name
                      location: 'New York, NY', // Added location
                      dateListed: '2024-11-21', // Added date listed
                    ),
                    const SizedBox(
                        height: 20), // Space between product card and text
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
