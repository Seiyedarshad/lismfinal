import 'package:assignment/constants.dart';
import 'package:assignment/screens/home.dart';
import 'package:assignment/screens/search.dart';
import 'package:assignment/screens/setttings.dart';
import 'package:assignment/screens/watchList.dart';
import 'package:assignment/screens/watched.dart';
import 'package:assignment/widgets/normalSliders.dart';
import 'package:assignment/widgets/reusedwidgets.dart';
import 'package:flutter/material.dart';

class trivia extends StatefulWidget {
  final List<dynamic> highestgrossingM;
  final List<dynamic> popularMoviesList;
  final List<dynamic> upcomingM;
  final List<dynamic> popularTV;

  trivia({
    Key? key,
    required this.highestgrossingM,
    required this.popularMoviesList,
    required this.upcomingM,
    required this.popularTV,
  }) : super(key: key);

  @override
  _triviaState createState() => _triviaState();
}

class _triviaState extends State<trivia> {
  int _selectedIndex = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 202, 212),

        title: const Row(children: [
          Image(
            image: AssetImage('assets/logotext.png'),
            alignment: Alignment.center,
            height: 300,
            width: 150,
          ),
        ]),

        // Other app bar properties...
      ),
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => watchList()));
              },
            ),
            ListTile(
              title: textstyledrawer("Watched", 15.0),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Watched()));
              },
            ),
            ListTile(
              title: textstyledrawer("settings", 15.0),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => Settings())));
              },
            )
            // Add more list tiles as needed
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 63, 202, 212),

      // Other app bar properties...

      body: Container(
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
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              verticalSpace(50),
              textstyle1(17.5, "Most Popular Movies of All time"),
              verticalSpace(10),
              SizedBox(
                height: 350,
                child: triviaslide(
                  response: widget.popularMoviesList,
                  onclick: false,
                  isMovie: true,
                ),
              ),
              textstyle1(17.5, "Most Popular TV Shows of All time"),
              verticalSpace(10),
              SizedBox(
                height: 350,
                child: triviaslide(
                  response: widget.popularTV,
                  onclick: false,
                  isMovie: false,
                ),
              ),
              verticalSpace(10),
              textstyle1(17.5, "Highest Grossing Movies"),
              verticalSpace(10),
              SizedBox(
                height: 350,
                child: triviaslide(
                  response: widget.highestgrossingM,
                  onclick: false,
                  isMovie: true,
                ),
              ),
              textstyle1(17.5, "Upcoming Movies"),
              verticalSpace(10),
              SizedBox(
                height: 350,
                child: triviaslide(
                  response: widget.upcomingM,
                  onclick: false,
                  isMovie: true,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 0) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Home()));
            } else if (index == 1) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Search()));
            }
          });
        },
      ),
    );
  }
}
