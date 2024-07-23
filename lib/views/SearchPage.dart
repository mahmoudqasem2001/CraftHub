// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/ArtistProfileFromUser.dart';
import 'package:grad_new_project/Views/product_details_view.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/view_model/home_cubit/home_cubit.dart';
import 'package:grad_new_project/view_model/search_cubit/search_cubit.dart';
import 'package:grad_new_project/view_model/search_cubit/search_state.dart';
import 'package:grad_new_project/widgets/ArtistCardWidget.dart';
import 'package:grad_new_project/widgets/GeneralSearchOptionsWidget.dart';
import 'package:grad_new_project/widgets/ItemWidgetAtUserPage.dart';
import 'package:grad_new_project/widgets/TextFiledContainer.dart';

class SearchPage extends StatefulWidget {
  static const routeName = 'general-search';
  // bool generalSearch;
  const SearchPage({
    super.key,
    //required this.generalSearch,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool readOnly = !(GeneralSearchOptionsWidget.artistsSelected ||
      GeneralSearchOptionsWidget.itemsSelected ||
      GeneralSearchOptionsWidget.projectsSelected);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> generalSearch =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final HomeCubit homeCubit = context.read<HomeCubit>();
    final SearchCubit searchCubit = context.read<SearchCubit>();

    var size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;

      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: /*UserAppBar(
            withLogo: false,
            title: "Search",
          ),*/
            AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.brown,
            ),
            onPressed: () {
              AppRouter.goBackTOScreen();
            },
          ),
          title: Text(
            "Search",
            style: GoogleFonts.philosopher(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.brown,
                    fontSize: 19)),
          ),
        ),
        body: Column(
          children: [
            TextFiledContainer(
              widthFactor: 0.95,
              heightFactor: 0.05,
              borderRadius: 15,
              child: TextFormField(
                onTap: () {
                  setState(() {
                    readOnly = !(GeneralSearchOptionsWidget.artistsSelected ||
                        GeneralSearchOptionsWidget.itemsSelected ||
                        GeneralSearchOptionsWidget.projectsSelected);
                  });
                },
                readOnly: !generalSearch['is_general'] ? false : readOnly,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      color: Color.fromARGB(201, 111, 53, 165),
                      fontWeight: FontWeight.bold),
                ),
                obscureText: false,
                controller: _searchController,
                validator: (value) {
                  setState(() {
                    //_errorText = widget.validator!(value);
                  });
                  return null;
                },
                onFieldSubmitted: (value) {
                  String type = GeneralSearchOptionsWidget.artistsSelected
                      ? 'artist'
                      : GeneralSearchOptionsWidget.projectsSelected
                          ? 'project'
                          : 'item';
                  searchCubit.search(
                    generalSearch['is_general'],
                    type,
                    value,
                    generalSearch['is_general']
                        ? 0
                        : generalSearch['searchData']['category_id'],
                  );
                },
                decoration: const InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(111, 53, 165, 0.341),
                    fontSize: 14.1,
                  ),
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
            generalSearch['is_general']
                ? const GeneralSearchOptionsWidget()
                : const SizedBox(
                    height: 1,
                    width: 1,
                  ),
            //this column must disappears once the results of searching starts to appearsS
            BlocConsumer<SearchCubit, SearchState>(
              bloc: searchCubit,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is! SearchLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // this widget: ArtistSearchResultWidget() should displayed to show the Artist Result
                      //  ArtistSearchResultWidget(),
                      SizedBox(
                        height:
                            !isDesktop ? size.height * 0.1 : size.height * 0.05,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/Search.jpg",
                          height: !isDesktop
                              ? size.height * 0.37
                              : size.height * 0.6,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.75,
                        child: Text(
                          generalSearch['is_general']
                              ? "Search for Artists or Items, Select what you are looking for first."
                              : "Searching for Items in this Category",
                          style: GoogleFonts.anta(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(201, 111, 53, 165),
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  );
                } else {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: state.result.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: !isDesktop ? 2 : 6,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) {
                        return !generalSearch['is_general'] ||
                                GeneralSearchOptionsWidget.itemsSelected
                            ? InkWell(
                                onTap: () {
                                  state.result[index]['fun'] =
                                      homeCubit.addItemFavorite;
                                  state.result[index]['bloc_state'] = null;

                                  AppRouter.goTOScreen(
                                      ProductDetailsScreen.routeName,
                                      state.result[index]);
                                },
                                child: ItemWidgetAtUserPage(
                                  inArtistProfilePage: false,
                                  isFavorites: state.result[index]
                                      ['is_favorite'],
                                  item: state.result[index],
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  AppRouter.goTOScreen(
                                    ArtistProfileFromUser.routeName,
                                    {
                                      'artist': state.result[index],
                                    },
                                  );
                                },
                                child: ArtistCardWidget(
                                  artist: state.result[index],
                                ),
                              );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
