import 'package:flutter/material.dart';
import 'package:grad_new_project/Views/AccountCompletionPage.dart';
import 'package:grad_new_project/Views/AdminBottomBar.dart';
import 'package:grad_new_project/widgets/AdminAddNewCategoryWidget.dart';
import 'package:grad_new_project/Views/AdminHomePage.dart';
import 'package:grad_new_project/Views/ArtistItemDetailsPage.dart';
import 'package:grad_new_project/Views/ArtistOrdersPageDetails.dart';
import 'package:grad_new_project/Views/ArtistProfileFromUser.dart';
import 'package:grad_new_project/Views/CartPage.dart';
import 'package:grad_new_project/Views/CategoryItemsPage.dart';
import 'package:grad_new_project/Views/CompleteAccountInfoPage.dart';
import 'package:grad_new_project/Views/SearchPage.dart';
import 'package:grad_new_project/Views/ReportPage.dart';
import 'package:grad_new_project/Views/UserCompletionPage.dart';
import 'package:grad_new_project/Views/UserItemDetailsPage.dart';
import 'package:grad_new_project/Views/UserPaymentPage.dart';
import 'package:grad_new_project/Views/UserPersonalInfoCompletionPage.dart';
import 'package:grad_new_project/Views/WebArtistDrawar.dart';
import 'package:grad_new_project/Views/WebUserDrawar.dart';

import 'package:grad_new_project/Views/product_details_view.dart';

import 'package:grad_new_project/chat_system/screens/chat_home_screen.dart';

//import 'package:grad_new_project/Views/test.dart';
import 'package:grad_new_project/views/AccountPage.dart';
import 'package:grad_new_project/views/ArtistProfilePage.dart';
import 'package:grad_new_project/views/HomePage.dart';
import 'package:grad_new_project/views/ArtistBottomBar.dart';
import 'package:grad_new_project/views/UserBottomBar.dart';
import '../Views/ArtistPaymentInfoCompletionPage.dart';
import '../Views/ArtistSignUpPage.dart';
import '../views/SignInPage.dart';
import '../views/UserSignUpPage.dart';
import '../views/WelcomePage.dart';

Map<String, WidgetBuilder> routes() {
  return {
    WelcomePage.routeName: (context) => WelcomePage(),
    UserSignUpPage.routeName: (context) => UserSignUpPage(),
    ArtistSignUpPage.routeName: (context) => ArtistSignUpPage(),
    SignInPage.routeName: (context) => SignInPage(),
    ArtistProfilePage.routeName: (context) => ArtistProfilePage(),
    ArtistBottomBar.routeName: (context) => ArtistBottomBar(),
    AccountPage.routeName: (context) => AccountPage(),
    HomePage.routeName: (context) => HomePage(),
    UserBottomNavbar.routeName: (context) => UserBottomNavbar(),
    CompleteAccountInfoPage.routeName: (context) => CompleteAccountInfoPage(),
    AccountCompletionPage.routeName: (context) => AccountCompletionPage(),
    CategoryItemsPage.routeName: (context) => CategoryItemsPage(),
    SearchPage.routeName: (context) => SearchPage(),
    ArtistProfileFromUser.routeName: (context) => ArtistProfileFromUser(),
    UserItemDetailsPage.routeName: (context) => UserItemDetailsPage(),
    CartPage.routeName: (context) => CartPage(
          isWeb: false,
        ),
    UserCompletionPage.routeName: (context) => UserCompletionPage(),
    WebArtistDrawar.routeName: (context) => WebArtistDrawar(),
    UserPersonalInfoCompletionPage.routeName: (context) =>
        UserPersonalInfoCompletionPage(),
    ArtistPaymentInfoCompletionPage.routeName: (context) =>
        ArtistPaymentInfoCompletionPage(),
    UserPaymentPage.routeName: (context) => UserPaymentPage(),
    WebUserDrawar.routeName: (context) => WebUserDrawar(),

    ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),

    ChatHomeScreen.routeName: (context) => ChatHomeScreen(),
    AdminBottomBar.routeName: (context) => AdminBottomBar(),
    ReportPage.routeName :(context) => ReportPage(),

  };
}
