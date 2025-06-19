import 'package:flutter/material.dart';

class PrintScheduleDialog extends StatefulWidget {
  final int fromWeek;
  final int toWeek;
  final void Function(int from, int to) onPrint;

  const PrintScheduleDialog({
    Key? key,
    required this.fromWeek,
    required this.toWeek,
    required this.onPrint,
  }) : super(key: key);

  @override
  _PrintScheduleDialogState createState() => _PrintScheduleDialogState();
}

class _PrintScheduleDialogState extends State<PrintScheduleDialog> {
  late int fromWeek;
  late int toWeek;

  @override
  void initState() {
    super.initState();
    fromWeek = widget.fromWeek;
    toWeek = widget.toWeek;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Row(
        children: [
          Icon(Icons.print, color: Colors.blue[600]),
          SizedBox(width: 8),
          Text(
            'In Thời Khóa Biểu',
            style: TextStyle(
              color: Colors.blue[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chọn khoảng tuần cần in:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16),
            _buildWeekDropdown('Từ tuần:', fromWeek, (val) {
              setState(() {
                fromWeek = val;
                if (toWeek < fromWeek) toWeek = fromWeek;
              });
            }),
            SizedBox(height: 12),
            _buildWeekDropdown('Đến tuần:', toWeek, (val) {
              setState(() {
                toWeek = val;
              });
            }, minWeek: fromWeek),
            SizedBox(height: 16),
            _buildSummary(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Hủy', style: TextStyle(color: Colors.grey[600])),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onPrint(fromWeek, toWeek);
          },
          icon: Icon(Icons.print, size: 18),
          label: Text('In TKB'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekDropdown(
    String label,
    int value,
    ValueChanged<int> onChanged, {
    int minWeek = 1,
  }) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(label, style: TextStyle(fontSize: 14))),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<int>(
              value: value,
              isExpanded: true,
              underline: SizedBox(),
              items: List.generate(52, (i) => i + 1)
                  .where((week) => week >= minWeek)
                  .map(
                    (week) => DropdownMenuItem(
                      value: week,
                      child: Text('Tuần $week'),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.blue[600]),
              SizedBox(width: 4),
              Text(
                'Thông tin in:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            '• Số tuần: ${toWeek - fromWeek + 1} tuần',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          Text(
            '• Thời gian: Tuần $fromWeek - Tuần $toWeek',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
