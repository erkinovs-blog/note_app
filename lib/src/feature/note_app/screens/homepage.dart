import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../models/note.dart';
import '../widgets/action_button.dart';
import '../widgets/custom_info_text.dart';
import '../widgets/empty_screen.dart';
import 'custom_scaffold.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ValueNotifier<List<Note>> notes;
  late SharedPreferences pref;

  void onSearchPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
          notes: notes,
          preferences: pref,
        ),
      ),
    );
  }

  void onInfoPressed() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: AppColors.scaffoldBG,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 38.h, horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomInfoText(text: "Designed by - Murodjon"),
                const CustomInfoText(text: "Redesigned by - Murodjon"),
                const CustomInfoText(text: "Illustrations by - Murodjon"),
                const CustomInfoText(text: "Icons - Murodjon"),
                const CustomInfoText(text: "Font - Murodjon"),
                10.verticalSpace,
                const Center(
                  child: CustomInfoText(text: "Made by Murodjon"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          pref = snapshot.data!;
          notes = ValueNotifier(
              pref.getStringList("notes")?.map(Note.fromJson).toList() ?? []);
          return CustomScaffold(
            preferences: pref,
            notes: notes,
            sliverAppBar: SliverAppBar(
              toolbarHeight: 100.h,
              elevation: 0,
              scrolledUnderElevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              floating: true,
              title: Text(
                "Notes",
                style: TextStyle(
                  fontSize: 43.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              centerTitle: false,
              backgroundColor: AppColors.scaffoldBG,
              actions: [
                ActionButton(
                  icon: Icons.search,
                  onPressed: onSearchPressed,
                ),
                21.horizontalSpace,
                ActionButton(
                  icon: Icons.info,
                  onPressed: onInfoPressed,
                ),
                24.horizontalSpace,
              ],
            ),
            emptyScreen: SliverFillRemaining(
              child: EmptyScreen(
                image: AppImages.emptyBackground,
                text: "Create your first note !",
              ),
            ),
            isHomePage: true,
          );
        } else {
          return const Scaffold(
            backgroundColor: AppColors.scaffoldBG,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
