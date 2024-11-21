// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

//Backend
import 'package:safe_stay/api/db_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Backend
import 'package:safe_stay/api/models/properties.dart';
import 'package:safe_stay/api/riverpod/property_state.dart';
import 'package:safe_stay/api/riverpod/authentication_state.dart';

// Routing
import 'package:go_router/go_router.dart';
import 'package:safe_stay/router/router.dart';

// Import the ProductCard widget
import 'package:safe_stay/components/product_card.dart'; // Import the ProductCard file

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardScreen>{

  @override
  Widget build(BuildContext context) {
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
            _buildContainter(context),
            // Main Card you requested
            
          ],
        ),
      ),
    );
  }

  Widget _buildContainter(BuildContext context){
    final fetchProperties = ref.watch(fetchPropertyList);

    return fetchProperties.when(
      data: (properties) {
        return Container(
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
                _buildDashboardHeader(),
                const SizedBox(height: 20),
                //Insert Product Card here
                // Product Card Integration
                Container(
                  child: ListView.builder(
                    itemCount: properties.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(propertyList: properties, index: index);
                    },
                  ),
                ),
                const SizedBox( height: 20), // Space between product card and text
              ],
            ),
          ),
        );
      }, 
      error: (err, stackTrace) => Text('Error fetching data from table: $err'), 
      loading: () => const LinearProgressIndicator(
        backgroundColor: Color.fromRGBO(48, 203, 34, 1),
      )
    );
  }

  Widget _buildDashboardHeader(){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: const Row(
        children: [
          SizedBox(width: 30),
          Text(
            "Find your property here",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}


  

