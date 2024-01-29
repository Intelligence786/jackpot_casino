import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:jackpot_casino/widgets/app_bar/custom_app_bar.dart';

import '../../../core/app_export.dart';
import '../../../game_components/reward_pull.dart';
import '../../../game_data/player_stats.dart';
import '../../../widgets/custom_icon_button.dart';
import '../additional_widgets/spin_button_panel.dart';
import '../game_bloc/game_bloc.dart';

class RouletteGame extends StatefulWidget {
  final List<String> images;

  const RouletteGame({Key? key, required this.images}) : super(key: key);

  @override
  State<RouletteGame> createState() => _RouletteGameState();
}

class _RouletteGameState extends State<RouletteGame>
    with TickerProviderStateMixin {
  StreamController<int> selected = StreamController<int>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int rand = 0;
  bool isClicked = false;
  late double currentAmount = 1000;

  @override
  Widget build(BuildContext context) {
    final images = <Widget>[
      Text('20', style: theme.textTheme.bodySmall),
      Text('10000', style: theme.textTheme.bodySmall),
      Text(
        '0',
        style: theme.textTheme.bodySmall,
      ),
      CustomImageView(imagePath: ImageConstant.imgContentCoin),
      Text(
        '20',
        style: theme.textTheme.bodySmall,
      ),
      CustomImageView(imagePath: ImageConstant.imgContentMoney),
      Text(
        '0',
        style: theme.textTheme.bodySmall,
      ),
      CustomImageView(imagePath: ImageConstant.imgContentBottle),
      Text(
        '50',
        style: theme.textTheme.bodySmall,
      ),
      CustomImageView(imagePath: ImageConstant.imgContentStone),
      Text(
        '100',
        style: theme.textTheme.bodySmall,
      ),
      CustomImageView(imagePath: ImageConstant.imgContentBomb),
      Text(
        '0',
        style: theme.textTheme.bodySmall,
      ),
      CustomImageView(imagePath: ImageConstant.imgContentCristall),
    ];
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgBgRoulette,
          ),
          Container(
            //decoration: AppDecoration.fillPrimary,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: 550.h,
                  height: 550.v,
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: AlignmentDirectional.center,
                    children: [
                      CustomImageView(
                        fit: BoxFit.fitHeight,
                        imagePath: ImageConstant.imgRouletteGame,
                      ),
                      Container(
                        //  padding: const EdgeInsets.all(20.0),
                        margin: EdgeInsets.only(top: 80, bottom: 30),
                        child: Stack(
                          //fit: StackFit.expand,
                          alignment: Alignment.center,
                          // fit: StackFit.passthrough,
                          children: [
                            Container(
                              decoration: AppDecoration.rouletteCircleGradient,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15, bottom: 15),
                              height: 400.v,
                              width: 400.h,
                              child: RotatedBox(
                                quarterTurns: 15,
                                child: FortuneWheel(
                                  onAnimationEnd: () {
                                    //RuletteRewardsPull.getRewardItem(rand);
                                    PlayerStats.incraseBalance(
                                        RuletteRewardsPull.getRewardItem(rand) *
                                            2);
                                    isClicked = false;
                                  },
                                  indicators: [
                                    FortuneIndicator(
                                        child: RotatedBox(
                                          quarterTurns: 1,
                                          child: Container(),
                                        ),
                                        alignment: Alignment.topCenter)
                                  ],
                                  animateFirst: false,
                                  selected: selected.stream,
                                  items: [
                                    for (int i = 0; i < images.length; i++)
                                      FortuneItem(
                                        child: RotatedBox(
                                          quarterTurns: 10,
                                          child: Container(
                                            padding: EdgeInsets.only(right: 50),
                                            // alignment: Alignment.center,
                                            height: 50.v,
                                            width: 100.h,
                                            child: Center(child: images[i]),
                                          ),
                                        ),
                                        style: FortuneItemStyle(
                                            color: i % 2 == 0
                                                ? Color(0XFFFF9B39)
                                                : Color(0XFF502E0E),
                                            borderColor: Color(0XffFF7853),
                                            borderWidth: 3),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 105,
                              child: CustomImageView(
                                width: 50.h,
                                height: 50.h,
                                imagePath: ImageConstant.imgRoulettePointer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                  rand = Fortune.randomInt(0, images.length);
                  print(rand);
                  selected.add(rand);
                }
              },
            ),
          ),
          Positioned(
              right: 30,
              top: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5.h, right: 10.v),
                    margin: EdgeInsets.all(5),
                    width: 150,
                    height: 50,
                    decoration: AppDecoration.fillPrimary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgContentCristall,
                        ),
                        Text('X10')
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.h, right: 10.v),
                    margin: EdgeInsets.all(5),
                    width: 150,
                    height: 50,
                    decoration: AppDecoration.fillPrimary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgContentStone,
                        ),
                        Text('X10')
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.h, right: 10.v),
                    margin: EdgeInsets.all(5),
                    width: 150,
                    height: 50,
                    decoration: AppDecoration.fillPrimary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgContentCristall,
                        ),
                        Text('X10')
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.h, right: 10.v),
                    margin: EdgeInsets.all(5),
                    width: 150,
                    height: 50,
                    decoration: AppDecoration.fillPrimary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgContentCristall,
                        ),
                        Text('X10')
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
