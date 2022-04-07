import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegiterationButtons extends StatelessWidget {
  const RegiterationButtons({
    this.page,
    required this.text,
    Key? key,
  }) : super(key: key);
  final  String text;
  final  page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextButton(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>page));},
        child:  Text(text ,style: TextStyle(fontWeight: FontWeight.bold, fontSize:19.sp),),
        style: TextButton.styleFrom(
            backgroundColor: Colors.white70,
            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(50),
            ),
            // side:const BorderSide(color: Colors.teal,width: 1.5) ,
            primary: Colors.teal,
            padding: const EdgeInsets.all(13)
        ),
      ),
    );
  }
}