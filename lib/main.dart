
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crud/screens/welcomepage.dart';


void main() async {
  await Supabase.initialize(
    url: 'https://qfrlpvvskqfqojsvztrb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFmcmxwdnZza3FmcW9qc3Z6dHJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjgzODQ1MzcsImV4cCI6MjA0Mzk2MDUzN30.50-O1tG3n0eVh5S-Ez4n4iE9nqo_PHc3HtYSoq42ips',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'zTHeCRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ignore: prefer_const_constructors
      home:WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
