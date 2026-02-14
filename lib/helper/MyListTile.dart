import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  String label;
  IconData icon;
  VoidCallback callback;
  bool isSelected;
  MyListTile({super.key,required this.label,required this.icon,required this.callback,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: ListTile(
        onTap: callback,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        selectedTileColor: ThemeColors.primaryColor,
        selected: isSelected,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(left: Constants.isDesktop(context)?25:0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, size: 20,color: isSelected?Colors.white:Colors.black,),
                SizedBox(width: 10),
                Text(label,style: TextStyle(color: isSelected?Colors.white:Colors.black),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
