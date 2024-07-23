import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/widgets/ArtistBankInfoWidget.dart';
import 'package:grad_new_project/widgets/ChangePasswordWidget.dart';
import 'package:grad_new_project/widgets/LogoutWidget.dart';
import 'package:grad_new_project/widgets/MyAppBar.dart';
import 'package:grad_new_project/widgets/PersonalInformationWidget.dart';
import 'package:grad_new_project/widgets/ProjectInformationWidget.dart';
import 'package:grad_new_project/widgets/TextContainerWithArrowButton.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../view_model/account_cubit/account_cubit.dart';
import '../view_model/account_cubit/account_state.dart';
import '../view_model/auth_cubit/auth_cubit.dart';

class AccountPage extends StatefulWidget {
  static String routeName = '/account';

  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  Image? img;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _projectNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _projectCategoryController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  int selectedIndex = 0;

  Future<XFile?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  void onMenuPressed(int index, Size size) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0) {
      showModalBottomSheet<void>(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.66,
            child: Container(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: PersonalInformationWidget(
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  emailController: _emailController,
                  size: size,
                ),
              ),
            ),
          );
        },
      );
    } else if (index == 1) {
      showModalBottomSheet<void>(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.66,
            child: Container(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: ProjectInformationWidget(
                  projectNameController: _projectNameController,
                  size: size,
                  projectCategoryController: _projectCategoryController,
                ),
              ),
            ),
          );
        },
      );
    } else if (index == 2) {
      showModalBottomSheet<void>(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.66,
            child: Container(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: ChangePasswordWidget(
                  currentPasswordController: _currentPasswordController,
                  newPasswordController: _newPasswordController,
                  confirmPasswordController: _confirmPasswordController,
                  size: size,
                ),
              ),
            ),
          );
        },
      );
    } else if (index == 3) {
      showModalBottomSheet<void>(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.66,
            child: Container(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: ArtistBankInfoWidget(
                  size: size,
                  bankNameController: _bankNameController,
                  accountNumberController: _accountNumberController,
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    final accountCubit = context.read<AccountCubit>();
    accountCubit.fetchArtistAccountInfo();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.orange,
        surfaceTintColor: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset(
            'assets/images/Icon.png',
            height: 40,
          ),
        ),
        foregroundColor: AppColors.brown,
      ),
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AccountLoaded || state is AccountUpdated) {
            final account = (state is AccountLoaded)
                ? state.account
                : (state as AccountUpdated).account;

            _firstNameController.text = account.firstName;
            _lastNameController.text = account.lastName;
            _emailController.text = account.email;
            _projectNameController.text = account.profile.projectName;
            _projectCategoryController.text =
                account.profile.categoryName.toString();

            return SingleChildScrollView(
              child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                children: [
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 5),
                      child: Container(
                        width: size.width * 0.3,
                        height: size.width * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5),
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            image: _imageFile != null
                                ? img!.image
                                : NetworkImage(account.profile.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: InkWell(
                      onTap: () async {
                        final XFile? image = await pickImage();
                        if (image != null) {
                          setState(() {
                            _imageFile = image;
                            img = Image.file(File(_imageFile!.path));
                          });
                          // Update the profile image using AccountCubit
                          context
                              .read<AccountCubit>()
                              .updateProfileInfo({'image': _imageFile!.path});
                        }
                      },
                      child: Text(
                        'Edit Photo',
                        style: GoogleFonts.philosopher(
                          textStyle: TextStyle(
                            color: AppColors.orange2,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            '${account.firstName} ${account.lastName}',
                            style: GoogleFonts.anta(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkBrown,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '~ ${account.profile.projectName}',
                            style: GoogleFonts.anta(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkBrown,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            account.email,
                            style: GoogleFonts.anta(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(113, 75, 43, 32),
                                fontSize: 10,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextContainerWithArrowButton(
                            height: size.height * 0.065,
                            onPressed: () => onMenuPressed(0, size),
                            text: "Personal Information",
                          ),
                          SizedBox(height: 10),
                          TextContainerWithArrowButton(
                            height: size.height * 0.065,
                            onPressed: () => onMenuPressed(1, size),
                            text: "Project Information",
                          ),
                          SizedBox(height: 10),
                          TextContainerWithArrowButton(
                            height: size.height * 0.065,
                            onPressed: () => onMenuPressed(2, size),
                            text: "Change Your Password",
                          ),
                          SizedBox(height: 10),
                          TextContainerWithArrowButton(
                            height: size.height * 0.065,
                            onPressed: () => onMenuPressed(3, size),
                            text: "Bank Account Information",
                          ),
                          SizedBox(height: 10),
                          TextContainerWithArrowButton(
                            height: size.height * 0.065,
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<AuthCubit>().signOut();
                            },
                            text: "Log out",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
                child: Text('Failed to load account information.'));
          }
        },
      ),
    );
  }
}
