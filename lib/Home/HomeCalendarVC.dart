import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Models/HomeModel.dart';
import 'Views/HomeTableViewCell.dart';

class HomeCalendarVC extends StatefulWidget {
  @override
  _HomeCalendarVCState createState() => _HomeCalendarVCState();
}

class _HomeCalendarVCState extends State<HomeCalendarVC> {
  // 数据
  List<HomeModel> dataList = [
    HomeModel(0, "英语单词", 30),
    HomeModel(1, "Swift底层", 150,
        isDone: true, descriptionString: "💻晚上22:22完成了Swift的学习,明天加油!"),
    HomeModel(2, "FlutterUI", 100,
        isDone: true, descriptionString: """🤚完成了第一章的学习
⌚️完成了第一章的练习题
🍐明天开始学习第二章
    """),
    HomeModel(3, "工作", 300, isDone: false),
  ];

  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("日历"),
      ),
      body: Column(
        children: [
          _calendar(),
          _listView(),
        ],
      ),
    );
  }

  //列表
  Widget _listView() {
    return Expanded(
        child: ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return HomeTableViewCell(dataList[index]);
      },
    ));
  }

  //日历
  Widget _calendar() {
    return TableCalendar(
      locale: 'zh_CN',
      calendarController: _calendarController,
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      initialCalendarFormat: CalendarFormat.week,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      // events: _events,
      // holidays: _holidays,
      // formatAnimation: FormatAnimation.slide,
      // startingDayOfWeek: StartingDayOfWeek.sunday,
      // availableGestures: AvailableGestures.all,
      // calendarStyle: CalendarStyle(
      //   outsideDaysVisible: false,
      //   weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
      //   holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      // ),
      // daysOfWeekStyle: DaysOfWeekStyle(
      //   weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      // ),
      // onDaySelected: (date, events, holidays) {
      //   _onDaySelected(date, events, holidays);
      //   _animationController.forward(from: 0.0);
      // },
      // onVisibleDaysChanged: _onVisibleDaysChanged,
      // onCalendarCreated: _onCalendarCreated,
    );
  }
}
