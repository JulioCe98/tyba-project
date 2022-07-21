import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tyba_hiring_test/src/app/screens/history/search_history.dart';

import 'package:tyba_hiring_test/src/app/widgets/lists/places_list.dart';
import 'package:tyba_hiring_test/src/app/widgets/search/search_bar.dart';
import 'package:tyba_hiring_test/src/data/models/history.dart';
import 'package:tyba_hiring_test/src/data/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Container(
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(100.0)),
            child: IconButton(
                onPressed: () => Navigator.of(context).pushNamed(SearchHistoryScreen.routeName),
                icon: const Icon(Icons.history, color: Colors.black))),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/imgs/enjoy.jpg'))),
            child: SafeArea(
                child:
                    Padding(padding: EdgeInsets.only(top: size.height * 0.05), child: Stack(children: const [_HomeScreenTitle(), PlacesList()])))));
  }
}

class _HomeScreenTitle extends ConsumerStatefulWidget {
  const _HomeScreenTitle({Key? key}) : super(key: key);

  @override
  ConsumerState<_HomeScreenTitle> createState() => _HomeScreenTitleState();
}

class _HomeScreenTitleState extends ConsumerState<_HomeScreenTitle> {
  void _getPlacesByCriteria(String address) {
    ref
        .read(historyControllerProvider.notifier)
        .saveHistory(History(searchCriteria: address, dateTime: DateTime.now().millisecondsSinceEpoch.toString()));

    ref.read(placeControllerProvider.notifier).getPlacesByAddress(address, 'catering');
  }

  void _getPlacesNearByUser() async {
    Position? userLocation = await ref.read(geolocationServiceProvider).getPosition();

    if (userLocation != null) {
      ref.read(historyControllerProvider.notifier).saveHistory(History(
          searchCriteria: "Nearby : LAT => ${userLocation.latitude}, LONG => ${userLocation.longitude}",
          dateTime: DateTime.now().millisecondsSinceEpoch.toString()));
    }

    ref.read(placeControllerProvider.notifier).getPlacesNearByUser('catering');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        child: Column(children: [
          Column(children: [
            Text('Need a restaurant?', style: TextStyle(color: Colors.grey.shade500, fontSize: size.width * 0.05)),
            SizedBox(height: size.height * 0.01),
            Text('Welcome Back', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: size.width * 0.08))
          ]),
          SizedBox(height: size.height * 0.01),
          SearchBar(onChanged: _getPlacesByCriteria),
          SizedBox(height: size.height * 0.01),
          GestureDetector(
              onTap: _getPlacesNearByUser,
              child:
                  Row(children: const [Icon(Icons.near_me), Text('Search places near me', style: TextStyle(decoration: TextDecoration.underline))]))
        ]));
  }
}
