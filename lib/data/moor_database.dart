import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Tasks], daos: [TodoDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
}

@UseDao(
  tables: [Tasks],
  queries: {
    'completedTasksGenerated':
        'SELECT * FROM tasks WHERE completed = 1 ORDER BY due_date DESC, name;'
  },
)
class TodoDao extends DatabaseAccessor<AppDatabase> with _$TodoDaoMixin {
  final AppDatabase db;

  TodoDao(this.db) : super(db);

  Future<List<Task>> getAllTasks() => select(tasks).get();

  Stream<List<Task>> watchAllTasks() {
    return (select(tasks)
          ..orderBy([
            (t) => OrderingTerm(expression: t.dueDate, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.name),
          ]))
        .watch();
  }

  Stream<List<Task>> watchCompletedTasks() {
    return (select(tasks)
          ..orderBy([
            (t) => OrderingTerm(expression: t.dueDate, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.name),
          ])
          ..where((t) => t.completed.equals(true)))
        .watch();
  }

  // Stream<List<Task>> watchCompletedTasksCustom() {
  //   return customSelectQuery(
  //       'SELECT * FROM tasks WHERE completed = 1 ORDER BY due_date DESC, name;',
  //       readsFrom: {tasks}).map((rows) {
  //     return rows.map((row) => Task.fromData(row.data, db)).toList();
  //   }).watch();
  // }

  Future insertTask(Insertable<Task> task) => into(tasks).insert(task);
  Future updateTask(Insertable<Task> task) => update(tasks).replace(task);
  Future deleteTask(Insertable<Task> task) => delete(tasks).delete(task);
}
