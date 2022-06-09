/*摆脱冷气，只是向上走，不必听自暴自弃者流的话。*/

import 'package:flutter/cupertino.dart';

///@name  : ViewState
///@author: create by  itzhu |  2022/6/8
///@desc  :
class ViewState<T> extends ChangeNotifier {
  static int STATE_INIT = 0;
  static int STATE_SUCCESS = 1;
  static int STATE_FAILED = 2;

  ViewState();

  ViewState.create({DateTime? updateTime, T? data, int? code, String? msg}){
    if (updateTime != null) {
      _updateTime = updateTime;
    }
    if (data != null) {
      _data = data;
    }
    if (code != null) {
      _code = code;
    }
    if (msg != null) {
      _msg = msg;
    }
  }

  DateTime? _updateTime;
  T? _data;
  int _code = STATE_INIT;
  String? _msg;

  DateTime? get updateTime => _updateTime;

  T? get data => _data;

  int get code => _code;

  String? get msg => _msg;

  void update({DateTime? updateTime, T? data, int? code, String? msg, bool notify = false}) {
    if (updateTime != null) {
      _updateTime = updateTime;
    }
    if (data != null) {
      _data = data;
    }
    if (code != null) {
      _code = code;
    }
    if (msg != null) {
      _msg = msg;
    }
    if (notify) {
      notifyListeners();
    }
  }
}
