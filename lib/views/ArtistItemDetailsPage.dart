import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/AccountPage.dart';
import 'package:grad_new_project/Views/ReportPage.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/shared/constants.dart';
import 'package:grad_new_project/widgets/EditableTextWiedget.dart';
import 'package:image_picker/image_picker.dart';

import '../view_model/item_cubit/item_cubit.dart';
import '../view_model/item_cubit/item_state.dart';

class ArtistItemDetailsPage extends StatefulWidget {
  final int itemId;
  final int index;

  const ArtistItemDetailsPage({
    Key? key,
    required this.itemId,
    required this.index,
  }) : super(key: key);

  static String routeName = 'artist-item-details';

  @override
  State<ArtistItemDetailsPage> createState() => _ArtistItemDetailsPageState();
}

class _ArtistItemDetailsPageState extends State<ArtistItemDetailsPage> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  XFile? _imageFile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemCubit()..fetchItemDetails(widget.itemId),
      child: Scaffold(
        body: BlocBuilder<ItemCubit, ItemState>(
          builder: (context, state) {
            if (state is ItemLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ItemDetailsSuccess) {
              var item = state.item;
              var size = MediaQuery.of(context).size;

              return Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: _imageFile != null
                                ? Image.file(
                                    File(
                                      _imageFile!.path,
                                    ),
                                    width: size.width * .9,
                                    height: size.height * 0.4,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    width: size.width * .9,
                                    height: size.height * 0.4,
                                    imageUrl: item.image,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              icon: const Icon(
                                Icons.mode_edit_outline_rounded,
                                color: AppColors.hintTextColor,
                              ),
                              onPressed: () async {
                                final ImagePicker _picker = ImagePicker();
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                ;
                                if (image != null) {
                                  setState(() {
                                    _imageFile = image;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      EditableTextWiedget(
                        textController: _itemNameController,
                        initialText: item.name,
                        fontSize: 25,
                        textFieldHieght: 30,
                      ),
                      EditableTextWiedget(
                        textController: _itemPriceController,
                        initialText: item.price.toString(),
                        fontSize: 20,
                        textFieldHieght: 45,
                      ),
                      EditableTextWiedget(
                        textController: _itemDescriptionController,
                        initialText: item.description,
                        fontSize: 12,
                        textFieldHieght: 70,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * .02,
                          bottom: size.height * .005,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(29),
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<ItemCubit>().deleteItemForArtist(
                                      widget.itemId, widget.index);
                                  Navigator.of(context).pop(true);
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 35, vertical: 2),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    AppColors.primary,
                                  ),
                                  overlayColor: MaterialStateProperty.all(
                                    AppColors.overlayColor,
                                  ),
                                ),
                                child: const Text(
                                  "Delete Item",
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(29),
                              child: ElevatedButton(
                                onPressed: () {
                                  Map<String, dynamic> data = {
                                    'name': _itemNameController.text,
                                    'price': double.tryParse(
                                            _itemPriceController.text) ??
                                        item.price,
                                    'description':
                                        _itemDescriptionController.text,
                                  };
                                  if (_imageFile != null) {
                                    data['image'] = _imageFile!.path;
                                  }

                                  context
                                      .read<ItemCubit>()
                                      .updateItemForArtist(item.id, data);
                                  // Implement save changes functionality
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 35, vertical: 2),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    AppColors.primary,
                                  ),
                                  overlayColor: MaterialStateProperty.all(
                                    AppColors.overlayColor,
                                  ),
                                ),
                                child: const Text(
                                  "Save Changes",
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: ExpansionTile(
                          leading: Container(
                            width: size.width * .3,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: AppColors.primary,
                                ),
                                Text(
                                  item.countLikes.toString(),
                                  style: GoogleFonts.anta(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.overlayColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.comment,
                                  color: AppColors.hintTextColor,
                                ),
                                Text(
                                  item.countComments.toString(),
                                  style: GoogleFonts.anta(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.overlayColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Container(),
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: List<Widget>.generate(
                                  state.comments.length,
                                  (int index) => CommentWidget(
                                    comment: state.comments[index],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ItemFailure) {
              return Center(
                child: Text('Failed to load item details: ${state.message}'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final Map<String, dynamic> comment;

  const CommentWidget({
    required this.comment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: InkWell(
            onTap: () {
              AppRouter.goTOScreen(AccountPage.routeName);
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 1),
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(comment['user']['image']
                          .toString()
                          .contains(Constants.host)
                      ? comment['user']['image']
                      : '${Constants.host}${comment['user']['image']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: size.width * 0.76,
          // height: size.height * 0.1,
          padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
          margin: const EdgeInsets.only(left: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.lightPurple),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${comment['user']['first_name']} ${comment['user']['last_name']}',
                    style: GoogleFonts.anta(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.overlayColor,
                            fontSize: 14)),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        AppRouter.goTOScreen(ReportPage.routeName);
                      },
                      icon: Icon(
                        Icons.report_gmailerrorred_rounded,
                        size: 20,
                        color: AppColors.grey,
                      ))
                ],
              ),
              Text(
                comment['comment'],
                style: GoogleFonts.palanquin(
                    textStyle: TextStyle(
                        //fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                        fontSize: 14)),
              )
            ],
          ),
        )
      ],
    );
  }
}
