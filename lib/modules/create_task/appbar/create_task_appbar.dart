import 'package:flutter/material.dart';
import '../../../themes_and_styles/text_style/text_style_roboto.dart';
import '../../main/main_page.dart';

class AppBarCreateTask extends StatelessWidget implements PreferredSizeWidget{
  const AppBarCreateTask({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
        },
      ),
      title: Text(
        'New To-Do',
        style: roboto20(),
      ),
    );
  }
}
