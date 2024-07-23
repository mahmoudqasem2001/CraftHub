import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/UserBottomBar.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/models/category_model.dart';
import 'package:grad_new_project/widgets/CategoriesButtons.dart';
import 'package:grad_new_project/view_model/auth_cubit/auth_cubit.dart';
import 'package:grad_new_project/view_model/auth_cubit/auth_state.dart';
import 'package:responsive_framework/responsive_row_column.dart';

Map<String, int> interestedCategories = {};

class UserCompletionPage extends StatelessWidget {
  const UserCompletionPage({super.key});
  static const String routeName = 'user-completion';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // Retrieve the arguments passed to this page
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final AuthCubit authCubit = context.read<AuthCubit>();

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        bool isDesktop = constraints.maxWidth > 900;
        return Scaffold(
          appBar: AppBar(
            shadowColor: AppColors.orange,
            surfaceTintColor: AppColors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 10, left: 7, bottom: 10),
              child: Image.asset(
                'assets/images/Icon.png',
                height: 30,
              ),
            ),
            leadingWidth: 160,
            foregroundColor: AppColors.brown,
          ),
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                // Show loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  },
                );
              } else if (state is AuthSuccess) {
                // Dismiss loading indicator
                Navigator.pop(context);
                // Navigate to UserBottomNavbar on success
                AppRouter.goTOScreen(UserBottomNavbar.routeName);
              } else if (state is AuthFailure) {
                // Dismiss loading indicator
                Navigator.pop(context);
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              final Map<String, int> categories = {};
              for (CategoryModel element in authCubit.categories) {
                categories[element.name] = int.parse(element.id);
              }
              print(authCubit.categories);

              return ResponsiveRowColumn(
                layout: !isDesktop
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ResponsiveRowColumnItem(
                    child: Container(
                      width: isDesktop ? size.width * 0.4 : size.width,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Text(
                              "You're Almost There!",
                              style: GoogleFonts.anta(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBrown,
                                  fontSize: !isDesktop ? 17 : 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 15),
                            child: Text(
                              'Final Step to Proceed! Select at least 3 Categories you are interested in. Remember, you can change them at any time.',
                              style: GoogleFonts.philosopher(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBrown,
                                  fontSize: !isDesktop ? 11 : 14,
                                ),
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              height: !isDesktop
                                  ? size.height * 0.5
                                  : size.height * 0.6,
                              child: CategoriesButtons(
                                categories: categories,
                              ), // This widget handles the category selection
                            ),
                          ),
                          Row(
                            mainAxisAlignment: !isDesktop
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 14),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(29),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      print(args['gender']);
                                      print(args['selectedDate']);
                                      print(args['image']);
                                      print(interestedCategories);
                                      // Trigger the createProfile method on button press
                                      BlocProvider.of<AuthCubit>(context)
                                          .createProfile(
                                              gender: args['gender'],
                                              birthDate: args['selectedDate'],
                                              image: args['image'],
                                              projectName: null,
                                              interestedCategories:
                                                  interestedCategories)
                                          .then((value) =>
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  UserBottomNavbar.routeName));
                                    },
                                    child: Text(
                                      "Save and SignIn",
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            horizontal: !isDesktop ? 30 : 70,
                                            vertical: 2),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        AppColors.primary,
                                      ),
                                      overlayColor: MaterialStateProperty.all(
                                        AppColors.overlayColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (!isDesktop)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 25, bottom: 10),
                                  child: Image.asset(
                                    'assets/images/completeUserSignup.jpg',
                                    height: 150,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isDesktop)
                    ResponsiveRowColumnItem(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 25, bottom: 10),
                        child: Image.asset(
                          'assets/images/completeUserSignup.jpg',
                          height: size.height * .7,
                          width: size.width * 0.4,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
