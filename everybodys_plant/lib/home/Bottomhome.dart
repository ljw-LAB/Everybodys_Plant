import 'package:flutter/material.dart';

class BottomHomePage extends StatefulWidget {
  final String? nickname;
  final String? plantname;
  final String? memo;
  const BottomHomePage(
      {Key? key,
      @required this.nickname,
      @required this.plantname,
      @required this.memo})
      : super(key: key);

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
                child: Column(
                  children: [
                    Text('${widget.nickname}'),
                    Text('${widget.plantname}'),
                    Text('${widget.memo}'),
                  ],
                ),
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
