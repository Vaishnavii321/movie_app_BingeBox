class Movie {
  final String title;
  final String summary;
  final String imageUrl;

  Movie({required this.title, required this.summary, required this.imageUrl});

  // Factory method to create a Movie object from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['show']['name'],
      summary: json['show']['summary'] ?? 'No summary available',
      imageUrl: (json['show']['image'] != null && json['show']['image']['medium'] != null) ? json['show']['image']['medium'] : 'https://via.placeholder.com/150',
    );
  }
}
