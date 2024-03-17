import 'package:flutter/material.dart';
import 'package:assignmentfinal/constants.dart';
import 'package:assignmentfinal/widgets/trendingslider.dart';
import 'package:assignmentfinal/api.dart';

class watchList extends StatefulWidget {
  const watchList({super.key});

  @override
  _watchListState createState() => _watchListState();
}

class _watchListState extends State<watchList> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Wait for all API calls to complete
      await api.searchtoWatchList();
    } catch (error) {
      print('Error fetching watched list: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(),
      body: FutureBuilder(
        future: _fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || api.watchedList == null) {
            return Center(child: Text('Error fetching data'));
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [topBGColor, middleBGColor, bottomBGColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textstyle1(15,
                        "The Movies/TV shows you Have on your Watch List : "),
                    verticalSlide(response: api.towatchedList, onclick: false),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
