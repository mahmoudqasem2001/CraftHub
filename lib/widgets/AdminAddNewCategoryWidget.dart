// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/widgets/TextFiledWithLable.dart';

class AdminAddNewCategoryWidget extends StatefulWidget {
  String name;
  int id;
  Size size;
  TextEditingController categoryNameController;
  AdminAddNewCategoryWidget({
    Key? key,
    required this.name,
    required this.id,
    required this.size,
    required this.categoryNameController,
  }) : super(key: key);

  @override
  State<AdminAddNewCategoryWidget> createState() =>
      _AdminAddNewCategoryWidgetState();
}

class _AdminAddNewCategoryWidgetState extends State<AdminAddNewCategoryWidget> {
  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;

  Future<XFile?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Column(
        children: [
          Text(
            'Add New Category',
            style: GoogleFonts.anta(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                    fontSize: isDesktop ? 11 : 22)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 8),
            child: InkWell(
              onTap: () async {
                final XFile? image = await pickImage();
                if (image != null) {
                  setState(() {
                    _imageFile = image;
                  });
                }
              },
              child: DottedBorder(
                borderType: BorderType.Circle,
                color: AppColors.hintTextColor,
                radius: Radius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.all(Radius.circular(1000)),
                    color: AppColors.lightPurple,
                  ),
                  height: widget.size.height * 0.175,
                  width: widget.size.width * .5,
                  child: _imageFile != null
                      ? Image.file(File(_imageFile!.path))
                      : Icon(
                          Icons.category_outlined,
                          size: 85,
                          color: AppColors.grey,
                        ),
                ),
              ),
            ),
          ),
          Text(
            'Select Category Image',
            style: GoogleFonts.anta(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                    fontSize: 11)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFiledWithLabel(
              controller: widget.categoryNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Name must not be empty";
                }
                return null;
              },
              heightFactor: 0.045,
              widthFactor: 0.8,
              borderRadius: 15,
              label: 'Category Name',
              obscureText: false,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isDesktop) AppRouter.goBackTOScreen();
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
                padding: EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isDesktop) AppRouter.goBackTOScreen();
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
