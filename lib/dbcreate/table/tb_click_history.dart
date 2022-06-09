import "../../beans/click_history.dart";
import '../common/db/base_table.dart';
import '../common/db/db_table.dart';

class ClickHistoryTable extends BaseTable<ClickHistory> {
  static const String TB_NAME = "tb_click_history";

  ///int id = 0;
  static const String ID = "id";

  ///int times = 0;
  static const String TIMES = "times";

  ///String? lastClickTime;
  static const String LAST_CLICK_TIME = "lastClickTime";

  ///double dValue = 0.0;
  static const String D_VALUE = "dValue";

  ///String? remark;
  static const String REMARK = "remark";

  static String createTableSql() {
    return DbTable.createTable(
        TB_NAME,
        [
          [ID, DbTable.TYPE_INTEGER, DbTable.NOT_NULL],
          [TIMES, DbTable.TYPE_INTEGER, DbTable.NOT_NULL, DbTable.defaultValue(0)],
          [LAST_CLICK_TIME, DbTable.TYPE_TEXT, DbTable.defaultDateTimeNow()],
          [D_VALUE, DbTable.TYPE_REAL, DbTable.NOT_NULL, DbTable.defaultValue(0.0)],
          [REMARK, DbTable.TYPE_TEXT],
        ],
        primaryKey: ID,
        autoIncrement: true);
  }

  @override
  String getIdKey() => ID;

  @override
  String getTableName() => TB_NAME;

  @override
  ClickHistory mapTo(Map<String, Object?> map) {
    ClickHistory data = ClickHistory();
    data.id = DbTable.getDataOrNull(map, ID);
    data.times = DbTable.getDataOrNull(map, TIMES);
    data.lastClickTime = DbTable.getDataOrNull(map, LAST_CLICK_TIME);
    data.dValue = DbTable.getDataOrNull(map, D_VALUE);
    data.remark = DbTable.getDataOrNull(map, REMARK);
    return data;
  }

  @override
  Map<String, Object?> toMap(ClickHistory data, {bool allowNullValue = false, bool allowId0 = false}) {
    return <String, Object?>{
      if (!allowId0 && data.id > 0) ID: data.id,
      if (!allowNullValue && data.times != null) TIMES: data.times,
      if (!allowNullValue && data.lastClickTime != null) LAST_CLICK_TIME: data.lastClickTime,
      if (!allowNullValue && data.dValue != null) D_VALUE: data.dValue,
      if (!allowNullValue && data.remark != null) REMARK: data.remark,
    };
  }
}
