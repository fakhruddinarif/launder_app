import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launder_app/models/outlet.dart';
import 'package:launder_app/presentation/blocs/outlet/outlet_event.dart';
import 'package:launder_app/presentation/blocs/outlet/outlet_state.dart';
import 'package:launder_app/services/outlet_service.dart';

class OutletBloc extends Bloc<OutletEvent, OutletState> {
  final OutletService outletService;
  List<Outlet> _outlets = [];

  OutletBloc({required this.outletService}) : super(OutletInitial()) {
    on<OutletCreateEvent>((event, emit) async {
      emit(OutletLoading());
      try {
        await outletService.create(
          CreateOutletRequest(
              name: event.name,
              address: event.address,
              phone: event.phone,
              city: event.city,
          ));
        emit(const OutletSuccess(message: 'Outlet created successfully'));
        print('Outlet created successfully');
      } catch (e) {
        emit(OutletFailure(message: e.toString()));
      }
    });

    on<OutletListEvent>((event, emit) async {
      emit(OutletLoading());
      try {
        final outlets = await outletService.list(ListOutletRequest(page: event.page, size: event.size));
        _outlets.addAll(outlets.data);
        emit(OutletListSuccess(message: 'Outlet success get data outlets', data: ListOutlet(
            data: _outlets,
            page: outlets.page,
            size: outlets.size,
            totalItem: outlets.totalItem,
            totalPage: outlets.totalPage
        )));
        print('Outlet success get data outlets');
      } catch (e) {
        print("Error List Outlet: $e");
        emit(OutletFailure(message: e.toString()));
      }
    });

    on<OutletGetEvent>((event, emit) async {
      emit(OutletLoading());
      try {
        final outlet = await outletService.get(GetOutletRequest(id: event.id));
        emit(OutletSuccess(message: 'Outlet success get data outlet', data: outlet));
        print('Outlet success get data outlet');
      } catch (e) {
        emit(OutletFailure(message: e.toString()));
      }
    });

    on<OutletUpdateEvent>((event, emit) async {
      emit(OutletLoading());
      try {
        final outlet = await outletService.update(
          UpdateOutletRequest(
              id: event.id,
              name: event.name,
              address: event.address,
              phone: event.phone,
              city: event.city
          ));
        emit(OutletSuccess(message: 'Outlet updated successfully', data: outlet));
        print('Outlet updated successfully');
      } catch (e) {
        emit(OutletFailure(message: e.toString()));
      }
    });

    on<OutletUpdateLogoEvent>((event, emit) async {
      emit(OutletLoading());
      try {
        final outlet = await outletService.updateLogo(
          UpdateOutletLogoRequest(
              id: event.id,
              logo: event.logo
          ));
        emit(OutletSuccess(message: 'Outlet logo updated successfully', data: outlet));
        print('Outlet logo updated successfully');
      } catch (e) {
        emit(OutletFailure(message: e.toString()));
      }
    });

    on<OutletDeleteEvent>((event, emit) async {
      emit(OutletLoading());
      try {
        await outletService.delete(DeleteOutletRequest(id: event.id));
        emit(const OutletSuccess(message: 'Outlet deleted successfully'));
        print('Outlet deleted successfully');
      } catch (e) {
        emit(OutletFailure(message: e.toString()));
      }
    });
  }
}