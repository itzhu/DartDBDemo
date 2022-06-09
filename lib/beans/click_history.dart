class ClickHistory {
  ///id，自动增长
  int id = 0;

  ///次数
  int times = 0;

  ///最后更新时间,数据库自动更新,yyyy-MM-dd HH:mm:ss。
  ///需要在生成ClickHistoryTable里面， DbTable.TYPE_TEXT之后，加上DbTable.defaultDateTimeNow()。
  ///如：[LAST_CLICK_TIME, DbTable.TYPE_TEXT,DbTable.defaultDateTimeNow()],
  String? lastClickTime;

  ///double 演示
  double dValue = 0.0;

  ///String 演示
  String? remark;

  ///db-ignore 生成tab时忽略此字段
  String? ignoreKey;

  ///默认构造函数，一定要有
  ClickHistory();
}
