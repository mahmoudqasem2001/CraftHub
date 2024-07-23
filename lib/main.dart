import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/chat_system/firebase_options.dart';
import 'package:grad_new_project/services/account_services.dart';
import 'package:grad_new_project/services/search_service.dart';
import 'package:grad_new_project/view_model/account_cubit/account_cubit.dart';
import 'package:grad_new_project/view_model/cart_cubit/cart_cubit.dart';
import 'package:grad_new_project/view_model/home_cubit/home_cubit.dart';
import 'package:grad_new_project/view_model/order_cubit/order_cubit.dart';
import 'package:grad_new_project/view_model/search_cubit/search_cubit.dart';
import 'package:grad_new_project/views/ArtistProfilePage.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'shared/routes.dart';
import 'core/utils/router/AppRouter.dart';
import 'view_model/auth_cubit/auth_cubit.dart';
import 'view_model/auth_cubit/auth_state.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter_notification_channel/flutter_notification_channel.dart';
//import 'package:flutter_notification_channel/notification_importance.dart';

void main() async {
  /* WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCb79IN5_J8g7DfHZq3mO4LpSYWJZXhYjw",
            authDomain: "crafthubchat.firebaseapp.com",
            projectId: "crafthubchat",
            storageBucket: "crafthubchat.appspot.com",
            messagingSenderId: "713463220223",
            appId: "1:713463220223:web:59fcb06a16ff090ebbc9ca"));
  } else {
    await Firebase.initializeApp();
  }*/

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //_initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = AuthCubit();
            cubit.getCategories();
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = CartCubit();
            return cubit;
          },
        ),
        BlocProvider(create: (context) {
          final cubit = HomeCubit();
          cubit.getHomeData();
          return cubit;
        }),
        BlocProvider(create: (context) {
          final cubit = OrderCubit();
          cubit.fetchOrders();
          return cubit;
        }),
        BlocProvider(create: (context) {
          final cubit = AccountCubit(AccountServicesImpl());
          return cubit;
        }),
        BlocProvider(create: (context) {
          final cubit = SearchCubit(
            searchService: SearchService(),
          );
          return cubit;
        }),
      ],
      child: Builder(builder: (context) {
        final cubit = BlocProvider.of<AuthCubit>(context);
        return BlocBuilder<AuthCubit, AuthState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is AuthInitial || current is AuthSuccess,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, widget) => ResponsiveWrapper.builder(
                ClampingScrollWrapper.builder(context, widget!),
                breakpoints: const [
                  ResponsiveBreakpoint.resize(350, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(600, name: TABLET),
                  ResponsiveBreakpoint.resize(800, name: DESKTOP),
                  ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
                ],
              ),
              navigatorKey: AppRouter.navigationKey,
              routes: routes(),
            );
          },
        );
      }),
    );
  }
}

/*_initializeNotification() async {
  var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');
}*/
