import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  ValueChanged<int> selectedIndex;
  BottomMenu({super.key, required this.selectedIndex});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
          unselectedFontSize: 14,
          selectedFontSize: 14,
          iconSize: 24,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              widget.selectedIndex(index);
            });
          },
          items: const [
            BottomNavigationBarItem(
                label: 'Today', icon: Icon(Icons.today_outlined)),
            BottomNavigationBarItem(
                label: 'Inbox', icon: Icon(Icons.inbox_outlined)),
            BottomNavigationBarItem(
                label: 'Search', icon: Icon(Icons.search_rounded)),
            BottomNavigationBarItem(
                label: 'Report', icon: Icon(Icons.report_outlined)),
          ]),
    );
  }
}
