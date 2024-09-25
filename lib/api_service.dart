import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String url = 'https://api.tvmaze.com/search/shows?q=all';

  Future<List<dynamic>> fetchMovies(String query) async {
    final response = await http.get(Uri.parse('$url$query'));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else{
      throw Exception('Failed to load movies');
    }
  }
}