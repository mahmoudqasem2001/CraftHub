import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/widgets/CategoriesButtons.dart';
import 'package:grad_new_project/widgets/CountrySelector.dart';
import 'package:grad_new_project/widgets/EditableTextFieldWithLabel.dart';

class UserInterestedInCategories extends StatefulWidget {
  UserInterestedInCategories({
    super.key,
    required this.size,
  });
  final Size size;

  @override
  State<UserInterestedInCategories> createState() =>
      _UserInterestedInCategoriesState();
}

class _UserInterestedInCategoriesState
    extends State<UserInterestedInCategories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'Change Interested In Categories',
            style: GoogleFonts.anta(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                    fontSize: 15)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "To update your interests, modify the categories by adding new ones or removing those that no longer apply.",
            style: GoogleFonts.philosopher(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.brown,
                    fontSize: 11)),
          ),
        ),
        Container(
          height: widget.size.height * 0.4,
          child: CategoriesButtons(
            categories: {},
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: widget.size.height * .02),
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
                      Color.fromARGB(255, 217, 119, 44),
                    ),
                    overlayColor: MaterialStateProperty.all(
                      AppColors.orange,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: widget.size.height * .02, left: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                      Color.fromARGB(255, 217, 119, 44),
                    ),
                    overlayColor: MaterialStateProperty.all(
                      AppColors.orange2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
