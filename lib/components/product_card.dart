import 'package:flutter/material.dart';
import 'package:safe_stay/api/models/properties.dart';

class ProductCard extends StatelessWidget {
  final List<PropertyData> propertyList;
  final int index;

  // Constructor to initialize the image URL, price, and other details
  ProductCard({
    required this.propertyList,
    required this.index,
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
                SizedBox(
                  width: 350, // Fixed width for the image carousel
                  height: 200, // Height of the carousel
                  child: PageView.builder(
                    itemCount: propertyList[index].propURL.length, 
                    itemBuilder: (BuildContext context, int index) {
                      return _buildImageCarousel(context, index);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Centered text info in the dialog
                Text(
                  'Name: ${propertyList[index].propName}',
                  textAlign: TextAlign.center,
                ),
                //Location
                Text(
                  'Location: ${propertyList[index].propLocation}',
                  textAlign: TextAlign.center,
                ),
                //Price of Property
                Text(
                  'Price: PHP ${propertyList[index].propPrice}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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

  Widget? _buildImageCarousel (BuildContext context, int imgIndex){
    return SizedBox(
        width: 350,
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            propertyList[index].propURL[imgIndex],
            width: 350, // Set the width of the image inside the carousel
            height: 200, // Set the height for consistency
            fit: BoxFit.cover,
          ),
        ),
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
        child: SizedBox(
          width: 200, // Set fixed width for the card
          height: 200, // Set fixed height for the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image inside the card
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  child: Image.network(
                    propertyList[index].propURL[0],
                    fit: BoxFit.cover,
                    width: double.infinity, // Stretch to fill available space
                  ),
                ),
              ),
              // Footer with price
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(30)),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.green,
                  child: Text(
                    propertyList[index].propName,
                    style: const TextStyle(
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
