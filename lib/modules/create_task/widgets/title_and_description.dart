import 'package:flutter/material.dart';
import '../../../themes_and_styles/text_style/text_style_roboto.dart';

class TitleAndDescription extends StatefulWidget {
  ValueChanged<String> myTitle;
  ValueChanged<String> myDescription;
  TitleAndDescription({super.key, required this.myTitle, required this.myDescription});

  @override
  State<TitleAndDescription> createState() => _TitleAndDescriptionState();
}

class _TitleAndDescriptionState extends State<TitleAndDescription> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          textCapitalization: TextCapitalization.sentences,
          style: roboto28(fontWeight: FontWeight.w400),
          cursorColor: const Color.fromRGBO(164, 68, 64, 1.0),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Title',
            hintStyle:
            roboto28(textColor: const Color.fromRGBO(157, 157, 157, 1.0)),
            border: InputBorder.none,
            contentPadding:
            const EdgeInsets.only(top: 20, bottom: 8),
          ),
          onChanged: widget.myTitle,
        ),
        TextField(
          controller: _descriptionController,
          maxLines: null,
          textCapitalization: TextCapitalization.sentences,
          style: roboto20(),
          cursorColor: const Color.fromRGBO(164, 68, 64, 1.0),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Description',
            hintStyle:
            roboto20(textColor: const Color.fromRGBO(157, 157, 157, 1.0)),
            border: InputBorder.none,
          ),
          onChanged: widget.myDescription,
        ),

      ],
    );
  }
}
