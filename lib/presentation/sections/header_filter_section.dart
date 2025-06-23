import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_nien_khoa.dart';

class HeaderFilterSection extends StatelessWidget {
  final String selectedMonth;
  final int selectedNienKhoaId;
  final List<String> months;
  final List<NienKhoa> nienKhoas;
  final VoidCallback onToggleEdit;
  final VoidCallback onSave;
  final VoidCallback onReload;
  final ValueChanged<String?> onMonthChanged;
  final ValueChanged<int?> onNienKhoaChanged;
  final bool isEditing;

  const HeaderFilterSection({
    super.key,
    required this.selectedMonth,
    required this.selectedNienKhoaId,
    required this.months,
    required this.nienKhoas,
    required this.onToggleEdit,
    required this.onSave,
    required this.onReload,
    required this.onMonthChanged,
    required this.onNienKhoaChanged,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.calendar_today, color: Colors.white70),
              SizedBox(width: 8),
              Text(
                'Chọn tháng và niên khóa:',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text(
                'Tháng:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                dropdownColor: Colors.blue,
                value: selectedMonth,
                onChanged: onMonthChanged,
                items: months
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                style: const TextStyle(color: Colors.white),
                iconEnabledColor: Colors.white,
              ),
              const SizedBox(width: 24),
              const Text(
                'Niên khóa:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<int>(
                dropdownColor: Colors.blue,
                value: selectedNienKhoaId,
                onChanged: onNienKhoaChanged,
                items: nienKhoas
                    .map(
                      (nk) => DropdownMenuItem<int>(
                        value: nk.id,
                        child: Text(nk.tenNienKhoa),
                      ),
                    )
                    .toList(),
                style: const TextStyle(color: Colors.white),
                iconEnabledColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: onToggleEdit,
                icon: Icon(isEditing ? Icons.close : Icons.edit),
                label: Text(isEditing ? 'Huỷ sửa' : 'Sửa điểm'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1976D2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.save),
                label: const Text('Lưu'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
