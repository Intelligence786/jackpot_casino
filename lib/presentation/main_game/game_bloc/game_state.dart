part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class InitGameState extends GameState {}

class RouletteGameState extends GameState {
final List<String> images;

  RouletteGameState(this.images);
}

class SlotMachineGameState extends GameState {
  final List<RollItem> rollItemsList;

  SlotMachineGameState({required this.rollItemsList});
}

class PokiesGameState extends GameState {
  final List<RollItem> rollItemsList;

  PokiesGameState({required this.rollItemsList});
}

class SlotMachineRewardState extends GameState {
  final List<int> reward;

  SlotMachineRewardState(this.reward);
}

class RouletteRewardState extends GameState {
  final int reward;

  RouletteRewardState(this.reward);
}

class SettingsMenuState extends GameState {}
class PresentMenuState extends GameState {}
