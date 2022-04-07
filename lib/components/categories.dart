import 'package:flutter/material.dart';

import 'package:grocery/models/category.dart';
import 'package:grocery/screens/category_screen/category_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Categories extends StatelessWidget {
  List<Category> categories = CategoriesList().categoriesList;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          categories.length,
          (index) => InkWell(
            onTap: () { Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryScreen(category: categories[index].name)));},
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: EdgeInsets.all(1.3.w),
              child: Container(

                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        categories[index].icon,
                        width: 6.w,
                      ),
                    ),
                    SizedBox(
                      width: 1.2.w,
                    ),
                    Text(
                      categories[index].name,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
