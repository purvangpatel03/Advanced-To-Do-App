import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/modules/home/widgets/home_date_list.dart';
import 'package:todo_app/modules/home/widgets/home_empty_view.dart';
import 'package:todo_app/modules/home/widgets/home_header.dart';
import 'package:todo_app/modules/home/widgets/home_task_list.dart';

import '../../database/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentDate = int.parse(DateFormat('d').format(DateTime.now()));
  int itemsCount = 0;
  int overdueItemCount = 0;
  int tappedIndex = 15;

  Future<void> assignItemCount() async {
    itemsCount = await getItemCount();
    overdueItemCount = await getOverdueItemCount();
  }

  Future<int> getItemCount() async {
    await openMyDatabase();
    int items = await getRowCountByDate(0, currentDate);
    return items;
  }

  Future<int> getOverdueItemCount() async {
    await openMyDatabase();
    int items = await getOverdueListCount(0, currentDate);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12, right: 12, top: 12),
          child: HeaderHomePage(
            currentDate: currentDate,
          ),
        ),
        Expanded(child: buildList()),
      ],
    );
  }

  Widget  buildList(){
    return FutureBuilder(
      future: assignItemCount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            (itemsCount != 0 || overdueItemCount != 0) &&
            currentDate == int.parse(DateFormat('d').format(DateTime.now()))) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              TaskHomePage(
                date: currentDate,
              ),
              MyDateList(
                tappedIndex: (index){
                  tappedIndex = index;
                },
                currentIndex: tappedIndex,
                currentDate: (date) {
                  setState(() {
                    currentDate = date;
                  });
                },
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            itemsCount != 0  &&
            currentDate != int.parse(DateFormat('d').format(DateTime.now()))) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              TaskHomePage(
                date: currentDate,
              ),
              MyDateList(
                tappedIndex: (index){
                  tappedIndex = index;
                },
                currentIndex: tappedIndex,
                currentDate: (date) {
                  setState(() {
                    currentDate = date;
                  });
                },
              ),
            ],
          );
        } else if (itemsCount == 0) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              EmptyHomePage(),
              MyDateList(
                tappedIndex: (index){
                  tappedIndex = index;
                },
                currentIndex: tappedIndex,
                currentDate: (date) {
                  setState(() {
                    currentDate = date;
                  });
                },
              ),
            ],
          );
        }
        return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(176, 57, 54, 1.0),
            ));
      },
    );
  }

}
