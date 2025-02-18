import 'package:reading_app/core/services/api/data/entities/models/permission_model.dart';

class RoleModel {
  final String name;
  final String description;
  final List<PermissionModel> permissions;

  RoleModel({
    required this.name,
    required this.description,
    required this.permissions,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      name: json['name'],
      description: json['description'],
      permissions: (json['permissions'] as List<dynamic>)
          .map((item) => PermissionModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'permissions': permissions.map((e) => e.toJson()).toList(),
    };
  }
}
