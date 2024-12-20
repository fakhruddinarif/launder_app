import 'dart:convert';

import 'package:launder_app/models/outlet.dart';
import 'package:launder_app/utils/http/http_client.dart';

class OutletService {
  Future<Outlet> create(CreateOutletRequest request) async {
    try {
      final formData = {
        'name': request.name,
        'address': request.address,
        'phone': request.phone,
        'city': request.city,
      };
      /*final fileHeader = [
        {
          'field': 'logo',
          'path': request.logo.path,
          'filename': request.logo.path.split('/').last,
        }
      ];*/
      final response = await LaunderHttpClient.multipart('outlet', 'POST', formData, []);
      final data = json.decode(response.body);
      if (response.statusCode == 201) {
        return Outlet.fromJson(data['data']);
      } else {
        throw data['errors'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ListOutlet> list(ListOutletRequest request) async {
    try {
      final response = await LaunderHttpClient.get("outlet?${request.toQueryParams()}");
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        final paging = data['paging'];
        return ListOutlet(
          data: (data['data'] as List).map((e) => Outlet.fromJson(e)).toList(),
          page: paging['page'],
          size: paging['size'],
          totalItem: paging['total_item'],
          totalPage: paging['total_page'],
        );
      } else {
        throw data['errors'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Outlet> get(GetOutletRequest request) async {
    try {
      final response = await LaunderHttpClient.get('outlet/${request.id}');
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return Outlet.fromJson(data['data']);
      } else {
        throw data['errors'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Outlet> update(UpdateOutletRequest request) async {
    try {
      final response = await LaunderHttpClient.patch('outlet/${request.id}', request.toJson());
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return Outlet.fromJson(data['data']);
      } else {
        throw data['errors'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Outlet> updateLogo(UpdateOutletLogoRequest request) async {
    try {
      final response = await LaunderHttpClient.multipart('outlet/${request.id}', 'PATCH', {}, [
        {
          'field': 'logo',
          'path': request.logo.path,
          'filename': request.logo.path.split('/').last,
        }
      ]);
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return Outlet.fromJson(data['data']);
      } else {
        throw data['errors'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> delete(DeleteOutletRequest request) async {
    try {
      final response = await LaunderHttpClient.delete('outlet/${request.id}');
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw data['errors'];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}