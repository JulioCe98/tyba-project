import 'package:flutter/material.dart';

import 'package:tyba_hiring_test/src/data/utils/debouncer.dart';

class SearchBar extends StatefulWidget {
  final Function(String)? onChanged;

  const SearchBar({Key? key, this.onChanged}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.lightGreen.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            hintText: 'Restaurants',
            suffixIcon: const Icon(Icons.search, color: Colors.black)),
        onChanged: onChanged);
  }

  void onChanged(String value) {
    _debouncer.onChanged(
        () => {
              if (widget.onChanged != null) {widget.onChanged!(value)}
            },
        500);
  }
}
