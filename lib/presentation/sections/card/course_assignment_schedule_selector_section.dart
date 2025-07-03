import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/presentation/pages/page_course_assignment_admin.dart';

class ScheduleSection extends StatefulWidget {
  final List<LopHocPhan> selectedClasses;

  const ScheduleSection({Key? key, required this.selectedClasses})
    : super(key: key);

  @override
  _ScheduleSectionState createState() => _ScheduleSectionState();
}

class _ScheduleSectionState extends State<ScheduleSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1976D2).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.schedule,
                  color: const Color(0xFF1976D2),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Phân công lịch học & lịch thi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1976D2),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          if (widget.selectedClasses.isEmpty)
            _buildEmptyState()
          else
            _buildScheduleContent(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Chọn lớp học phần để xem lịch',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Vui lòng chọn ít nhất một lớp từ danh sách trên',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleContent() {
    return Column(
      children: [
        // Selected classes info
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                'Đã chọn ${widget.selectedClasses.length} lớp học phần',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Tab bar
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 8),
                    Text('Lịch học'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.quiz, size: 20),
                    const SizedBox(width: 8),
                    Text('Lịch thi'),
                  ],
                ),
              ),
            ],
            labelColor: const Color(0xFF1976D2),
            unselectedLabelColor: Colors.grey.shade600,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            indicatorPadding: const EdgeInsets.all(4),
            dividerColor: Colors.transparent,
          ),
        ),

        const SizedBox(height: 20),

        // Tab content
        Container(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [_buildClassScheduleTab(), _buildExamScheduleTab()],
          ),
        ),
      ],
    );
  }

  Widget _buildClassScheduleTab() {
    return SingleChildScrollView(
      child: Column(
        children: widget.selectedClasses.map((classInfo) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        classInfo.tenHocPhan,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        classInfo.chuongTrinhDaoTao.tenChuongTrinhDaoTao,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                _buildScheduleRow(
                  icon: Icons.access_time,
                  label: 'Thời gian',
                  value: 'Thứ 2, 7:30 - 11:30',
                ),
                _buildScheduleRow(
                  icon: Icons.location_on,
                  label: 'Phòng học',
                  value: 'A101',
                ),
                _buildScheduleRow(
                  icon: Icons.date_range,
                  label: 'Thời gian học',
                  value: '15 tuần (01/09 - 15/12)',
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            _showScheduleDialog(context, classInfo, 'class'),
                        icon: Icon(Icons.edit_calendar, size: 18),
                        label: Text('Chỉnh sửa'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1976D2),
                          side: BorderSide(color: const Color(0xFF1976D2)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExamScheduleTab() {
    return SingleChildScrollView(
      child: Column(
        children: widget.selectedClasses.map((classInfo) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade600,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        classInfo.tenHocPhan,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        classInfo.chuongTrinhDaoTao.tenChuongTrinhDaoTao,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                _buildScheduleRow(
                  icon: Icons.quiz,
                  label: 'Hình thức thi',
                  value: classInfo.loaiLopHocPhan == 'TH'
                      ? 'Thực hành'
                      : 'Viết',
                ),
                _buildScheduleRow(
                  icon: Icons.access_time,
                  label: 'Thời gian thi',
                  value: '90 phút',
                ),
                _buildScheduleRow(
                  icon: Icons.calendar_today,
                  label: 'Ngày thi',
                  value: 'Chưa xếp lịch',
                ),
                _buildScheduleRow(
                  icon: Icons.location_on,
                  label: 'Phòng thi',
                  value: 'Chưa xếp lịch',
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            _showScheduleDialog(context, classInfo, 'exam'),
                        icon: Icon(Icons.edit_calendar, size: 18),
                        label: Text('Xếp lịch thi'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.orange.shade600,
                          side: BorderSide(color: Colors.orange.shade600),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildScheduleRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ),
          Text(
            ': $value',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showScheduleDialog(
    BuildContext context,
    LopHocPhan classInfo,
    String type,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            type == 'class' ? 'Chỉnh sửa lịch học' : 'Xếp lịch thi',
            style: TextStyle(
              color: const Color(0xFF1976D2),
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Lớp: ${classInfo.tenHocPhan}'),
              // Text('Môn: ${classInfo.}'),
              const SizedBox(height: 16),
              Text(
                type == 'class'
                    ? 'Chức năng chỉnh sửa lịch học sẽ được phát triển'
                    : 'Chức năng xếp lịch thi sẽ được phát triển',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
