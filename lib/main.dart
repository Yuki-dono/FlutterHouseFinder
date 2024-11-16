import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Stay',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Add some padding to the whole body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start, // Align all children to the start (left side)
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .start, // Align the content at the start of the Row
              children: [
                const SizedBox(width: 20), // Left margin for the text
                const Text(
                  'Safe Stay',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 34, 124, 29),
                  ),
                ),
                const Spacer(), // Pushes the buttons to the far right
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0), // Add spacing between buttons
                  child: TextButton(
                    onPressed: () {
                      // Add login logic here
                    },
                    style: TextButton.styleFrom(
                      side: BorderSide.none, // No border
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Square corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0), // Add padding inside the button
                    ),
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Color.fromARGB(255, 149, 149, 149),
                          fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0), // Right padding for the last button
                  child: TextButton(
                    onPressed: () {
                      // Add registration logic here
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 34, 124, 29),
                      side: BorderSide.none, // No border
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              12.0), // Bottom-left corner rounded
                          topLeft: Radius.zero, // Keep top-left corner square
                          topRight: Radius.zero, // Keep top-right corner square
                          bottomRight:
                              Radius.zero, // Keep bottom-right corner square
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0), // Add padding inside the button
                    ),
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 20.0), // Adds some padding to the top of the text area
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligns text to the start (left)
                  children: [
                    SizedBox(height: 150),
                    Row(children: [
                      SizedBox(width: 30),
                      SizedBox(
                        child: Column(
                          children: [
                            Text(
                              'Find your safe stay',
                              style: TextStyle(fontSize: 40),
                            ),
                            Text(
                              'near your university',
                              style: TextStyle(fontSize: 40),
                            ),
                          ],
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
