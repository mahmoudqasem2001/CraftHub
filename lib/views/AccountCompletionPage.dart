import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/ArtistPaymentInfoCompletionPage.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/widgets/DropDownList.dart';
import 'package:grad_new_project/widgets/TextFiledContainer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../view_model/auth_cubit/auth_cubit.dart';

class AccountCompletionPage extends StatefulWidget {
  static String routeName = 'account-completion';
  const AccountCompletionPage({super.key});

  @override
  State<AccountCompletionPage> createState() => _AccountCompletionPageState();
}

class _AccountCompletionPageState extends State<AccountCompletionPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  TextEditingController _projectCategoryController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime? selectedDate;
  String gender = '0';
  Future<XFile?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<void> createProfile() async {
    print('gender' + gender);
    print(selectedDate != null ? selectedDate!.toString() : "Data Null");
    print(_imageFile!.path);
    await BlocProvider.of<AuthCubit>(context).authServices.createProfile(
        gender: int.parse(gender),
        birthDate: selectedDate!.toString().split(' ').first,
        image: _imageFile!.path,
        interestedCategories: {
          '0': 1,
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    bool readOnlyProjectCategory =
        true; // false only if the user selects the others option in the categories DropDown list
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      final double containerSize =
          !isDesktop ? size.width * 0.4 : size.height * 0.23;
      return Scaffold(
        appBar: AppBar(
          leadingWidth: !isDesktop ? 160 : 180,
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
              height: !isDesktop ? 30 : 100,
            ),
          ),
        ),
        body: ResponsiveRowColumn(
          layout: !isDesktop
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.center,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          columnMainAxisAlignment: MainAxisAlignment.center,
          //  crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResponsiveRowColumnItem(
              child: Container(
                width: isDesktop ? size.width * 0.4 : size.width * 0.95,
                child: Column(
                  children: [
                    if (isDesktop)
                      SizedBox(
                        height: 40,
                      ),
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
                    if (isDesktop)
                      SizedBox(
                        height: 10,
                      ),
                    Center(
                      child: Text(
                        'Profile Picture',
                        style: GoogleFonts.philosopher(
                            textStyle: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: AppColors.darkBrown,
                                fontSize: !isDesktop ? 13 : 16)),
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
                                    fontSize: !isDesktop ? 13 : 16)),
                          ),
                        ),
                        DropDownList(
                          selectedGender: gender,
                          dropdownItems: getGender(),
                          width:
                              !isDesktop ? size.width * .4 : size.width * 0.13,
                          hintText: "Gender",
                        ),
                      ],
                    ),
                    //date of birth
                    TextFiledContainer(
                      widthFactor: !isDesktop ? 0.7 : 0.32,
                      heightFactor: !isDesktop ? 0.05 : 0.06,
                      borderRadius: 29,
                      child: TextFormField(
                        readOnly: readOnlyProjectCategory,
                        controller: _dateController,
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
                              setState(() {
                                _dateController.text =
                                    selectedDate!.toString().split(' ').first;
                              });
                              //print(selectedDate.toString());
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // width: width,
                          height: size.height * 0.038,
                          child: Text(
                            'Project Category:',
                            style: GoogleFonts.philosopher(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    fontSize: !isDesktop ? 13 : 16)),
                          ),
                        ),
                        DropDownList(
                          dropdownItems: getCategories(),
                          width:
                              !isDesktop ? size.width * .6 : size.width * 0.2,
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
                              fontSize: !isDesktop ? 13 : 15)),
                    ),
                    // want to make sure to accept the text only if the user selects the ((others)) option in the categories list
                    TextFiledContainer(
                      widthFactor: !isDesktop ? 0.7 : 0.323,
                      heightFactor: !isDesktop ? 0.05 : 0.06,
                      borderRadius: 29,
                      child: TextFormField(
                        readOnly: true,
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
                    SizedBox(
                      height:
                          !isDesktop ? size.height * 0.03 : size.height * 0.055,
                    ),
                    if (isDesktop)
                      Container(
                        width: size.width * 0.25,
                        height: size.height * 0.07,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: ElevatedButton(
                            onPressed: () {
                              AppRouter.goTOScreen(
                                  ArtistPaymentInfoCompletionPage.routeName);
                            },
                            child: Text(
                              "Save and SignIn",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: isDesktop ? 16 : 13),
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
                      ),
                  ],
                ),
              ),
            ),

            // image
            ResponsiveRowColumnItem(
              child: Container(
                width: isDesktop ? size.width * 0.5 : size.width * 0.9,
                child: ResponsiveRowColumn(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  layout: !isDesktop
                      ? ResponsiveRowColumnType.ROW
                      : ResponsiveRowColumnType.COLUMN,
                  rowMainAxisAlignment: MainAxisAlignment.start,
                  rowCrossAxisAlignment: CrossAxisAlignment.start,
                  columnCrossAxisAlignment: CrossAxisAlignment.center,
                  columnMainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ResponsiveRowColumnItem(
                      child: Image.asset(
                        "assets/images/AccountCompletion.jpg",
                        width: !isDesktop ? size.width * .5 : size.width * .5,
                        height:
                            !isDesktop ? size.height * 0.3 : size.height * .7,
                      ),
                    ),
                    if (!isDesktop)
                      ResponsiveRowColumnItem(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: ElevatedButton(
                            onPressed: () {
                              createProfile();

                              AppRouter.goTOScreen(
                                  ArtistPaymentInfoCompletionPage.routeName);
                            },
                            child: Text(
                              "Save and SignIn",
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
                      ),
                    if (isDesktop)
                      ResponsiveRowColumnItem(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 30),
                          child: Text(
                            'Complete Your \nPersonal Information',
                            style: GoogleFonts.philosopher(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  fontSize: 30),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                  ],
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
  "Male": 0,
  "Female": 1,
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
    print("value gender: " + value.toString());
  });
  return menuItems;
}
