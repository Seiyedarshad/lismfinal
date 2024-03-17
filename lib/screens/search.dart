import 'package:assignment/api.dart';
import 'package:assignment/screens/Trivia.dart';
import 'package:assignment/screens/home.dart';
import 'resultsSearch.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/reusedwidgets.dart';

class Search extends StatefulWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _selectedType = true;
  String type = "movie";
  final _formKey = GlobalKey<FormState>();
  final SearchController = TextEditingController();
  bool _showPanel = false; // Track whether to show the panel
  int _selectedIndex = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [topBGColor, middleBGColor, bottomBGColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  verticalSpace(300),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: reusedTextField(
                                "Search Yout heart out",
                                SearchController,
                                false,
                                Icons.search_off_rounded,
                              ),
                            ),
                            horizontalSpace(5),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _showPanel = !_showPanel;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.filter_7_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_showPanel) ...[
                          verticalSpace(10),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Filter by',
                                    selectionColor: Colors.amberAccent,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                                DropdownButton<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Movie',
                                      child: Text('Movies',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                    DropdownMenuItem(
                                      value: 'TV',
                                      child: Text('TV shows',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      if (value == 'movie') {
                                        _selectedType = true;
                                        type = value!;
                                      } else {
                                        _selectedType = false;
                                        type = value!;
                                      }
                                    });
                                  },
                                  hint: Text(
                                    '${type} ',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        verticalSpace(20),
                        Container(
                          width: double.infinity,
                          height: 45.0,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: <Color>[Colors.amberAccent, Colors.black],
                              tileMode: TileMode.mirror,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (SearchController.text != "") {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SearchResults(
                                            selectType: _selectedType,
                                            query: SearchController.text,
                                            type: '',
                                          )));
                                }
                              },
                              child: Center(
                                child: Text(
                                  "Search",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Home()));
          } else if (index == 2) {
            // Navigate to the Trivia page
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => trivia(
                    popularMoviesList: api.popularM,
                    popularTV: api.populartv,
                    highestgrossingM: api.highestGrossM,
                    upcomingM: api.upcomingMoviesList)));
          }
        },
      ),
    );
  }
}
