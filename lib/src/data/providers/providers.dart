import 'package:riverpod/riverpod.dart';
import 'package:tyba_hiring_test/src/app/controllers/history_controller.dart';

import 'package:tyba_hiring_test/src/app/controllers/places_controller.dart';
import 'package:tyba_hiring_test/src/data/repositories/external/remote_geolocation_repository.dart';
import 'package:tyba_hiring_test/src/data/repositories/external/remote_places.repository.dart';
import 'package:tyba_hiring_test/src/data/repositories/local/local_geolocation_repository.dart';
import 'package:tyba_hiring_test/src/data/repositories/local/local_history_repository.dart';
import 'package:tyba_hiring_test/src/data/services/geolocation_service.dart';
import 'package:tyba_hiring_test/src/data/services/history_service.dart';
import 'package:tyba_hiring_test/src/data/services/places_service.dart';
import 'package:tyba_hiring_test/src/data/usecases/geolocation_use_case.dart';
import 'package:tyba_hiring_test/src/data/usecases/historial_use_case.dart';
import 'package:tyba_hiring_test/src/data/usecases/places_use_case.dart';

Provider<HistoryService> historyServiceProvider = Provider<HistoryService>((ref) => HistoryService());

Provider<LocalHistoryRepository> localHistoryRepositoryProvider = Provider<LocalHistoryRepository>((ref) {
  return LocalHistoryRepository(ref.read(historyServiceProvider));
});

Provider<HistoryUseCase> historyUseCaseProvider = Provider<HistoryUseCase>((ref) {
  return HistoryUseCase(ref.read(localHistoryRepositoryProvider));
});

StateNotifierProvider<HistoryStateController, HistoryState> historyControllerProvider =
    StateNotifierProvider<HistoryStateController, HistoryState>((ref) => HistoryStateController(ref.read(historyUseCaseProvider)));

Provider<GeolocationService> geolocationServiceProvider = Provider<GeolocationService>((ref) {
  return GeolocationService();
});

Provider<LocalGeolocationRepository> localGeolocationRepositoryProvider = Provider<LocalGeolocationRepository>((ref) {
  return LocalGeolocationRepository(ref.read(geolocationServiceProvider));
});

Provider<RemoteGeolocationRepository> remoteGeolocationRepositoryProvider = Provider<RemoteGeolocationRepository>((ref) {
  return RemoteGeolocationRepository(ref.read(geolocationServiceProvider));
});

Provider<GeolocationUseCase> geolocationUseCaseProvider = Provider<GeolocationUseCase>((ref) {
  return GeolocationUseCase(ref.read(remoteGeolocationRepositoryProvider));
});

Provider<PlacesService> placesServiceProvider = Provider<PlacesService>((ref) {
  return PlacesService();
});

Provider<RemotePlacesRepository> remotePlacesRepositoryProvider = Provider<RemotePlacesRepository>((ref) {
  return RemotePlacesRepository(ref.read(placesServiceProvider));
});

Provider<PlacesUseCase> placesUseCaseProvider = Provider<PlacesUseCase>((ref) {
  return PlacesUseCase(ref.read(remotePlacesRepositoryProvider), ref.read(localGeolocationRepositoryProvider));
});

StateNotifierProvider<PlacesController, PlacesState> placeControllerProvider =
    StateNotifierProvider<PlacesController, PlacesState>((ref) => PlacesController(ref, ref.read(placesUseCaseProvider)));
