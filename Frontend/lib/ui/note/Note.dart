import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/bloc/bloc/NoteBloc.dart';
import 'package:safebox/bloc/event/NoteEvent.dart';
import 'package:safebox/bloc/state/NoteState.dart';
import 'package:safebox/model/dao/NoteDao.dart';
import 'package:safebox/ui/menu/MainMenu.dart';

import 'PutNote.dart';

class Note extends StatefulWidget {
  const Note({super.key});
  @override
  _Note createState() => _Note();

}

class _Note extends State<Note> {

  late NoteBloc noteBloc;
  List<NoteDao> noteBoxList = [];
  @override
  void initState() {
    super.initState();
    noteBloc = NoteBloc();
    noteBloc.add(GetNotesEvent());

  }

  @override
  void dispose() {
    noteBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainMenu()),
          );
          // Return false to cancel the default back button action
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
                title: Text('Note'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // Add your onPressed code here!
                      addNoteDialog();
                    },
                  ),
                ]
            ),
            body: BlocBuilder<NoteBloc, NoteState>(
                bloc: noteBloc,
                builder: (context, state) {
                  if (state is NoteLoading) {

                  } else if (state is NoteError) {
                    showSnackBar(state.errorMessage);
                  } else if (state is GetNotesLoaded) {
                    noteBoxList = state.notes;
                  }
                  return mainBody();
                }
            )
        ),
    );
  }

  Widget mainBody() {
    return Column(
      children: [
        Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                        itemCount: noteBoxList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return noteCard(index);
                        },
                      )
                  )
                ],
              ),
            )
        )
      ],
    );
  }

  Widget noteCard(int index) {
    return
      InkWell(
        onTap: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PutNote(id: noteBoxList[index].id)),
          );
        },
        child: Card(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  child: Text("test"),
                )
              ],
            ),
          ),
        )
      );
  }


  Future addNoteDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirmation'),
          content: Text('Select options'),
          actions: [
            TextButton(
              child: Text('Note'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PutNote()),
                );
              },
            )
          ],
        )
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        )
    );
  }
}