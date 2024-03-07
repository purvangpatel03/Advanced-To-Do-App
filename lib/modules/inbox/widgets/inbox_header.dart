import 'package:flutter/material.dart';
import '../../../themes_and_styles/text_style/text_style_roboto.dart';

class HeaderInboxPage extends StatelessWidget {
  const HeaderInboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Completed Tasks:', style: roboto28(fontWeight: FontWeight.w600).copyWith(letterSpacing: 1.2),),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
      ],
    );
  }
}
