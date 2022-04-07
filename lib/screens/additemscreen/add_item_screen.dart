import 'dart:io';
import 'package:flutter/material.dart';

import 'package:grocery/providers/item_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'components/add_item_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);
  static const id = 'addProduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? fileImage;
  String? name;
  String? description;
  double? price;
  String? category;
  List categoryMenu = ['Vegetables', 'Fruits', 'Spices'];
  var productId = Uuid().v4();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: fileImage != null
                    ? Image.file(
                        fileImage!,
                        width: 40.w,
                        height: 30.h,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'images/fruit.png',
                        width: 55.w,
                        height: 30.h,
                        fit: BoxFit.contain,
                      ),
              ),
              TextButton.icon(
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    final image =
                        (await _picker.getImage(source: ImageSource.gallery));

                    if (image != null) {
                      setState(() {
                        fileImage = File(image.path);
                      });
                    }
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text('Take an image')),
              SizedBox(
                height: 4.w
              ),
              AddProductFields(
                  hint: 'name',
                  lines: 1,
                  ontap: (value) {
                    name = value;
                  }),
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: Container(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(25)),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    hint: Text(
                      'Select category',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Theme.of(context).primaryColor),
                    ),
                    iconSize: 25.sp,
                    icon:  Icon(Icons.keyboard_arrow_down , color:Theme.of(context).primaryColor ,),
                    borderRadius: BorderRadius.circular(15),
                    isExpanded: true,
                    value: category,
                    onChanged: (newValue) {
                      setState(() {
                        category = newValue.toString();

                      });
                    },
                    items: categoryMenu
                        .map((value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                  ),
                ),
              ),
              AddProductFields(
                  hint: 'price',
                  type: TextInputType.number,
                  lines: 1,
                  ontap: (value) {
                    price = double.tryParse(value);
                  }),
              AddProductFields(
                  hint: 'description',
                  lines: 4,
                  ontap: (value) {
                    description = value;
                  }),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.all(3.w),
                child: MaterialButton(

                  padding: EdgeInsets.all(4.w),
                  onPressed: () async {

                    if (name == null ||
                        price == null ||
                        description == null ||
                        fileImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'please fill all the fields and add an image',
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      );
                    } else {
                      final success = await Provider.of<ItemsProvider>(context,
                              listen: false)
                          .addItem(
                        name: name!,
                        desc: description!,
                        image: fileImage!,
                        category: category!,
                        price: price!,
                        id: productId,
                      );

                      if (success == true) {
                        Navigator.pop(context);
                      } else {

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'error$success',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  },
                  minWidth: double.infinity / 2,
                  color: Colors.tealAccent,
                  child: Text('add item',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black54,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
