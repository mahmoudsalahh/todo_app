import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salahh/modules/archived_tasks/archived.dart';
import 'package:salahh/modules/done_tasks/done_tasks.dart';
import 'package:salahh/modules/new_tasks/new_tasks.dart';
import 'package:salahh/shared/app_provider/provider.dart';
import 'package:salahh/shared/cubit/cubit.dart';
import 'package:salahh/shared/cubit/states.dart';
import 'package:salahh/shared/shared.component/component.dart';
import 'package:sqflite/sqflite.dart';


class HomeLayout extends StatefulWidget {

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {


  var scaffoldkey = GlobalKey<ScaffoldState>();

  var controllertitle = TextEditingController();

  var controllertime = TextEditingController();

  var controllerdate = TextEditingController();

  var formkey = GlobalKey<FormState>();

   Icon? floatIcon =Icon(Icons.edit);
  bool isIcon = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=> AppProvider(),
      child: Scaffold(
        key: scaffoldkey,
        body: Column(
          children: [
            context.watch<AppProvider>().tasks[context.watch<AppProvider>().currentIndex],
          ],
        )
        bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme: IconThemeData(
            color: Colors.amber[700],
          ),
          fixedColor: Colors.black,
          onTap: (index){
            context.read<AppProvider>().changeBar(index);
          },
          currentIndex: context.watch<AppProvider>().currentIndex,
          items:
            context.watch<AppProvider>().bottomNavBarItem,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber[700],
          elevation: 0.0,
          onPressed: (){
            if (isIcon){
              if(formkey.currentState!.validate()){
              context.read<AppProvider>().insertToDatabase(
                  title: controllertitle.text,
                  time: controllertime.text,
                  date: controllerdate.text
              ).then((value){
                Navigator.pop(context);
                isIcon = false;
                setState(() {
                  floatIcon =Icon(Icons.done);
                });
              });
           //   controllertitle.text='';
           //  controllertime.text='';
           // controllerdate.text='';


            }
            }
            else{
              scaffoldkey.currentState!.showBottomSheet((context) =>
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 300,
                      child: Stack(
                        children: [
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                image: DecorationImage(image:AssetImage('images/study.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      controller: controllertitle,
                                      //keyboardType: TextInputType.visiblePassword,
                                      //obscureText: true,
                                      decoration: InputDecoration(
                                        hoverColor: Colors.blueGrey,
                                        labelText: 'New Task',labelStyle: TextStyle(fontWeight: FontWeight.bold,),
                                        prefixIcon: Icon(Icons.task),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value)
                                      {
                                        if(value!.isEmpty)
                                        {
                                          return 'field is Empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height:10.0),
                                    TextFormField(
                                      controller: controllertime,
                                      //keyboardType: TextInputType.visiblePassword,
                                      //obscureText: true,
                                      onTap: (){
                                        showTimePicker(
                                          context: context,
                                          initialTime:TimeOfDay.now(),
                                        ).then((value) {
                                          controllertime.text = value!.format(context);
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Time',labelStyle: TextStyle(fontWeight: FontWeight.bold,),
                                        //prefixIcon: Icon(Icons.task),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value)
                                      {
                                        if(value!.isEmpty)
                                        {
                                          return 'field is Empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height:10.0),
                                    TextFormField(
                                      controller: controllerdate,
                                      //keyboardType: TextInputType.visiblePassword,
                                      //obscureText: true,
                                      onTap: (){
                                        showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.parse('2022-06-01')).then((value) {
                                          controllerdate.text = DateFormat.MMMMd().format(value!);
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Date',labelStyle: TextStyle(fontWeight: FontWeight.bold,),
                                        //prefixIcon: Icon(Icons.task),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value)
                                      {
                                        if(value!.isEmpty)
                                        {
                                          return 'field is Empty';
                                        }
                                        return null;
                                      },
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ));
              isIcon = true;
              setState(() {
                floatIcon = Icon(Icons.add);
              });

            }

          },
          child: floatIcon ,
        ),
      ),

    );
  }

}

