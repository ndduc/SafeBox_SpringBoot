import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/bloc/bloc/NoteBloc.dart';

import '../../bloc/state/NoteState.dart';

class PutNote extends StatefulWidget {
  const PutNote({super.key});
  _PutNote createState() => _PutNote();
}


class _PutNote extends State<PutNote> {
  late NoteBloc noteBloc;
  ScrollController _scrollController = ScrollController();
  FocusNode noteFocusNode = FocusNode();
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    noteBloc = NoteBloc();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    noteController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SafeBox'),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        bloc: noteBloc,
        builder: (context, state) {
          return mainBody();
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle FAB press
        },
        child: Icon(Icons.save),
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

}