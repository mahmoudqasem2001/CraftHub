import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/chat_system/screens/chat_home_screen.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/services/account_services.dart';
import 'package:grad_new_project/view_model/account_cubit/account_cubit.dart';
import 'package:grad_new_project/view_model/account_cubit/account_state.dart';
import 'package:grad_new_project/views/AccountPage.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          AccountCubit(AccountServicesImpl())..fetchArtistAccountInfo(),
      child: AppBar(
        shadowColor: AppColors.orange,
        surfaceTintColor: AppColors.white,
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 7, bottom: 10),
          child: Image.asset(
            'assets/images/Icon.png',
            height: 30,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  AppRouter.goTOScreen(ChatHomeScreen.routeName);
                },
                child: Icon(Icons.messenger, color: AppColors.primary),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: InkWell(
              onTap: () {
                AppRouter.goTOScreen(AccountPage.routeName);
              },
              child: BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  if (state is AccountLoaded) {
                    //print(state.account.profile.image);
                    return Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 1),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(state.account.profile.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else if (state is AccountLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 1),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
        leadingWidth: 160,
        foregroundColor: AppColors.brown,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
