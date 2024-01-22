import '../Widgets/customtextstyle.dart';
import '../classes/language_constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MultipleFilter extends StatelessWidget {
  Widget? child;
  final Function()? onPressed;
  IconData? icon;

  MultipleFilter({
    super.key,
    this.onPressed,
    this.icon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(1),
        border: Border.all(color: Colors.black12),
        color: Colors.white,
      ),
      child: DataTable(
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => Color.fromARGB(255, 104, 104, 208)),
        columns: [
          DataColumn(
              label: Text(
            translation(context).candidates,
            style: CustomTextStyle.nameOfHeading,
          )),
          DataColumn(
              label: Text(translation(context).verified,
                  style: CustomTextStyle.nameOfHeading)),
          DataColumn(
              label: Text(translation(context).qualification,
                  style: CustomTextStyle.nameOfHeading)),
          DataColumn(
              label: Text(translation(context).jobClassification,
                  style: CustomTextStyle.nameOfHeading)),
          DataColumn(
              label: Text(translation(context).jobClassifications,
                  style: CustomTextStyle.nameOfHeading)),
          DataColumn(
              label: Text(translation(context).label,
                  style: CustomTextStyle.nameOfHeading)),
          DataColumn(
              label: Text(translation(context).noOfDaysOpen,
                  style: CustomTextStyle.nameOfHeading)),
          DataColumn(
              label: Text(translation(context).cvDoc,
                  style: CustomTextStyle.nameOfHeading)),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(
              'xxxxxxxxxxxxxxx',
              style: CustomTextStyle.nameOflist,
            )),
            DataCell(Text(
              '',
              style: CustomTextStyle.nameOflist,
            )),
            DataCell(Text(
              'xxxxxxxxxxxxxxx',
              style: CustomTextStyle.nameOflist,
            )),
            DataCell(Text(
              'Senior plumber',
              style: CustomTextStyle.nameOflist,
            )),
            DataCell(Text(
              'Senior plumber',
              style: CustomTextStyle.nameOflist,
            )),
            DataCell(Text(
              'blue',
              style: CustomTextStyle.nameOflist,
            )),
            DataCell(Text(
              '60',
              style: CustomTextStyle.nameOflist,
            )),
            DataCell(Text(
              'xxxxxxxxxxxxxxx',
              style: CustomTextStyle.nameOflist,
            )),
          ]),
        ],
      ),
    );
  }
}
