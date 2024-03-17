import 'package:assignmentfinal/constants.dart';
import 'package:assignmentfinal/screens/search.dart';
import 'package:assignmentfinal/screens/setttings.dart';
import 'package:assignmentfinal/screens/signin.dart';
import 'package:assignmentfinal/screens/watchList.dart';
import 'package:assignmentfinal/screens/watched.dart';
import 'package:assignmentfinal/widgets/carouselTrend.dart';
import 'package:assignmentfinal/widgets/normalSliders.dart';
import 'package:assignmentfinal/widgets/reusedwidgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Trivia.dart';
import 'package:assignmentfinal/api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final Future<List<dynamic>> _apiData;
  int _selectedIndex = 0;
  bool _isLoggedin = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _apiData = _fetchData();
    _checkLoginStatus();
  }

  bool showDaily = true;

  Future<List<dynamic>> _fetchData() async {
    final List<Future> futures = [
      api.trendingMoviesDay(),
      api.trendingMoviesWeek(),
      api.upcomingMovies(),
      api.topRatedTV(),
      api.topRatedM(),
      api.popularTV(),
      api.mostGrossingM(),
      api.popularMovies(),
      api.nowplaying()
    ];

    // Wait for all API calls to complete
    final List<dynamic> responses = await Future.wait(futures);
    return responses;
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedin = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoggedin) {
      return const SignIn();
    }
    return FutureBuilder(
      future: _apiData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            ),
          );
        } else {
          return Scaffold(
            key: _scaffoldKey,
            appBar: defaultAppBar(),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Row(children: [
                      Image(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.cover,
                        height: 60,
                      ),
                      Image(
                        image: AssetImage("assets/logotext.png"),
                        fit: BoxFit.cover,
                        height: 30,
                        width: 100,
                      )
                    ]),
                  ),
                  ListTile(
                    title: textstyledrawer("Watch List", 15.0),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const watchList()));
                    },
                  ),
                  ListTile(
                    title: textstyledrawer("Watched", 15.0),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Watched()));
                    },
                  ),
                  ListTile(
                    title: textstyledrawer("settings", 15.0),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => Settings())));
                    },
                  )
                  // Add more list tiles as needed
                ],
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [topBGColor, middleBGColor, bottomBGColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Column(
                    children: [
                      verticalSpace(20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Welcome!!",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                verticalSpace(5),
                              ]),
                        ],
                      ),
                      verticalSpace(20),
                      Row(
                        children: [
                          textstyle1(20, "Trending Movies"),
                          horizontalSpace(70),
                          TextButton(
                            //Toggle between trending movies daily and weekly
                            onPressed: () {
                              setState(() {
                                showDaily = !showDaily;
                              });
                            },
                            child: Text(showDaily ? 'Daily' : 'Weekly',
                                selectionColor: Colors.amber,
                                style: const TextStyle(
                                  fontSize: 16,
                                )),
                          ),
                        ],
                      ),
                      verticalSpace(10),
                      SizedBox(
                        height: 350,
                        child: carouselSlide(
                          response: showDaily
                              ? api.trendingMoviesListDay
                              : api.trendingMoviesListWeek,
                          onclick: false,
                          flag: true,
                        ),
                      ),
                      verticalSpace(10),
                      textstyle1(20, "On Theatres  : "), //Whats on theatres
                      verticalSpace(10),
                      SizedBox(
                        height: 300,
                        child: triviaslide(
                          response: api.nowShowingList,
                          onclick: false,
                          isMovie: true,
                        ),
                      ),
                      verticalSpace(10),
                      textstyle1(20, "Top Rated Movies  : "),
                      verticalSpace(10),
                      SizedBox(
                        height: 300,
                        child: triviaslide(
                          response: api.topRatedMList,
                          onclick: false,
                          isMovie: true,
                        ),
                      ),
                      verticalSpace(10),
                      textstyle1(20, "Top Rated TV Shows  : "),
                      verticalSpace(10),
                      SizedBox(
                        height: 300,
                        child: triviaslide(
                          response: api.topRatedTVList,
                          onclick: false,
                          isMovie: true,
                        ),
                      ),
                      verticalSpace(10),
                      verticalSpace(10),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                if (index == 0) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Home()));
                } else if (index == 1) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Search()));
                } else if (index == 2) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => trivia(
                            popularMoviesList: api.popularM,
                            popularTV: api.populartv,
                            upcomingM: api.upcomingMoviesList,
                            highestgrossingM: api.highestGrossM,
                          )));
                }
              },
            ),
          );
        }
      },
    );
  }
}
