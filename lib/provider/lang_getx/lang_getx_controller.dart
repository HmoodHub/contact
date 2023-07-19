import 'package:contacts/provider/lang_getx/shaerd_pref/shaerd_pref_controller.dart';
import 'package:get/get.dart';

class LangGetxController extends GetxController{
  static LangGetxController get to => Get.find<LangGetxController>();
  RxString language= 'en'.obs;
@override
  void onInit() {
    super.onInit();
    language.value = SharedPrefController().myLang;
  }
  void changeLanguage(){
  language.value = language.value == 'en' ? 'er' : 'en';
  }
}