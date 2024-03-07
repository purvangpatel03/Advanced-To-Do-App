import 'package:flutter/material.dart';
import 'package:todo_app/modules/create_task/widgets/dropdown.dart';
import 'package:todo_app/modules/create_task/widgets/submit_and_clear_button.dart';
import 'package:todo_app/modules/create_task/widgets/tags_chip.dart';
import 'package:todo_app/modules/create_task/widgets/title_and_description.dart';

import 'appbar/create_task_appbar.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  String selectedTag ='';
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCreateTask(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleAndDescription(
                  myTitle: (newTitle){
                    setState(() {
                      title = newTitle;
                    });
                  },
                  myDescription: (newDescription){
                    setState(() {
                      description = newDescription;
                    });
                  },
                ),
                TagsChip(tags: selectedTag),
                const SizedBox(
                  height: 12,
                ),
                MyDropdown(
                  selectedTags: (tag) {
                    if (!(selectedTag == tag)) {
                      setState(() {
                        selectedTag = tag;
                      });
                    }
                  },
                ),
                SubmitAndClear(
                  title: title,
                  description: description,
                  tag: selectedTag,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
