import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {

  ///Constructor
  HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            //Columnの中央揃え
//        mainAxisSize: MainAxisSize.min,
            //上端揃え
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              ///プロフィールカード
              _myCard(
                width: 400.0,
                height: 150.0,
                cardColor: null,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: null,
                      child: FittedBox(
                        child: Text(
                          'User Image',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      minRadius: 40.0,
                      maxRadius: 60.0,
                      backgroundColor: Colors.grey,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  ///自作CardWidget
  Widget _myCard({double width, double height, Color cardColor, Widget child}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1.0,
            blurRadius: 10.0,
            offset: Offset(10, 10),
          ),
        ],
      ),
      width: width,
      height: height,
      margin: EdgeInsets.all(10.0),
      child: Card(
        color: cardColor,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: child,
        ),
      ),
    );
  }

}