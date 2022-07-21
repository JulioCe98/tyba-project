import 'package:tyba_hiring_test/src/data/models/history.dart';
import 'package:tyba_hiring_test/src/data/services/history_service.dart';

class LocalHistoryRepository {
  final HistoryService _historyService;

  LocalHistoryRepository(this._historyService);

  Future<List<History>?> getCurrentHistorial() {
    return _historyService.getCurrentHistorial();
  }

  void saveHistory(History history) {
    _historyService.saveHistory(history);
  }
}
