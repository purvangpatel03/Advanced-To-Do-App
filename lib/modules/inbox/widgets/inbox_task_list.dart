import 'package:flutter/material.dart';
import '../../../database/database_helper.dart';
import '../../../themes_and_styles/text_style/text_style_roboto.dart';
import 'inbox_empty_view.dart';
import 'inbox_header.dart';

class TaskInboxPage extends StatefulWidget {
  TaskInboxPage({super.key});

  @override
  State<TaskInboxPage> createState() => _TaskInboxPageState();
}

class _TaskInboxPageState extends State<TaskInboxPage> {
  int itemsCount = 0;

  Future<void> assignItemCount() async {
    itemsCount = await getItemCount();
  }

  Future<int> getItemCount() async {
    await openMyDatabase();
    int items = await getRowCount(1);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: assignItemCount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && itemsCount != 0) {
            return taskList();
          }
          else if (itemsCount == 0){
            return EmptyInboxPage();
          }
          return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(176, 57, 54, 1.0),
              ));
        });
  }

  Widget taskList() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          HeaderInboxPage(),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: getList(1),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  deleteList(snapshot.data?[index]['id']);
                                });
                              },
                              child: Container(
                                height: 22,
                                width: 22,
                                margin: const EdgeInsets.only(top: 6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 2, color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data?[index]['title'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: roboto24(fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    snapshot.data?[index]['description'],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: roboto18(textColor: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Chip(

                                  side: BorderSide.none,
                                  label: Text(
                                    '# ${snapshot.data?[index]['tag']}',
                                    style: roboto14(),
                                  ),
                                ),
                              Text(
                                'Task date: ${snapshot.data?[index]['date']}',
                                textAlign: TextAlign.center,
                                style: roboto12(),
                              ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 2,
                      );
                    },
                    itemCount: snapshot.data?.length ?? 0,
                  ),
                );
              }
              return const Center(
                  child: CircularProgressIndicator(
                color: Color.fromRGBO(176, 57, 54, 1.0),
              ));
            },
          ),

        ],
      ),
    );
  }
}
