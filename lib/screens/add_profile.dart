import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crud/screens/profile_detail_page.dart';

class AddProfilePage extends StatefulWidget {
  final Profile? profile; // Accepting a Profile parameter

  const AddProfilePage({super.key, this.profile}); // Constructor

  // Update the constructor to accept a Map type for profile
  AddProfilePage.fromMap({super.key, required Map<String, dynamic> profile}) 
      : profile = Profile.fromMap(profile);
  @override
  _AddProfilePageState createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? name, address, phoneNumber, profession;
  int? age;
  List<dynamic> profiles = [];

  @override
  void initState() {
    super.initState();
    fetchProfiles();
    if (widget.profile != null) { // Check if a profile is provided
      // Initialize form fields with profile data
      name = widget.profile!.name;
      age = widget.profile!.age;
      address = widget.profile!.address;
      phoneNumber = widget.profile!.phoneNumber;
      profession = widget.profile!.profession;
    }
  }

  Future<void> fetchProfiles() async {
    try {
      final response = await Supabase.instance.client.from('profiles').select();
      setState(() {
        profiles = response;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching profiles: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Input Container
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: name, // Set initial value if editing
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value;
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Age Input Container
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: age?.toString(), // Set initial value if editing
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age <= 0) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    age = int.parse(value!);
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Address Input Container
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: address, // Set initial value if editing
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    address = value;
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Phone Number Input Container
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: phoneNumber, // Set initial value if editing
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    final phone = int.tryParse(value);
                    if (phone == null || value.length < 6) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phoneNumber = value;
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Profession Input Container
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: profession, // Set initial value if editing
                  decoration: const InputDecoration(
                    labelText: 'Profession',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your profession';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    profession = value;
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Insert or update the profile in Supabase
                      try {
                        if (widget.profile != null) {
                          // Update existing profile
                          await Supabase.instance.client
                              .from('profiles')
                              .update({
                            'name': name,
                            'age': age,
                            'address': address,
                            'phone_number': phoneNumber,
                            'profession': profession,
                          })
                              .eq('id', widget.profile!.id); // Assuming profiles have an 'id' field
                        } else {
                          // Insert new profile
                          await Supabase.instance.client
                              .from('profiles')
                              .insert({
                            'name': name,
                            'age': age,
                            'address': address,
                            'phone_number': phoneNumber,
                            'profession': profession,
                          });
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile successfully saved!')),
                        );

                        fetchProfiles();
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error saving profile: $error')),
                        );
                      }
                    }
                  },
                  child: const Text('Save Profile'),
                ),
              ),
              const SizedBox(height: 20),

              // Displaying Fetched Profiles
              Expanded(
                child: ListView.builder(
                  itemCount: profiles.length,
                  itemBuilder: (context, index) {
                    final profile = profiles[index];
                    return ListTile(
                      title: Text('${profile['name']}, ${profile['profession']}'),
                      subtitle: Text('Age: ${profile['age']}, Phone: ${profile['phone_number']}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
