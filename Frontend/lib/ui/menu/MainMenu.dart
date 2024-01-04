import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/bloc/bloc/SafeBoxBloc.dart';
import 'package:safebox/ui/gallery/Gallery.dart';
import 'package:safebox/ui/note/Note.dart';
import 'package:safebox/ui/safebox/SafeBox.dart';

import 'model/MainMenuUIModel.dart';

String safeBoxKey = "SAFE-BOX";
String galleryKey = "GALLERY";
String noteKey = "NOTE";
class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  _MainMenu createState() => _MainMenu();

}

class _MainMenu extends State<MainMenu> {
  List<MainMenuUIModel> uiMenuList = [
    MainMenuUIModel(mainTitle: "Safe Box", subTitle: "Manage Credential", key: safeBoxKey, icon: const Icon(Icons.security)),
    MainMenuUIModel(mainTitle: "Note", subTitle: "Quick Note", key: noteKey, icon: const Icon(Icons.note)),
    MainMenuUIModel(mainTitle: "Gallery", subTitle: "Photo Viewer", key: galleryKey, icon: const Icon(Icons.photo))
  ];

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
              children: List.generate(uiMenuList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    navigateToSafeBox(uiMenuList[index].key);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.grey,
                    child: Center(
                      child: ListTile(
                        leading: uiMenuList[index].icon,
                        title: Text(
                          uiMenuList[index].mainTitle,
                          style: TextStyle(fontSize: 25),
                        ),
                        subtitle: Text(
                          uiMenuList[index].subTitle,
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


  void navigateToSafeBox(String key) {
    if (key == safeBoxKey) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SafeBox()),
      );
    }
    else if (key == galleryKey) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Gallery()),
      );
    }
    else if (key == noteKey) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Note()),
      );
    }

  }
}