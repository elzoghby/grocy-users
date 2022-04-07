import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/components/categories.dart';
import 'package:grocery/components/search_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:grocery/screens/home/components/sale_card.dart';
import 'package:grocery/screens/home/components/top_bar.dart';

import 'item_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column (
          children: [
            SizedBox(height: 3.h),
            TopBar(),
            SizedBox(height: 3.h),
            SearchField(),
            Categories(),
            SaleCard(),
            ItemCard()
          ],
        ),
      ),
    );
  }
}

