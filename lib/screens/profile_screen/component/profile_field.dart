import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class ProfileFields extends StatelessWidget {
  ProfileFields({
    Key? key,
    this.lines = 1,
    @required this.hint,
    @required this.ontap,
    @required this.editTab,
    @required this.enable,
    @required this.type,
  }) : super(key: key);

  final lines;
  final hint;
  final ontap;
  final editTab;
  final type;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              keyboardType: type,
              enabled: enable,
              maxLines: lines,
              autofocus: false,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  labelText: hint),
              onChanged: ontap,
            ),
          ),
          SizedBox(
            width: 1.5.w,
          ),
          IconButton(
            onPressed: editTab,
            icon: const Icon(Icons.mode_edit, color: Colors.redAccent),
            iconSize: 25.sp,
          )
        ],
      ),
    );
  }
}
