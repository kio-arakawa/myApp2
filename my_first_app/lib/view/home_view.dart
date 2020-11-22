import 'package:flutter/material.dart';
import 'package:my_first_app/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {

  ///Constructor
  HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('homeViewBuild');
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: Container(
        height: 900,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              //Columnの中央揃え
//        mainAxisSize: MainAxisSize.min,
              //上端揃え
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                ///日付表示
                Consumer<HomeViewModel>(
                  builder: (_,model,__) {
                    return _myCard(
                      isCard: false,
//                      width: 400.0,
//                      height: 80.0,
                      cardColor: Colors.deepOrangeAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Icon(
                            Icons.access_alarms,
                          ),

                          Text(
                            '  ${model.getDateTime()}',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                ///プロフィールカード
                _myCard(
                  isCard: true,
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
      ),
    );
  }

  ///自作CardWidget
  Widget _myCard({bool isCard, double width, double height, Color cardColor, Widget child}) {
    return Container(
      decoration: isCard
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1.0,
                  blurRadius: 10.0,
                  offset: Offset(10, 10),
                ),
              ],
            )
          : BoxDecoration(),
      width: width,
      height: height,
      margin: EdgeInsets.all(10.0),
      child: isCard
          ? Card(
              color: cardColor,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: child,
              ),
            )
          : Padding(
              padding: EdgeInsets.all(10.0),
              child: child,
            ),
    );
  }

}