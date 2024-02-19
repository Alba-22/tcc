import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutterpad/app/infra/datasources/isar/isar_datasource.dart';
import 'package:flutterpad/app/infra/datasources/local/isar_tasks_local_datasource.dart';
import 'package:flutterpad/app/infra/datasources/local/tasks_local_datasource.dart';
import 'package:flutterpad/app/infra/datasources/remote/rest_tasks_remote_datasource.dart';
import 'package:flutterpad/app/infra/datasources/remote/tasks_remote_datasource.dart';
import 'package:flutterpad/app/infra/repository/tasks_repository_impl.dart';
import 'package:flutterpad/app/infra/services/network_checker/mixed_network_checker.dart';
import 'package:flutterpad/app/infra/services/network_checker/network_checker.dart';
import 'package:flutterpad/app/presentation/repositories/tasks_repository.dart';
import 'package:flutterpad/app/presentation/stores/create_edit_store.dart';
import 'package:flutterpad/app/presentation/stores/get_tasks_store.dart';
import 'package:flutterpad/app/presentation/stores/mark_task_completion_store.dart';
import 'package:flutterpad/app/presentation/stores/synchronize_store.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:uuid/uuid.dart';

final GetIt locator = GetIt.instance;

void registerDependencies() {
  // External Packages
  locator.registerFactory(() => InternetConnectionChecker());
  locator.registerFactory(() => Connectivity());
  locator.registerFactory(() => Dio());
  locator.registerFactory(() => IsarDatasource.isar);
  locator.registerFactory(() => const Uuid());

  // Services
  locator.registerFactory<NetworkChecker>(() => MixedNetworkChecker(locator.get(), locator.get()));

  // Datasources
  locator.registerFactory<TasksRemoteDatasource>(() => RestTasksRemoteDatasource(locator.get()));
  locator.registerFactory<TasksLocalDatasource>(() => IsarTasksLocalDatasource(locator.get()));

  // Repositories
  locator.registerFactory<TasksRepository>(
    () => TasksRepositoryImpl(locator.get(), locator.get(), locator.get()),
  );

  // Stores
  locator.registerLazySingleton(() => GetTasksStore(locator.get()));
  locator.registerLazySingleton(() => MarkTaskCompletionStore(locator.get()));
  locator.registerLazySingleton(() => SynchronizeStore(locator.get()));
  locator.registerLazySingleton(() => CreateEditStore(locator.get(), locator.get()));
}
