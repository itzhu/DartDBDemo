/*摆脱冷气，只是向上走，不必听自暴自弃者流的话。*/

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_db_creator_simple/app.dart';
import 'package:flutter_db_creator_simple/beans/click_history.dart';
import 'package:flutter_db_creator_simple/dbcreate/table/tb_click_history.dart';
import 'package:flutter_db_creator_simple/pages/common/view_state.dart';
import 'package:provider/provider.dart';

///@name  : page_main
///@author: create by  itzhu |  2022/6/8
///@desc  :
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _MainPageViewData viewData = _MainPageViewData();
    viewData.refreshAll();
    return Scaffold(
      appBar: AppBar(title: const Text("数据库测试")),
      body: Column(
        children: [
          ChangeNotifierProvider.value(
            value: viewData.countViewState,
            builder: (context, child) {
              var times = context.watch<ViewState<int>>().data;
              return Text("点击次数:$times");
            },
          ),
          Expanded(
              child: _DbReadView(
            viewData: viewData,
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewData.addTimes();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _DbReadView extends StatelessWidget {
  _DbReadView({Key? key, required this.viewData});

  final _MainPageViewData viewData;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: viewData.dbRefreshViewState,
        builder: (context, _) {
          var state = context.watch<ViewState>();
          print("state updateTime:${state.updateTime}");
          var list = viewData.listData;
          return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                var data = list[index];
                return Text("id:${data.id},times:${data.times},lastClickTime:${data.lastClickTime}");
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 1,
                  color: Colors.black12,
                );
              },
              itemCount: list.length);
        });
  }
}

class _MainPageViewData {
  ClickHistory clickHistory = ClickHistory();
  ViewState<int> countViewState = ViewState<int>.create(data: 0);

  ViewState dbRefreshViewState = ViewState();
  var listData = <ClickHistory>[];

  Future<void> addTimes() async {
    clickHistory.times++;
    clickHistory.dValue = Random().nextDouble();
    clickHistory.remark = "remark--${clickHistory.times}";
    countViewState.update(data: clickHistory.times, notify: true);
    //存入数据库
    var data = await App.db.getTable<ClickHistoryTable>(ClickHistoryTable.TB_NAME)?.save(clickHistory);
    print("data:$data");
    if (data?.first == 2) {
      clickHistory.id = data!.second;
    }
    refreshAll();
  }

  void refreshAll() {
    var table = App.db.getTable<ClickHistoryTable>(ClickHistoryTable.TB_NAME);

    table?.find().then((value) {
      listData = value;
      print("value:$value");
      dbRefreshViewState.update(updateTime: DateTime.now(), notify: true);
    }).onError((error, stackTrace) {
      print("$error");
    });
  }
}
