import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/app_colors.dart';
import '../models/note.dart';
import 'note_page.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
    super.key,
    required this.sliverAppBar,
    required this.emptyScreen,
    required this.notes,
    required this.preferences,
    this.isHomePage = false,
    this.text = "",
  });
  final SharedPreferences preferences;
  final SliverAppBar sliverAppBar;
  final SliverFillRemaining emptyScreen;
  final String text;
  final bool isHomePage;
  final ValueNotifier<List<Note>> notes;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  late List<Note> notesCopy;

  @override
  void initState() {
    super.initState();
  }

  void onFABTap() {
    // preferences.clear();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotePage(
          notes: widget.notes,
        ),
      ),
    );
  }

  void actionDelete(ValueNotifier<bool> deleteNotifier) {
    deleteNotifier.value = false;
  }

  void onDelete(Note note) {
    List<Note> temp = widget.notes.value;
    temp.remove(note);
    widget.notes.value = temp.toList();
    widget.preferences.setStringList(
      "notes",
      temp.map((e) => e.toJson()).toList(),
    );
  }

  void onEditTap(Note note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotePage(
          notes: widget.notes,
          note: note,
          editMode: false,
        ),
      ),
    );
  }

  void onEditLongPress(ValueNotifier<bool> deleteNotifier) {
    deleteNotifier.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBG,
      body: ValueListenableBuilder(
        valueListenable: widget.notes,
        builder: (context, value, child) {
          notesCopy = value
              .where((e) => e.title.toLowerCase().contains(
                    widget.text.toLowerCase(),
                  ))
              .toList();
          return CustomScrollView(
            slivers: [
              widget.sliverAppBar,
              notesCopy.isEmpty
                  ? widget.emptyScreen
                  : SliverList.builder(
                      itemCount: notesCopy.length,
                      itemBuilder: (context, index) {
                        Note note = notesCopy[index];
                        ValueNotifier<bool> deleteNotifier =
                            ValueNotifier(false);
                        return ValueListenableBuilder(
                          valueListenable: deleteNotifier,
                          builder: (context, isDelete, child) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25.w,
                                vertical: 8.h,
                              ),
                              child: Stack(
                                children: [
                                  ListTile(
                                    trailing: isDelete
                                        ? IconButton(
                                            onPressed: () => onDelete(note),
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          )
                                        : null,
                                    tileColor: AppColors.cardColors[index % 6],
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 25.h,
                                      horizontal: 45.w,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        const Radius.circular(10).w,
                                      ),
                                    ),
                                    title: Text(
                                      note.title.trim().isEmpty
                                          ? note.description.trim()
                                          : note.title.trim(),
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25.sp,
                                      ),
                                    ),
                                    onTap: isDelete
                                        ? () => actionDelete(deleteNotifier)
                                        : () => onEditTap(note),
                                    onLongPress: () =>
                                        onEditLongPress(deleteNotifier),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
            ],
          );
        },
      ),
      floatingActionButton: widget.isHomePage
          ? SizedBox.square(
              dimension: 70.w,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: onFABTap,
                elevation: 15,
                backgroundColor: AppColors.scaffoldBG,
                child: Icon(
                  Icons.add,
                  size: 48.r,
                  color: AppColors.white,
                ),
              ),
            )
          : null,
    );
  }
}
