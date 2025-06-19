class Role {
  final int id;
  final String name;
  final String guardName;
  final List<Permission> permissions;

  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      guardName: json['guard_name'],
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => Permission.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Permission {
  final int id;
  final String name;
  final String guardName;

  Permission({required this.id, required this.name, required this.guardName});

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'],
      name: json['name'],
      guardName: json['guard_name'],
    );
  }
}
