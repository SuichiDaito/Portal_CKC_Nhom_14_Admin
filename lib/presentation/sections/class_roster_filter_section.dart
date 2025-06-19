// widgets/filter_section.dart
import 'package:flutter/material.dart';

class FilterSection extends StatefulWidget {
  final List<String> subjects;
  final List<String> statuses;
  final String? selectedSubject;
  final String? selectedStatus;
  final Function(String?) onSubjectChanged;
  final Function(String?) onStatusChanged;
  final VoidCallback onClearFilters;

  const FilterSection({
    Key? key,
    required this.subjects,
    required this.statuses,
    this.selectedSubject,
    this.selectedStatus,
    required this.onSubjectChanged,
    required this.onStatusChanged,
    required this.onClearFilters,
  }) : super(key: key);

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Filter Header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.filter_list, color: Colors.blue[700], size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Bộ lọc',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[800],
                    ),
                  ),
                  const Spacer(),
                  // Active filter indicator
                  if (widget.selectedSubject != null ||
                      widget.selectedStatus != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getActiveFilterCount().toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.blue[700],
                  ),
                ],
              ),
            ),
          ),

          // Filter Content
          if (_isExpanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subject Filter
                  Text(
                    'Môn học',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: widget.selectedSubject,
                      hint: const Text('Chọn môn học'),
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text('Tất cả môn học'),
                        ),
                        ...widget.subjects.map(
                          (subject) => DropdownMenuItem<String>(
                            value: subject,
                            child: Text(subject),
                          ),
                        ),
                      ],
                      onChanged: widget.onSubjectChanged,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Status Filter
                  Text(
                    'Trạng thái',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: widget.selectedStatus,
                      hint: const Text('Chọn trạng thái'),
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text('Tất cả trạng thái'),
                        ),
                        ...widget.statuses.map(
                          (status) => DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          ),
                        ),
                      ],
                      onChanged: widget.onStatusChanged,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Clear Filters Button
                  if (widget.selectedSubject != null ||
                      widget.selectedStatus != null)
                    SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: widget.onClearFilters,
                        icon: const Icon(Icons.clear),
                        label: const Text('Xóa bộ lọc'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[600],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  int _getActiveFilterCount() {
    int count = 0;
    if (widget.selectedSubject != null) count++;
    if (widget.selectedStatus != null) count++;
    return count;
  }
}
