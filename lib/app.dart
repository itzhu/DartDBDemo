
import 'app_db.dart';

class App {
  App._privateConstructor();

  static final App _instance = App._privateConstructor();

  static App getInstance() {
    return _instance;
  }

  static late final AppDb db;

  void init(){
    _initDb();
  }

  ///数据库配置
  void _initDb() {
    final AppDb dbConfig = AppDb();
    App.db = dbConfig;
  }

}
