import 'package:flutter/material.dart';

import 'package:grocery/models/items.dart';
import 'package:grocery/providers/item_provider.dart';
import 'package:grocery/screens/detailed_item_screen/detailed_item_screen.dart';
import 'package:grocery/screens/home/components/section_title.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../all_items_screen/all_items_screen.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<ItemsProvider>(context).items;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:SectionTitle(
              title: 'Popular items ',
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllItemsScreen()));
              }),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              items.length,
              (index) => Container(
                margin: EdgeInsets.all(1.5.w),
                height: 30.h,
                width: 20.h,
                padding: EdgeInsets.all(0.5.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF005f73)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<ItemsProvider>(context, listen: false)
                                .changefav(items[index].id!);
                          },
                          child: Icon(
                            items[index].isFavorite!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.redAccent,
                            size: 25.sp,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailItemScreen(id: items[index].id!)));
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              items[index].imageUrl!,
                              fit: BoxFit.cover,
                              width: 28.w,
                              height: 18.h,
                            ),
                          ),
                          Text(
                            items[index].name!,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text( '\$ ${items[index].price}',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    color: Theme.of(context).shadowColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                ),
              ),
            ),

      ],
    );
  }
}
