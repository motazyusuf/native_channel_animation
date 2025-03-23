import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:native_channel/features/home/repo/home_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    HomeRepo homeRepo = HomeRepo();
    Future<void> loadBattery(event, emit) async {
      String batteryLevel = await homeRepo.getBatteryLevel();
      emit(BatteryLoaded(batteryLevel));
    }

    on<LoadBatteryEvent>(loadBattery);
  }
}
