import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/bloc/bloc/SafeBoxBloc.dart';
import 'package:safebox/bloc/event/SafeBoxEvent.dart';
import 'package:safebox/bloc/state/SafeBoxState.dart';
import 'package:clipboard/clipboard.dart';

import '../../model/dao/SafeBoxDao.dart';

List<String> searchOptionList = ['Location', 'User'];

class SafeBox extends StatefulWidget {
  const SafeBox({super.key});
  @override
  _SafeBox createState() => _SafeBox();
}

class _SafeBox extends State<SafeBox> {
  late SafeBoxBloc safeBoxBloc;
  String searchOptionSelectedValue = searchOptionList.first;
  List<SafeBoxDao> safeBoxList = [];

  TextEditingController searchController = TextEditingController();
  List<TextEditingController> userNameControllerList = [];
  List<TextEditingController> passWordControllerList = [];


  @override
  void initState() {
    super.initState();
    safeBoxBloc = SafeBoxBloc();
    safeBoxBloc.add(GetRecordsEvent("test"));
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
            print("LOADING");
          }
          else if (state is SafeBoxLoaded) {
            safeBoxList = state.data.dataObject;
            userNameControllerList = List.generate(safeBoxList.length, (index) => TextEditingController(text: safeBoxList[index].userName));
            passWordControllerList = List.generate(safeBoxList.length, (index) => TextEditingController(text: safeBoxList[index].password));

            print("LOADED");
          }
          else if (state is SafeBoxErrorState) {
            print("ERROR\t\t" + state.errorMessage);
          }
          else if (state is SafeBoxSearchOptionUpdateState) {
            searchOptionSelectedValue = state.selectedOption;
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
                              switch(searchOptionSelectedValue) {
                                case "Location":
                                  safeBoxBloc.add(GetRecordsEvent(searchController.text));
                                  break;
                                case "User":
                                  break;
                                default:
                                  break;
                              }
                            },
                            child: Text('Search Credential'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.31,
                          child: ElevatedButton(
                            onPressed: () {
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
                                          SizedBox(
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context).size.width * 0.10,
                                            child: ListTile(
                                              title: TextField(
                                                obscureText: true,
                                                controller: passWordControllerList[index],
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Password',
                                                ),
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(Icons.copy),
                                                onPressed: () {
                                                  FlutterClipboard.copy(passWordControllerList[index].text)
                                                      .then((value) => print('Value copied to clipboard'))
                                                      .catchError((error) => print('Failed to copy text: $error'));
                                                  // Perform delete action
                                                },
                                              )
                                            ),
                                          ),
                                          SizedBox(
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
                                          child: const Text('Update'),
                                          onPressed: () {/* ... */},
                                        ),
                                        const SizedBox(width: 8),
                                        TextButton(
                                          child: const Text('Delete'),
                                          onPressed: () {/* ... */},
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    )
                                  ],
                                )
                            ),
                          );
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

}