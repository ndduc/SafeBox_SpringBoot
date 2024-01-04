import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/bloc/bloc/SafeBoxBloc.dart';
import 'package:safebox/bloc/event/SafeBoxEvent.dart';
import 'package:safebox/bloc/state/SafeBoxState.dart';
import 'package:clipboard/clipboard.dart';

import '../../model/dao/SafeBoxDao.dart';
import 'AddSafeBox.dart';
import 'EditSafeBox.dart';

List<String> searchOptionList = ['All', 'Location', 'User'];

class SafeBox extends StatefulWidget {
  const SafeBox({super.key});
  @override
  _SafeBox createState() => _SafeBox();
}

class _SafeBox extends State<SafeBox> {
  late SafeBoxBloc safeBoxBloc;
  Map<int, bool> credCartPasswordMap = {};
  String searchOptionSelectedValue = searchOptionList.first;
  List<SafeBoxDao> safeBoxList = [];

  TextEditingController searchController = TextEditingController();
  List<TextEditingController> userNameControllerList = [];
  List<TextEditingController> passWordControllerList = [];

  @override
  void initState() {
    super.initState();
    safeBoxBloc = SafeBoxBloc();
    safeBoxBloc.add(GetRecordsEvent("", ""));

  }

  @override
  void dispose() {
    safeBoxBloc.close();
    for (var controller in userNameControllerList) {
      controller.dispose();
    }

    for (var controller in passWordControllerList) {
      controller.dispose();
    }
    searchController.dispose();
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
          else if (state is SafeBoxLoaded) {
            safeBoxList = state.data.dataObject;
            credCartPasswordMap = {};
            for(var i = 0; i < safeBoxList.length; i++) {
              credCartPasswordMap[i] = true;
            }
            userNameControllerList = List.generate(safeBoxList.length, (index) => TextEditingController(text: safeBoxList[index].userName));
            passWordControllerList = List.generate(safeBoxList.length, (index) => TextEditingController(text: safeBoxList[index].password));
          }
          else if (state is SafeBoxDeleteSafeBoxRecordHiveLoaded) {
            safeBoxList.removeAt(state.deleteIndex);
          }
          else if (state is SafeBoxSearchOptionUpdateState) {
            searchOptionSelectedValue = state.selectedOption;
          }
          else if (state is SafeBoxHideUnHidePasswordState) {
            credCartPasswordMap[state.index] = state.hide;
          }
          else if (state is SaveNewSafeBoxRecordForHiveLoaded) {
          }
          else if (
              state is SaveNewSafeBoxRecordForHiveError ||
              state is SafeBoxErrorState ||
              state is SafeBoxDeleteSafeBoxRecordHiveError ||
              state is SaveNewSafeBoxRecordForHiveError) {

            String error = "";
            if (state is SaveNewSafeBoxRecordForHiveError) {
              error = state.errorMessage;
            }
            else if (state is SafeBoxErrorState) {
              error = state.errorMessage;
            }
            else if (state is SafeBoxDeleteSafeBoxRecordHiveError) {
              error = state.errorMessage;
            }
            else if (state is SaveNewSafeBoxRecordForHiveError) {
              error = state.errorMessage;
            }
            showSnackBar(error);
          }
          return mainBody();
        },
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
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            height: 50,
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Search Text',
                              ),
                            ),
                          )
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: DropdownButton<String>(
                            value: searchOptionSelectedValue,
                            items: searchOptionList
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              // Handle dropdown value change
                              safeBoxBloc.add(UpdateSearchOptionEvent(newValue!));

                            },
                            underline: SizedBox()
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.61,
                          child: ElevatedButton(
                            onPressed: () {
                              safeBoxBloc.add(GetRecordsEvent(searchController.text, searchOptionSelectedValue));

                            },
                            child: Text('Search'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.31,
                          child: ElevatedButton(
                            onPressed: () {
                              navigateToAddSafeBox();
                            },
                            child: Text('Add New'),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                        itemCount: safeBoxList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return credCart(index);
                        },
                      )
                  )
                ],
              ),
            )
        ),
      ],
    );
  }

  Widget credCart(int index) {
    return Card(
      child: Container(
          child: Column(
            children: [
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(safeBoxList[index].location),
                    Text(safeBoxList[index].website)
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.10,
                      child: ListTile(
                        title: TextField(
                          controller: userNameControllerList[index],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            FlutterClipboard.copy(userNameControllerList[index].text)
                                .then((value) => print('Value copied to clipboard'))
                                .catchError((error) => print('Failed to copy text: $error'));
                            // Perform delete action
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.10,
                      child: ListTile(
                        title: TextField(
                          obscureText: credCartPasswordMap[index]!,
                          controller: passWordControllerList[index],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.copy),
                              onPressed: () {
                                FlutterClipboard.copy(passWordControllerList[index].text)
                                    .then((value) => print('Value copied to clipboard'))
                                    .catchError((error) => print('Failed to copy text: $error'));
                                // Perform delete action
                              },
                            ),
                            IconButton(
                              icon: Icon(credCartPasswordMap[index]! ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                safeBoxBloc.add(HideUnHidePasswordEvent(index, !credCartPasswordMap[index]!));
                                // Perform delete action
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Last Update Date Time: ${safeBoxList[index].modifiedDatetime}")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('Quick Update'),
                    onPressed: () {
                      var model = safeBoxList[index];
                      model.password = passWordControllerList[index].text;
                      model.userName = userNameControllerList[index].text;
                      safeBoxBloc.add(SaveNewSafeBoxRecordForHiveEvent(data: model));
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('Edit'),
                    onPressed: () {
                      navigateToEditSafeBox(safeBoxList[index].name, safeBoxList[index].location, safeBoxList[index].id);
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      confirmDialog(index);
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              )
            ],
          )
      ),
    );
  }

  void navigateToAddSafeBox() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSafeBox()),
    );
  }

  void navigateToEditSafeBox(String name, String location, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditSafeBox(name: name, location: location, id: id)),
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

  Future confirmDialog(int index) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to delete?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              // Perform delete action
              var model = safeBoxList[index];
              // safeBoxBloc.add(DeleteRecordEvent(model));
              safeBoxBloc.add(DeleteSafeBoxRecordHiveErrorEvent(name: model.name, location: model.location, id: model.id, deletedIndex: index));
              Navigator.of(context).pop();
            },
          ),
        ],
      )
    );
  }

}