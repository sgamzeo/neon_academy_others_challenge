import 'package:neon_others_challenge/models/coral_fragment.dart';

import 'package:path_provider/path_provider.dart';
import 'objectbox.g.dart'; // otomatik üretilen dosya

class ObjectBox {
  late final Store store;
  late final Box<CoralFragment> coralBox;

  ObjectBox._create(this.store) {
    coralBox = Box<CoralFragment>(store);
  }

  static Future<ObjectBox> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: "${dir.path}/objectbox");
    return ObjectBox._create(store);
  }
}
