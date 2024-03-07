import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../database/database_helper.dart';
import '../../../themes_and_styles/text_style/text_style_roboto.dart';
import '../../main/main_page.dart';
import '../create_task_page.dart';

class SubmitAndClear extends StatelessWidget {
  String title;
  String description;
  String tag;
  SubmitAndClear(
      {super.key,
      required this.title,
      required this.description,
      required this.tag});
  var time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            int date = int.parse(DateFormat('d').format(time));
            String month = DateFormat('MMM').format(time);
            if (title != '' && description != '') {
              insertList(title, description, tag, date, month);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            } else {
              _showDialogBox(context);
            }
          },
          child: Text(
            'SUBMIT',
            style: roboto16().copyWith(letterSpacing: 1.2),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CreateTaskPage()));
          },
          child: Text(
            'CLEAR',
            style: roboto16().copyWith(letterSpacing: 1.2),
          ),
        ),
      ],
    );
  }

  void _showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Title and description\nare required.',
            textAlign: TextAlign.center,
            style: roboto20(),
          ),
          content: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Back',
              style: roboto14(),
            ),
          ),
        );
      },
    );
  }
}
