import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/dropdownController.dart';
import 'package:note_app/db/noteDatabaseHelper.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/views/AddNoteScreen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DropDownController dropDownController = Get.put(DropDownController());

  Map<String, Color> color = {
    "red": Colors.red,
    "pink": Colors.pink,
    "blue": Colors.blue,
    "orange": Colors.orange,
    "black": Colors.black,
    "white": Color(0xffF8F8F8)
  };

  @override
  void initState() {
    dropDownController.getNoteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
      ),
      body: GetBuilder<DropDownController>(builder: (context) {

        return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GridView.custom(
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  QuiltedGridTile(1, 2),
                  QuiltedGridTile(3, 2),
                  QuiltedGridTile(2, 2),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: dropDownController.noteList.length,
                (context, index) {
                  return CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNoteScreen(
                                noteModel: dropDownController.noteList[index]),
                          ));
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                color[dropDownController.noteList[index].color],
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(1, 2),
                                  blurRadius: 3)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                dropDownController
                                    .noteList[index].creationDate!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black)),
                            Text(
                              dropDownController.noteList[index].title!,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                  );
                },
              ),
            ));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NoteModel n1 = NoteModel();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNoteScreen(noteModel: n1),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
