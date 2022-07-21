import 'package:tyba_hiring_test/src/data/models/history.dart';
import 'package:tyba_hiring_test/src/data/repositories/local/local_history_repository.dart';

class HistoryUseCase {
  final LocalHistoryRepository _historylLocalRepo;

  HistoryUseCase(this._historylLocalRepo);

  Future<List<History>?> getCurrentHistorial() {
    return _historylLocalRepo.getCurrentHistorial();
  }

  void saveHistory(History history) {
    _historylLocalRepo.saveHistory(history);
  }
}
