import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/modules/search/widgets/search_header.dart';
import 'package:todo_app/modules/search/widgets/search_textfield.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {

    // return Center(
    //   child: Lottie.asset(
    //     repeat: false,
    //       'assets/search/search_empty_lottie/search_lottie.json'),
    // );

    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderSearchPage(),
          TextFieldSearch()
        ],
      ),
    );
  }
}
