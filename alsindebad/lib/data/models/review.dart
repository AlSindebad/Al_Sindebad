

class Review {
  final String userId;
  final int rating;

  Review({required this.userId, required this.rating});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
    };
  }

  static Review fromMap(Map<String, dynamic> map) {
    return Review(
      userId: map['userId'],
      rating: map['rating'],
    );
  }
}