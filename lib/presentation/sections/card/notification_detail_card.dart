import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/notification_content_detail.dart';
import 'package:portal_ckc/presentation/sections/notification_footer_detail.dart';
import 'package:portal_ckc/presentation/sections/notification_sender_information_detail.dart';

class NotificationDetailCard extends StatelessWidget {
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
            typeNotificationSender: 'Phòng Công Tác Chính Trị',
            date: '24/09/2025',
          ),
          NotificationContentDetail(
            headerNotification: 'Thông báo quan trọng',
            linkImage: '',
            contentNotification:
                'Phòng Công tác Chính trị thông báo về việc tổ chức Hội nghị tổng kết công tác năm 2025 và triển khai nhiệm vụ năm 2026. Hội nghị sẽ được tổ chức vào:\n\n'
                '• Thời gian: 8h00 ngày 25/06/2025\n'
                '• Địa điểm: Hội trường lớn - Tầng 2\n'
                '• Đối tượng tham dự: Toàn thể cán bộ công chức viên chức\n\n'
                'Nội dung chính của hội nghị bao gồm:\n'
                '1. Báo cáo tổng kết công tác năm 2025\n'
                '2. Đánh giá kết quả thực hiện các mục tiêu đề ra\n'
                '3. Triển khai kế hoạch công tác năm 2026\n'
                '4. Biểu dương khen thưởng các tập thể, cá nhân xuất sắc\n\n'
                'Đề nghị các đồng chí sắp xếp công việc để tham dự đầy đủ, đúng giờ.',
          ),
          NotificationFooterDetail(lengthComment: '2'),
        ],
      ),
    );
  }
}
