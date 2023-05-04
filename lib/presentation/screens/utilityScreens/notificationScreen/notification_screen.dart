import 'package:fablearner_app/controllers/notification_controller.dart';
import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> _notifications = [];
  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final Database database = await openDatabase(
      p.join(await getDatabasesPath(), 'notifications.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> notifications = await database.query(
      'notifications',
    );

    setState(() {
      _notifications.clear();
      _notifications.addAll(notifications);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: CustomAppBar(
          title: 'Notifications',
          showBackButton: true,
          centerTitle: false,
          onBackButtonPressed: () {
            Get.back();
          },
        ),
        body: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            final title = notification['title'];
            final body = notification['body'];
            final date = DateFormat('dd-MM-yyyy').parse(notification['date']);

            return ListTile(
              title: Text(
                title,
                style: AppStyles.notificationListTitleStyle,
              ),
              subtitle: Text(body),
              trailing: Text(DateFormat.yMMMMd().format(date)),
            );
          },
        ));
  }
}
