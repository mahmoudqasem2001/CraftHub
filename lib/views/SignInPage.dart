import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/chat_system/api/FirebaseServices.dart';
import 'package:grad_new_project/chat_system/screens/chat_home_screen.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/views/ArtistBottomBar.dart';
import 'package:grad_new_project/views/HomePage.dart';
import 'package:grad_new_project/views/UserBottomBar.dart';
import 'package:grad_new_project/views/WelcomePage.dart';
import 'package:grad_new_project/widgets/TextFiledContainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view_model/auth_cubit/auth_cubit.dart';
import '../view_model/auth_cubit/auth_state.dart';

class SignInPage extends StatefulWidget {
  static String routeName = '/sign-in';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isVisible = false;

  bool isLogin = true;

  String? _passwordErrorText;
  String? _emailErrorText;

  Future<void> login() async {
    if (_formKey.currentState!.validate() &&
        _emailErrorText == null &&
        _passwordErrorText == null) {
      debugPrint('Email: ${_emailController.text}');
      debugPrint('Password: ${_passwordController.text}');
      await BlocProvider.of<AuthCubit>(context).signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  String? validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      return null;
    } else {
      return 'Password must contain at least 8 characters, including uppercase, lowercase, number, and special character';
    }
  }

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
    final cubit = BlocProvider.of<AuthCubit>(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isDesktop = constraints.maxWidth > 900;

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/LoginBackground.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor:
                AppColors.transparent, // Make the Scaffold transparent
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: ResponsiveRowColumn(
                    columnPadding: isDesktop
                        ? EdgeInsets.symmetric(horizontal: size.width * 0.1)
                        : EdgeInsets.all(0),
                    layout: ResponsiveRowColumnType.COLUMN,
                    columnMainAxisAlignment: MainAxisAlignment.start,
                    columnCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveRowColumnItem(
                          child: SizedBox(height: size.height * 0.05)),
                      if (isDesktop)
                        ResponsiveRowColumnItem(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    "assets/images/login.png",
                                    width: size.width * 0.3,
                                    height: size.height * 0.6,
                                    //fit: BoxFit.none,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.05),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextFiledContainer(
                                        widthFactor: 0.74,
                                        heightFactor: 0.065,
                                        borderRadius: 29,
                                        child: TextFormField(
                                          controller: _emailController,
                                          validator: (value) {
                                            if (value != null) {
                                              setState(() {
                                                _emailErrorText =
                                                    validateEmail(value);
                                              });
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Your Email",
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
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            _emailErrorText!,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      SizedBox(height: size.height * 0.01),
                                      TextFiledContainer(
                                        widthFactor: 0.74,
                                        heightFactor: 0.065,
                                        borderRadius: 29,
                                        child: TextFormField(
                                          controller: _passwordController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              setState(() {
                                                _passwordErrorText =
                                                    "Password must not be empty";
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
                                            hintText: "Your Password",
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
                                                    ? Icons
                                                        .visibility_off_outlined
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
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            _passwordErrorText!,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      SizedBox(height: size.height * 0.02),
                                      BlocConsumer<AuthCubit, AuthState>(
                                        bloc: cubit,
                                        listenWhen: (previous, current) =>
                                            current is AuthSuccess ||
                                            current is AuthFailure,
                                        listener: (context, state) async {
                                          if (state is AuthSuccess) {
                                            final SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            final String? userType =
                                                prefs.getString('userType');
                                            print(userType);

                                            if (userType == 'customer') {
                                              Navigator.pushNamed(context,
                                                  UserBottomNavbar.routeName);
                                            } else if (userType == 'artist') {
                                              Navigator.pushNamed(context,
                                                  ArtistBottomBar.routeName);
                                            }
                                          } else if (state is AuthFailure) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Error'),
                                                  content: Text(state.message),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        buildWhen: (previous, current) =>
                                            current is AuthLoading ||
                                            current is AuthFailure ||
                                            current is AuthSuccess ||
                                            current is AuthInitial,
                                        builder: (context, state) {
                                          if (state is AuthLoading) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 20),
                                              width: size.width * 0.74,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(29),
                                                child: ElevatedButton(
                                                  onPressed: login,
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive(),
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .symmetric(
                                                      horizontal: 40,
                                                    )),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppColors
                                                                .primary),
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .all(AppColors
                                                                .overlayColor),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 20),
                                            width: size.width * 0.74,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(29),
                                              child: ElevatedButton(
                                                onPressed: login,
                                                child: Text(
                                                  "LOGIN",
                                                  style: TextStyle(
                                                      color: AppColors.white),
                                                ),
                                                style: ButtonStyle(
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          EdgeInsets.symmetric(
                                                    horizontal: 40,
                                                  )),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          AppColors.primary),
                                                  overlayColor:
                                                      MaterialStateProperty.all(
                                                          AppColors
                                                              .overlayColor),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: size.height * 0.02),
                                      TextButton(
                                        onPressed: () => AppRouter.goTOScreen(
                                            WelcomePage.routeName),
                                        child: Text(
                                          'Do not have an account? Sign Up',
                                          style: GoogleFonts.philosopher(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else // For mobile and smaller screens
                        ResponsiveRowColumnItem(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/login.png",
                                width: size.width * 0.7,
                                height: size.height * 0.4,
                                //fit: BoxFit.none,
                              ),
                              SizedBox(height: size.height * 0.05),
                              TextFiledContainer(
                                widthFactor: 0.74,
                                heightFactor: 0.065,
                                borderRadius: 29,
                                child: TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value != null) {
                                      setState(() {
                                        _emailErrorText = validateEmail(value);
                                      });
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Your Email",
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
                              SizedBox(height: size.height * 0.02),
                              TextFiledContainer(
                                widthFactor: 0.74,
                                heightFactor: 0.065,
                                borderRadius: 29,
                                child: TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setState(() {
                                        _passwordErrorText =
                                            "Password must not be empty";
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
                                    hintText: "Your Password",
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
                              SizedBox(height: size.height * 0.02),
                              BlocConsumer<AuthCubit, AuthState>(
                                bloc: cubit,
                                listenWhen: (previous, current) =>
                                    current is AuthSuccess ||
                                    current is AuthFailure,
                                listener: (context, state) async {
                                  if (state is AuthSuccess) {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    final String? userType =
                                        prefs.getString('userType');
                                    print(userType);
                                    if (userType == 'customer') {
                                      Navigator.pushNamed(
                                          context, UserBottomNavbar.routeName);
                                    } else if (userType == 'artist') {
                                      Navigator.pushNamed(
                                          context, ArtistBottomBar.routeName);
                                    }
                                  } else if (state is AuthFailure) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: Text(state.message),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                buildWhen: (previous, current) =>
                                    current is AuthLoading ||
                                    current is AuthFailure ||
                                    current is AuthSuccess ||
                                    current is AuthInitial,
                                builder: (context, state) {
                                  if (state is AuthLoading) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      width: size.width * 0.74,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(29),
                                        child: ElevatedButton(
                                          onPressed: login,
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.symmetric(
                                              horizontal: 40,
                                            )),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColors.primary),
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    AppColors.overlayColor),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    width: size.width * 0.74,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(29),
                                      child: ElevatedButton(
                                        onPressed: login,
                                        child: Text(
                                          "LOGIN",
                                          style:
                                              TextStyle(color: AppColors.white),
                                        ),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                            horizontal: 40,
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.primary),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  AppColors.overlayColor),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: size.height * 0.02),
                              TextButton(
                                onPressed: () => AppRouter.goBackTOScreen(),
                                child: Text(
                                  'Do not have an account? Sign Up',
                                  style: GoogleFonts.philosopher(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  final _auth = FirebaseAuth.instance;
  String errorMessage = '';
  void signUp(String email, String password) async {
    setState(() {
      errorMessage = '';
    });

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Store additional user information in Firestore
        APIs.createUser().then((value) {
          AppRouter.goTOScreen(ArtistBottomBar.routeName);
        });
        AppRouter.goTOScreen(ArtistBottomBar.routeName);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use.';
      } else {
        errorMessage = 'An error occurred. Please try again.';
      }
      print(e.message);
    }
    print(errorMessage);
  }

  void signIn(String email, String password) async {
    setState(() {
      errorMessage = '';
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Check if user exists
        if ((await APIs.userExsist())) {
          //AppRouter.goTOScreen(ChatHomeScreen.routeName);
          AppRouter.goTOScreen(ArtistBottomBar.routeName);
        } else {
          APIs.createUser().then((value) {
            AppRouter.goTOScreen(ArtistBottomBar.routeName);
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else {
        errorMessage = 'An error occurred. Please try again.';
      }
      print(e.message);
    }
  }
}
