import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_theme.dart';
import 'package:news_app/core/resources/routes_manager.dart';
import 'package:news_app/ui/home/screen/home_screen.dart';
import 'core/resources/my_bloc_observer.dart';

void main() {
    Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'News C20',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
          routes: {
            RoutesManager.homeRoute:(context)=>HomeScreen()
          },
          initialRoute: RoutesManager.homeRoute,
          home: child,
        );
      },
    );
  }
}

