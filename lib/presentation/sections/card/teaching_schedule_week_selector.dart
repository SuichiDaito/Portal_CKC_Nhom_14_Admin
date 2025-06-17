import 'package:flutter/material.dart';

class WeekSelector extends StatelessWidget {
  final int selectedWeek;
  final ValueChanged<int?> onChanged;

  const WeekSelector({required this.selectedWeek, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tuần: ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButton<int>(
              value: selectedWeek,
              underline: SizedBox(),
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue[600]),
              style: TextStyle(
                color: Colors.blue[600],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              items: List.generate(52, (index) => index + 1)
                  .map(
                    (week) => DropdownMenuItem(
                      value: week,
                      child: Text('Tuần $week'),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
