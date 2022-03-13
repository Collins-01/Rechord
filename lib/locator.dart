import 'package:get_it/get_it.dart';
import 'package:rechord/services/record_service.dart';
import 'package:rechord/services/storage_service.dart';

GetIt locator = GetIt.instance;
setUpLocator() async {
  locator.registerLazySingleton(() => RecordService());
  locator.registerLazySingleton(() => StorageService());
}

