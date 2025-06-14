import 'package:flutter/material.dart';
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
      title: '🎉 Chào mừng bạn!',
      content: 'Cảm ơn bạn đã đăng ký. Hãy khám phá ứng dụng ngay!',
      date: '14/06/2025',
      bgColor: Colors.orange[100]!,
      buttonColor: Colors.orange,
    ),
    NotificationCard(
      title: '🎉 Chào mừng bạn!',
      content: 'Cảm ơn bạn đã đăng ký. Hãy khám phá ứng dụng ngay!',
      date: '14/06/2025',
      bgColor: Colors.blue[100]!,
      buttonColor: Colors.blue,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông báo mới nhất',
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
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
