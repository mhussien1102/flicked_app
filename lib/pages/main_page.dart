import 'dart:ui';
import 'package:flicked_app/models/movie.dart';
import 'package:flicked_app/models/search_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  static double deviceWidth = 0;
  static double deviceHeight = 0;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: deviceWidth,
        height: deviceHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [buildBackground(), buildForeground()],
        ),
      ),
    );
  }

  Widget buildBackground() {
    return Container(
      height: deviceHeight, // ✅ بقت متاحة هنا
      width: deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images-na.ssl-images-amazon.com/images/I/91B32iU7ayL._AC_SL1500_.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget buildForeground() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, deviceHeight * 0.02, 0, 0),
      width: deviceHeight * 0.88,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          topBarWidget(),
          Container(
            height: deviceHeight * 0.83,
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
            child: MoviesListViewWidget(),
          ),
        ],
      ),
    );
  }

  Widget topBarWidget() {
    return Container(
      height: deviceHeight * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.black54,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [searchBarWidget(), categorySelcetionWidget()],
      ),
    );
  }

  Widget searchBarWidget() {
    final _border = InputBorder.none;
    return SizedBox(
      height: deviceHeight * 0.05,
      width: deviceWidth * 0.50,
      child: TextField(
        controller: searchController,
        onSubmitted: (intput) {},
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: _border,
          border: _border,
          prefixIcon: Icon(Icons.search, color: Colors.white24),
          hintText: 'Search....',
          hintStyle: TextStyle(color: Colors.white54),
          filled: false,
          fillColor: Colors.white24,
        ),
      ),
    );
  }

  Widget categorySelcetionWidget() {
    return DropdownButton(
      icon: Icon(Icons.menu, color: Colors.white24),
      dropdownColor: Colors.black38,
      value: SearchCategory.popular,
      underline: Container(height: 1, color: Colors.white24),
      onChanged: (value) {},
      items: [
        DropdownMenuItem(
          value: SearchCategory.popular,
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.upComing,
          child: Text(
            SearchCategory.upComing,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.none,
          child: Text(
            SearchCategory.none,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget MoviesListViewWidget() {
    final List<Movie> movie = [];

    for (int i = 0; i < 20; i++) {
      movie.add(
        Movie(
          name: 'War of the Worlds',
          language: "EN",
          isAdult: false,
          description:
              'Will Radford is a top analyst for Homeland Security who tracks potential threats through a mass surveillance program, until one day an attack by an unknown entity leads him to question whether the government is hiding something from him... and from the rest of the world.',
          posterPath: '/yvirUYrva23IudARHn3mMGVxWqM.jpg',
          rating: 8.3,
          releaseDate: '7-4-2021',
          backdropPath: "/kqHypb4MdEBUFiphf49bK99T4cn.jpg",
        ),
      );
    }

    if (movie.isNotEmpty) {
      return ListView.builder(
        itemCount: movie.length,
        itemBuilder: (context, count) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: deviceHeight * 0.01,
              horizontal: 0,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Text(movie[count].name),
            ),
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white),
      );
    }
  }
}
