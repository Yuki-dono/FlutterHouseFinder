import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl; // Keep this as a single image URL
  final String price;
  final String name;
  final String location;
  final String dateListed;

  // Constructor to initialize the image URL, price, and other details
  ProductCard({
    required this.imageUrl,
    required this.price,
    required this.name,
    required this.location,
    required this.dateListed,
  });

  // Function to display the dialog
  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: Container(
            width: 400, // Custom width for the dialog
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Dialog size adapts to content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Image carousel using PageView
                Container(
                  width: 350, // Fixed width for the image carousel
                  height: 200, // Height of the carousel
                  child: PageView(
                    children: [
                      // First image from the product URL
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl,
                          width:
                              350, // Set the width of the image inside the carousel
                          height: 200, // Set the height for consistency
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Second mock image (placeholder)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://via.placeholder.com/350x200', // Example second image
                          width:
                              350, // Set the width of the image inside the carousel
                          height: 200, // Set the height for consistency
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Third mock image (another placeholder)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://via.placeholder.com/350x200?text=Image+3', // Another placeholder
                          width:
                              350, // Set the width of the image inside the carousel
                          height: 200, // Set the height for consistency
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Centered text info in the dialog
                Text(
                  'Date Listed: $dateListed',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Name: $name',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Location: $location',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Price: $price',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Close button aligned at the bottom
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ),
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
      onTap: () => _showDetailsDialog(context), // Show the dialog on tap
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: 200, // Set fixed width for the card
          height: 200, // Set fixed height for the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image inside the card
              Expanded(
                flex: 2, // Image takes more space
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  child: Image.network(
                    imageUrl, // Display the image
                    fit: BoxFit.cover,
                    width: 200, // Match the container's width
                  ),
                ),
              ),
              // Footer with price
              ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.green,
                  child: Text(
                    price,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
