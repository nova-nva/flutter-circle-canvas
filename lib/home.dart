import 'dart:async';
import 'dart:math';

import 'package:canvas2/modelos.dart';
import 'package:flutter/material.dart';

import 'graficos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<ModeloPunto> vPunto = [];
  var rnd = Random();
  Future timerDelete (List<ModeloPunto> vp){
    Completer completer = Completer();
    Timer(Duration(milliseconds: 10), (){
      _nextDelete(vp);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            CustomPaint(painter: DibujaPunto(vPunto),),
            GestureDetector(
              onPanDown: (desp){
                setState(() {
                  double x, y;
                  x = desp.globalPosition.dx;
                  y = desp.globalPosition.dy;
                  double radio = rnd.nextDouble() * 50;
                  int r = rnd.nextInt(256);
                  int g = rnd.nextInt(256);
                  int b = rnd.nextInt(256);
                  vPunto.add(ModeloPunto(x, y, radio, Color.fromARGB(1000, r, g, b)));
                  print("X: $x, Y: $y");
                });
              },
              onPanUpdate: (desp){
                setState(() {
                  double x, y;
                  x = desp.globalPosition.dx;
                  y = desp.globalPosition.dy;
                  double radio = rnd.nextDouble() * 50;
                  int r = rnd.nextInt(256);
                  int g = rnd.nextInt(256);
                  int b = rnd.nextInt(256);
                  vPunto.add(ModeloPunto(x, y, radio, Color.fromARGB(1000, r, g, b)));
                  print("X: $x, Y: $y");
                });
              },
            )
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          color: Colors.pink,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: Icon(Icons.add_box),
                  onPressed: (){
                    setState(() {
                      double x = rnd.nextDouble() * screen.width;
                      double y = rnd.nextDouble() * screen.height;
                      double radio = rnd.nextDouble() * 50;
                      int r = rnd.nextInt(256);
                      int g = rnd.nextInt(256);
                      int b = rnd.nextInt(256);
                      vPunto.add(ModeloPunto(x, y, radio, Color.fromARGB(1000, r, g, b)));
                    });
                  }
              ),
              IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: (){
                    setState(() {
                      vPunto.clear();
                    });
                  }
              ),
              IconButton(
                  icon: Icon(Icons.cancel_schedule_send),
                  onPressed: (){
                    setState(() {
                      timerDelete(vPunto);
                    });
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  _nextDelete(List<ModeloPunto> vp){
    setState(() {
      if(vp.length > 0){
        vp.removeLast();
        timerDelete(vp);
      }
    });
  }
}
