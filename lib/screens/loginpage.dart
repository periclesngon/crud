import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'homeScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  // Function to handle login using Supabase Auth
  Future<void> _handleLogin() async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: _idController.text,
        password: _passwordController.text,
      );

      if (response.user != null) {
        // Login successful, navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  HomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = "Login failed. Please check your credentials.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with Supabase'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email (or ID) TextField
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Error Message
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
