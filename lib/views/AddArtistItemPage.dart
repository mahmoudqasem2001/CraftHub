// AddArtistItemPage.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/widgets/TextFiledWithLable.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../models/item_model.dart';
import '../view_model/item_cubit/item_cubit.dart';
import '../view_model/item_cubit/item_state.dart';

class AddArtistItemPage extends StatefulWidget {
  const AddArtistItemPage({Key? key}) : super(key: key);

  @override
  State<AddArtistItemPage> createState() => _AddArtistItemPageState();
}

class _AddArtistItemPageState extends State<AddArtistItemPage> {
  final _itemNameController = TextEditingController();
  final _itemPriceController = TextEditingController();
  final _itemDescriptionController = TextEditingController();
  final _itemPerItemController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<XFile?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;

      return BlocProvider(
        create: (context) => ItemCubit(),
        child: Scaffold(
          body: BlocListener<ItemCubit, ItemState>(
            listener: (context, state) {
              if (state is ItemCreateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item created successfully!')),
                );
              } else if (state is ItemFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: BlocBuilder<ItemCubit, ItemState>(
              builder: (context, state) {
                if (state is ItemLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SingleChildScrollView(
                  child: ResponsiveRowColumn(
                    columnPadding: isDesktop
                        ? EdgeInsets.symmetric(horizontal: size.width * 0.07)
                        : const EdgeInsets.all(0),
                    columnMainAxisAlignment: MainAxisAlignment.start,
                    columnCrossAxisAlignment: !isDesktop
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    layout: !isDesktop
                        ? ResponsiveRowColumnType.COLUMN
                        : ResponsiveRowColumnType.ROW,
                    children: [
                      ResponsiveRowColumnItem(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.07,
                              right: size.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final XFile? image = await pickImage();
                                  if (image != null) {
                                    setState(() {
                                      _imageFile = image;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 17),
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    color: AppColors.hintTextColor,
                                    radius: const Radius.circular(12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.lightPurple,
                                      ),
                                      height: !isDesktop
                                          ? size.height * 0.175
                                          : size.height * 0.22,
                                      width: !isDesktop
                                          ? size.width * .5
                                          : size.width * .17,
                                      child: _imageFile != null
                                          ? Image.file(File(_imageFile!.path))
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .add_photo_alternate_rounded,
                                                  size: !isDesktop ? 100 : 120,
                                                  color: AppColors.grey,
                                                ),
                                                Text(
                                                  "Click to upload the Item image",
                                                  style: GoogleFonts.anaheim(
                                                    textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.grey,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              TextFiledWithLabel(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Item name must not be empty";
                                  }
                                  return null;
                                },
                                Icon: null,
                                heightFactor: !isDesktop ? 0.045 : 0.05,
                                borderRadius: 15,
                                label: 'Item Name',
                                obscureText: false,
                                controller: _itemNameController,
                                widthFactor: !isDesktop ? 0.9 : 0.24,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: TextFiledWithLabel(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Item Price must not be empty";
                                        }
                                        return null;
                                      },
                                      Icon: null,
                                      heightFactor: !isDesktop ? 0.045 : 0.05,
                                      borderRadius: 15,
                                      label: 'Price per Item',
                                      obscureText: false,
                                      controller: _itemPriceController,
                                      widthFactor: !isDesktop ? 0.9 : 0.12,
                                    ),
                                  ),
                                  if (isDesktop)
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: TextFiledWithLabel(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Per Item must not be empty";
                                          }
                                          return null;
                                        },
                                        Icon: null,
                                        heightFactor: !isDesktop ? 0.045 : 0.05,
                                        borderRadius: 15,
                                        label: 'Per Item',
                                        obscureText: false,
                                        controller: _itemPerItemController,
                                        widthFactor: !isDesktop ? 0.9 : 0.12,
                                      ),
                                    ),
                                ],
                              ),
                              TextFiledWithLabel(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Description must not be empty";
                                  }
                                  return null;
                                },
                                Icon: null,
                                heightFactor: !isDesktop ? 0.215 : 0.3,
                                borderRadius: 15,
                                label: 'Description',
                                obscureText: false,
                                controller: _itemDescriptionController,
                                widthFactor: !isDesktop ? 0.9 : 0.24,
                              ),
                              if (!isDesktop)
                                TextFiledWithLabel(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Per Item must not be empty";
                                    }
                                    return null;
                                  },
                                  Icon: null,
                                  heightFactor: 0.045,
                                  borderRadius: 15,
                                  label: 'Per Item',
                                  obscureText: false,
                                  controller: _itemPerItemController,
                                  widthFactor: !isDesktop ? 0.9 : 0.24,
                                ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveRowColumnItem(
                        child: ResponsiveRowColumn(
                          columnPadding: isDesktop
                              ? EdgeInsets.symmetric(
                                  horizontal: size.width * 0.04)
                              : EdgeInsets.all(0),
                          layout: isDesktop
                              ? ResponsiveRowColumnType.COLUMN
                              : ResponsiveRowColumnType.ROW,
                          columnMainAxisAlignment: MainAxisAlignment.start,
                          columnCrossAxisAlignment: CrossAxisAlignment.start,
                          rowMainAxisAlignment: MainAxisAlignment.start,
                          rowCrossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isDesktop)
                              ResponsiveRowColumnItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 100, left: 150),
                                  child: Text(
                                    'Add a New Item',
                                    style: GoogleFonts.philosopher(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                            fontSize: 36)),
                                  ),
                                ),
                              ),
                            ResponsiveRowColumnItem(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 0,
                                  right: !isDesktop ? size.width * .25 : 0,
                                ),
                                child: Image.asset(
                                  "assets/images/AddNewItem.png",
                                  width: size.width * 0.36,
                                  height: !isDesktop
                                      ? size.height * 0.15
                                      : size.height * 0.5,
                                ),
                              ),
                            ),
                            ResponsiveRowColumnItem(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * .02,
                                    left: isDesktop ? 100 : 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(29),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_itemNameController.text.isNotEmpty &&
                                          _itemPriceController
                                              .text.isNotEmpty &&
                                          _itemDescriptionController
                                              .text.isNotEmpty &&
                                          _itemPerItemController
                                              .text.isNotEmpty &&
                                          _imageFile != null) {
                                        final item = Item.newItem(
                                          name: _itemNameController.text,
                                          price: double.parse(
                                              _itemPriceController.text),
                                          description:
                                              _itemDescriptionController.text,
                                          image: _imageFile!.path,
                                          perItem: int.parse(
                                              _itemPerItemController.text),
                                        );

                                        context
                                            .read<ItemCubit>()
                                            .createItemForArtist(item);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Please fill all fields')),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Save",
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            horizontal: !isDesktop ? 30 : 170,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
