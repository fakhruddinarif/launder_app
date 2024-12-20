import 'package:image_picker/image_picker.dart';

class Outlet {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String city;
  final String? logo;
  final String user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Outlet({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.city,
    this.logo,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return Outlet(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      logo: json['logo'],
      user: json['user'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }
}

class ListOutlet {
  final List<Outlet> data;
  final int page;
  final int size;
  final int totalItem;
  final int totalPage;

  ListOutlet({
    required this.data,
    required this.page,
    required this.size,
    required this.totalItem,
    required this.totalPage,
  });

  factory ListOutlet.fromJson(Map<String, dynamic> json) {
    return ListOutlet(
      data: (json['data'] as List).map((e) => Outlet.fromJson(e)).toList(),
      page: json['page'],
      size: json['size'],
      totalItem: json['total_item'],
      totalPage: json['total_page'],
    );
  }
}

class CreateOutletRequest {
  final String name;
  final String address;
  final String phone;
  final String city;
  final XFile? logo;

  CreateOutletRequest({
    required this.name,
    required this.address,
    required this.phone,
    required this.city,
    this.logo,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'city': city,
    };
  }
}

class ListOutletRequest {
  final int page;
  final int size;

  ListOutletRequest({
    required this.page,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'size': size,
    };
  }

  String toQueryParams() {
    final  params = toJson();
    params.removeWhere((key, value) => value == null);
    return '?' + params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }
}

class GetOutletRequest {
  final String id;

  GetOutletRequest({
    required this.id,
  });
}

class UpdateOutletRequest {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String city;

  UpdateOutletRequest({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'city': city,
    };
  }
}

class UpdateOutletLogoRequest {
  final String id;
  final XFile logo;

  UpdateOutletLogoRequest({
    required this.id,
    required this.logo,
  });
}

class DeleteOutletRequest {
  final String id;

  DeleteOutletRequest({
    required this.id,
  });
}