import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/AccountPage.dart';
import 'package:grad_new_project/Views/UserCompletionPage.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/widgets/DropDownList.dart';
import 'package:grad_new_project/widgets/TextFiledContainer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../view_model/auth_cubit/auth_cubit.dart';

class UserPersonalInfoCompletionPage extends StatefulWidget {
  static String routeName = 'user-Info-completion';
  const UserPersonalInfoCompletionPage({super.key});

  @override
  State<UserPersonalInfoCompletionPage> createState() =>
      _UserPersonalInfoCompletionPageState();
}

class _UserPersonalInfoCompletionPageState
    extends State<UserPersonalInfoCompletionPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  DateTime? selectedDate;

  TextEditingController _dateController = TextEditingController();
  Future<XFile?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController _projectCategoryController = TextEditingController();
    bool readOnlyProjectCategory =
        true; // false only if the user selects the others option in the categories DropDown list
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      final double containerSize =
          !isDesktop ? size.width * 0.4 : size.height * 0.23;
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 160,
          foregroundColor: AppColors.brown,
          shadowColor: AppColors.orange,
          //backgroundColor: AppColors.primary,
          surfaceTintColor: AppColors.white,
          elevation: 2,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
          leading: Padding(
            padding: const EdgeInsets.only(top: 10, left: 7, bottom: 10),
            child: Image.asset(
              'assets/images/Icon.png',
              height: 30,
            ),
          ),
        ),
        body: ResponsiveRowColumn(
          layout: !isDesktop
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.center,
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResponsiveRowColumnItem(
              child: Container(
                width: isDesktop ? size.width * 0.4 : size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Welcome to CraftHub',
                            style: GoogleFonts.anta(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkBrown,
                                    fontSize: !isDesktop ? 17 : 25)),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 15, bottom: 20),
                      child: Text(
                        'Complete Your Registration! Select Your Profile Picture and enter your information including gender and date of birth.',
                        style: GoogleFonts.philosopher(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkBrown,
                                fontSize: !isDesktop ? 11 : 13)),
                      ),
                    ),
                    /*
                    InkWell(
                      onTap: () async {
                        final XFile? image = await pickImage();
                        if (image != null) {
                          setState(() {
                            _imageFile = image;
                          });
                        }
                      },
                      child: DottedBorder(
                        borderType: BorderType.Circle,
                        color: AppColors.hintTextColor,
                        radius: Radius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.all(Radius.circular(1000)),
                            color: AppColors.lightPurple,
                          ),
                          height: !isDesktop
                              ? size.height * 0.175
                              : size.height * 0.3,
                          width: size.width * .5,
                          child: _imageFile != null
                              ? Image.file(File(_imageFile!.path))
                              : Icon(
                                  Icons.person_add_alt_1,
                                  size: !isDesktop ? 85 : 110,
                                  color: AppColors.grey,
                                ),
                        ),
                      ),
                    ),*/

                    InkWell(
                      onTap: () async {
                        final XFile? image = await pickImage();
                        if (image != null) {
                          setState(() {
                            _imageFile = image;
                          });
                        }
                      },
                      child: DottedBorder(
                        borderType: BorderType.Circle,
                        color: Colors.grey,
                        radius: Radius.circular(containerSize / 2),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple.shade50,
                          ),
                          height: containerSize,
                          width: containerSize,
                          child: _imageFile != null
                              ? ClipOval(
                                  child: Image.file(
                                    File(_imageFile!.path),
                                    fit: BoxFit.cover,
                                    width: containerSize,
                                    height: containerSize,
                                  ),
                                )
                              : Icon(
                                  Icons.person_add_alt_1,
                                  size: 85,
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: isDesktop ? 8.0 : 0),
                        child: Text(
                          'Profile Picture',
                          style: GoogleFonts.philosopher(
                              textStyle: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  color: AppColors.darkBrown,
                                  fontSize: !isDesktop ? 13 : 15)),
                        ),
                      ),
                    ),
                    //gender
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // width: width,
                          height: size.height * 0.038,
                          child: Text(
                            'Gender:  ',
                            style: GoogleFonts.philosopher(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    fontSize: !isDesktop ? 13 : 17)),
                          ),
                        ),
                        DropDownList(
                          dropdownItems: getGender(),
                          width:
                              !isDesktop ? size.width * .4 : size.width * 0.15,
                          hintText: "Gender",
                        ),
                      ],
                    ),
                    //date of birth
                    TextFiledContainer(
                      widthFactor: !isDesktop ? 0.7 : 0.3,
                      heightFactor: !isDesktop ? 0.05 : 0.07,
                      borderRadius: 29,
                      child: TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () async {
                              selectedDate = await showDatePickerDialog(
                                // currentDate: DateTime(2007, 10, 15),
                                //selectedDate: DateTime(2007, 10, 16),

                                splashRadius: 20,
                                height: !isDesktop
                                    ? size.height * 0.3
                                    : size.height * 0.44,
                                width: size.width * 0.4,
                                daysOfTheWeekTextStyle: GoogleFonts.philosopher(
                                  textStyle: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: !isDesktop ? 12 : 15,
                                  ),
                                ),
                                enabledCellsTextStyle: GoogleFonts.philosopher(
                                  textStyle: TextStyle(
                                    color: AppColors.brown,
                                    fontSize: !isDesktop ? 12 : 15,
                                  ),
                                ),
                                context: context,
                                minDate: DateTime(1950, 1, 1),
                                maxDate: DateTime(2008, 12, 31),
                              );
                              //print(selectedDate.toString());
                              setState(() {
                                _dateController.text =
                                    selectedDate!.toString().split(' ').first;
                              });
                            },
                            icon: Icon(
                              Icons.date_range_rounded,
                              color: AppColors.primary,
                              size: !isDesktop ? 20 : 25,
                            ),
                          ),
                          hintText: "Date of Birth",
                          hintStyle: TextStyle(
                            color: AppColors.hintTextColor,
                            fontSize: 15,
                          ),
                          icon: null,
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /*SizedBox(
                            width: size.width * 0.4,
                          ),*/
                            ClipRRect(
                              borderRadius: BorderRadius.circular(29),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, UserCompletionPage.routeName,
                                      arguments: {
                                        'selectedDate': selectedDate!
                                            .toString()
                                            .split(' ')
                                            .first,
                                        'gender': 0,
                                        'image': _imageFile!.path,
                                        'categories': categories,
                                      });
                                },
                                child: Text(
                                  "Save and Continue",
                                  style: TextStyle(color: AppColors.white),
                                ),
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 2),
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
                          ],
                        ),
                        if (!isDesktop)
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 18.0, top: 10),
                            child: Image.asset(
                              "assets/images/UserInfoCompletion.jpg",
                              width: size.width * .5,
                              height: size.height * 0.3,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // image
            if (isDesktop)
              ResponsiveRowColumnItem(
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0, top: 10),
                  child: Image.asset(
                    "assets/images/UserInfoCompletion.jpg",
                    width: size.width * .5,
                    height: size.height * 0.75,
                  ),
                ),
              ),
          ],
        ),
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

final Map<String, int> gender = {
  "Male": 1,
  "Female": 2,
};
List<DropdownMenuItem<String>> getGender() {
  List<DropdownMenuItem<String>> menuItems = [];
  gender.forEach((text, value) {
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
