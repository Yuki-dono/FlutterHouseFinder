import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blue, // You can choose any color you like
      ),
      body: Center(
        child: Text(
          'Welcome to Safe Stay',
          style: TextStyle(
            fontSize: 24, // You can adjust the font size
            fontWeight: FontWeight.bold,
            color: Colors.black, // You can change the text color
          ),
        ),
      ),
    );
  }
}
