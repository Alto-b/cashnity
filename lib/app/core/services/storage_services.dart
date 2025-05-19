// import 'package:get_storage/get_storage.dart';

// class StorageService {
//   final GetStorage _box = GetStorage();

//   void setLoginStatus(bool status) => _box.write('userLoggedInStatus', status);
//   bool isUserLoggedIn() => _box.read('userLoggedInStatus') ?? false;
// }

import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  // Login status methods
  void setLoginStatus(bool status) => _box.write('userLoggedInStatus', status);
  bool isUserLoggedIn() => _box.read('userLoggedInStatus') ?? false;

  // User ID methods
  void setLoggedInUserId(String userId) => _box.write('loggedInUserId', userId);
  String? getLoggedInUserId() => _box.read('loggedInUserId');

  // Optional: Clear all stored data on logout
  void clear() => _box.erase();
}
