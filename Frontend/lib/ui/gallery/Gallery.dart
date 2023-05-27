import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/bloc/bloc/GalleryBloc.dart';
import 'package:safebox/bloc/state/GalleryState.dart';

import '../../bloc/bloc/SafeBoxBloc.dart';
import '../../bloc/state/SafeBoxState.dart';

class Gallery extends StatefulWidget {
  @override
  _Gallery createState() => _Gallery();
}

class _Gallery extends State<Gallery> {
  late GalleryBloc galleryBloc;

  @override
  void initState() {
    super.initState();
    galleryBloc = GalleryBloc();
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
        body: BlocBuilder<GalleryBloc, GalleryState>(
          bloc: galleryBloc,
          builder: (context, state) {
            return SizedBox();
          },
        )
    );
  }

}