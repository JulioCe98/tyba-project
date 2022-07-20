import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tyba_hiring_test/src/app/controllers/places_controller.dart';
import 'package:tyba_hiring_test/src/data/models/place.dart';
import 'package:tyba_hiring_test/src/data/providers/providers.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer(builder: (context, ref, child) {
      PlacesState placesController = ref.watch(placeControllerProvider);

      return Positioned(
          bottom: placesController.loadedPlaces.isNotEmpty ? 0 : -size.height * 0.08,
          child: Container(
              width: size.width,
              height: placesController.loadedPlaces.isNotEmpty ? size.height * 0.5 : size.height * 0.3,
              padding: EdgeInsets.symmetric(vertical: size.height * 0.04, horizontal: size.width * 0.1),
              decoration: BoxDecoration(
                  color: Colors.lightGreen.shade100,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0))),
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: placesController.loadedPlaces.isNotEmpty
                      ? Column(children: [
                          Text('Places Founded', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: size.width * 0.08)),
                          SizedBox(height: size.height * 0.01),
                          Expanded(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: placesController.loadedPlaces.length,
                                itemBuilder: (context, int index) {
                                  return PlaceListTile(place: placesController.loadedPlaces[index]);
                                }),
                          )
                        ])
                      : const _PlacesListPlaceholder())));
    });
  }
}

class PlaceListTile extends StatelessWidget {
  final Place place;

  const PlaceListTile({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
        height: size.height * 0.17,
        child: Row(children: [
          Container(
              clipBehavior: Clip.antiAlias,
              width: size.width * 0.3,
              height: size.height,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: place.image.isNotEmpty
                  ? Image.network(place.image, fit: BoxFit.cover, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset('assets/imgs/plate.jpg', fit: BoxFit.cover);
                    })
                  : Image.asset('assets/imgs/plate.jpg', fit: BoxFit.cover)),
          SizedBox(width: size.width * 0.03),
          Expanded(
              child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(place.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.black, fontSize: size.width * 0.05, letterSpacing: 3, fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.01),
            Text.rich(
                TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: size.width * 0.03),
                    children: [const TextSpan(text: 'Address: ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: place.addressLine2)]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            SizedBox(height: size.height * 0.01),
            Text.rich(
                TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: size.width * 0.03),
                    children: [const TextSpan(text: 'Phone: ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: place.phoneNumber)]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            SizedBox(height: size.height * 0.01),
            Text.rich(
                TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: size.width * 0.03),
                    children: [const TextSpan(text: 'Sector: ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: place.sector)]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis)
          ]))
        ]));
  }
}

class _PlacesListPlaceholder extends StatelessWidget {
  const _PlacesListPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          clipBehavior: Clip.antiAlias,
          width: size.width * 0.3,
          height: size.height * 0.15,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Image.asset('assets/imgs/plate.jpg', fit: BoxFit.cover)),
      Expanded(
          child: Column(children: [
        Text('Find all your favorite restaurants',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: size.width * 0.05, letterSpacing: 3, fontWeight: FontWeight.bold))
      ]))
    ]);
  }
}
