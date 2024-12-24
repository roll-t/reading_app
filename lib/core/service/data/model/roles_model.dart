
import 'package:reading_app/core/service/data/model/permission_model.dart';

class RolesModel {
  final String name;
  final String description;
  final List<PermissionModel> permissions;

  RolesModel({
    required this.name,
    required this.description,
    required this.permissions,
  });

  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(
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
