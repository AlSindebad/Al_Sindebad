class UserProfile {
  String uid;
  String username;
  String email;
  String country;

  UserProfile({
    required this.uid,
    required this.username,
    required this.email,
    required this.country,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data, String uid) {
    return UserProfile(
      uid: uid,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      country: data['country'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'country': country,
    };
  }
}
