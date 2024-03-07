import 'package:flutter/material.dart';
import 'package:todo_app/modules/main/widgets/bottom_menu.dart';
import 'package:todo_app/modules/main/widgets/floating_button.dart';

import '../home/home_page.dart';
import '../inbox/inbox_page.dart';
import '../report/report_page.dart';
import '../search/search_page.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _getScreen(),
        bottomNavigationBar: BottomMenu(
          selectedIndex: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        floatingActionButton: _createTaskButton(),
      ),
    );
  }

  _getScreen() {
    switch (currentIndex) {
      case 1:
        return InboxPage();
      case 2:
        return const SearchPage();
      case 3:
        return const ReportPage();
      default:
        return const HomePage();
    }
  }

  _createTaskButton() {
    switch (currentIndex) {
      default:
        return const FloatingButton();
    }
  }
}
