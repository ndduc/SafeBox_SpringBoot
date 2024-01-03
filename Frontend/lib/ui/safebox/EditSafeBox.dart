import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/bloc/bloc/SafeBoxBloc.dart';
import 'package:safebox/bloc/event/SafeBoxEvent.dart';
import 'package:safebox/bloc/state/SafeBoxState.dart';
import 'package:safebox/model/dao/SafeBoxDao.dart';
import 'package:safebox/ui/safebox/SafeBox.dart';

class EditSafeBox extends StatefulWidget {
  final String name;
  final String location;
  final String id;
  const EditSafeBox({super.key, required this.name, required this.location, required this.id});
  @override
  _EditSafeBox createState() => _EditSafeBox();
}

class _EditSafeBox extends State<EditSafeBox> {
  late SafeBoxBloc safeBoxBloc;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  ScrollController _scrollController = ScrollController();
  FocusNode noteFocusNode = FocusNode();

  bool _isTextHiddenPassword = true;

  late SafeBoxDao safeBoxDao;

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

    safeBoxBloc = SafeBoxBloc();
    safeBoxBloc.add(GetSpecificSafeBoxRecordHiveByIdEvent(name: widget.name, location: widget.location, id: widget.id));
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    locationController.dispose();
    urlController.dispose();
    groupNameController.dispose();
    noteController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SafeBox'),
        ),
        body: BlocBuilder<SafeBoxBloc, SafeBoxState>(
            bloc: safeBoxBloc,
            builder: (context, state) {
              if (state is SafeBoxLoading) {

              }
              else if (state is SafeBoxGetSpecificSafeBoxRecordHiveByIdLoaded) {
                print("LOADED");
                safeBoxDao = state.safebox;
                print(safeBoxDao.id);

                loadData();
              }
              else if (state is SafeBoxGetSpecificSafeBoxRecordHiveByIdError) {
              }
              else if (state is SafeBoxHideUnHidePasswordStateSingleField) {
                _isTextHiddenPassword = state.hide;
              }
              return mainBody();
            }
        )
    );
  }

  void loadData() {
    userNameController.text = safeBoxDao.name;
    passwordController.text = safeBoxDao.password;
    locationController.text = safeBoxDao.location;
    urlController.text = safeBoxDao.website;
    groupNameController.text = safeBoxDao.name;
    noteController.text = safeBoxDao.note;
  }


  Widget mainBody() {
    return Card(
      child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: TextField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        )
                    )
                ),
                ListTile(
                  title: TextField(
                      controller: passwordController,
                      obscureText: _isTextHiddenPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      )
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(_isTextHiddenPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          safeBoxBloc.add(HideUnHidePasswordEventSingleField(!_isTextHiddenPassword));
                          // Perform delete action
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Location',
                      )
                  ),
                ),
                ListTile(
                  title: TextField(
                      controller: urlController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Url',
                      )
                  ),
                ),
                ListTile(
                  title: TextField(
                      controller: groupNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Group (Name)',
                      )
                  ),
                ),
                ListTile(
                  title: TextField(
                      controller: noteController,
                      focusNode: noteFocusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Note',
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 5, // Allows the field to expand dynamically
                    ),

                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text('Save'),
                      onPressed: () {
                        SafeBoxDao model = SafeBoxDao.newRecord(
                            location: locationController.text,
                            name: groupNameController.text,
                            password: passwordController.text,
                            userName: userNameController.text,
                            website: urlController.text,
                            note: noteController.text);
                        safeBoxBloc.add(SaveRecordEvent(model));

                      },
                    )
                  ],
                )

              ],
            ),
          )
      ),

    );
  }
}