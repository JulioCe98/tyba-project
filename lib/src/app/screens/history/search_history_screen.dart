import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tyba_hiring_test/src/app/controllers/history_controller.dart';
import 'package:tyba_hiring_test/src/data/models/history.dart';
import 'package:tyba_hiring_test/src/data/providers/providers.dart';

class SearchHistoryScreen extends ConsumerStatefulWidget {
  static const routeName = "search-history";

  const SearchHistoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchHistoryScreen> createState() => _SearchHistoryScreenState();
}

class _SearchHistoryScreenState extends ConsumerState<SearchHistoryScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(historyControllerProvider.notifier).getCurrentHistorial();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.black)),
            backgroundColor: Colors.lightGreen.shade100),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/imgs/enjoy.jpg'))),
            child: SafeArea(child: Consumer(builder: (context, ref, child) {
              HistoryState historyState = ref.watch(historyControllerProvider);

              return Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: size.height * 0.05),
                  child: Column(children: [
                    Text('History of Searchs',
                        textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: size.width * 0.08)),
                    SizedBox(height: size.height * 0.02),
                    Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: historyState.historial.length,
                            itemBuilder: (context, int index) {
                              return _HistorySearchListTile(history: historyState.historial[index]);
                            }))
                  ]));
            }))));
  }
}

class _HistorySearchListTile extends StatelessWidget {
  final History history;

  const _HistorySearchListTile({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.03),
        decoration: BoxDecoration(color: Colors.lightGreen.withOpacity(0.6), borderRadius: BorderRadius.circular(10.0)),
        child: Row(children: [
          Icon(Icons.map, size: size.height * 0.05),
          SizedBox(width: size.width * 0.03),
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text.rich(
                TextSpan(style: TextStyle(color: Colors.black, fontSize: size.width * 0.03), children: [
                  const TextSpan(text: 'Address: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: history.searchCriteria)
                ]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            SizedBox(height: size.height * 0.01),
            Text.rich(
                TextSpan(style: TextStyle(color: Colors.black, fontSize: size.width * 0.03), children: [
                  const TextSpan(text: 'Datetime: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: DateTime.fromMillisecondsSinceEpoch(int.parse(history.dateTime)).toString())
                ]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis)
          ]))
        ]));
  }
}
