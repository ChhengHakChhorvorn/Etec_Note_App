import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/dropdownController.dart';
import 'package:note_app/models/category_model.dart';
import 'package:note_app/models/note_model.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key, required this.noteModel});

  NoteModel noteModel;

  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtBody = TextEditingController();

  List<String> categoryList = ["Personal", "Home", "Reminder"];
  List<String> colorList = ["red", "pink", "blue", "orange", "black", "white"];
  Map<String, Color> color = {
    "red": Colors.red,
    "pink": Colors.pink,
    "blue": Colors.blue,
    "orange": Colors.orange,
    "black": Colors.black,
    "white": Color(0xffF8F8F8)
  };

  DropDownController dropDownController = Get.put(DropDownController());

  @override
  Widget build(BuildContext context) {
    if (noteModel.id != null) {
      txtTitle.text = noteModel.title!;
      txtBody.text = noteModel.body!;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff8981D8),
        actions: noteModel.id != null
            ? [
                TextButton(
                    onPressed: () {
                      dropDownController.updateNote(NoteModel(
                          id: noteModel.id,
                          title: txtTitle.text,
                          body: txtBody.text,
                          category:
                              categoryList[dropDownController.index.value],
                          creationDate: DateTime.now().toString(),
                          color: dropDownController.color.string));
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Color(0xffF8F8F8)),
                    ))
              ]
            : [
                TextButton(
                    onPressed: () {
                      dropDownController.insertNote(NoteModel(
                          title: txtTitle.text,
                          body: txtBody.text,
                          category:
                              categoryList[dropDownController.index.value],
                          creationDate: DateTime.now().toString(),
                          color: dropDownController.color.string));

                      Navigator.pop(context);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Color(0xffF8F8F8)),
                    ))
              ],
        title: Text('Add Note'),
      ),
      body: GetBuilder<DropDownController>(builder: (context) {
        return Container(
          color: color[noteModel.color],

          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(children: [
              SizedBox(
                height: 15,
              ),
              Container(
                height: 80,
                child: TextField(
                  controller: txtTitle,
                  minLines: 1,
                  maxLines: 10,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: "Title"),
                ),
              ),
              Container(
                height: 300,
                child: TextField(
                  controller: txtBody,
                  minLines: 15,
                  maxLines: 50,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: "Write a note..."),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Category: '),
                  GetBuilder<DropDownController>(builder: (context) {
                    int val = dropDownController.index.abs();
                    return Container(
                        width: 100,
                        height: 50,
                        child: DropdownButton(
                            value: categoryList[val],
                            items: categoryList.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (value) {
                              switch (value) {
                                case "Personal":
                                  {
                                    dropDownController.changeindex(0);
                                  }
                                  break;
                                case "Home":
                                  {
                                    dropDownController.changeindex(1);
                                  }
                                  break;
                                case "Reminder":
                                  {
                                    dropDownController.changeindex(2);
                                  }
                                  break;
                              }
                            }));
                  }),
                ],
              ),
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colorList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final models = colorList[index];
                    return MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        dropDownController.changeColor(colorList[index]);
                        noteModel.color = dropDownController.color.string;
                      },
                      color: color[colorList[index]],
                      shape: CircleBorder(),
                      child: noteModel.color == colorList[index]
                          ? Icon(Icons.check)
                          : null,
                    );
                  },
                ),
              )
            ]),
          ),
        );
      }),
    );
  }
}
