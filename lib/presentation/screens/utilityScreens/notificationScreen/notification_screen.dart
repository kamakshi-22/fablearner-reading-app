import 'package:path/path.dart' as p;

import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> _notifications = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    _loading = false;
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _loading = true;
    });

    final Database database = await openDatabase(
      p.join(await getDatabasesPath(), 'notifications.db'),
      version: 1,
    );

    // check if the table exists and create it if necessary
    final tableExists = await database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='notifications'");
    if (tableExists.isEmpty) {
      await database.execute(
        'CREATE TABLE notifications(id INTEGER PRIMARY KEY, title TEXT, body TEXT, date TEXT)',
      );
    }

    final List<Map<String, dynamic>> notifications = await database.query(
      'notifications',
    );

    setState(() {
      _notifications.clear();
      _notifications.addAll(notifications);
      _loading = false;
    });
  }

  Future<void> _deleteNotifications() async {
    setState(() {
      _loading = true;
    });

    final Database database = await openDatabase(
      p.join(await getDatabasesPath(), 'notifications.db'),
      version: 1,
    );

    await database.delete('notifications');

    final List<Map<String, dynamic>> notifications = await database.query(
      'notifications',
    );

    setState(() {
      _notifications.clear();
      _notifications.addAll(notifications);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkBlue,
        appBar: CustomAppBar(
          title: 'Notifications',
          showBackButton: true,
          centerTitle: false,
          onBackButtonPressed: () {
            Get.back();
          },
          actions: [
            IconButton(
              onPressed: _notifications.isEmpty
                  ? null
                  : () {
                      _deleteNotifications();
                    },
              icon: Icon(
                Icons.delete,
                color: white,
                size: AppSizes().notificationsListDeleteIconSize,
              ),
              splashRadius: 20,
            ),
            IconButton(
              onPressed: () {
                _loadNotifications();
              },
              icon: Icon(
                Icons.refresh,
                color: white,
                size: AppSizes().refreshIconSize,
              ),
              splashRadius: 20,
            )
          ],
        ),
        body: _loading
            ? const LoadingAnimation()
            : _notifications.isEmpty
                ? Center(
                    child: Text(
                    'Nothing to show yet.',
                    style: AppStyles.errorTextStyle,
                  ))
                : ListView.builder(
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final notification =
                          _notifications.reversed.toList()[index];
                      final title = notification['title'];
                      final body = notification['body'];
                      final date =
                          DateFormat('dd-MM-yyyy').parse(notification['date']);

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: SizedBox(
                          height: 80,
                          child: ListTile(
                              leading: Icon(
                                Icons.notifications,
                                color: white,
                                size: AppSizes().notificationsListTileIconSize,
                              ),
                              title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style:
                                          AppStyles.notificationListTitleStyle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    ),
                                    Text(
                                      DateFormat.yMMMMd().format(date),
                                      style: AppStyles
                                          .notificationListTrailingStyle,
                                    )
                                  ]),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              tileColor: lightBlue,
                              onTap: () {
                                // Show popup here
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: white,
                                      title: Text(
                                        title,
                                        style: AppStyles
                                            .notificationListTitleStyle
                                            .copyWith(
                                          color: darkBlue,
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat.yMMMMd().format(date),
                                            style: AppStyles
                                                .notificationListTrailingStyle,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            body,
                                            style: AppStyles
                                                .notificationListSubtitleStyle,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Close',
                                            style: AppStyles.buttonTextStyle,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                //
                              }),
                        ),
                      );
                    },
                  ));
  }
}
