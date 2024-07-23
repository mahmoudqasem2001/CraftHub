import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/view_model/auth_cubit/auth_cubit.dart';
import 'package:grad_new_project/view_model/auth_cubit/auth_state.dart';
import 'package:grad_new_project/views/WelcomePage.dart';

class LogoutWidget extends StatelessWidget {
  final Size size;

  const LogoutWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Log out',
              style: GoogleFonts.anta(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 8),
            child: Text(
              "Are you sure you want to Log out?",
              style: GoogleFonts.philosopher(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * .02, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
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
                padding: EdgeInsets.only(top: size.height * .02),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().signOut().then(
                            AppRouter.goTOScreenAndReplace(
                                WelcomePage.routeName),
                          );
                    },
                    child: Text(
                      "Yes",
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
