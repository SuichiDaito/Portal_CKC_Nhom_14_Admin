import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';

class GradeInputSection extends StatefulWidget {
  final SinhVienLopHocPhan student;
  final Function(SinhVienLopHocPhan) onGradeSubmit;
  final bool isExpanded;
  final bool isEditing;

  const GradeInputSection({
    Key? key,
    required this.student,
    required this.onGradeSubmit,
    this.isExpanded = false,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<GradeInputSection> createState() => _GradeInputSectionState();
}

class _GradeInputSectionState extends State<GradeInputSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final _attendanceController = TextEditingController();
  final _processController = TextEditingController();
  final _examController = TextEditingController();
  final _finalController = TextEditingController();
  final _theoryController = TextEditingController();

  bool _hasSubmitted = false;
  bool _hasChangedSinceSubmit = false;

  double _clampScore(double value) => value.clamp(0.0, 10.0);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    if (widget.isExpanded) _animationController.forward();

    _setInitialValues();
    _addListeners();
  }

  void _setInitialValues() {
    _attendanceController.text = (widget.student.diemChuyenCan ?? 0.0)
        .toStringAsFixed(1);
    _processController.text = (widget.student.diemQuaTrinh ?? 0.0)
        .toStringAsFixed(1);
    _examController.text = (widget.student.diemThi ?? 0.0).toStringAsFixed(1);
    _theoryController.text = (widget.student.diemLyThuyet ?? 0.0)
        .toStringAsFixed(1);
    _calculateFinalScore(); // set initial tổng kết
  }

  void _addListeners() {
    _attendanceController.addListener(_onScoreChanged);
    _processController.addListener(_onScoreChanged);
    _examController.addListener(_onScoreChanged);
    _theoryController.addListener(_onScoreChanged);
  }

  void _onScoreChanged() {
    _calculateFinalScore();
    _hasChangedSinceSubmit = true;
    _updateStudentData();
  }

  void _updateStudentData() {
    widget.student.diemChuyenCan =
        double.tryParse(_attendanceController.text) ?? 0.0;
    widget.student.diemQuaTrinh =
        double.tryParse(_processController.text) ?? 0.0;
    widget.student.diemThi = double.tryParse(_examController.text) ?? 0.0;
    widget.student.diemLyThuyet =
        double.tryParse(_theoryController.text) ?? 0.0;
  }

  void _calculateFinalScore() {
    double cc = double.tryParse(_attendanceController.text) ?? 0.0;
    double qt = double.tryParse(_processController.text) ?? 0.0;
    double thi = double.tryParse(_examController.text) ?? 0.0;

    double finalScore = (cc * 0.1) + (qt * 0.3) + (thi * 0.6);
    _finalController.text = finalScore.toStringAsFixed(1);
    widget.student.diemTongKet = finalScore;
  }

  void _submitGrade() {
    widget.onGradeSubmit(widget.student);

    setState(() {
      _hasSubmitted = true;
      _hasChangedSinceSubmit = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✅ Đã nộp điểm cho ${widget.student.sinhVien.hoSo.hoTen}',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant GradeInputSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded && !oldWidget.isExpanded) {
      _animationController.forward();
    } else if (!widget.isExpanded && oldWidget.isExpanded) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _attendanceController.dispose();
    _processController.dispose();
    _examController.dispose();
    _finalController.dispose();
    _theoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                Icon(Icons.grade, color: Colors.blue.shade700, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Nhập điểm - ${widget.student.sinhVien.hoSo.hoTen}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInput(
                    'Chuyên cần',
                    _attendanceController,
                    '(10%)',
                    readOnly: !widget.isEditing,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInput(
                    'Quá trình',
                    _processController,
                    '(30%)',
                    readOnly: !widget.isEditing,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildInput(
                    'Lý thuyết',
                    _theoryController,
                    '(Tự chọn)',
                    readOnly: !widget.isEditing,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildInput(
                    'Thi',
                    _examController,
                    '(60%)',
                    readOnly: !widget.isEditing,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInput(
                    'Tổng kết',
                    _finalController,
                    '',
                    readOnly: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _submitGrade,
              icon: const Icon(Icons.check, size: 20),
              label: const Text(
                'Nộp điểm',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: Colors.green.shade200,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    TextEditingController controller,
    String hint, {
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\.\d{0,1})?')),
          ],
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: readOnly ? Colors.grey.shade100 : Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }
}
