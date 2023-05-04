import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:path/path.dart';

class LocalStorage{
  Future<void> saveNotification(RemoteMessage message) async {
  final Database database = await openDatabase(
    join(await getDatabasesPath(), 'notifications.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE notifications(id INTEGER PRIMARY KEY, title TEXT, body TEXT)',
      );
    },
    version: 1,
  );

  final String title = message.notification!.title.toString();
  final String body = message.notification!.body.toString();

  await database.insert(
    'notifications',
    {
      'title': title,
      'body': body,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  final List<Map<String, dynamic>> notifications = await database.query(
    'notifications',
  );

  print('NOTIFICATIONS: Saved notifications: $notifications');
}

}
