// sections/grade_input_section.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portal_ckc/presentation/sections/card/class_list_studen_infor_class_section.dart';

class GradeInputSection extends StatefulWidget {
  final Student student;
  final Function(StudentGrade) onGradeSubmit;
  final bool isExpanded;

  const GradeInputSection({
    Key? key,
    required this.student,
    required this.onGradeSubmit,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  State<GradeInputSection> createState() => _GradeInputSectionState();
}

class _GradeInputSectionState extends State<GradeInputSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool hasSubmitted = false;
  double _clampScore(double value) {
    return value.clamp(0.0, 10.0);
  }

  final _attendanceController = TextEditingController();
  final _processController = TextEditingController();
  final _examController = TextEditingController();
  final _finalController = TextEditingController();

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

    if (widget.isExpanded) {
      _animationController.forward();
    }

    // Initialize with existing grades if available
    if (widget.student.grade != null) {
      _attendanceController.text = widget.student.grade!.attendanceScore
          .toString();
      _processController.text = widget.student.grade!.processScore.toString();
      _examController.text = widget.student.grade!.examScore.toString();
      _finalController.text = widget.student.grade!.finalScore.toString();
    }
  }

  @override
  void didUpdateWidget(GradeInputSection oldWidget) {
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
    super.dispose();
  }

  void _calculateFinalScore() {
    double attendance = double.tryParse(_attendanceController.text) ?? 0.0;
    double process = double.tryParse(_processController.text) ?? 0.0;
    double exam = double.tryParse(_examController.text) ?? 0.0;

    double finalScore = (attendance * 0.1) + (process * 0.3) + (exam * 0.6);
    _finalController.text = finalScore.toStringAsFixed(1);
  }

  void _submitGrade() {
    StudentGrade grade = StudentGrade(
      attendanceScore: double.tryParse(_attendanceController.text) ?? 0.0,
      processScore: double.tryParse(_processController.text) ?? 0.0,
      examScore: double.tryParse(_examController.text) ?? 0.0,
      finalScore: double.tryParse(_finalController.text) ?? 0.0,
    );
    widget.onGradeSubmit(grade);

    setState(() {
      hasSubmitted = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✅ Đã nộp điểm cho ${widget.student.fullName}'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
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
                  'Nhập điểm - ${widget.student.fullName}',
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
                  child: _buildGradeInput(
                    'Chuyên cần',
                    _attendanceController,
                    '(10%)',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildGradeInput(
                    'Quá trình',
                    _processController,
                    '(30%)',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildGradeInput('Thi', _examController, '(60%)'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildGradeInput(
                    'Tổng kết',
                    _finalController,
                    '',
                    isReadOnly: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: hasSubmitted
                        ? null // Vô hiệu hóa nếu đã nộp
                        : () {
                            _calculateFinalScore();
                            _submitGrade();
                          },
                    icon: const Icon(Icons.check, size: 18),
                    label: Text(hasSubmitted ? 'Đã nộp' : 'Nộp điểm'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hasSubmitted
                          ? Colors.grey
                          : Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
      ),
    );
  }

  Widget _buildGradeInput(
    String label,
    TextEditingController controller,
    String hint, {
    bool isReadOnly = false,
  }) {
    void increase() {
      double current = double.tryParse(controller.text) ?? 0.0;
      current = _clampScore(current + 0.5);
      controller.text = current.toStringAsFixed(1);
    }

    void decrease() {
      double current = double.tryParse(controller.text) ?? 0.0;
      current = _clampScore(current - 0.5);
      controller.text = current.toStringAsFixed(1);
    }

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
        Row(
          children: [
            if (!isReadOnly)
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: decrease,
                color: Colors.blue,
              ),
            Expanded(
              child: TextFormField(
                controller: controller,
                readOnly: isReadOnly,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d{0,2}(\.\d{0,1})?'),
                  ),
                ],
                onChanged: (value) {
                  double? input = double.tryParse(value);
                  if (input != null && input > 10) {
                    controller.text = '10.0';
                  }
                },
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.blue.shade600,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: isReadOnly ? Colors.grey.shade100 : Colors.white,
                ),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isReadOnly ? Colors.grey.shade600 : Colors.black87,
                ),
              ),
            ),
            if (!isReadOnly)
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: increase,
                color: Colors.blue,
              ),
          ],
        ),
      ],
    );
  }
}
