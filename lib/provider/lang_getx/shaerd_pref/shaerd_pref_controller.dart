import 'package:shared_preferences/shared_preferences.dart';
enum PrefKeys { lang }
class SharedPrefController{

  SharedPrefController._internal();
  static final SharedPrefController _instance = SharedPrefController._internal();
  factory SharedPrefController(){
    return _instance;
  }
  static SharedPreferences? _preferences;

  static Future<SharedPreferences> get instance async => _preferences ??= await SharedPreferences.getInstance();


  Future<void> setLang(String lang)async{
    await _preferences!.setString(PrefKeys.lang.toString(), lang);
  }
  String get myLang => _preferences!.getString(PrefKeys.lang.toString()) ?? 'en';
}