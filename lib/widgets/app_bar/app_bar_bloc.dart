import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../game_data/player_stats.dart';

part 'app_bar_event.dart';

part 'app_bar_state.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  AppBarBloc()
      : super(AppBarState(life: PlayerStats.balance)) {

    PlayerStats.balanceStream.listen((life) {
      add(UpdateBalance(life));
    });

    on<UpdateBalance>((event, emit) {
      PlayerStats.balance = event.life;
      emit(AppBarState(life: event.life,));
    });

  }
}
