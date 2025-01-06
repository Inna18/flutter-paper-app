import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({required this.selectRange, super.key});

  // final List<DateTime> defaultRange;
  void Function(List<DateTime> dates) selectRange;

  @override
  State<StatefulWidget> createState() {
    return _CustomDatePickerState();
  }
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  List<String> weekdays = ['일', '월', '화', '수', '목', '금', '토'];
  DateTime _today = DateTime.now();
  List<DateTime> _selectedRange = [DateTime.now(), DateTime.now()];
  // Sunday = 0
  int prevMLastDay =
      (DateTime(DateTime.now().year, DateTime.now().month, 0).day);
  int currentMLastDay =
      (DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day);
  int prevMLastWeekday =
      (DateTime(DateTime.now().year, DateTime.now().month, 0).weekday) % 7;
  int currentMFirstWeekday =
      (DateTime(DateTime.now().year, DateTime.now().month).weekday) % 7;
  int firstDay = 0;
  int lastDay = 0;
  List<List<int>> calendar = [];
  bool isSelected = false;

  DateTime startAt = DateTime.now();
  DateTime endAt = DateTime.now();
  bool startAtChosen = false;
  bool endAtChosen = false;

  @override
  void initState() {
    super.initState();
    firstDay = prevMLastWeekday == 6
        ? 0
        : DateTime(DateTime.now().year, DateTime.now().month, 0).day -
            prevMLastWeekday;
    lastDay =
        7 - (DateTime(DateTime.now().year, DateTime.now().month + 1).weekday);
    setCalendar();
  }

  void setCalendar() {
    List<int> prevMonth = [];
    List<int> currentMonth = [];
    List<int> nextMonth = [];

    if (firstDay != 0) {
      for (int i = firstDay; i <= prevMLastDay; i++) {
        prevMonth.add(i);
      }
    }
    for (int i = 1; i <= currentMLastDay; i++) {
      currentMonth.add(i);
    }
    for (int i = 1; i <= lastDay; i++) {
      nextMonth.add(i);
    }
    setState(() {
      calendar = [prevMonth, currentMonth, nextMonth];
    });
  }

  @override
  Widget build(BuildContext context) {
    void rerenderDates() {
      prevMLastDay = (DateTime(_today.year, _today.month, 0).day);
      currentMLastDay = (DateTime(_today.year, _today.month + 1, 0).day);
      prevMLastWeekday = (DateTime(_today.year, _today.month, 0).weekday) % 7;
      currentMFirstWeekday = (DateTime(_today.year, _today.month).weekday) % 7;
      firstDay = prevMLastWeekday == 6
          ? 0
          : DateTime(_today.year, _today.month, 0).day - prevMLastWeekday;
      lastDay = 7 - (DateTime(_today.year, _today.month + 1).weekday);
    }

    void toPrevMonth() {
      setState(() {
        // change current date (month) to previous
        if (_today.month == 1) {
          _today = DateTime(_today.year - 1, 12);
        } else {
          _today = DateTime(_today.year, _today.month - 1);
        }
        rerenderDates();
      });
      setCalendar();
    }

    void toNextMonth() {
      setState(() {
        // change current date (month) to next
        if (DateTime.now().month == 12) {
          _today = DateTime(_today.year + 1, 1);
        } else {
          _today = DateTime(_today.year, _today.month + 1);
        }
        rerenderDates();
      });
      setCalendar();
    }

    bool isToday(int day) {
      return _today.year == DateTime.now().year &&
          _today.month == DateTime.now().month &&
          DateTime.now().day == day;
    }

    void setDate(String date, int type, day) {
      DateTime tempDate = DateTime.now();
      if (type == 0) {
        tempDate = DateTime(_today.year, _today.month - 1, day);
      } else if (type == 1) {
        tempDate = DateTime(_today.year, _today.month, day);
      } else {
        tempDate = DateTime(_today.year, _today.month + 1, day);
      }

      if (date == 'start') {
        startAt = tempDate;
      } else {
        endAt = tempDate;
      }
    }

    void setSelectedDate(int type, int day) {
      if (!startAtChosen || endAtChosen) {
        setDate('start', type, day);
        startAtChosen = true;
        endAtChosen = false;
        endAt = startAt;
      } else {
        setDate('end', type, day);
        if (endAt.isBefore(startAt)) {
          var temp = startAt;
          startAt = endAt;
          endAt = temp;
        }
        endAtChosen = true;
      }

      if (startAtChosen && endAtChosen) {
        _selectedRange = [startAt, endAt];
        widget.selectRange(_selectedRange);
      }
    }

    bool isStartOrEnd(int day, int type) {
      if (type == 0) {
        if (startAt == DateTime(_today.year, _today.month - 1, day) ||
            endAt == DateTime(_today.year, _today.month - 1, day)) {
          return true;
        }
      } else if (type == 1) {
        if (startAt == DateTime(_today.year, _today.month, day) ||
            endAt == DateTime(_today.year, _today.month, day)) {
          return true;
        }
      } else {
        if (startAt == DateTime(_today.year, _today.month + 1, day) ||
            endAt == DateTime(_today.year, _today.month + 1, day)) {
          return true;
        }
      }
      return false;
    }

    return SizedBox(
      height: 320,
      width: 320,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                onPressed: toPrevMonth,
                icon: const Icon(
                  Icons.chevron_left,
                )),
            Text(
              DateFormat('yyyy.MM').format(_today),
              style: const TextStyle(fontSize: 16),
            ),
            IconButton(
                onPressed: toNextMonth,
                icon: const Icon(
                  Icons.chevron_right,
                )),
          ]),
          const SizedBox(
            height: 8,
          ),
          Center(
              // Weekdays
              child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 5,
            children: weekdays
                .map((weekday) => SizedBox(
                    height: 32,
                    width: 36,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(weekday,
                          style: weekday == '토' || weekday == '일'
                              ? TextStyle(color: Colors.red[300])
                              : TextStyle(color: Colors.blue[500])),
                    )))
                .toList(),
          )),
          Center(
              // Dates
              child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 5,
            children: [
              ...calendar[0].map((day) => GestureDetector(
                    // prevMonth dates
                    onTap: () {
                      setSelectedDate(0, day);
                      setState(() {
                        isSelected = false;
                        isSelected = true;
                      });
                    },
                    child: Container(
                        height: 32,
                        width: 36,
                        child: Align(
                          alignment: Alignment.center,
                          child: isStartOrEnd(day, 0)
                              ? Container(
                                  padding: day < 10
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color.fromRGBO(
                                          33, 150, 243, 1)),
                                  child: Text(day.toString(),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                )
                              : Text(
                                  day.toString(),
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                ),
                        )),
                  )),
              ...calendar[1].map((day) => GestureDetector(
                    // currentMonth dates
                    onTap: () {
                      setSelectedDate(1, day);
                      setState(() {
                        isSelected = false;
                        isSelected = true;
                      });
                    },
                    child: Container(
                        height: 32,
                        width: 36,
                        child: Align(
                            alignment: Alignment.center,
                            child: isToday(day)
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                33, 150, 243, 1))),
                                    child: Text(day.toString()),
                                  )
                                : isStartOrEnd(day, 1)
                                    ? Container(
                                        padding: day < 10
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 6),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: const Color.fromRGBO(
                                                33, 150, 243, 1)),
                                        child: Text(day.toString(),
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      )
                                    : Text(day.toString()))),
                  )),
              ...calendar[2].map((day) => GestureDetector(
                    // nextMonth dates
                    onTap: () {
                      setSelectedDate(2, day);
                      setState(() {
                        isSelected = false;
                        isSelected = true;
                      });
                    },
                    child: Container(
                        height: 32,
                        width: 36,
                        child: Align(
                          alignment: Alignment.center,
                          child: isStartOrEnd(day, 2)
                              ? Container(
                                  padding: day < 10
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color.fromRGBO(
                                          33, 150, 243, 1)),
                                  child: Text(day.toString(),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                )
                              : Text(
                                  day.toString(),
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                        )),
                  )),
            ],
          )),
        ],
      ),
    );
  }
}
