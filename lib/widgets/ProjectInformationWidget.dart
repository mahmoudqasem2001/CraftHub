// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/widgets/DropDownList.dart';
import 'package:grad_new_project/widgets/EditableTextFieldWithLabel.dart';
import 'package:grad_new_project/widgets/TextFiledContainer.dart';

class ProjectInformationWidget extends StatelessWidget {
  ProjectInformationWidget({
    Key? key,
    required TextEditingController projectNameController,
    required TextEditingController projectCategoryController,
    required this.size,
  })  : _projectNameController = projectNameController,
        _projectCategoryController = projectCategoryController;

  // _projectNameController = projectNameController;

  final TextEditingController _projectNameController;
  final TextEditingController _projectCategoryController;
  final Size size;
  bool readOnlyProjectCategory =
      true; // false only if the user selects the others option in the categories DropDown list
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //   Icon(Icons.s)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Project Information',
              style: GoogleFonts.anta(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                      fontSize: isDesktop ? 15 : 22)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 12),
            child: Text(
              "All the Text Field here are Editable, you can update your information as you like."
              " Don't forget to save the changes! Make sure to choose the Best Category that describes your Project.",
              style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brown,
                      fontSize: isDesktop ? 11 : 13)),
            ),
          ),
          EditableTextFieldWithLabel(
            label: 'Project Name:      ',
            currentInfo: 'Hore',
            controller: _projectNameController,
          ),

          /*  EditableTextFieldWithLabel(
              label: 'Project Name:  ',
              currentInfo: 'Hore',
              controller: _projectNameController,
            ),*/
          Container(
            height: 15,
            color: AppColors.lightPurple,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // width: width,
                height: size.height * 0.04,
                child: Text(
                  'Project Category:',
                  style: GoogleFonts.philosopher(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 14)),
                ),
              ),
              DropDownList(
                dropdownItems: getCategories(),
                width: 250,
                hintText: "Categories",
              ),
            ],
          ),
          Text(
            'if Others, Please Enter Your Project Category :',
            style: GoogleFonts.philosopher(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: 13)),
          ),
          // want to make sure to accept the text only if the user selects the ((others)) option in the categories list
          TextFiledContainer(
            widthFactor: 0.7,
            heightFactor: 0.05,
            borderRadius: 29,
            child: TextFormField(
              readOnly: readOnlyProjectCategory,
              controller: _projectCategoryController,
              decoration: InputDecoration(
                hintText: "Project Category",
                hintStyle: TextStyle(
                  color: AppColors.hintTextColor,
                  fontSize: 15,
                ),
                icon: null,
                border: InputBorder.none,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * .04, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isDesktop) AppRouter.goBackTOScreen();
                    },
                    child: Text(
                      "Discard",
                      style: TextStyle(color: AppColors.white),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        AppColors.primary,
                      ),
                      overlayColor: MaterialStateProperty.all(
                        AppColors.overlayColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * .04),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isDesktop) AppRouter.goBackTOScreen();
                    },
                    child: Text(
                      "  Save  ",
                      style: TextStyle(color: AppColors.white),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        AppColors.primary,
                      ),
                      overlayColor: MaterialStateProperty.all(
                        AppColors.overlayColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

final Map<String, int> categories = {
  "Events Candy Giveaways": 1,
  "Heritage and Embroidery": 2,
  "Resin Crafts": 3,
  "Refractory Clay Accessories": 4,
  "Beads Handmades": 5,
  "Sewing Clothes": 6,
  "Drawing": 7,
  "Handmade Notebooks": 8,
  "Interactive Paper Games": 9,
  "Wool Dolls": 10,
  "Handmade Furnitures": 11,
  "Wood Carving": 12,
  "Handmade Accessories": 13,
  "Others": 111,
};

List<DropdownMenuItem<String>> getCategories() {
  List<DropdownMenuItem<String>> menuItems = [];
  categories.forEach((text, value) {
    menuItems.add(
      DropdownMenuItem(
        child: Text(
          text,
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(169, 75, 43, 32),
                  fontSize: 14)),
        ),
        value: value.toString(),
      ),
    );
  });
  return menuItems;
}
