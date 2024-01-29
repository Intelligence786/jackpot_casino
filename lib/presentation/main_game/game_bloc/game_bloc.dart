import '../../../core/app_export.dart';
import '../../../core/custom_slot_machine.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(InitGameState()) {
    _setupEventHandlers();
  }

  void _setupEventHandlers() {
    on<StartRouletteGame>(_handleStartRouletteGame);
    on<StartSlotMachineGame>(_handleStartSlotMachineGame);
    on<StartPokiesGame>(_handleStartPokiesGame);
    on<ClaimSlotMachineReward>(_handleClaimSlotMachineReward);
    on<ClaimRouletteReward>(_handleClaimRouletteReward);
    on<OpenSettingsMenu>(_handleOpenSettingsMenu);
    on<OpenMainMenu>(_handleOpenMainMenu);
    on<OpenPresentMenu>(_handleOpenPresentMenu);
  }

  void _handleOpenMainMenu(OpenMainMenu event, Emitter<GameState> emit) {
    emit(InitGameState());
  }

  void _handleOpenPresentMenu(OpenPresentMenu event, Emitter<GameState> emit) {

    emit(PresentMenuState());
  }

  void _handleStartRouletteGame(
      StartRouletteGame event, Emitter<GameState> emit) {
    bool _clockwise = true;

    final images = <String>[
      (ImageConstant.imgContentBottle),
      (ImageConstant.imgContentCristall),
      (ImageConstant.imgContentApple),
      (ImageConstant.imgContentBomb),
      (ImageConstant.imgContentCoin),
      (ImageConstant.imgContentCrown),
      (ImageConstant.imgContentMeat),
      (ImageConstant.imgContentMoney),
      (ImageConstant.imgContentStar),
      (ImageConstant.imgContentStone),
    ];

    emit(RouletteGameState(images));
  }

  void _handleStartSlotMachineGame(
      StartSlotMachineGame event, Emitter<GameState> emit) {
    List<RollItem> _rollItemList = [
      RollItem(
        index: 0,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentBottle,
        ),
      ),
      RollItem(
        index: 1,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentCristall,
        ),
      ),
      RollItem(
        index: 2,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentApple,
        ),
      ),
      RollItem(
        index: 3,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentBomb,
        ),
      ),
      RollItem(
        index: 4,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentCoin,
        ),
      ),
      RollItem(
        index: 5,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentCrown,
        ),
      ),
      RollItem(
        index: 6,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentMeat,
        ),
      ),
      RollItem(
        index: 7,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentMoney,
        ),
      ),
      RollItem(
        index: 8,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentStar,
        ),
      ),
      RollItem(
        index: 9,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentStone,
        ),
      ),
    ];

    emit(SlotMachineGameState(rollItemsList: _rollItemList));
  }

  void _handleStartPokiesGame(StartPokiesGame event, Emitter<GameState> emit) {
    List<RollItem> _rollItemList = [
      RollItem(
        index: 0,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentBottle,
        ),
      ),
      RollItem(
        index: 1,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentCristall,
        ),
      ),
      RollItem(
        index: 2,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentApple,
        ),
      ),
      RollItem(
        index: 3,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentBomb,
        ),
      ),
      RollItem(
        index: 4,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentCoin,
        ),
      ),
      RollItem(
        index: 5,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentCrown,
        ),
      ),
      RollItem(
        index: 6,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentMeat,
        ),
      ),
      RollItem(
        index: 7,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentMoney,
        ),
      ),
      RollItem(
        index: 8,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentStar,
        ),
      ),
      RollItem(
        index: 9,
        child: CustomImageView(
          imagePath: ImageConstant.imgContentStone,
        ),
      ),
    ];

    emit(PokiesGameState(rollItemsList: _rollItemList));
  }

  void _handleClaimSlotMachineReward(
      ClaimSlotMachineReward event, Emitter<GameState> emit) {
    emit(SlotMachineRewardState(event.rewardInts)); // Пример выигрыша
  }

  void _handleClaimRouletteReward(
      ClaimRouletteReward event, Emitter<GameState> emit) {
    emit(RouletteRewardState(event.rewardInt)); // Пример выигрыша
  }

  void _handleOpenSettingsMenu(
      OpenSettingsMenu event, Emitter<GameState> emit) {
    emit(SettingsMenuState());
  }
}
