import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/bloc/bloc/SafeBoxBloc.dart';
import 'package:safebox/ui/safebox/SafeBox.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  _MainMenu createState() => _MainMenu();

}

class _MainMenu extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 1,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 5.0,
              children: List.generate(3, (index) {
                return GestureDetector(
                  onTap: () {
                    navigateToSafeBox();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.grey,
                    child: Center(
                      child: ListTile(
                        leading: Icon(Icons.security),
                        title: Text(
                          'Safe Box',
                          style: TextStyle(fontSize: 25),
                        ),
                        subtitle: Text(
                          'Credential Manager',
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                      ,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      )
    );
  }


  void navigateToSafeBox() {
    print("TEST");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SafeBox()),
    );
  }
}