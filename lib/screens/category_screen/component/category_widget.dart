import 'package:flutter/material.dart';
import 'package:grocery/models/category.dart'as model;

import 'package:responsive_sizer/responsive_sizer.dart';
class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.categoryD,
  }) : super(key: key);

  final model.Category categoryD;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Container(
          width: 35.w,
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                categoryD.icon,
                width: 5.w,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              categoryD.name,
            )
          ],
        ),
      ),
    );
  }
}