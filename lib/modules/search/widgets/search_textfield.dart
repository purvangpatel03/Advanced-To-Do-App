import 'package:flutter/material.dart';

import '../../../themes_and_styles/text_style/text_style_roboto.dart';

class TextFieldSearch extends StatelessWidget {
  TextFieldSearch({super.key});

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          textCapitalization: TextCapitalization.sentences,
          style: roboto18(fontWeight: FontWeight.w400),
          cursorColor: const Color.fromRGBO(164, 68, 64, 1.0),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Find Task, projects, and more.',
            hintStyle:
            roboto18(textColor: const Color.fromRGBO(157, 157, 157, 1.0)),
            border: InputBorder.none,
            contentPadding:
            const EdgeInsets.only(top: 20, bottom: 8),
          ),
        ),
      ],
    );
  }
}
