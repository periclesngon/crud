import 'package:flutter/material.dart';
import 'dart:math'; // For flipping animation
import 'package:crud/screens/add_profile.dart';
import 'package:crud/screens/profile_detail_page.dart';
import 'edit_profile_page.dart';

// Global list of profiles to simulate a database
List<Profile> profiles = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Flipping animation repeats
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('zTHeCRUD'),
        backgroundColor: Colors.white12,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the welcome page (just a placeholder here)
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Placeholder()));
            },
          )
        ],
      ),
      body: Row(
        children: [
          // Blue container taking 1/4 of the width for buttons
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            color: const Color.fromARGB(255, 90, 152, 203),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Add Profile page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProfilePage())); // No profile data (new)
                  },
                  child: const Text('Add Profile'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Edit Profile page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()));
                  },
                  child: const Text('Edit Existing Profile'),
                ),
              ],
            ),
          ),

          // Expanded area with background image, title, and welcome animation
          Expanded(
            child: Column(
              children: [
                // Container with web image taking 3/4 of the available space
               Container(
  height: MediaQuery.of(context).size.height * 0.75,
  width: double.infinity,
  child: Image.network(
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnkxfJirB8PCdExcEmRAxbnsjpz22v-c6d-w&s",
    scale: 1.0,
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
    fit: BoxFit.cover,
  ),
),

                // Title Text positioned under the image
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Here you can enter your details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Flipping container with "Welcome" text under the title
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(_controller.value * pi),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.blue, // Blue color as requested
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
