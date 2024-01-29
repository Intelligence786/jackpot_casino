part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class StartRouletteGame extends GameEvent {


  StartRouletteGame();
}

class StartSlotMachineGame extends GameEvent {}

class StartPokiesGame extends GameEvent {}

class ClaimSlotMachineReward extends GameEvent {
  final List<int> rewardInts;


  ClaimSlotMachineReward(this.rewardInts);
}

class ClaimRouletteReward extends GameEvent {
  final int rewardInt;


  ClaimRouletteReward(this.rewardInt);
}

class OpenSettingsMenu extends GameEvent {}

class OpenMainMenu extends GameEvent {}

class OpenPresentMenu extends GameEvent {}
