import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tyba_hiring_test/src/app/widgets/lists/places_list.dart';
import 'package:tyba_hiring_test/src/app/widgets/search/search_bar.dart';
import 'package:tyba_hiring_test/src/data/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
    ref.read(placeControllerProvider.notifier).getPlacesByAddress(address, 'catering.restaurant');
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
          SearchBar(onChanged: _getPlacesByCriteria)
        ]));
  }
}
