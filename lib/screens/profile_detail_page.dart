class Profile {
  final String name;
  final int age;
  final String address;
  final String phoneNumber;
  final String profession;
  final String id; // Add an id field

  Profile({
    required this.name,
    required this.age,
    required this.address,
    required this.phoneNumber,
    required this.profession,
     required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'address': address,
      'phone_number': phoneNumber,
      'profession': profession,
       'id': id,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'],
      age: map['age'],
      address: map['address'],
      phoneNumber: map['phone_number'],
      profession: map['profession'],
      id: map['id'], 
    );
  }
}
