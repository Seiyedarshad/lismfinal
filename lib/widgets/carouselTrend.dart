import 'package:assignmentfinal/api.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screens/SingleMovie.dart';

class carouselSlide extends StatelessWidget {
  final bool flag; // true- Movie, False, TV
  final List<dynamic> response;
  final bool onclick;

  carouselSlide(
      {super.key,
      required this.response,
      required this.flag,
      required this.onclick});

  RegExp regex = RegExp(r'\b\d{4}\b');

  @override
  Widget build(BuildContext context) {
    bool isMovie = flag;
    return CarouselSlider(
      options: CarouselOptions(
        height: 350,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: response.map((movie) {
        String title = movie['original_title'] ?? movie['name'] ?? 'Unknown';
        String? firstAirDate = movie['first_air_date'];
        String? releaseDate = movie['release_date'];
        String date = firstAirDate ?? releaseDate ?? '-';
        String year = regex.stringMatch(date) ?? '-';

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => viewMoviesTv(
                movie: flag
                    ? api.viewMovie(movie['id'])
                    : api.viewShow(movie['id']),
                isMovie: isMovie,
              ),
            ));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.transparent, // Background color for each item
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10.0),
                        bottom: Radius.circular(10.0)),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500/${movie["poster_path"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1, // Limiting to two lines
                            overflow: TextOverflow
                                .ellipsis, // Truncate with ellipsis if exceeds two lines
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            year,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
