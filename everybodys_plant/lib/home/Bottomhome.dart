import 'package:flutter/material.dart';

class BottomHomePage extends StatefulWidget {
  const BottomHomePage({Key? key}) : super(key: key);

  @override
  State<BottomHomePage> createState() => _BottomHomePageState();
}

class _BottomHomePageState extends State<BottomHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.shortestSide,
              child: Container(
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
