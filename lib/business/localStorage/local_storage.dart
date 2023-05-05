import 'package:path/path.dart' as p;

import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class LocalStorage {
  Future<void> saveNotification(RemoteMessage message) async {
    final Database database = await openDatabase(
      p.join(await getDatabasesPath(), 'notifications.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notifications(id INTEGER PRIMARY KEY, title TEXT, body TEXT, date TEXT)',
        );
      },
    );

    final String title = message.notification!.title.toString();
    final String body = message.notification!.body.toString();
    final int dateInMillis = DateTime.now().millisecondsSinceEpoch;
    final String formattedDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(dateInMillis));

    final bool tableExists = await database
        .rawQuery('SELECT 1 FROM sqlite_master WHERE type = "table" AND name = "notifications"')
        .then((value) => value.isNotEmpty);

    if (!tableExists) {
      await database.execute(
        'CREATE TABLE notifications(id INTEGER PRIMARY KEY, title TEXT, body TEXT, date TEXT)',
      );
    }

    await database.insert(
      'notifications',
      {
        'title': title,
        'body': body,
        'date': formattedDate,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final List<Map<String, dynamic>> notifications = await database.query(
      'notifications',
    );

    if (kDebugMode) {
      print('NOTIFICATIONS: Saved notifications: $notifications');
    }
  }
}


/* class LocalStorage {
  Future<void> saveNotification(RemoteMessage message) async {
    final Database database = await openDatabase(
      p.join(await getDatabasesPath(), 'notifications.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notifications(id INTEGER PRIMARY KEY, title TEXT, body TEXT, date TEXT)',
        );
      },
      version: 1,
    );

    final String title = message.notification!.title.toString();
    final String body = message.notification!.body.toString();
    final int dateInMillis = DateTime.now().millisecondsSinceEpoch;
    final String formattedDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(dateInMillis));

    await database.insert(
      'notifications',
      {
        'title': title,
        'body': body,
        'date': formattedDate,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final List<Map<String, dynamic>> notifications = await database.query(
      'notifications',
    );

    if (kDebugMode) {
      print('NOTIFICATIONS: Saved notifications: $notifications');
    }
  }
}
 */
