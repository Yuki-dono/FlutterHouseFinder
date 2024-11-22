import 'package:flutter/material.dart';
import 'package:safe_stay/api/models/properties.dart';

class ProductCard extends StatelessWidget {
  final List<PropertyData> propertyList;
  final int index;

  ProductCard({
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
              mainAxisSize: MainAxisSize
                  .min, // Ensures the dialog size adapts to its content
              children: [
                // Horizontally scrollable images (one at a time)
                Container(
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
                          icon: const Icon(Icons.arrow_left,
                              color: Color.fromARGB(255, 34, 124, 29)),
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
                          icon: const Icon(Icons.arrow_right,
                              color: Color.fromARGB(255, 34, 124, 29)),
                          onPressed: () {
                            // Navigate right
                            if (pageController.page! <
                                propertyList[index].propURL.length - 1) {
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDetailsDialog(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image inside the card
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: SizedBox(
                height: 106,
                child: Image.network(
                  propertyList[index].propURL[0],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    );
                  },
                ),
              ),
            ),
            // Footer with property name
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(16)),
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.green,
                child: Text(
                  propertyList[index].propName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
