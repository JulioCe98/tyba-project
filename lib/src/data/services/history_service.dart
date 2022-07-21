import 'package:shared_preferences/shared_preferences.dart';
import 'package:tyba_hiring_test/src/data/models/history.dart';

class HistoryService {
  Future<List<History>?> getCurrentHistorial() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('search_history')) {
      List<String> historiesRawData = pref.getStringList('search_history')!;
      List<History> histories = [];
      for (String item in historiesRawData) {
        histories.add(History.fromJson(item));
      }
      return histories;
    } else {
      return null;
    }
  }

  void saveHistory(History history) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('search_history')) {
      List<String> currentHistories = pref.getStringList('search_history')!;
      pref.setStringList('search_history', [history.toJson(), ...currentHistories]);
    } else {
      pref.setStringList('search_history', [history.toJson()]);
    }
  }
}
