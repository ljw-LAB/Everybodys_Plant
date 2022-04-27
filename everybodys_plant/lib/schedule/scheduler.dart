import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:date_picker_timeline/extra/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class Schedule extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SchedulePage(title: 'Everybodys Plants Schedule'),
    );
  }
}

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SchedulePage> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () {
            _controller.animateToSelection();
          },
        ),
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.blueGrey[100],
          child: Column(
            //: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: DatePicker(
                  DateTime.now(),
                  //DateTime.parse("19900101"),
                  width: 60,
                  height: 80,
                  controller: _controller,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text("You Selected:"),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(DateFormat('yy/MM/dd').format(_selectedValue)),
              //DateFormat('yyyy-MM-dd – kk:mm').format(now);
              Padding(
                padding: EdgeInsets.all(20),
              ),
            ],
          ),
        ));
  }
}
