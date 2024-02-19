import 'package:flutterpad/app/infra/models/isar_task_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource {
  static late final Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [IsarTaskModelSchema],
      directory: dir.path,
    );
  }
}
