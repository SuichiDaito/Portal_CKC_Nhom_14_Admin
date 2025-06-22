class Permission {
  final int id;
  final String name;

  Permission({required this.id, required this.name});

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(id: json['id'], name: json['name'] ?? '');
  }
}

class Role {
  final int id;
  final String name;
  final List<Permission> permissions;

  Role({required this.id, required this.name, required this.permissions});

  factory Role.fromJson(Map<String, dynamic> json) {
    var permissionsList = <Permission>[];
    if (json['permissions'] != null) {
      permissionsList = (json['permissions'] as List)
          .map((e) => Permission.fromJson(e))
          .toList();
    }

    return Role(
      id: json['id'],
      name: json['name'] ?? '',
      permissions: permissionsList,
    );
  }
}
