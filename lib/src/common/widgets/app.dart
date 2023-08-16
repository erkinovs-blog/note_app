import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../feature/note_app/screens/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      useInheritedMediaQuery: false,
      builder: (context, child) {
        return MaterialApp(
          title: "Note App",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: "Nunito",
          ),
          home: child,
        );
      },
      child: const HomePage(),
    );
  }
}
