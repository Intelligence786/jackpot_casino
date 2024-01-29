import 'package:jackpot_casino/game_data/player_stats.dart';
import 'package:jackpot_casino/presentation/main_game/additional_widgets/balance_panel.dart';
import 'package:jackpot_casino/presentation/main_game/additional_widgets/spin_button_panel.dart';
import 'package:jackpot_casino/widgets/app_bar/custom_app_bar.dart';

import '../../../core/app_export.dart';
import '../../../core/custom_slot_machine.dart';
import '../../../game_components/reward_pull.dart';
import '../../../widgets/custom_icon_button.dart';
import '../game_bloc/game_bloc.dart';

class SlotMachineGame extends StatefulWidget {
  final List<RollItem> rollItemsList;

  const SlotMachineGame({Key? key, required this.rollItemsList})
      : super(key: key);

  @override
  State<SlotMachineGame> createState() => _SlotMachineGameState();
}

class _SlotMachineGameState extends State<SlotMachineGame>
    with TickerProviderStateMixin {
  late SlotMachineController _controller;
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

    for (int i = 0; i < 3; i++) {
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
    _controller.start(hitRollItemIndex: index < 5 ? index : null);
  }

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
            fit: BoxFit.fitHeight,
            height: 1000.h,
            imagePath: ImageConstant.imgBgSlots,
            // margin: EdgeInsets.only(top: 10.h),
            alignment: Alignment.topCenter,
            //color: Colors.,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SlotMachine(
                height: 380.v,
                reelItemExtent: 500.h,
                width: 800.h,
                reelHeight: 250.v,
                reelWidth: 150.h,
                reelSpacing: 5.h,
                shuffle: false,
                rollItems: rollItems,
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

                  /* context
                      .read<GameBloc>()
                      .add(ClaimSlotMachineReward(resultIndexes));*/
                },
              ),
            ],
          ),
          Positioned(
            top: 100,
            left: 50,
            right: 50,
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
