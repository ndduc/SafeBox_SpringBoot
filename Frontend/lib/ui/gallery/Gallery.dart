import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:safebox/bloc/bloc/GalleryBloc.dart';
import 'package:safebox/bloc/state/GalleryState.dart';
import 'package:photo_view/photo_view.dart';

import '../../bloc/bloc/SafeBoxBloc.dart';
import '../../bloc/state/SafeBoxState.dart';
import '../../model/dao/GalleryItemDao.dart';

class Gallery extends StatefulWidget {
  @override
  _Gallery createState() => _Gallery();
}

class _Gallery extends State<Gallery> {
  late GalleryBloc galleryBloc;
  List<GalleryItemDao> galleryItemList = [
    new GalleryItemDao(id: "1", resource: "assets/images/madoka_por.jpg"),
    new GalleryItemDao(id: "2", resource: "assets/images/madoka_por_l.jpg"),
    new GalleryItemDao(id: "3", resource: "assets/images/madoka_land.jpg"),
  ];

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
          title: Text('Gallery'),
        ),
        body: BlocBuilder<GalleryBloc, GalleryState>(
          bloc: galleryBloc,
          builder: (context, state) {
            return slideShowViewer();
          },
        )
    );
  }

  Widget fixedViewer() {
    return  PhotoView(
      imageProvider: AssetImage("assets/images/madoka_por.jpg"),
      initialScale: PhotoViewComputedScale.contained,
      heroAttributes: PhotoViewHeroAttributes(tag: "test-attr"),
      basePosition: Alignment.center,
    );
  }

  Widget slideShowViewer() {
    return Container(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: AssetImage(galleryItemList[index].resource),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes: PhotoViewHeroAttributes(tag: galleryItemList[index].id),
            );
          },
          itemCount: galleryItemList.length,
          // loadingBuilder: (context, event) => Center(
          //   child: Container(
          //     width: 20.0,
          //     height: 20.0,
          //     child: CircularProgressIndicator(
          //       value: event == null
          //           ? 0
          //           : event.cumulativeBytesLoaded / event.expectedTotalBytes,
          //     ),
          //   ),
          // ),
          // backgroundDecoration: widget.backgroundDecoration,
          // pageController: widget.pageController,
          // onPageChanged: onPageChanged,
        )
    );
  }
}