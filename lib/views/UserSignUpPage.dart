import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/views/HomePage.dart';
import 'package:grad_new_project/views/UserPersonalInfoCompletionPage.dart';
import 'package:grad_new_project/widgets/LocationSelectorWithTextField.dart';
import 'package:grad_new_project/widgets/LocationSelectorWithTextField.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../core/utils/router/AppColors.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import '../view_model/auth_cubit/auth_state.dart';
import '../widgets/TextFiledWithLable.dart';

class UserSignUpPage extends StatefulWidget {
  static String routeName = '/user-sign-up';

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final city = _cityController.text;
      final country = _countryController.text;
      final state = _stateController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      //print(email);
      await BlocProvider.of<AuthCubit>(context).signUpAsUser(
        firstName,
        lastName,
        email,
        country,
        state,
        city,
        password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 800;

      return Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset("assets/images/access.png"),
                width: size.width * 0.3,
                height: size.height * .15,
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      children: [
                        ResponsiveRowColumn(
                          layout: isDesktop
                              ? ResponsiveRowColumnType.ROW
                              : ResponsiveRowColumnType.COLUMN,
                          rowCrossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ResponsiveRowColumnItem(
                              child: ResponsiveVisibility(hiddenWhen: const [
                                Condition.largerThan(name: DESKTOP),
                              ], child: SizedBox(height: size.height / 11)),
                            ),
                            ResponsiveRowColumnItem(
                              child: ResponsiveVisibility(
                                hiddenWhen: const [
                                  Condition.smallerThan(name: DESKTOP),
                                ],
                                child: Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: size.height / 6),
                                    child: Image.asset(
                                      "images/userSignUp.png",
                                      width: size.width * 0.5,
                                      height: size.height * 0.5,
                                      //fit: BoxFit.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ResponsiveRowColumnItem(
                              child: Container(
                                width:
                                    isDesktop ? size.width * 0.3 : size.width,
                                child: Column(
                                  children: [
                                    ResponsiveRowColumnItem(
                                      child: ResponsiveVisibility(
                                          hiddenWhen: const [
                                            Condition.smallerThan(
                                                name: DESKTOP),
                                          ],
                                          child: SizedBox(
                                              height: size.height / 11)),
                                    ),
                                    Text(
                                      'User Sign Up',
                                      style: GoogleFonts.anton(
                                          textStyle: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                              color: AppColors.primary)),
                                    ),
                                    SizedBox(height: size.height / 39),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextFiledWithLabel(
                                          controller: _firstNameController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "First name must not be empty";
                                            }
                                            return null;
                                          },
                                          heightFactor: 0.045,
                                          widthFactor:
                                              ResponsiveWrapper.of(context)
                                                      .isSmallerThan(DESKTOP)
                                                  ? 0.368
                                                  : 0.145,
                                          borderRadius: 15,
                                          label: 'First Name',
                                          obscureText: false,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        TextFiledWithLabel(
                                          controller: _lastNameController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Last name must not be empty";
                                            }
                                            return null;
                                          },
                                          Icon: null,
                                          heightFactor: 0.045,
                                          widthFactor:
                                              ResponsiveWrapper.of(context)
                                                      .isSmallerThan(DESKTOP)
                                                  ? 0.368
                                                  : 0.145,
                                          borderRadius: 15,
                                          label: 'Last Name',
                                          obscureText: false,
                                        ),
                                      ],
                                    ),
                                    /*TextFiledWithLabel(
                                      controller: _cityController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "City must not be empty";
                                        }
                                        return null;
                                      },
                                      Icon: null,
                                      heightFactor: 0.045,
                                      widthFactor: 0.74,
                                      borderRadius: 15,
                                      label: 'City',
                                      obscureText: false,
                                    ),*/
                                    //****   Note: here when the location is selected I set the hint text
                                    // of the text field to hold the selected COuntry/city/state  ***** */
                                    LocationSelectorWithTextField(
                                      selectedCountry: 'Country',
                                      selectedState: 'State',
                                      selectedCity: 'City',
                                      countryController: _countryController,
                                      stateController: _stateController,
                                      cityController: _cityController,
                                    ),
                                    TextFiledWithLabel(
                                      controller: _emailController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Email must not be empty";
                                        } else if (!value.contains('@')) {
                                          return "Please enter a valid email";
                                        }
                                        return null;
                                      },
                                      Icon: null,
                                      heightFactor: 0.045,
                                      widthFactor: 0.74,
                                      borderRadius: 15,
                                      label: 'Email',
                                      obscureText: false,
                                    ),
                                    TextFiledWithLabel(
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Password must not be empty";
                                        } else if (value.length < 9) {
                                          return "Password must be more than 8 charactars";
                                        }
                                        return null;
                                      },
                                      Icon: null,
                                      heightFactor: 0.045,
                                      widthFactor: 0.74,
                                      borderRadius: 15,
                                      label: 'Password',
                                      obscureText: true,
                                    ),
                                    TextFiledWithLabel(
                                      controller: _confirmPasswordController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "password must not be empty";
                                        } else if (_confirmPasswordController
                                                .text !=
                                            _passwordController.text) {
                                          return "Passwords do not matched";
                                        }
                                        return null;
                                      },
                                      Icon: null,
                                      heightFactor: 0.045,
                                      widthFactor: 0.74,
                                      borderRadius: 15,
                                      label: 'Confirm Password',
                                      obscureText: true,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 16),
                                      width: size.width * 0.74,
                                      child: BlocConsumer<AuthCubit, AuthState>(
                                        listener: (context, state) {
                                          if (state is AuthSuccess) {
                                            //print(state);

                                            Navigator.pushReplacementNamed(
                                                context,
                                                UserPersonalInfoCompletionPage
                                                    .routeName);
                                          } else if (state is AuthFailure) {
                                            //print(state.message);
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('Error'),
                                                content: Text(state.message),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is AuthLoading) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(29),
                                              child: ElevatedButton(
                                                onPressed: signUp,
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                                style: ButtonStyle(
                                                  padding:
                                                      MaterialStateProperty.all(
                                                    EdgeInsets.symmetric(
                                                        horizontal: 40),
                                                  ),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    AppColors.primary,
                                                  ),
                                                  overlayColor:
                                                      MaterialStateProperty.all(
                                                    AppColors.overlayColor,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(29),
                                            child: ElevatedButton(
                                              onPressed: signUp,
                                              child: Text(
                                                "SIGN UP",
                                                style: TextStyle(
                                                    color: AppColors.white),
                                              ),
                                              style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                  EdgeInsets.symmetric(
                                                      horizontal: 40),
                                                ),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  AppColors.primary,
                                                ),
                                                overlayColor:
                                                    MaterialStateProperty.all(
                                                  AppColors.overlayColor,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    /* SizedBox(
                                                          height: size.height * 0.095,
                                                        ),*/
                                    /*TextButton(
                                                          onPressed: () => AppRouter.goBackTOScreen(),
                                                          child: Text(
                                                            'Do not have an account? Sign Up',
                                                            style: GoogleFonts.philosopher(
                                  textStyle: TextStyle(fontWeight: FontWeight.bold)),
                                                          ),
                                                        ),*/
                                    if (!isDesktop)
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            "assets/images/userSignUp.png",
                                            width: isDesktop
                                                ? size.width * 0.3
                                                : size.width * 0.4,
                                            height: size.height * 0.2,
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            ResponsiveRowColumnItem(
                              child: ResponsiveVisibility(
                                  hiddenWhen: const [
                                    Condition.smallerThan(name: DESKTOP),
                                  ],
                                  child: SizedBox(
                                    width: 170,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset("images/userSignUp.png"),
                width: size.width * 0.54,
                height: size.height * 0.27,
              ),*/
            ],
          ),
        ),
      );
    });
  }
}
