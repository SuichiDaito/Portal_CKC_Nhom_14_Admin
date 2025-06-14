import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/presentation/pages/page_notification_detail_admin.dart';
import 'package:portal_ckc/presentation/sections/card/notification_card.dart';

class NotificationsHomeAdmin extends StatefulWidget {
  final String typeNotification;
  final String contentNotification;
  final String date;
  const NotificationsHomeAdmin({
    super.key,
    required this.typeNotification,
    required this.contentNotification,
    required this.date,
  });
  @override
  State<NotificationsHomeAdmin> createState() => _NotificationsHomeAdmin();
}

class _NotificationsHomeAdmin extends State<NotificationsHomeAdmin> {
  final list = [
    NotificationCard(
      title: '🎉 Chào mừng bạn!78687',
      content: 'Cảm ơn bạn đã đăng ký. Hãy khám phá ứng dụng ngay!',
      date: '14/06/2025',
      bgColor: Colors.orange[100]!,
      buttonColor: Colors.orange,
      onPressed: () {},
    ),
    NotificationCard(
      title: '🎉 Chào mừng bạn!',
      content: 'Cảm ơn bạn đã đăng ký. Hãy khám phá ứng dụng ngay!',
      date: '14/06/2025',
      bgColor: Colors.blue[100]!,
      buttonColor: Colors.blue,
      onPressed: () {},
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.typeNotification}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  NotificationCard(
                    title: list[index].title,
                    content: list[index].content,
                    date: list[index].date,
                    bgColor: list[index].bgColor,
                    buttonColor: list[index].buttonColor,
                    onPressed: () {
                      context.go(
                        '/notifications/detail',
                        extra: {
                          'title': list[index].title,
                          'content': list[index].content,
                          'date': list[index].date,
                        },
                      );
                    },
                  ),
                  SizedBox(height: 15),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
