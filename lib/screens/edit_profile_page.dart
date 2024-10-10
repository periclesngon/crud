import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crud/screens/add_profile.dart'; // Ensure you have the correct import for your homescreen
import 'package:crud/screens/profile_detail_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  List<Profile> profiles = []; // Replace with your actual profiles data

  @override
  void initState() {
    super.initState();
    fetchProfiles(); // Ensure profiles are fetched initially
  }

  // Fetch profiles from Supabase
  Future<void> fetchProfiles() async {
    final response = await Supabase.instance.client
        .from('profiles')
        .select();

    // ignore: unnecessary_null_comparison
    if (response != null && response.isNotEmpty) {
      setState(() {
        profiles = (response as List).map((profile) => Profile.fromMap(profile)).toList();
      });
    } else {
      // Handle error or empty response
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching profiles or no data available')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profiles'),
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return ListTile(
            title: Text('${profile.name}, ${profile.profession}'),
            subtitle: Text('Age: ${profile.age}, Phone: ${profile.phoneNumber}'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final editedProfile = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProfilePage.fromMap(profile: profile.toMap()),
                  ),
                );

                if (editedProfile != null) {
                  setState(() {
                    profiles[index] = Profile.fromMap(editedProfile); // Update the specific profile in the list
                  });

                  // Update in Supabase
                  await Supabase.instance.client
                      .from('profiles')
                      .update(editedProfile)
                      .eq('id', profile.id);
                }
              },
            ),
            onLongPress: () async {
              setState(() {
                profiles.removeAt(index); // Remove profile from local list
              });

              // Delete from Supabase
              await Supabase.instance.client
                  .from('profiles')
                  .delete()
                  .eq('id', profile.id);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile deleted')),
              );
            },
          );
        },
      ),
    );
  }
}
