import 'package:flutter/material.dart';
import 'package:crud/screens/homeScreen.dart'; // Adjust this import based on your project structure

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Container with background image, covering 3/4 of the screen
Container(
  height: MediaQuery.of(context).size.height * 0.75,
  width: MediaQuery.of(context).size.width,
  child: Image.network(
    'https://www.seatssoftware.com/wp-content/uploads/2023/12/SEAtS-imagery-23-14-900x600.png',
    fit: BoxFit.cover,
    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      }
    },
    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
      return const Center(
        child: Text(
          'Image failed to load',
          style: TextStyle(color: Colors.red),
        ),
      );
    },
  ),
),

          // Welcome text placed under the image
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'WELCOME TO zTHeCRUD!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Continue Button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(), // Replace with your HomeScreen widget
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 62, 134, 193),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
