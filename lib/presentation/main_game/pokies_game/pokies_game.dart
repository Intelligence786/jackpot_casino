import 'package:jackpot_casino/core/custom_pokies.dart';
import 'package:jackpot_casino/presentation/main_game/additional_widgets/balance_panel.dart';
import 'package:jackpot_casino/widgets/app_bar/custom_app_bar.dart';

import '../../../core/app_export.dart';
import '../../../game_components/reward_pull.dart';
import '../../../game_data/player_stats.dart';
import '../../../widgets/custom_icon_button.dart';
import '../additional_widgets/spin_button_panel.dart';
import '../game_bloc/game_bloc.dart';

class PokiesGame extends StatefulWidget {
  const PokiesGame({Key? key}) : super(key: key);

  @override
  State<PokiesGame> createState() => _PokiesGameState();
}

class _PokiesGameState extends State<PokiesGame> with TickerProviderStateMixin {
  late PokiesController _controller;
  late List<RollItem> rollItems;
  late double currentAmount = 1000;
  @override
  void initState() {
    super.initState();

    setState(() {
      rollItems = [
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
    });
  }

  stopRandomly() async {
    // Инициируем остановку каждого колеса с рандомной задержкой
    final random = Random();

    for (int i = 0; i < 4; i++) {
      // Генерируем рандомную задержку от 500 до 1500 миллисекунд (или другой диапазон по вашему усмотрению)
      final delay = Duration(milliseconds: 500 + random.nextInt(1000));

      // Ожидаем заданную задержку перед остановкой следующего колеса
      await Future.delayed(delay);

      // Запускаем остановку текущего колеса
      _controller.stop(reelIndex: i);
    }
  }

  void onStart() {
    final index = Random().nextInt(20);
    _controller.start(hitRollItemIndex: index < 6 ? index : null);
  }

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(
        titleWidgets: CustomIconButton(
          height: 40.h,
          width: 40.h,
          decoration: AppDecoration.circleButton(),
          onTap: () {
            context.read<GameBloc>().add(OpenMainMenu());
          },
          // padding: EdgeInsets.all(4.h),
          child: Icon(
            Icons.arrow_back_ios_sharp,
            size: 20,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgBgPokies,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgPokiesGame,
                      fit: BoxFit.fitHeight,
                    ),
                    Pokies(
                      height: 300.v,
                      reelItemExtent: 70.h,
                      width: 400.h,
                      reelHeight: 210.v,
                      reelWidth: 100.h,
                      reelSpacing: 5.h,
                      shuffle: false,
                      rollItems: rollItems,
                      multiplyNumberOfSlotItems: 3,
                      onCreated: (controller) {
                        _controller = controller;
                      },
                      onFinished: (resultIndexes) async {
                        await Future.delayed(Duration(seconds: 1));
                        isClicked = false;
                        setState(() {
                          if (SlotMachineRewardsPull.getRewardItem(
                              resultIndexes))
                            PlayerStats.incraseBalance(currentAmount * 2);
                        });
                    /*    context
                            .read<GameBloc>()
                            .add(ClaimSlotMachineReward(resultIndexes));*/
                      },
                    ),

                    Positioned(
                      bottom: 10,
                      child: BalancePanel(
                        plusTap: () {
                          setState(() {
                            currentAmount += 1000;
                          });
                        },
                        minusTap: () {
                          setState(() {
                            if (currentAmount > 1000) currentAmount -= 1000;
                          });
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 30,
            top: 100,
            child: SpinButtonPanel(
              amountText: currentAmount.toStringAsFixed(0),
              onTap: () {
                if (!isClicked) {
                  isClicked = true;
                  setState(() {
                    PlayerStats.decreaseBalance(currentAmount);
                  });
                  onStart();
                  stopRandomly();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
