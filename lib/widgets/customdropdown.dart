import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T? value;
  final Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;

  const CustomDropDown({
    Key? key,
    this.value,
    this.onChanged,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          value: value,
          isExpanded: true,
          items: items,
          onChanged: onChanged,
          buttonStyleData: ButtonStyleData(
            height: 30,
            elevation: 2,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.white,
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down_sharp,
            ),
            iconSize: 25,
            iconEnabledColor: Colors.black,
            iconDisabledColor: null,
          ),
          dropdownStyleData: DropdownStyleData(
            elevation: 0,
            maxHeight: 200,
            padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              color: Colors.white,
            ),
            scrollPadding: EdgeInsets.all(5),
            scrollbarTheme: ScrollbarThemeData(
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 30,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
