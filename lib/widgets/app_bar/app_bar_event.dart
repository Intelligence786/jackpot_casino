part of 'app_bar_bloc.dart';

@immutable
abstract class AppBarEvent {}

class UpdateBalance extends AppBarEvent {
  final double life;

  UpdateBalance(this.life);
}


