import 'dart:math';

import 'package:flutter/material.dart';
import 'package:radiusformula/widgets/corner_side.dart';
import 'package:radiusformula/widgets/label.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radius Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Radius Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _padding = 24;
  double _inner = 40;
  double _outer = 64;

  _onPaddingChange(double value) {
    setState(() {
      _padding = value;
      _inner = (_outer - _padding) < 0 ? 0 : _outer - _padding;
    });
  }

  _onInnerChange(double value) {
    setState(() {
      _inner = value;
      _outer = _padding + _inner;
    });
  }

  _onOuterChange(double value) {
    setState(() {
      _outer = value;
      _inner = (_outer - _padding) < 0 ? 0 : _outer - _padding;
    });
  }

  _randomize() {
    Random random = Random();

    setState(() {
      _inner = random.nextInt(80) + 10;
      _padding = random.nextInt(50) + 10;
      _outer = _padding + _inner;
    });
  }

  Widget _badgeText(String text, {Color? labelColor}) {
    return Text(
      text,
      style: TextStyle(
        color: labelColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 306,
              width: 306,
              alignment: Alignment.center,
              foregroundDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFFFFF),
                    Color.fromARGB(0, 255, 255, 255),
                  ],
                  stops: [0.25, 0.75],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomPaint(
                    foregroundPainter: CornerSidePainter(
                      radius: _outer,
                      borderColor: Colors.green.shade300,
                    ),
                    child: Container(
                      height: 300,
                      width: 300,
                      padding: EdgeInsets.all(_padding),
                      child: CustomPaint(
                        foregroundPainter: CornerSidePainter(
                          radius: _inner,
                          borderColor: Colors.blue.shade300,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -40,
                    left: -35,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Center(
                        child: _badgeText(
                          _outer.round().toString(),
                          labelColor: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 60,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Center(
                        child: _badgeText(
                          _inner.round().toString(),
                          labelColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: 2,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: _padding - 4,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                        ),
                        child: Center(
                          child: _badgeText(
                            _padding.round().toString(),
                            labelColor: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 40,
                right: 20,
                left: 20,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFebeaed),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFd5d7d9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    width: double.maxFinite,
                    child: const Text(
                      "Outer Radius = Inner Radius + Padding",
                      style: TextStyle(
                        color: Color(0xFF77797b),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Label(
                        title: "Outer",
                        value: _outer,
                        color: Colors.green,
                      ),
                      Expanded(
                        child: Slider(
                          activeColor: Colors.green,
                          thumbColor: Colors.white,
                          value: _outer,
                          min: 0,
                          max: (100 + _padding),
                          divisions: 100,
                          label: _outer.round().toString(),
                          onChanged: _onOuterChange,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Label(
                        title: "Inner",
                        value: _inner,
                        color: Colors.blue,
                      ),
                      Expanded(
                        child: Slider(
                          activeColor: Colors.blue,
                          thumbColor: Colors.white,
                          value: _inner,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          label: _inner.round().toString(),
                          onChanged: _onInnerChange,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Label(
                        title: "Padding",
                        value: _padding,
                        color: Colors.amber,
                      ),
                      Expanded(
                        child: Slider(
                          activeColor: Colors.amber,
                          thumbColor: Colors.white,
                          value: _padding,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          label: _padding.round().toString(),
                          onChanged: _onPaddingChange,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    onPressed: _randomize,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: const Color(0xFFd5d7d9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(14),
                      child: const Center(
                        child: Text(
                          "Randomize",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
