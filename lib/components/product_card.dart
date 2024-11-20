import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
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
        return AlertDialog(
          title: Text('Product Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Display the information in the dialog
                Text('Name: $name'),
                Text('Location: $location'),
                Text('Price: $price'),
                Text('Image URL: $imageUrl'),
                Text('Date Listed: $dateListed'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
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
          width: 200, // Set fixed width
          height: 200, // Set fixed height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Make the image expand to fill all available space
              Expanded(
                flex: 2, // This allows the image to take up more space
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  child: Image.network(
                    imageUrl, // Use the provided image URL
                    fit: BoxFit
                        .cover, // Ensure the image scales properly to fill the container
                    width: 200, // Set width to match the container width
                  ),
                ),
              ),
              // This will ensure the footer stays at the bottom
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
