import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrintExamDialog extends StatefulWidget {
  final DateTime initialFromDate;
  final DateTime initialToDate;
  final void Function(DateTime from, DateTime to) onPrint;

  const PrintExamDialog({
    Key? key,
    required this.initialFromDate,
    required this.initialToDate,
    required this.onPrint,
  }) : super(key: key);

  @override
  _PrintExamDialogState createState() => _PrintExamDialogState();
}

class _PrintExamDialogState extends State<PrintExamDialog> {
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();
    fromDate = widget.initialFromDate;
    toDate = widget.initialToDate;
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
            'In Lịch Thi',
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
              'Chọn khoảng thời gian cần in:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16),
            _buildDatePicker(
              label: 'Từ ngày:',
              date: fromDate,
              onDateSelected: (date) {
                setState(() {
                  fromDate = date;
                  if (toDate.isBefore(fromDate)) {
                    toDate = fromDate;
                  }
                });
              },
            ),
            SizedBox(height: 12),
            _buildDatePicker(
              label: 'Đến ngày:',
              date: toDate,
              onDateSelected: (date) {
                setState(() {
                  toDate = date;
                });
              },
            ),
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
            widget.onPrint(fromDate, toDate);
          },
          icon: Icon(Icons.print, size: 18),
          label: Text('In Lịch Thi'),
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

  Widget _buildDatePicker({
    required String label,
    required DateTime date,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(label, style: TextStyle(fontSize: 14))),
        Expanded(
          flex: 3,
          child: TextButton(
            onPressed: () {
              _showDatePicker(context, date, onDateSelected);
            },
            child: Text(DateFormat('dd/MM/yyyy').format(date)),
          ),
        ),
      ],
    );
  }

  Future<void> _showDatePicker(
    BuildContext context,
    DateTime initialDate,
    ValueChanged<DateTime> onDateSelected,
  ) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      onDateSelected(date);
    }
  }

  Widget _buildSummary() {
    final difference = toDate.difference(fromDate).inDays + 1;
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
            '• Số ngày: $difference ngày',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          Text(
            '• Thời gian: ${DateFormat('dd/MM/yyyy').format(fromDate)} - ${DateFormat('dd/MM/yyyy').format(toDate)}',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
