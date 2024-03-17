import 'package:assignment/api.dart';
import 'package:flutter/material.dart';

import '../screens/SingleMovie.dart';

class triviaslide extends StatelessWidget {
  final bool onclick;
  final bool isMovie;
  final List<dynamic> response;

  triviaslide(
      {required this.response, required this.onclick, required this.isMovie});

  RegExp regex = RegExp(r'\d{4}');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: List.generate(response.length, (index) {
              String title = response[index]['original_title'] ??
                  response[index]['name'] ??
                  'Unknown';

              return GestureDetector(
                onTap: onclick
                    ? null
                    : () {
                        print(response[index]['id']);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => viewMoviesTv(
                            movie: isMovie
                                ? api.viewMovie(response[index]['id'])
                                : api.viewShow(response[index]['id']),
                            isMovie: isMovie,
                          ),
                        ));
                      },
                child: Container(
                  width: 180,
                  // Set the width of each container as needed
                  margin: const EdgeInsets.only(right: 8),
                  // Adjust margin as needed
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10.0),
                            bottom: Radius.circular(10.0)),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w300_and_h450_bestv2/${response[index]["poster_path"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        title,
                        style: const TextStyle(
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
        ],
      ),
    );
  }
}
