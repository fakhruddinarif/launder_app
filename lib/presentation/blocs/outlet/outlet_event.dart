import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class OutletEvent extends Equatable {
  const OutletEvent();

  @override
  List<Object?> get props => [];
}

class OutletCreateEvent extends OutletEvent {
  final String name;
  final String address;
  final String phone;
  final String city;
  final XFile? logo;

  const OutletCreateEvent({
    required this.name,
    required this.address,
    required this.phone,
    required this.city,
    this.logo,
  });

  @override
  List<Object?> get props => [name, address, phone, city, logo];
}

class OutletListEvent extends OutletEvent {
  final int page;
  final int size;

  const OutletListEvent({
    required this.page,
    required this.size,
  });

  @override
  List<Object> get props => [page, size];
}

class OutletGetEvent extends OutletEvent {
  final String id;

  const OutletGetEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class OutletUpdateEvent extends OutletEvent {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String city;

  const OutletUpdateEvent({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.city,
  });

  @override
  List<Object> get props => [id, name, address, phone, city];
}

class OutletUpdateLogoEvent extends OutletEvent {
  final String id;
  final XFile logo;

  const OutletUpdateLogoEvent({
    required this.id,
    required this.logo,
  });

  @override
  List<Object> get props => [id, logo];
}

class OutletDeleteEvent extends OutletEvent {
  final String id;

  const OutletDeleteEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}