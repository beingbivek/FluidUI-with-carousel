import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:liquid_menu/ui/widgets/liquid.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  AnimationController _animationController;

  Map<String, String> words = {
    'अति उत्तम': 'Awesome',
    'कुर्सी': 'Chair',
    'कुरा': 'Talk',
    'राम्रो': 'Good',
    'चरित्र': 'Character',
    'मानसिक': 'Mental',
    'देखाउनु': 'Show',
  };
  List<String> nepaliWords = [];
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    words.forEach((key, value) => nepaliWords.add(key));
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.blueAccent,
        ),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.0, left: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Remember',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.blueAccent),
                ),
                Text(
                  'Words',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.blue[400],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: false,
                onPageChanged: (value, reason) {
                  setState(() {
                    
                    _index = value + 1;
                  });
                },
              ),
              items: nepaliWords.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Liquid(
                            isFlipped: false,
                            controller: _animationController,
                            data: words[i].toString(),
                          ),
                          Liquid(
                            isFlipped: true,
                            controller: _animationController,
                            data: i,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Center(
            child: SizedBox(
              height: 50,
              child: Text('# $_index/${words.length}'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
