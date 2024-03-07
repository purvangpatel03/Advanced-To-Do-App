import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateList extends StatefulWidget {
  ValueChanged<int> currentDate;
  ValueChanged<int> tappedIndex;
  int currentIndex ;
  MyDateList({super.key, required this.currentDate, required this.currentIndex, required this.tappedIndex});

  @override
  State<MyDateList> createState() => _MyDateListState();
}


class _MyDateListState extends State<MyDateList> {
  final ScrollController _myScrollController =
      ScrollController(initialScrollOffset: 15 * 46);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(
        bottom: 14,
        right: 80,
      ),
      color: Color.fromRGBO(30, 30, 30, 1.0),
      child: MyList(),
    );
  }

  Widget MyList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      controller: _myScrollController,
      itemCount: 15,
      itemBuilder: (context, index) {
        final date = DateTime.now()
            .subtract(const Duration(days: 14))
            .add(Duration(days: index));
        return InkWell(
          onTap: () {
            widget.tappedIndex(index+1);
            setState(() {
              widget.currentDate(int.parse(DateFormat('d').format(date)));
            });
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                top: BorderSide.none,
                bottom: BorderSide.none,
                right: BorderSide(
                  width: 2,
                  color: Color.fromRGBO(115, 115, 115, 1.0),
                ),
              ),
              color: widget.currentIndex == index+1 ? Color.fromRGBO(200, 76, 73, 1.0) : Color.fromRGBO(68, 68, 68, 1.0),
              //color: const Color.fromRGBO(68, 68, 68, 1.0),
            ),
            margin: const EdgeInsets.only(left: 8),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat('MMM').format(date)),
                Text(DateFormat('d').format(date)),
              ],
            ),
          ),
        );
      },
    );
  }
}
