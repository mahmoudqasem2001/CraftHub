import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/shared/constants.dart';
import 'package:grad_new_project/widgets/ItemWidgetAtUserPage.dart';
import 'package:grad_new_project/widgets/UserAppBar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ArtistProfileFromUser extends StatefulWidget {
  static const String routeName = "user-artist-profile";

  const ArtistProfileFromUser({super.key});

  @override
  State<ArtistProfileFromUser> createState() => _ArtistProfileFromUserState();
}

class _ArtistProfileFromUserState extends State<ArtistProfileFromUser> {
  bool isFollowing = false;

  Future<void> followArtist(int profileId) async {
    final String apiUrl = '${Constants.baseUrl}follow-ups/follow/';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final Map<String, dynamic> body = {
      'profile': profileId,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer ${accessToken}', // Replace with actual token
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 201) {
        print(response.statusCode);
      } else {
        throw Exception('Failed to follow artist');
      }
    } catch (e) {
      print('Error following artist: $e');
      // Handle error state or show error message
    }
  }

  // Function to handle unfollowing an artist
  Future<void> unfollowArtist(int profileId) async {
    final String apiUrl = '${Constants.baseUrl}follow-ups/unfollow/';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final Map<String, dynamic> body = {
      'profile': profileId,
    };

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer ${accessToken}', // Replace with actual token
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 204) {
      } else {
        throw Exception('Failed to unfollow artist');
      }
    } catch (e) {
      print('Error unfollowing artist: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Scaffold(
          appBar: UserAppBar(
            withLogo: false,
            generalSearch: true,
            title: args['artist']['first_name'] +
                ' ' +
                args['artist']['last_name'],
          ),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: !isDesktop ? 24 : 100),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(left: isDesktop ? 60.0 : 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              width: !isDesktop
                                  ? size.width / 4
                                  : size.width * 0.15,
                              height: !isDesktop
                                  ? size.width / 4
                                  : size.width * 0.15,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 5),
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${Constants.host}${args['artist']['profile']['image']}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                args['artist']['first_name'] +
                                    ' ' +
                                    args['artist']['last_name'],
                                style: TextStyle(
                                    color: AppColors.darkBrown,
                                    fontSize: !isDesktop ? 16 : 24,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${args['artist']['profile']['followers_count']}',
                                    style: const TextStyle(
                                        color: AppColors.darkBrown,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Text(
                                    ' followers',
                                    style: TextStyle(
                                        color: AppColors.darkBrown,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                args['artist']['profile']['category'],
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: ElevatedButton(
                              onPressed: () {
                                if (isFollowing) {
                                  unfollowArtist(
                                      args['artist']['profile']['id']);
                                  setState(() {
                                    isFollowing = false;
                                  });
                                } else {
                                  followArtist(args['artist']['profile']['id']);
                                  setState(() {
                                    isFollowing = true;
                                  });
                                }
                              },
                              child: Text(
                                isFollowing ? "Following" : "Follow",
                                style: TextStyle(color: AppColors.white),
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                    horizontal: !isDesktop ? 45 : 60,
                                    vertical: 1.5,
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  isFollowing
                                      ? AppColors.grey
                                      : AppColors.primary,
                                ),
                                overlayColor: MaterialStateProperty.all(
                                  AppColors.overlayColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Message",
                                  style: TextStyle(color: AppColors.brown),
                                ),
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: !isDesktop ? 40 : 55,
                                        vertical: 1.5),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    AppColors.lightPurple,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.lightPurple2, // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.5,
                  child: SingleChildScrollView(
                    child: /* Column(
                    children: [ItemAtUserPageWidget(), ItemAtUserPageWidget()],
                  ),*/
                        Container(
                      height: size.height * 0.5,
                      child: GridView.builder(
                        itemCount: args['artist']['profile']['items'].length,
                        //shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: !isDesktop
                              ? 3
                              : 6, // Number of columns in the grid
                          crossAxisSpacing: 0, // Spacing between columns
                          mainAxisSpacing: 0, // Spacing between rows
                          //childAspectRatio: ,
                          mainAxisExtent: !isDesktop ? 175 : 185,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // AppRouter.goTOScreen(
                              //     UserItemDetailsPage.routeName, {"itemId": args['artist']['profile']['items'][index]});
                            },
                            child: ItemWidgetAtUserPage(
                              inArtistProfilePage: true,
                              isFavorites: false,
                              item: args['artist']['profile']['items'][index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ])));
    });
  }
}

Widget SortMenu(BuildContext context) {
  return DropdownSearch<String>(
    popupProps: PopupProps.menu(
      fit: FlexFit.loose,
      menuProps: MenuProps(
        borderRadius: BorderRadius.circular(10),
      ),
      showSelectedItems: true,
    ),
    items: const ['Newest', 'Most Popular'],
    dropdownDecoratorProps: const DropDownDecoratorProps(
      baseStyle: TextStyle(fontSize: 11),
      dropdownSearchDecoration: InputDecoration(
        labelText: "Sort By",
      ),
    ),
    onChanged: (String? newValue) {},
    selectedItem: null,
  );
}
