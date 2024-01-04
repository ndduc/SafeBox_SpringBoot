import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/bloc/bloc/NoteBloc.dart';
import 'package:safebox/bloc/state/NoteState.dart';
import 'package:safebox/model/dao/NoteDao.dart';

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

  }

  @override
  void dispose() {
    noteBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return mainBody();
        }
      )
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
    return Card(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              child: Text("test"),
            )
          ],
        ),
      ),
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

              },
            ),
            TextButton(
              child: Text('Checklist'),
              onPressed: () {

              },
            )
          ],
        )
    );
  }
}