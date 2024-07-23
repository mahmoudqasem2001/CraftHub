// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';

import 'package:grad_new_project/widgets/TextFiledContainer.dart';
import 'package:grad_new_project/widgets/TextFiledWithLable.dart';

class PaypalWidget extends StatefulWidget {
  final TextEditingController emailController;

  final TextEditingController passwordController;
  PaypalWidget({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<PaypalWidget> createState() => _PaypalWidgetState();
}

class _PaypalWidgetState extends State<PaypalWidget> {
  bool _isVisible = false;

  bool isLogin = true;

  String? _passwordErrorText;
  String? _emailErrorText;
  String? validateEmail(String value) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      return null;
    } else {
      return 'Please enter a valid email';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return SizedBox(
        height: size.height * 0.3,
        width: isDesktop ? size.width * 0.3 : size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 12,
                ),
                child: Text(
                  "To complete your purchase, please log in to your PayPal account and enter the required information. "
                  "Ensure that your PayPal account is active and has sufficient funds to cover the total amount.",
                  style: GoogleFonts.philosopher(
                      textStyle: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: AppColors.brown,
                          fontSize: 12)),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                width: size.width * 0.88,
                height: size.height * 0.065,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.hintTextColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  controller: widget.emailController,
                  validator: (value) {
                    if (value != null) {
                      setState(() {
                        _emailErrorText = validateEmail(value);
                      });
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Your PayPal Email",
                    hintStyle: TextStyle(
                      color: AppColors.hintTextColor,
                      fontSize: 15,
                    ),
                    icon: Icon(
                      Icons.email,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (_emailErrorText != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    _emailErrorText!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
              SizedBox(height: size.height * 0.01),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                width: size.width * 0.88,
                height: size.height * 0.065,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.hintTextColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  controller: widget.passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      setState(() {
                        _passwordErrorText = "Password must not be empty";
                      });
                    } else if (value.length < 9) {
                      setState(() {
                        _passwordErrorText =
                            "Password must be more than 8 characters";
                      });
                    } else {
                      setState(() {
                        _passwordErrorText = null;
                      });
                    }

                    return null;
                  },
                  obscureText: !_isVisible,
                  decoration: InputDecoration(
                    hintText: "Your  PalPay Password",
                    hintStyle: TextStyle(
                      color: AppColors.hintTextColor,
                      fontSize: 15,
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: Icon(
                        _isVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
              if (_passwordErrorText != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    _passwordErrorText!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
