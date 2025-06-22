import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class ScheduleCopyCard extends StatefulWidget {
  final int currentWeek;
  final VoidCallback onCopySchedule;

  const ScheduleCopyCard({
    Key? key,
    required this.currentWeek,
    required this.onCopySchedule,
  }) : super(key: key);

  @override
  _ScheduleCopyCardState createState() => _ScheduleCopyCardState();
}

class _ScheduleCopyCardState extends State<ScheduleCopyCard> {
  late TextEditingController _fromWeekController;
  late TextEditingController _toWeekController;

  @override
  void initState() {
    super.initState();
    _fromWeekController = TextEditingController(
      text: widget.currentWeek.toString(),
    );
    _toWeekController = TextEditingController(
      text: (widget.currentWeek + 1).toString(),
    );
  }

  @override
  void dispose() {
    _fromWeekController.dispose();
    _toWeekController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(3.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sao chép lịch cho các tuần sau:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _fromWeekController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Từ tuần',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _toWeekController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Đến tuần',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                CustomButton(
                  text: 'Chép',
                  onPressed: () {
                    final fromWeek = int.tryParse(_fromWeekController.text);
                    final toWeek = int.tryParse(_toWeekController.text);

                    if (fromWeek != null &&
                        toWeek != null &&
                        fromWeek <= toWeek) {
                      // Thực hiện logic sao chép lịch ở đây
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Sao chép lịch từ tuần $fromWeek đến tuần $toWeek',
                          ),
                        ),
                      );
                      widget.onCopySchedule(); // Trigger callback if needed
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Vui lòng nhập tuần hợp lệ.'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
