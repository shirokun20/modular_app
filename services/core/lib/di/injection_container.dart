import 'package:core/core.dart';
import 'package:my_dependencies/dependencies.dart';

Future initDI() async {
  final storage = StorageUtil(SecureStorage());
  Get.lazyPut(() => storage, fenix: true);
  Get.put(AppService(storage));
}