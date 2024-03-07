import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../database/database_helper.dart';
import '../../../themes_and_styles/text_style/text_style_roboto.dart';
import 'home_empty_view.dart';

class TaskHomePage extends StatefulWidget {
  int date;
  TaskHomePage({super.key, required this.date});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  int currentDate = int.parse(DateFormat('d').format(DateTime.now()));
  int itemsCount = 0;

  Future<void> assignItemCount() async {
    itemsCount = await getItemCount();
  }

  Future<int> getItemCount() async {
    await openMyDatabase();
    int items = await getRowCount(0);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: assignItemCount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            itemsCount != 0) {
          return Padding(
            padding: const EdgeInsets.only(left: 12.0, right:12, bottom: 12),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                list(),
              ],
            ),
          );
        } else if (itemsCount == 0) {
          return const EmptyHomePage();
        }
        return const Center(
            child: CircularProgressIndicator(
          color: Color.fromRGBO(176, 57, 54, 1.0),
        ));
      },
    );
  }

  Widget list() {
    if (widget.date ==
        int.parse(DateFormat('d').format(DateTime.now()))) {
      return todayTaskList();
    } else {
      return commonTaskList();
    }
  }

  Widget todayTaskList() {
    return Expanded(
      child: Column(
        children: [
          FutureBuilder(
            future: getOverdueList(0, widget.date),
            builder: (context, snapshot) {;
              int listLength = snapshot.data?.length ?? 0;
              if (snapshot.connectionState == ConnectionState.done &&
                  listLength != 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Overdue Tasks:",
                      style: roboto20(textColor: const Color.fromRGBO(
                          232, 196, 195, 1.0), fontWeight: FontWeight.w400).copyWith(letterSpacing: 1, height: 2),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        bool isTag = snapshot.data?[index]['tag'] == '';
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    updateStatus(
                                        snapshot.data?[index]['id'], 1);
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  margin: const EdgeInsets.only(top: 6),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2,
                                        color: const Color.fromRGBO(
                                            232, 196, 195, 1.0)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data?[index]['title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: roboto24(fontWeight: FontWeight.w500,
                                          textColor: const Color.fromRGBO(
                                              232, 196, 195, 1.0)),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      snapshot.data?[index]['description'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: roboto18(
                                          textColor: const Color.fromRGBO(
                                              232, 196, 195, 1.0)),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Overdue Task\nDate: ${snapshot.data?[index]['date']}',
                                    textAlign: TextAlign.center,
                                    style: roboto12(
                                        textColor: const Color.fromRGBO(
                                            232, 196, 195, 1.0)),
                                  ),
                                  Chip(
                                    side: BorderSide.none,
                                    label: Text(
                                      isTag ? '' :
                                      '# ${snapshot.data?[index]['tag']}',
                                      style: roboto14(
                                          textColor: const Color.fromRGBO(
                                              232, 196, 195, 1.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Color.fromRGBO(
                              232, 196, 195, 1.0),
                          thickness: 2,
                        );
                      },
                      itemCount: snapshot.data?.length ?? 0,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
          commonTaskList(),
        ],
      ),
    );
  }

  Widget commonTaskList() {
    return FutureBuilder(
      future: getListByDate(0, widget.date),
      builder: (context, snapshot) {
        int listLength = snapshot.data?.length ?? 0;
        if (snapshot.connectionState == ConnectionState.done &&
            listLength != 0) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(widget.date),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      bool isTag = snapshot.data?[index]['tag'] == '';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  updateStatus(snapshot.data?[index]['id'], 1);
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
                            Chip(
                              side: BorderSide.none,
                              label: Text(
                                isTag ? '' :
                                '# ${snapshot.data?[index]['tag']}',
                                style: roboto14(),
                              ),
                              deleteIconColor: Colors.white,
                              deleteIcon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        thickness: 2,
                      );
                    },
                    itemCount: snapshot.data?.length ?? 0,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget getText(date){
    if(date == int.parse(DateFormat('d').format(DateTime.now()))){
      return Text(
        "Today's Tasks:",
        style: roboto20(fontWeight: FontWeight.w400).copyWith(letterSpacing: 1, height: 2),
      );
    }
    return const SizedBox();
  }
}
