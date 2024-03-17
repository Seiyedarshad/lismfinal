import 'package:flutter/material.dart';
import 'package:assignmentfinal/api.dart';
import 'package:assignmentfinal/localStorage.dart';
// Import local storage utilities
import 'package:assignmentfinal/widgets/reusedwidgets.dart';
import '../constants.dart';

class viewMoviesTv extends StatelessWidget {
  late Future<void> movie;
  final bool isMovie;

  viewMoviesTv({Key? key, required this.movie, required this.isMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movie,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white54,
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [topBGColor, middleBGColor, bottomBGColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Wrap the image with a container to apply gradient
                      Stack(
                        children: [
                          SizedBox(
                            height: 450,
                            child: ImageOverlayWidget(
                              imageUrl:
                                  "https://image.tmdb.org/t/p/original/${api.viewMovieTVMap["backdrop_path"]}",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(20),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            api.viewMovieTVMap["title"] ??
                                                api.viewMovieTVMap["name"] ??
                                                "l",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        horizontalSpace(10),
                                      ],
                                    ),
                                    verticalSpace(2),
                                    Text(
                                      api.viewMovieTVMap["release_date"]
                                              ?.split('-')[0] ??
                                          "",
                                      style: const TextStyle(
                                        color: Colors.white60,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${(api.viewMovieTVMap["vote_average"] * 10).toStringAsFixed(1)}%",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            verticalSpace(20),
                            Text(
                              api.viewMovieTVMap["overview"],
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      OutlinedButton(
                        onPressed: () {
                          LocalStorage.addToWatchedList(
                              api.viewMovieTVMap["id"]);
                          LocalStorage.addWatchedListType(isMovie);
                          // Save movie name to watched list
                        },
                        style: ButtonStyle(),
                        child: const Text(
                          'Watched? Click me!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      OutlinedButton(
                          onPressed: () {
                            LocalStorage.addToWatchList(
                                api.viewMovieTVMap["id"]);
                            LocalStorage.addToWatchListType(
                                isMovie); // Save movie name to to-watch list
                          },
                          child: const Text(
                            "Add to Watch List",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      verticalSpace(20),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
