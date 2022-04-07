import 'package:flutter/material.dart';

import 'package:grocery/providers/item_provider.dart';

import 'package:provider/provider.dart';
import '../../models/items.dart';
import 'component/add_to_card.dart';
import 'component/top_item_row.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class DetailItemScreen extends StatelessWidget {
  DetailItemScreen({required this.id, Key? key}) : super(key: key);
  String id;

//https://www.youtube.com/watch?v=FETHa3A7qTs
  int count = 2;

  @override
  Widget build(BuildContext context) {
    final Item item =
        Provider.of<ItemsProvider>(context, listen: true).findById(id);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TopItemRow(),
              Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          item.imageUrl!,
                          height: 30.h,
                          width: 60.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    GestureDetector(
                      onTap: () async {
                        //item.isFavorite=!item.isFavorite!;
                        Provider.of<ItemsProvider>(context, listen: false)
                            .changefav(id);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding:
                              EdgeInsets.all(3.w),
                          width:30.w,
                          decoration: BoxDecoration(
                            color: item.isFavorite!
                                ? Color(0xFFFFE6E6)
                                : Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Icon(
                            item.isFavorite!
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: item.isFavorite!
                                ? Color(0xFFFF4848)
                                : Color(0xFFDBDEE4),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      item.category!,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp),
                    ),
                    SizedBox(height: 3.w),
                    Text(
                      item.name!,
                      style: TextStyle(
                        color: Theme.of(context).shadowColor,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      '\$${item.price}',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      '   ${item.description!}',
                      style: TextStyle(
                        color: Theme.of(context).shadowColor,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 12.3.h,
                    ),

                  ],
                ),
              ),
              AddToCart(
                item: item,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
