import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_stay/api/models/properties.dart';
import 'package:safe_stay/api/riverpod/property_state.dart';
import 'package:safe_stay/api/riverpod/authentication_state.dart';
import 'package:safe_stay/components/product_card.dart';

//Notes for Shaheen
// 1. Rating System
// 2. Description
// 3. Add/Update
// 4. Soft-delete (Property is sold, NO DELETING!)
// 5. Upload Images to bucket -> Links directly to PropID and is an array
// 6. Profile System
// 7. Fix Routing

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header with app name and logout
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
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
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
                  alignment: WrapAlignment.spaceEvenly,
                  children: properties.map((property) {
                    return SizedBox(
                      width: 150, // Square width
                      height: 150, // Square height
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

  Widget _buildBelowCardContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Color.fromARGB(255, 34, 124, 29),
      child: const Center(
        child: Text(
          'Additional Information or Footer-like Content Goes Here',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
