import 'package:assignment/api.dart';
import 'package:flutter/material.dart';
import '../screens/SingleMovie.dart';

class verticalSlide extends StatelessWidget {
  final bool onclick;
  final List<dynamic> response;

  verticalSlide({
    required this.response,
    required this.onclick,
  });

  RegExp regex = RegExp(r'\d{4}');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(response.length, (index) {
          String title = response[index]['original_title'] ??
              response[index]['name'] ??
              'Unknown';

          return GestureDetector(
            onTap: onclick
                ? null
                : () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => viewMoviesTv(
                        movie: api.viewMovie(response[index]['id']),
                        isMovie: false,
                      ),
                    ));
                  },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w300_and_h350_bestv2/${response[index]["poster_path"]}",
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
