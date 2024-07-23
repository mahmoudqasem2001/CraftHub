import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/view_model/order_cubit/order_cubit.dart';
import 'package:grad_new_project/widgets/DropDownList.dart';
import 'package:grad_new_project/widgets/OrderContianer.dart';

class ArtistOrdersPage extends StatelessWidget {
  const ArtistOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Scaffold(
          // appBar: MyAppBar(),
          body: Column(
        children: [
          Row(
            crossAxisAlignment:
                !isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 55),
                child: DropDownList(
                  dropdownItems: statusItems,
                  width: !isDesktop ? size.width * .4 : size.width * .15,
                  hintText: "Status",
                ),
              ),
              DropDownList(
                dropdownItems: sortByItems,
                width: !isDesktop ? size.width * .39 : size.width * .15,
                hintText: "Sort By",
              ),
            ],
          ),
          const Expanded(child: OrderContainer()),
        ],
      ));
    });
  }
}

List<DropdownMenuItem<String>> get sortByItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Text(
          "Sort By",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(169, 75, 43, 32),
                  fontSize: 14)),
        ),
        value: "All"),
    DropdownMenuItem(
        child: Text(
          "Newest",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 14)),
        ),
        value: "Newest"),
    DropdownMenuItem(
        child: Text(
          "Oldest",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 14)),
        ),
        value: "Oldest"),
    DropdownMenuItem(
        child: Text(
          "Most Expensive",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 14)),
        ),
        value: "Most Expensive"),
    DropdownMenuItem(
        child: Text(
          "Cheapest",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 14)),
        ),
        value: "Cheapest"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get statusItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Text(
          "Status",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(169, 75, 43, 32),
                  fontSize: 14)),
        ),
        value: "All"),
    DropdownMenuItem(
        child: Text(
          "Recently Arrived",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 14)),
        ),
        value: "Recently Arrived"),
    DropdownMenuItem(
        child: Text(
          "Processing",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 14)),
        ),
        value: "Processing"),
    DropdownMenuItem(
        child: Text(
          "Completed",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 14)),
        ),
        value: "Most Completed"),
  ];
  return menuItems;
}
