import 'package:flutter/material.dart';
import 'package:assignmentfinal/constants.dart';
import 'package:assignmentfinal/widgets/trendingslider.dart';
import 'package:assignmentfinal/api.dart';

class Watched extends StatefulWidget {
  @override
  _WatchedState createState() => _WatchedState();
}

class _WatchedState extends State<Watched> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Wait for all API calls to complete
      await api.searchWatchedList();
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
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textstyle1(15, "The Movies/TV shows you Have watched : "),
                    verticalSlide(response: api.watchedList, onclick: false),
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
