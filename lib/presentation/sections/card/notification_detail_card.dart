import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/notification_content_detail.dart';
import 'package:portal_ckc/presentation/sections/notification_footer_detail.dart';
import 'package:portal_ckc/presentation/sections/notification_sender_information_detail.dart';

class NotificationDetailCard extends StatelessWidget {
  final String typeNotificationSender;
  final String date;
  final String headerNotification;
  final String contentNotification;
  final String lengthComment;

  const NotificationDetailCard({
    Key? key,
    required this.typeNotificationSender,
    required this.date,
    required this.headerNotification,
    required this.contentNotification,
    required this.lengthComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationSenderInformationDetail(
            typeNotificationSender: typeNotificationSender,
            date: date,
          ),
          NotificationContentDetail(
            headerNotification: headerNotification,
            linkImage: '',
            contentNotification: contentNotification,
          ),
          NotificationFooterDetail(lengthComment: lengthComment),
        ],
      ),
    );
  }
}
