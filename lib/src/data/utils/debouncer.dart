import 'dart:async';

class Debouncer {
  Timer? _timer;

  void onChanged(Function() func, int milliseconds) {
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), func);
  }
}
