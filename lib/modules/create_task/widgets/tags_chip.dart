import 'package:flutter/material.dart';
import '../../../themes_and_styles/text_style/text_style_roboto.dart';

class TagsChip extends StatefulWidget {
  String tags;
  TagsChip({super.key, required this.tags});

  @override
  State<TagsChip> createState() => _TagsChipState();
}

class _TagsChipState extends State<TagsChip> {
  @override
  Widget build(BuildContext context) {
    if(!(widget.tags == '')){
      return Chip(
        backgroundColor: const Color.fromRGBO(114, 114, 114, 1.0),
        side: BorderSide.none,
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        label: Text(widget.tags, style: roboto16(fontWeight: FontWeight.w500),),
        deleteIconColor: Colors.white,
        deleteIcon: const Icon(Icons.close),
        onDeleted: (){
          setState(() {
            widget.tags ='';
          });
        },
      );
    }
    return Container();
  }
}
