import 'package:flutter/material.dart';

import '../../../themes_and_styles/text_style/text_style_roboto.dart';

class MyDropdown extends StatefulWidget {
  ValueChanged<String> selectedTags;
  MyDropdown({super.key, required this.selectedTags});

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String _selectedTag = '';
  List<String> _customTags = ['Home', 'Routine','Sports'];
  List<String> _selectedTagList = [];


  @override
  Widget build(BuildContext context) {
    print(_selectedTag);
    return DropdownButton(
      hint: Text("Choose Tag"),
      dropdownColor: const Color.fromRGBO(70, 70, 70, 1.0),
      padding: const EdgeInsets.only( bottom: 24),
      onChanged: (newValue) {
        if (newValue == 'Add Custom Tag') {
          _addCustomTag(context);
        } else {
          setState(() {
            _selectedTag = newValue!;
            widget.selectedTags(newValue);
            _selectedTagList.add(newValue);
          });
        }
      },
      items: [
        for (String tag in _customTags)
          DropdownMenuItem<String>(
            value: tag,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tag),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                     setState(() {
                      _customTags.remove(tag);
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        const DropdownMenuItem<String>(
          value: 'Add Custom Tag',
          child: Text('Add Custom Tag'),
        ),
      ],
    );
  }

  Future<void> _addCustomTag(BuildContext context) async {
    String? newTag = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text('Add Custom Tag'),
          content: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.words,
            style: roboto18(),
            cursorColor: const Color.fromRGBO(164, 68, 64, 1.0),
            keyboardType: TextInputType.text,

            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(164, 68, 64, 1.0),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(164, 68, 64, 1.0),
                ),
              ),
              hintText: 'Enter custom Tag',

              hintStyle:
              roboto18(textColor: const Color.fromRGBO(182, 182, 182, 1.0)),
            ),
          ),
          actions: [
            Row(
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                SizedBox(width: 12,),
                Flexible(
                  child: ElevatedButton(

                    onPressed: () {
                      String newTag = controller.text;
                      if (newTag.isNotEmpty) {
                        Navigator.pop(context, newTag);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
    if (newTag != null && !_customTags.contains(newTag)) {
      setState(() {
        _customTags.add(newTag);
      });
    }

  }
}