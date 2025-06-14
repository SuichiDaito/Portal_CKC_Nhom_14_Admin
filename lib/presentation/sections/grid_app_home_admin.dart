import 'package:flutter/material.dart';

class GridAppHomeAdmin extends StatefulWidget {
  const GridAppHomeAdmin({super.key});
  State<GridAppHomeAdmin> createState() => _GridAppHomeAdmin();
}

class _GridAppHomeAdmin extends State<GridAppHomeAdmin> {
  final functions = [
    {
      'icon': Icons.assignment,
      'title': 'Kết quả\nrèn luyện',
      'color': Colors.blue,
    },
    {
      'icon': Icons.notifications,
      'title': 'Thông\nbáo',
      'color': Colors.orange,
    },
    {'icon': Icons.video_call, 'title': 'KPKP', 'color': Colors.green},
    {'icon': Icons.description, 'title': 'SKCH', 'color': Colors.purple},
    {'icon': Icons.calendar_today, 'title': 'Lịch học', 'color': Colors.red},
    {
      'icon': Icons.library_books,
      'title': 'Tài liệu\nhọc tập',
      'color': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: functions.length,
      itemBuilder: (context, index) {
        final function = functions[index];
        return GestureDetector(
          onTap: () {
            // Handle function tap
            print('Tapped: ${function['title']}');
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (function['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    function['icon'] as IconData,
                    color: function['color'] as Color,
                    size: 28,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  function['title'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
