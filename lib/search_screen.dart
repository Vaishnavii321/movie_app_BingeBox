import 'package:flutter/material.dart';
import 'package:movie_app/api_service.dart';
import 'package:movie_app/schema.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiService apiService = ApiService();
  List<dynamic> searchResults = [];
  TextEditingController _searchController = TextEditingController();

  void searchMovies(String query) async {
    final results = await apiService.fetchMovies(query);
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search movies...',
              hintStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.white70),
              contentPadding: EdgeInsets.symmetric(vertical: 15),
            ),
            style: const TextStyle(color: Colors.white),
            onSubmitted: searchMovies,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: searchResults.isNotEmpty
          ? GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                Movie movie = Movie.fromJson(searchResults[index]);
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/details', arguments: movie);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            movie.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No results found',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
    );
  }
}

