import 'package:flutter/material.dart';
import 'package:salahh/modules/archived_tasks/archived.dart';
import 'package:salahh/modules/done_tasks/done_tasks.dart';
import 'package:salahh/modules/new_tasks/new_tasks.dart';
import 'package:sqflite/sqflite.dart';

class AppProvider extends ChangeNotifier {
  int currentIndex = 0;
  List tasks = [NewTasks(), DoneTasks(), ArchivedTasks()];
  List titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  List<BottomNavigationBarItem> bottomNavBarItem = [
    BottomNavigationBarItem(label: 'New Tasks', icon: Icon(Icons.task)),
    BottomNavigationBarItem(
        label: 'Done Tasks', icon: Icon(Icons.done_all_rounded)),
    BottomNavigationBarItem(
        label: 'Archived', icon: Icon(Icons.archive_outlined)),
  ];
  void changeBar(index) {
    currentIndex = index;
    notifyListeners();
  }

  Database? database;

  void createDatabae() async {
    database =
        await openDatabase('todo', version: 1, onCreate: (database, version) {
      print(' database Created');
      database
          .execute(
              'CREATE TABLE tasks (id INTGER PRIMARY KEY , title TEXT , time TEXT,date TEXT)')
          .then((value) {
        print('table created ');
      });
    }, onOpen: (database) {
          getFromDatabase(database).then((value){
            gettask = value;
          });
      print('database open');
    });
    notifyListeners();
  }

  Future insertToDatabase({
   required String title,
    required String time,
    required String date,
  }) async {
    return await database!.transaction((txn)async  {
      await txn.rawInsert(
              'INSERT INTO tasks(title , time ,date ) VALUES ("$title ","$time" , "$date") ')
          .then((value) {
        print('$value table inserted ');
      }).catchError((error){});
      return null;
    });
    notifyListeners();
  }
List<Map>? gettask = [];
  Future<List<Map>> getFromDatabase(database) async {
    notifyListeners();
   return await database!.rawQuery('SELECT * FROM Tasks');

  }
}
