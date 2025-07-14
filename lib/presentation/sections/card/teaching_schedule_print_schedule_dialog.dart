import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_tuan.dart';

class PrintScheduleDialog extends StatefulWidget {
  final int fromWeek;
  final int toWeek;
  final void Function(int from, int to) onPrint;
  final List<TuanModel> tuanList;
  const PrintScheduleDialog({
    Key? key,
    required this.fromWeek,
    required this.toWeek,
    required this.onPrint,
    required this.tuanList,
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

            _buildWeekDropdown('Đến tuần:', toWeek, (val) {
              setState(() {
                toWeek = val;
              });
            }, minWeekId: fromWeek),

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

  Widget _buildWeekDropdown(String label,
    int value,
    ValueChanged<int> onChanged, {
    int? minWeekId,
  }) {
    final filteredTuan = minWeekId != null
        ? widget.tuanList.where((t) => t.id >= minWeekId).toList()
        : widget.tuanList;

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
              value: filteredTuan.any((t) => t.id == value) ? value : null,
              isExpanded: true,
              underline: SizedBox(),
              items: filteredTuan
                  .map(
                    (t) => DropdownMenuItem<int>(
                      value: t.id,
                      child: Text('Tuần ${t.tuan}'),
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
    final fromTuan = widget.tuanList.firstWhere(
      (t) => t.id == fromWeek,
      orElse: () => widget.tuanList.first,
    );
    final toTuan = widget.tuanList.firstWhere(
      (t) => t.id == toWeek,
      orElse: () => widget.tuanList.last,
    );

    final dateFormat = DateFormat('dd/MM/yyyy');
    final String fromDateStr = fromTuan.ngayBatDau != null
        ? dateFormat.format(fromTuan.ngayBatDau!)
        : '---';
    final String toDateStr = toTuan.ngayKetThuc != null
        ? dateFormat.format(toTuan.ngayKetThuc!)
        : '---';

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
            '• Số tuần: ${toWeek == fromWeek ? 1 : widget.tuanList.where((t) => t.id >= fromWeek && t.id <= toWeek).length} tuần',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          Text(
            '• Thời gian: $fromDateStr - $toDateStr',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],),
    );
  }
}