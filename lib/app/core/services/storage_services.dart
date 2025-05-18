import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  void setLoginStatus(bool status) => _box.write('userLoggedInStatus', status);
  bool isUserLoggedIn() => _box.read('userLoggedInStatus') ?? false;
}
