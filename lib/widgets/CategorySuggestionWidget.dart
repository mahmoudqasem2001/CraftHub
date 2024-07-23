// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/widgets/AdminAddNewCategoryWidget.dart';

class CategorySuggestionWidget extends StatelessWidget {
  int categorySuggestionID;
  String categorySuggestionName;
  TextEditingController categoryNameController;
  CategorySuggestionWidget({
    Key? key,
    required this.categorySuggestionID,
    required this.categorySuggestionName,
    required this.categoryNameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: AppColors.lightPurple,
          leading: InkWell(
            onTap: () {},
            child: Icon(
              Icons.delete,
              color: AppColors.primary,
            ),
          ),
          title: Text(
            categorySuggestionName,
            style: GoogleFonts.philosopher(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.brown,
                    fontSize: 15)),
          ),
          trailing: InkWell(
              onTap: () {
                categoryNameController.text = categorySuggestionName;
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
                              id: categorySuggestionID,
                              name: categorySuggestionName,
                              size: size,
                            )),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.arrow_forward_ios_outlined,
                  color: AppColors.brown)),
        ),
      ),
    );
  }
}
