import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:note_app/db/noteDatabaseHelper.dart';
import 'package:note_app/models/note_model.dart';

class DropDownController extends GetxController {

  RxList<NoteModel> noteList = RxList<NoteModel>();

  RxString color = "white".obs;
  RxInt index = 0.obs;

  void getNoteList() async {
    NoteDatabaseHelper notedb = NoteDatabaseHelper();
    noteList.value = await notedb.getNoteData();
    update();
  }

  void insertNote(NoteModel noteModel) async {
    NoteDatabaseHelper notedb = NoteDatabaseHelper();
    await notedb.insertData(noteModel);
    noteList.value = await notedb.getNoteData();
    update();
  }

  void updateNote(NoteModel noteModel) async {
    NoteDatabaseHelper notedb = NoteDatabaseHelper();
    await notedb.updateData(noteModel);
    noteList.value = await notedb.getNoteData();
    update();
  }

  void changeindex(int val) {
    index = val.obs;
    update();
  }

  void changeColor(String color) {
    this.color = color.obs;
    update();
  }
}
