// In lib/components/product_card.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_stay/api/models/properties.dart';
import 'package:safe_stay/components/edit_property_dialog.dart'; // Import the dialog
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_stay/api/riverpod/authentication_state.dart';

class ProductCard extends ConsumerWidget {
  final List<PropertyData> propertyList;
  final int index;
  
  bool isAdmin(String email){
    const adminEmail = 'shaern@gmail.com';
    return email == adminEmail;
  }

  const ProductCard({
    super.key,
    required this.propertyList,
    required this.index,
  });

  void _showDetailsDialog(BuildContext context) {
    // Initialize a PageController to control the PageView
    PageController pageController = PageController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(16.0),

            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensures the dialog size adapts to its content
              children: [
                // Horizontally scrollable images (one at a time)
                SizedBox(
                  height: 200, // Fixed height for images (adjust as needed)
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView.builder(
                        controller: pageController,
                        itemCount: propertyList[index].propURL.length,
                        itemBuilder: (BuildContext context, int imgIndex) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              propertyList[index].propURL[imgIndex],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 50,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      // Left Navigation Button
                      Positioned(
                        left: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_left, color: Color.fromARGB(255, 34, 124, 29)),
                          onPressed: () {
                            // Navigate left
                            if (pageController.page! > 0) {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),

                      // Right Navigation Button
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_right, color: Color.fromARGB(255, 34, 124, 29)),
                          onPressed: () {
                            // Navigate right
                            if (pageController.page! < propertyList[index].propURL.length - 1) {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Property Name
                Text(
                  propertyList[index].propName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Location
                Text(
                  'Location: ${propertyList[index].propLocation}',
                  textAlign: TextAlign.center,
                ),
                // Price
                Text(
                  'Price: PHP ${propertyList[index].propPrice}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isCurrentUserAdmin = isAdmin(authState.user?.email ?? ''); // Check admin status

    return InkWell(
      onTap: () => _showDetailsDialog(context),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.network(
                    propertyList[index].propURL[0],
                    fit: BoxFit.cover,
                    width: 300,
                    height: 300,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 50,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      propertyList[index].propPrice.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.raleway().fontFamily,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.green,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          4.toString(),
                          style: TextStyle(
                            fontFamily: GoogleFonts.raleway().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text(
                propertyList[index].propName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.raleway().fontFamily,
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                propertyList[index].propLocation,
                style: TextStyle(
                  fontFamily: GoogleFonts.raleway().fontFamily,
                  fontSize: 12,
                  color: Colors.green,
                ),
              ),
            ),
            if (isCurrentUserAdmin) // Conditionally render the Edit button
              ElevatedButton(
                onPressed: () {
                  _showEditDialog(context, ref);
                },
                child: const Text('Edit'),
              ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => EditPropertyDialog(
        property: propertyList[index],
        propertyId: propertyList[index].propID, // Pass the property data to the dialog
      ),
    );
  }
}