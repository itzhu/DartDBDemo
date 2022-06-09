import 'dart:io';

import 'package:flutter_db_creator_simple/dbcreate/common/db/db_util.dart';
import 'package:flutter_db_creator_simple/dbcreate/table/tb_click_history.dart';
import 'package:sqflite/sqflite.dart';

import 'dbcreate/common/db/base_db.dart';

///数据库管理
class AppDb extends AbsDb {
  ///只支持android\ios\windows
  @override
  Future<String> getDbPath() async {
    if (Platform.isWindows) {
      return "G:/aaa/";
    } else {
      return "${await getDatabasesPath()}/";
    }
  }

  @override
  int getDbVersion() => 1;

  @override
  String getFileName() => "app_db.db";

  @override
  Future onCreate(Database db, int version) async {
    db.execute(ClickHistoryTable.createTableSql());
  }

  @override
  Future onUpgrade(Database db, int oldVersion, int newVersion) async {
    DBUtil.deleteTable(db, ClickHistoryTable.TB_NAME);
    onCreate(db, newVersion);
  }

  var cache = {};

  T? getTable<T>(String tbName) {
    var tb = cache[tbName];
    if (tb == null) {
      switch (tbName) {
        case ClickHistoryTable.TB_NAME:
          cache[tbName] = ClickHistoryTable();
          return cache[tbName];
      }
    }
    return tb;
  }
}
