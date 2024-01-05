import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/bloc/bloc/NoteBloc.dart';
import 'package:safebox/bloc/event/NoteEvent.dart';
import 'package:safebox/model/dao/NoteDao.dart';

import '../../bloc/state/NoteState.dart';
import 'Note.dart';

class PutNote extends StatefulWidget {
  String? id;
  PutNote({super.key, this.id});
  _PutNote createState() => _PutNote();
}


class _PutNote extends State<PutNote> {
  late NoteBloc noteBloc;
  late NoteDao model;
  ScrollController _scrollController = ScrollController();
  FocusNode noteFocusNode = FocusNode();
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    noteBloc = NoteBloc();

    if (widget.id != null)  {
      noteBloc.add(GetNoteEvent(widget.id!));
    }
    noteFocusNode.addListener(() {
      if (noteFocusNode.hasFocus) {
        // Scroll to the bottom of the screen when the note field is focused
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    noteController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Note()),
        );
        // Return false to cancel the default back button action
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('SafeBox'),
          ),
          body: BlocBuilder<NoteBloc, NoteState>(
              bloc: noteBloc,
              builder: (context, state) {
                if (state is NoteLoading) {

                } else if (state is NoteError) {
                  showSnackBar(state.errorMessage);
                } else if (state is SaveNoteLoaded) {
                  // noteBloc.add(NavToNoteEvent(context));
                } else if (state is GetNoteLoaded) {
                  model = state.note;
                  noteController.text = model.content;
                }

                return mainBody();
              }
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model = NoteDao.newRecord(content: noteController.text);
              noteBloc.add(SaveNoteEvent(model));
            },
            child: Icon(Icons.save),
          )
      )
    );



  }

  Widget mainBody() {
    double screenHeight = MediaQuery.of(context).size.height;

    double appBarHeight = AppBar().preferredSize.height;
    double topPadding = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    double adjustedHeight = screenHeight - appBarHeight - topPadding - bottomPadding;


    return Card(
      child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: adjustedHeight,
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: noteController,
                        focusNode: noteFocusNode,
                        keyboardType: TextInputType.multiline,
                        maxLines: adjustedHeight.floor(), // Allows the TextField to expand
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Type here...',
                        ),
                      ),
                    )
                  ]
              )
          )
      ),
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