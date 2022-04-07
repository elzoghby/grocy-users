import 'package:flutter/material.dart';
import 'package:grocery/components/search_field.dart';

import 'package:grocery/providers/item_provider.dart';
import 'package:provider/provider.dart';

import '../../models/items.dart';

import '../detailed_item_screen/detailed_item_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({required this.search, Key? key}) : super(key: key);
  final String search;


  @override
  Widget build(BuildContext context) {
    final List<Item>items = Provider.of<ItemsProvider>(context)
        .searchForProduct(search);
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SearchField(title: search),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(1.4.w),
                child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 15,
                    mainAxisExtent: 320,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailItemScreen(id: items[index].id!,)));
                      },
                      child: SizedBox(
                        width: 20.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              height: 20.h,
                              width: 22.w,
                              child: Image.network(
                                items[index].imageUrl!,

                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              items[index].name!,
                              style: TextStyle(fontSize: 18.sp),

                            ),
                            SizedBox(height: 0.3.h),
                            Text(
                              items[index].category!,
                              style: TextStyle(
                                fontSize: 13.5.sp, color: Colors.grey,),


                            ),
                            SizedBox(height: 0.3.h),
                            Text(
                              '\$${items[index].price}',
                              style: TextStyle(fontSize: 16.sp, color: Theme
                                  .of(context)
                                  .primaryColor,),

                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
