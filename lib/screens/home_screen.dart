import 'package:flutter/material.dart';

import '/api/anime_api.dart';
import '/screens/anime_detail_screen.dart.dart';
import '/widgets/anime_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    AnimeApi.fetchAnimes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AnimeApi.fetchAnimes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data != null) {
          final animes = snapshot.data!;

          return Scaffold(
            appBar: AppBar(title: const Text('Animes List')),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: ListView.builder(
                itemCount: animes.length,
                itemBuilder: (context, index) {
                  final anime = animes.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AnimeDetailScreen(
                            anime: anime,
                          ),
                        ),
                      );
                    },
                    child: AnimeTile(anime: anime),
                  );
                },
              ),
            ),
          );
        }

        return Center(
          child: Text(
            snapshot.error.toString(),
          ),
        );
      },
    );
  }
}
