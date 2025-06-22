import 'package:flutter/material.dart';

class DropdownItem {
  final String value;
  final String label;
  final IconData icon;

  DropdownItem({required this.value, required this.label, required this.icon});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DropdownItem &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
