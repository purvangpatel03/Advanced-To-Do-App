import 'package:flutter/material.dart';
import 'package:todo_app/modules/inbox/widgets/inbox_task_list.dart';

class InboxPage extends StatefulWidget {
  InboxPage({super.key});

  @override
  State<InboxPage> createState() => _HomePageState();
}

class _HomePageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return TaskInboxPage();
  }
}
