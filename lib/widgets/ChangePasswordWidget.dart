import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/widgets/TextFiledWithLable.dart';

class ChangePasswordWidget extends StatefulWidget {
  ChangePasswordWidget({
    super.key,
    required TextEditingController currentPasswordController,
    required TextEditingController newPasswordController,
    required TextEditingController confirmPasswordController,
    // required TextEditingController projectNameController,
    required this.size,
  })  : _currentPasswordController = currentPasswordController,
        _newPasswordController = newPasswordController,
        _confirmPasswordController = confirmPasswordController;
  // _projectNameController = projectNameController;

  final TextEditingController _currentPasswordController;
  final TextEditingController _newPasswordController;
  final TextEditingController _confirmPasswordController;
  final Size size;

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  bool _currentIsVisible = false;
  bool _newIsVisible = false;
  bool _confirmIsVisible = false;
  @override
  Widget build(BuildContext context) {
    //isDesktop ? 11 : 13
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //   Icon(Icons.s)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Change Your Password',
              style: GoogleFonts.anta(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                      fontSize: isDesktop ? 15 : 20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 12),
            child: Text(
              "Choose a strong Password for Your account",
              style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brown,
                      fontSize: isDesktop ? 11 : 13)),
            ),
          ),
          TextFiledWithLabel(
            controller: widget._currentPasswordController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Password must not be empty";
              } else if (value.length < 9) {
                return "Password must be more than 8 characters";
              }
              return null;
            },
            Icon: IconButton(
              onPressed: () {
                setState(() {
                  _currentIsVisible = !_currentIsVisible;
                });
              },
              icon: Icon(
                _currentIsVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            heightFactor: 0.045,
            widthFactor: 0.85,
            borderRadius: 15,
            label: 'Current Password',
            obscureText: !_currentIsVisible,
          ),
          TextFiledWithLabel(
            controller: widget._newPasswordController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Password must not be empty";
              } else if (value.length < 9) {
                return "Password must be more than 8 characters";
              }
              return null;
            },
            Icon: IconButton(
              onPressed: () {
                setState(() {
                  _newIsVisible = !_newIsVisible;
                });
              },
              icon: Icon(
                _newIsVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            heightFactor: 0.045,
            widthFactor: 0.85,
            borderRadius: 15,
            label: 'New Password',
            obscureText: !_newIsVisible,
          ),
          TextFiledWithLabel(
            controller: widget._confirmPasswordController,
            validator: (value) {
              if (value!.isEmpty) {
                return "password must not be empty";
              } else if (widget._confirmPasswordController.text !=
                  widget._currentPasswordController.text) {
                return "Passwords do not matched";
              }
              return null;
            },
            Icon: IconButton(
              onPressed: () {
                setState(() {
                  _confirmIsVisible = !_confirmIsVisible;
                });
              },
              icon: Icon(
                _confirmIsVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            heightFactor: 0.045,
            widthFactor: 0.85,
            borderRadius: 15,
            label: 'Confirm Password',
            obscureText: !_confirmIsVisible,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: widget.size.height * .02, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                padding: EdgeInsets.only(top: widget.size.height * .02),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isDesktop) Navigator.pop(context);
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
