import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/bloc/bloc/SafeBoxBloc.dart';
import 'package:safebox/bloc/event/SafeBoxEvent.dart';
import 'package:safebox/bloc/state/SafeBoxState.dart';

class AddSafeBox extends StatefulWidget {
  const AddSafeBox({super.key});
  @override
  _AddSafeBox createState() => _AddSafeBox();
}

class _AddSafeBox extends State<AddSafeBox> {
  late SafeBoxBloc safeBoxBloc;

  @override
  void initState() {
    super.initState();
    safeBoxBloc = SafeBoxBloc();
    safeBoxBloc.add(GetRecordsEvent("", ""));
  }

  @override
  void dispose() {
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
          return mainBody();
        }
      )
    );
  }

  Widget mainBody() {
    return Card(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  )
              ),
            ),
            ListTile(
              title: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  )
              ),
            ),
            ListTile(
              title: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location',
                  )
              ),
            ),
            ListTile(
              title: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Url',
                  )
              ),
            ),
            ListTile(
              title: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Group',
                  )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {/* ... */},
                )
              ],
            )

          ],
        ),
      )
    );
  }
}