import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/widgets/ChangePasswordWidget.dart';
import 'package:grad_new_project/widgets/LogoutWidget.dart';
import 'package:grad_new_project/widgets/MyAppBar.dart';
import 'package:grad_new_project/widgets/PersonalInformationWidget.dart';
import 'package:grad_new_project/widgets/ProjectInformationWidget.dart';
import 'package:grad_new_project/widgets/TextContainerWithArrowButton.dart';
import 'package:grad_new_project/widgets/UserAppBar.dart';
import 'package:grad_new_project/widgets/UserInterestedInCategories.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../view_model/account_cubit/account_cubit.dart';
import '../view_model/account_cubit/account_state.dart';

class UserAccountPage extends StatefulWidget {
  static String routeName = '/account';
  const UserAccountPage({super.key});

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  Image? img;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<AccountCubit>().fetchCustomerAccountInfo();
  }

  Future<XFile?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  int selctedIndex = 1;
  void mobileOnPressed(double heightFactor, Widget onPressedChild) {
    showModalBottomSheet<void>(
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: heightFactor,
          //widthFactor: size.width * 0.2,
          child: onPressedChild,
        );
      },
      isScrollControlled: true,
    );
  }

  Widget getChildWidget(int index, Size size) {
    switch (index) {
      case 1:
        return Container(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
            child: PersonalInformationWidget(
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                emailController: _emailController,
                size: size),
          ),
        );
      case 2:
        return Container(
          width: size.width,
          child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
              child: ChangePasswordWidget(
                  currentPasswordController: _currentPasswordController,
                  newPasswordController: _newPasswordController,
                  confirmPasswordController: _confirmPasswordController,
                  size: size)),
        );
      case 3:
        return Container(
          width: size.width,
          child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
              child: UserInterestedInCategories(size: size)),
        );
      case 4:
        return Padding(
            padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
            child: LogoutWidget(size: size));
      default:
        return Center(
          child: Text('Invalid variable value'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;

      return Scaffold(
        appBar: !isDesktop
            ? UserAppBar(
                withLogo: true,
                generalSearch: true,
              )
            : null,
        body: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountLoaded) {
              _firstNameController.text = state.account.firstName;
              _lastNameController.text = state.account.lastName;
              _emailController.text = state.account.email;
              return SingleChildScrollView(
                child: ResponsiveRowColumn(
                  layout: !isDesktop
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  rowMainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ResponsiveRowColumnItem(
                      child: SizedBox(
                        height: size.height,
                        width: size.width,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: isDesktop ? 100.0 : 0,
                              top: isDesktop ? 20 : 0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 5),
                                child: Container(
                                  width: !isDesktop
                                      ? size.width * 0.3
                                      : size.width * 0.15,
                                  height: !isDesktop
                                      ? size.width * 0.3
                                      : size.width * 0.15,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 5),
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: _imageFile != null
                                          ? img!.image
                                          : NetworkImage(
                                              state.account.profile.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final XFile? image = await pickImage();
                                  if (image != null) {
                                    setState(() {
                                      _imageFile = image;
                                      img = Image.file(File(_imageFile!.path));
                                    });
                                  }
                                },
                                child: Text(
                                  'Edit Photo',
                                  style: GoogleFonts.philosopher(
                                      textStyle: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: AppColors.orange2,
                                          fontSize: 13)),
                                ),
                              ),
                              //user name
                              Center(
                                child: Text(
                                  '${state.account.firstName} ${state.account.lastName}',
                                  style: GoogleFonts.anta(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.darkBrown,
                                          fontSize: 15)),
                                ),
                              ),
                              // user email
                              Center(
                                child: Text(
                                  state.account.email,
                                  style: GoogleFonts.anta(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              113, 75, 43, 32),
                                          fontSize: 10)),
                                ),
                              ),
                              SizedBox(
                                height: !isDesktop ? 10 : 30,
                              ),
                              TextContainerWithArrowButton(
                                height: size.height * 0.065,
                                onPressed: () {
                                  if (!isDesktop) {
                                    mobileOnPressed(
                                      0.66,
                                      Container(
                                        width: size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 16, right: 16),
                                          child: PersonalInformationWidget(
                                              firstNameController:
                                                  _firstNameController,
                                              lastNameController:
                                                  _lastNameController,
                                              emailController: _emailController,
                                              size: size),
                                        ),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      selctedIndex = 1;
                                    });
                                    //print(selctedIndex);
                                  }
                                },
                                text: "  Personal Information",
                                // heightFactor: 0.66,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextContainerWithArrowButton(
                                height: size.height * 0.065,
                                onPressed: () {
                                  if (!isDesktop) {
                                    mobileOnPressed(
                                      0.66,
                                      Container(
                                        width: size.width,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 16, right: 16),
                                            child: ChangePasswordWidget(
                                                currentPasswordController:
                                                    _currentPasswordController,
                                                newPasswordController:
                                                    _newPasswordController,
                                                confirmPasswordController:
                                                    _confirmPasswordController,
                                                size: size)),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      selctedIndex = 2;
                                    });
                                    //print(selctedIndex);
                                  }
                                },
                                text: "  Change Your Password",
                                //heightFactor: 0.66,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ////////////////////////
                              TextContainerWithArrowButton(
                                height: size.height * 0.065,
                                onPressed: () {
                                  if (!isDesktop) {
                                    mobileOnPressed(
                                      0.66,
                                      Container(
                                        width: size.width,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 16, right: 16),
                                            child: UserInterestedInCategories(
                                                size: size)),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      selctedIndex = 3;
                                    });
                                    //print(selctedIndex);
                                  }
                                },
                                text: "  Interested Categories",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /////////////////////////////////
                              TextContainerWithArrowButton(
                                height: size.height * 0.065,
                                onPressed: () {
                                  if (!isDesktop) {
                                    mobileOnPressed(
                                      0.2,
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 16, right: 16),
                                          child: LogoutWidget(size: size)),
                                    );
                                  } else {
                                    setState(() {
                                      selctedIndex = 4;
                                    });
                                    //print(selctedIndex);
                                  }
                                },
                                text: "  Log out",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (isDesktop)
                      ResponsiveRowColumnItem(
                        child: SizedBox(
                          width: 30,
                        ),
                      ),
                    if (isDesktop)
                      ResponsiveRowColumnItem(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: SizedBox(
                            height: size.height,
                            width: size.width * 0.33,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 0,
                                    right: !isDesktop ? size.width * .25 : 0,
                                  ),
                                  child: Image.asset(
                                    "assets/images/UserAccount.jpg",
                                    width: size.width * 0.36,
                                    height: !isDesktop
                                        ? size.height * 0.15
                                        : size.height * 0.35,
                                  ),
                                ),
                                /*  Text("Hi"),
                          SizedBox(
                            height: 160,
                          ),*/
                                getChildWidget(selctedIndex, size),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              );
            } else if (state is AccountFailure) {
              return Center(child: Text('Failed to load account information.'));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
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
  "Handmade Furniture": 11,
  "Wood Carving": 12,
  "Handmade Accessories": 13,
  "Handmade Candles": 14,
  "Others": 111,
};
final Map<String, int> gender = {
  "Male": 1,
  "Female": 2,
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
