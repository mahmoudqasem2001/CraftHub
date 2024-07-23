import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/widgets/AdminAddNewCategoryWidget.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/models/category_model.dart';
import 'package:grad_new_project/widgets/CategorySuggestionWidget.dart';

class AdminHomePage extends StatelessWidget {
  static const String routeName = "admin-home";
  AdminHomePage({super.key});
  TextEditingController categoryNameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Supported Categories',
                  style: GoogleFonts.anta(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.brown,
                          fontSize: 15)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    /*AppRouter.goTOScreen(
                      CategoryItemsPage.routeName,
                      {
                        'categoryId': categories[index].id,
                        'userCountry': 'country',
                      },
                    );*/
                    //print(categories[index].name);
                  },
                  focusColor: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          categories[index].imgUrl,
                          width: 60,
                          height: 60,
                        ),
                        Container(
                          width: 60,
                          child: Text(
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            categories[index].name,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 9,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: ElevatedButton(
                onPressed: () {
                  categoryNameController.text = " ";
                  showModalBottomSheet<void>(
                    isDismissible: false,
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 1,
                        child: Container(
                          width: size.width,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 16, right: 16),
                              child: AdminAddNewCategoryWidget(
                                categoryNameController: categoryNameController,
                                id: -1,
                                name: "",
                                size: size,
                              )),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "Add New Category",
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
            padding: const EdgeInsets.only(top: 28.0, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories Suggestions',
                  style: GoogleFonts.anta(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.brown,
                          fontSize: 15)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 12, left: 16),
            child: Text(
              "These Are Suggestions for Categories came from Artists, you have to review them and decide to accept it or just Ignore",
              style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brown,
                      fontSize: 11)),
              softWrap: true,
              //overflow: ,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            // height: 500, // Fixed height for the scrollable list
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return CategorySuggestionWidget(
                      categoryNameController: categoryNameController,
                      categorySuggestionID: index,
                      categorySuggestionName: 'Category');
                }),
          ),
        ],
      ),
    );
  }
}
