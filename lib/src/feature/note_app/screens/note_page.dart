import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/src/feature/note_app/widgets/custom_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/app_colors.dart';
import '../models/note.dart';
import '../widgets/action_button.dart';
import '../widgets/custom_text_field.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    required this.notes,
    this.editMode = true,
    this.note,
  });
  final ValueNotifier<List<Note>> notes;
  final Note? note;
  final bool editMode;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late SharedPreferences preferences;
  late ValueNotifier<bool> editMode;
  Note? note;

  late List<Widget> editModeActions = [
    ActionButton(
      icon: Icons.visibility,
      onPressed: () {
        FocusScope.of(context).unfocus();
      },
    ),
    21.horizontalSpace,
    ActionButton(
      icon: Icons.save,
      onPressed: onPressed,
    ),
    24.horizontalSpace,
  ];

  late List<Widget> viewModeActions = [
    ActionButton(
      icon: Icons.edit,
      onPressed: () => editMode.value = true,
    ),
    24.horizontalSpace,
  ];

  void falseEditMode() {
    editMode.value = false;
  }

  void saveNote(List<Note> temp) {
    widget.notes.value = temp;
    preferences.setStringList("notes", temp.map((e) => e.toJson()).toList());
    falseEditMode();
  }

  void onPressed() async {
    if (titleController.text.isEmpty && descriptionController.text.isEmpty) {
      return;
    }
    List<Note> temp = widget.notes.value.toList();
    if (note != null) {
      if (note!.title != titleController.text ||
          note!.description != descriptionController.text) {
        bool? isSaved = await CustomDialog.showCustomDialog(
          context: context,
          text: "Save changes ?",
          cancelText: "No",
          acceptText: "Yes",
        );
        int index = temp.indexOf(note!);
        if (isSaved!) {
          temp[index].title = titleController.text;
          temp[index].description = descriptionController.text;
          saveNote(temp);
        } else {
          falseEditMode();
          titleController.text = note!.title;
          descriptionController.text = note!.description;
        }
      } else {
        falseEditMode();
      }
    } else {
      note = Note(
        title: titleController.text,
        description: descriptionController.text,
      );
      temp.insert(0, note!);
      saveNote(temp);
    }
  }

  void onBackPressed() async {
    if (titleController.text != (note?.title ?? "") ||
        descriptionController.text != (note?.description ?? "")) {
      bool? isSaved = await CustomDialog.showCustomDialog(
        context: context,
        text: "Are your sure you want discard your changes ?",
        cancelText: "Discard",
        acceptText: "Keep",
      );

      if (isSaved != null && !isSaved && mounted) {
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? "");
    descriptionController =
        TextEditingController(text: widget.note?.description ?? "");
    editMode = ValueNotifier(widget.editMode);
    note = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: editMode,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBG,
          appBar: AppBar(
            toolbarHeight: 100.h,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.scaffoldBG,
            leadingWidth: 80,
            leading: Center(
              child: ActionButton(
                icon: Icons.chevron_left,
                onPressed: onBackPressed,
              ),
            ),
            actions: value ? editModeActions : viewModeActions,
          ),
          body: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                preferences = snapshot.data!;
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                  child: ListView(
                    children: [
                      CustomTextField(
                        enable: value,
                        controller: titleController,
                        labelText: "Title",
                        fontSize: 35.sp,
                        autofocus: true,
                        height: 1.4,
                      ),
                      40.verticalSpace,
                      CustomTextField(
                        enable: value,
                        controller: descriptionController,
                        labelText: "Type something...",
                        fontSize: 22.sp,
                        height: 1.2,
                        maxLines: 60,
                      ),
                      24.verticalSpace,
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
