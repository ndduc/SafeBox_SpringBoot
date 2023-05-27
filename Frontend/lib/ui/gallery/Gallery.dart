import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/SafeBoxBloc.dart';
import '../../bloc/state/SafeBoxState.dart';

class Gallery extends StatefulWidget {
  @override
  _Gallery createState() => _Gallery();
}

class _Gallery extends State<Gallery> {
  late SafeBoxBloc safeBoxBloc;

  @override
  void initState() {
    super.initState();
    safeBoxBloc = SafeBoxBloc();
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
            return SizedBox();
          },
        )
    );
  }

}