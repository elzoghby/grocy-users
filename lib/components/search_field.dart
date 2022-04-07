import 'package:flutter/material.dart';

import 'package:grocery/screens/search/search_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    this.title,
    Key? key,
  }) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                if (value != null) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SearchScreen(search: value)));
                }
              },
              onChanged: (value) => title,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal:4.w,
                    vertical: 2.w),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: title != null ? title : "Search product",
              ),
            ),
          ),
          IconButton(onPressed: () {
            if (title != null) {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SearchScreen(search: title)));
            }
          }, icon: const Icon(Icons.search), color: Colors.teal,)
        ],
      ),
    );
  }
}