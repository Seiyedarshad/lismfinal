import 'package:assignmentfinal/api.dart';
import 'package:assignmentfinal/widgets/trendingslider.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class SearchResults extends StatefulWidget {
  final String type;
  final bool selectType;
  final String query;

  const SearchResults({
    Key? key,
    required this.type,
    required this.selectType,
    required this.query,
  }) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late Future<void> searchResult;

  @override
  void initState() {
    super.initState();
    searchResult = _fetchData();
  }

  Future<List> _fetchData() async {
    String type = widget.selectType ? "movie" : "tv";
    final List<Future> response = [api.searchmoviesTV(type, widget.query)];
    return await Future.wait(response);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchResult,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black26,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(20),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.keyboard_return_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Search Results for ${widget.query}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        verticalSpace(5),
                        verticalSlide(
                          response: api.searchList,
                          onclick: false,
                        ),
                      ]),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
