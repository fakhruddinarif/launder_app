import 'package:equatable/equatable.dart';
import 'package:launder_app/models/outlet.dart';

abstract class OutletState extends Equatable {
  const OutletState();

  @override
  List<Object?> get props => [];
}

class OutletInitial extends OutletState {}

class OutletLoading extends OutletState {}

class OutletSuccess extends OutletState {
  final String message;
  final Outlet? data;

  const OutletSuccess({required this.message, this.data});

  @override
  List<Object?> get props => [message, data];
}

class OutletListSuccess extends OutletState {
  final String message;
  final ListOutlet data;

  const OutletListSuccess({required this.message, required this.data});

  @override
  List<Object> get props => [message, data];
}

class OutletFailure extends OutletState {
  final String message;

  const OutletFailure({required this.message});

  @override
  List<Object> get props => [message];
}