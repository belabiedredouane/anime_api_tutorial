import 'dart:convert';

import 'package:http/http.dart' as http;

import '/models/anime.dart';

class AnimeApi {
  static Future<List<Anime>> fetchAnimes() async {
    const baseUrl = 'https://ghibliapi.vercel.app/films';

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Anime> animes = data
          .map(
            (animeData) => Anime.fromJson(animeData),
          )
          .toList();

      return animes;
    } else {
      print('Error: ${response.body}');
      print('Status Code: ${response.statusCode}');
      throw Exception('Could not retrieve data from api');
    }
  }
}
