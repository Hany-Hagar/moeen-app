import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Isar db;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    db = await Isar.open([], directory: dir.path, maxSizeMiB: 5120);
  }
}
