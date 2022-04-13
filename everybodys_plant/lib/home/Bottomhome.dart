import 'package:flutter/material.dart';

class BottomHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ListView(
        children: <Widget>[
          _pageOfTop(), // 상단
          _pageOfMiddle(), // 중단
          _pageOfBottom(), // 하단
        ],
      ),
    );
  }
}

Widget _pageOfTop() {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.directions_bike,
                size: 40,
              ),
              Text('자전거'),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.directions_run,
                size: 40,
              ),
              Text('달리기'),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.directions_bus,
                size: 40,
              ),
              Text('버스'),
            ],
          ),
        ],
      ),
      SizedBox(
        height: 30,
      ),
      // Row와 Row사이에 위치시켜서 여백 넣기
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.directions_car,
                size: 40,
              ),
              Text('자동차'),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.directions_subway,
                size: 40,
              ),
              Text('지하철'),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.directions_boat,
                size: 40,
              ),
              Text('보트'),
            ],
          ),
        ],
      )
    ],
  );
}

Widget _pageOfMiddle() {
  return Text('pageOfMiddle');
}

Widget _pageOfBottom() {
  final items = List.generate(15, (i) {
    var num = i + 1;
    return ListTile(
      leading: Icon(Icons.notifications),
      title: Text('$num번째 ListTile'),
    );
  });
  return ListView(
    physics: NeverScrollableScrollPhysics(), // 해당 리스트의 스크롤 금지
    shrinkWrap: true, // 상위 리스트 위젯이 별도로 있다면 true 로 설정해야 스크롤이 가능
    children: items,
  );
}
