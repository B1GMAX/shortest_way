import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  SharedPreferences? _preferences;

  Preferences._();

  static final Preferences _instance = Preferences._();

  static Preferences get instance => _instance;

  Future<SharedPreferences> get pref async =>
      _preferences ?? await SharedPreferences.getInstance();

  Future<void> saveUrl(String url) async => (await pref).setString('url', url);

  Future<String> getUrl() async => (await pref).getString('url') ?? '';
}
