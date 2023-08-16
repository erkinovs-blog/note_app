import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../models/note.dart';
import '../widgets/empty_screen.dart';
import 'custom_scaffold.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.notes,
    required this.preferences,
  });

  final ValueNotifier<List<Note>> notes;
  final SharedPreferences preferences;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController textController;
  late FocusNode focusNode;
  late ValueNotifier<String> text = ValueNotifier("");
  late ValueNotifier<List<Note>> notes;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    focusNode = FocusNode();
    notes = widget.notes;
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: text,
      builder: (context, value, child) {
        return CustomScaffold(
          preferences: widget.preferences,
          notes: notes,
          sliverAppBar: SliverAppBar(
            floating: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            toolbarHeight: 100.h,
            titleSpacing: 24.w,
            backgroundColor: AppColors.scaffoldBG,
            leadingWidth: 0,
            leading: const SizedBox.shrink(),
            title: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search by the keyword...",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20.sp,
                  color: AppColors.clearButtonColor.withOpacity(0.5),
                ),
                filled: true,
                fillColor: AppColors.actionButtonBG,
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(const Radius.circular(30).r),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(const Radius.circular(30).r),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 38.w, vertical: 13.h),
                suffixIcon: GestureDetector(
                  onTap: () {
                    textController.clear();
                    text.value = "";
                  },
                  child: const Icon(
                    Icons.clear,
                    color: AppColors.clearButtonColor,
                  ),
                ),
              ),
              focusNode: focusNode,
              onTapOutside: (event) => focusNode.unfocus(),
              onChanged: (changedValue) => text.value = changedValue,
              controller: textController,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.clearButtonColor,
              ),
            ),
          ),
          emptyScreen: SliverFillRemaining(
            child: textController.text.isEmpty
                ? const SizedBox.shrink()
                : EmptyScreen(
                    image: AppImages.emptySearchBackground,
                    text: "File not found. Try searching again.",
                  ),
          ),
          text: value,
        );
      },
    );
  }
}
