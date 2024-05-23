class UserProfile {
  String uid;
  String name;
  String email;
  String country;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.country,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data, String uid) {
    return UserProfile(
      uid: uid,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      country: data['country'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'country': country,
    };
  }
}
