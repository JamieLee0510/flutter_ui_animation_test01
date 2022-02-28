import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorAnimation;
  Animation _otherColorAnimation;
  Animation _sizeAnimation;
  bool changed;
  List<bool> _controllList;

  void initData() {
    changed = false;
    _controllList = [false, false, false];
  }

  @override
  void initState() {
    initData();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _colorAnimation = ColorTween(
            begin: const Color(0xFFD2A0B5).withOpacity(0.4),
            end: const Color(0xFF576487))
        .animate(_animationController);

    _otherColorAnimation = ColorTween(
            begin: const Color(0xFFD2A0B5).withOpacity(0.4),
            end: const Color(0xFF7651DE).withOpacity(0.3))
        .animate(_animationController);

    _sizeAnimation =
        Tween<double>(begin: 144, end: 200).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void startStopAnimation() {
    if (!changed) {
      if (_animationController.isCompleted) {
        //Check if animation is at endpoint
        _animationController.value = 0;
      }
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      changed = !changed;
    });
  }

  void change01() {
    setState(() {
      _controllList = [true, false, false];
    });
    startStopAnimation();
  }

  void change02() {
    setState(() {
      _controllList = [false, true, false];
    });
    startStopAnimation();
  }

  void change03() {
    setState(() {
      _controllList = [false, false, true];
    });
    startStopAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Center(
                    child: GestureDetector(
                  onTap: change01,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (BuildContext context, Widget child) {
                      return Container(
                        height: _controllList[0] ? _sizeAnimation.value : 144,
                        width: _controllList[0] ? _sizeAnimation.value : 144,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _controllList[0]
                              ? _colorAnimation.value
                              : _otherColorAnimation.value,
                          border: Border.all(color: Colors.white),
                        ),
                      );
                    },
                  ),
                )),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                child: Center(
                    child: GestureDetector(
                  onTap: change02,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (BuildContext context, Widget child) {
                      return Container(
                        height: _controllList[1] ? _sizeAnimation.value : 144,
                        width: _controllList[1] ? _sizeAnimation.value : 144,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _controllList[1]
                              ? _colorAnimation.value
                              : _otherColorAnimation.value,
                        ),
                      );
                    },
                  ),
                )),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                child: Center(
                    child: GestureDetector(
                  onTap: change03,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (BuildContext context, Widget child) {
                      return Container(
                        height: _controllList[2] ? _sizeAnimation.value : 144,
                        width: _controllList[2] ? _sizeAnimation.value : 144,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _controllList[2]
                              ? _colorAnimation.value
                              : _otherColorAnimation.value,
                        ),
                      );
                    },
                  ),
                )),
              ),
            ],
          ),

          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
