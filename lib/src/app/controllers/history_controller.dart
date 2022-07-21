import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tyba_hiring_test/src/data/models/history.dart';
import 'package:tyba_hiring_test/src/data/usecases/historial_use_case.dart';

class HistoryState {
  List<History> historial;

  HistoryState({required this.historial});

  HistoryState copyWith(List<History>? newHistorial) {
    return HistoryState(historial: newHistorial ?? historial);
  }
}

class HistoryStateController extends StateNotifier<HistoryState> {
  final HistoryUseCase _historialUseCase;

  HistoryStateController(this._historialUseCase) : super(HistoryState(historial: []));

  void getCurrentHistorial() async {
    List<History>? historial = await _historialUseCase.getCurrentHistorial();
    state = state.copyWith(historial);
  }

  void saveHistory(History history) {
    _historialUseCase.saveHistory(history);
  }
}
