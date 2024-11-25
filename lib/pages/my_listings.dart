import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:safe_stay/api/models/properties.dart'; // Ensure this import matches your project structure
import 'package:safe_stay/components/edit_listing_card.dart';

class MyListingScreen extends StatefulWidget {
  const MyListingScreen({super.key});

  @override
  State<MyListingScreen> createState() => _MyListingScreenState();
}

class _MyListingScreenState extends State<MyListingScreen> {
  final CarouselController _carouselController = CarouselController();

  // Mock property data
  final List<PropertyData> mockProperties = [
    PropertyData(
      propName: 'Cozy Apartment',
      propLocation: 'Downtown, City',
      propPrice: 2500.00,
      propURL: [
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750', // Replace with actual image URL
      ],
    ),
    PropertyData(
      propName: 'Luxury Villa',
      propLocation: 'Beachfront, Suburb',
      propPrice: 5000.00,
      propURL: [
        'https://images.unsplash.com/photo-1580130544977-624d0e30b923', // Replace with actual image URL
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Listings'),
        backgroundColor: const Color.fromRGBO(34, 124, 29, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const PropertyHeaderCard(title: 'Your Listings'),
            const SizedBox(height: 20),
            // Carousel Slider to replace ListView
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: mockProperties.length,
                itemBuilder: (context, index, realIndex) {
                  return EditListingCard(
                    index: index, 
                    propertyList: mockProperties,
                  );
                },
                options: CarouselOptions(
                  height: 500, // Increased height to accommodate full card
                  enableInfiniteScroll: false,
                  viewportFraction: 0.8, // Show partially visible cards on sides
                  enlargeCenterPage: true, // Makes the current card slightly larger
                  padEnds: false,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildBelowCardContainer(),
          ],
        ),
      ),
    );
  }
}

// PropertyHeaderCard Widget
class PropertyHeaderCard extends StatelessWidget {
  final String title;

  const PropertyHeaderCard({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 120),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        child: Container(
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
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Footer Container
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