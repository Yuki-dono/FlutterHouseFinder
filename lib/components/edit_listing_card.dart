import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_stay/api/models/properties.dart';

class EditListingCard extends StatelessWidget {
  final List<PropertyData> propertyList;
  final int index;

  const EditListingCard({
    Key? key,
    required this.propertyList,
    required this.index,
  }) : super(key: key);

  void _showEditDialog(BuildContext context) {
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
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Edit Listing',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle edit action
                    Navigator.of(context).pop();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Confirm Edit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Listing'),
          content: const Text('Are you sure you want to delete this listing?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle delete action
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final property = propertyList[index];

    return InkWell(
      onTap: () => _showEditDialog(context),
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
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    property.propURL[0],
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
                // Price Badge
                Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'PHP ${property.propPrice}',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.raleway().fontFamily,
                          fontSize: 12,
                        ),
                      ),
                    )),
                // Edit Badge
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Edit',
                            style: TextStyle(
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
              ],
            ),
            // Property Name
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text(
                property.propName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.raleway().fontFamily,
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            ),
            // Property Location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                property.propLocation,
                style: TextStyle(
                  fontFamily: GoogleFonts.raleway().fontFamily,
                  fontSize: 12,
                  color: Colors.green,
                ),
              ),
            ),
            // Delete Button
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () => _showDeleteConfirmationDialog(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete Listing'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
