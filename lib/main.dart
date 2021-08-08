import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/shop_layout.dart';
import 'package:shop_application/modules/on_boarding/onboarding_screen.dart';
import 'package:shop_application/shared/components/constants.dart';
import 'package:shop_application/shared/cubit/themecubit_cubit.dart';
import 'package:shop_application/shared/network/local/cache_helper.dart';
import 'package:shop_application/shared/network/remote/dio_helper.dart';
import 'package:shop_application/shared/styles/themes.dart';

import 'bloc_observer.dart';
import 'layout/cubit/shop_cubit.dart';
import 'modules/login/shop_login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool onBoarding = await CacheHelper.getData(key: "onBoarding");
  token = await CacheHelper.getData(key: "token");
  print(token);
  bool isDark = CacheHelper.getData(key: 'isDark');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;

  const MyApp({Key key, this.startWidget, this.isDark}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
