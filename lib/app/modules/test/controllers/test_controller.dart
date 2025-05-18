import 'package:get/get.dart';

class TestController extends GetxController {
  var isSticky = false.obs; // Observable to track if it's sticky
  var isVisible = true.obs; // Observable to track if the card is visible
}
