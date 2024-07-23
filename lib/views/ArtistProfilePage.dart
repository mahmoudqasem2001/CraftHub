import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/Views/ArtistItemDetailsPage.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/services/account_services.dart';
import 'package:grad_new_project/view_model/account_cubit/account_state.dart';
import 'package:grad_new_project/widgets/ProductItem.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../view_model/account_cubit/account_cubit.dart';
import '../view_model/item_cubit/item_cubit.dart';
import '../view_model/item_cubit/item_state.dart';

class ArtistProfilePage extends StatelessWidget {
  static String routeName = 'artist-profile';
  const ArtistProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Scaffold(
        body: BlocProvider(
          create: (context) =>
              AccountCubit(AccountServicesImpl())..fetchArtistAccountInfo(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 24),
            child: Column(
              children: [
                BlocBuilder<AccountCubit, AccountState>(
                  builder: (context, state) {
                    if (state is AccountLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AccountLoaded) {
                      final account = state.account;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              width:
                                  isDesktop ? size.width / 8 : size.width / 4,
                              height:
                                  isDesktop ? size.width / 8 : size.width / 4,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 5),
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(account.profile.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${account.firstName} ${account.lastName}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text('  -  '),
                                  Text(
                                    account.profile.projectName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${account.followersCount}',
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
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                account.profile.categoryName.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.grey),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (state is AccountFailure) {
                      return Center(
                        child: Text('Failed to load account'),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                Row(
                  children: [
                    Text(
                      'Uploaded Items',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.overlayColor),
                    ),
                    Spacer(),
                    SizedBox(width: 100, child: SortMenu(context)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: BlocProvider<ItemCubit>(
                    create: (context) => ItemCubit()..fetchItemsForArtist(),
                    child: BlocBuilder<ItemCubit, ItemState>(
                      builder: (context, itemState) {
                        print('--------- $itemState');
                        if (itemState is ItemLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (itemState is ItemListSuccess) {
                          return ListView.builder(
                            scrollDirection:
                                isDesktop ? Axis.horizontal : Axis.vertical,
                            itemCount: itemState.items.length,
                            itemBuilder: (context, index) {
                              final product = itemState.items[index];
                              //print(itemState.items.length);
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isDesktop ? 20 : 0),
                                child: InkWell(
                                  onTap: () {
                                    pushWithNavBar(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ArtistItemDetailsPage(
                                          itemId: product.id,
                                          index: index,
                                        ),
                                      ),
                                    ).then((value) {
                                      context
                                          .read<ItemCubit>()
                                          .fetchItemsForArtist();
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Card(
                                        child: ProductItem(
                                          productItem: product,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.favorite,
                                                color: AppColors.primary,
                                              ),
                                              Text(
                                                " Likes : ${product.countLikes}",
                                                style: TextStyle(
                                                  color: AppColors.overlayColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.shopping_bag,
                                                color: AppColors.grey,
                                              ),
                                              Text(
                                                " Ordered : ${product.countOrders}",
                                                style: TextStyle(
                                                  color: AppColors.overlayColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.comment,
                                                color: AppColors.grey,
                                              ),
                                              Text(
                                                " Comments : ${product.countComments}",
                                                style: TextStyle(
                                                  color: AppColors.overlayColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (itemState is ItemFailure) {
                          return Center(
                            child: Text(
                                'Failed to load items: ${itemState.message}'),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
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
}
