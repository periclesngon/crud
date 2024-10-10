import 'package:flutter/material.dart';
import 'package:crud/screens/homeScreen.dart'; // Adjust this import based on your project structure

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Expanded container with background image to cover available space
          Expanded(
            child: Image.network(
              'https://static.vecteezy.com/system/resources/previews/027/186/781/large_2x/happy-black-female-executive-working-on-laptop-in-contemporary-office-and-smiling-at-camera-photo.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width, // Ensures it fits the full width
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20), // Add padding for spacing
            child: ElevatedButton(
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
          ),
        ],
      ),
    );
  }
}
