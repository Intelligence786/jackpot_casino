import 'package:flutter/services.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:jackpot_casino/presentation/main_game/pokies_game/pokies_game.dart';
import 'package:jackpot_casino/presentation/main_game/slot_machine_game/slot_machine_game.dart';
import 'package:jackpot_casino/presentation/present_screen/present_menu.dart';
import 'package:jackpot_casino/widgets/custom_icon_button.dart';

import '../../core/app_export.dart';
import '../../game_components/reward_item.dart';
import '../../game_components/reward_pull.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../settings_screen/settings_menu.dart';
import 'additional_widgets/roulette_reward_widget.dart';
import 'game_bloc/game_bloc.dart';
import 'roulette_game/roulette_game.dart';

class MainGame extends StatefulWidget {
  @override
  State<MainGame> createState() => _MainGameState();

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: MainGame(),
    );
  }
}

class _MainGameState extends State<MainGame> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Center(
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is InitGameState) {
            return _mainScreenButtonsWidget(context);
          } else if (state is RouletteGameState) {
            return RouletteGame(
              images: state.images,
            );
          } else if (state is PokiesGameState) {
            return PokiesGame();
          } else if (state is SlotMachineGameState) {
            return SlotMachineGame(
              rollItemsList: state.rollItemsList,
            );
          }  else if (state is SettingsMenuState) {
            return SettingsMenu();
          } else if (state is PresentMenuState) {
            return PresentMenu();
          } else {
            return Center(child: Text('Unknown State'));
          }
        },
      ),
    );
  }

  Widget _mainScreenButtonsWidget(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidgets: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomIconButton(
                height: 40.h,
                width: 40.h,
                decoration: AppDecoration.circleButton(),
                onTap: () {
                  context.read<GameBloc>().add(OpenSettingsMenu());
                },
                // padding: EdgeInsets.all(4.h),
                child: Icon(Icons.settings)),
            SizedBox(
              width: 5,
            ),
            CustomIconButton(
              height: 40.h,
              width: 40.h,
              decoration: AppDecoration.circleButton(),
              onTap: () {
                context.read<GameBloc>().add(OpenPresentMenu());
              },
              // padding: EdgeInsets.all(4.h),
              child: Icon(Octicons.gift),
            ),
          ],
        ),
        actionWidgets: Container(
          padding: EdgeInsets.all(4.h),
          child: Text(
            'CHOOSE A GAME',
            style: theme.textTheme.headlineLarge,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomImageView(
            fit: BoxFit.fitHeight,
            height: 1000.h,
            imagePath: ImageConstant.imgBgMain,
            // margin: EdgeInsets.only(top: 10.h),
            alignment: Alignment.topCenter,
            //color: Colors.,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _menuPanel(context,
                  imgPath: ImageConstant.imgSlots,
                  name: 'SLOT MACHINE',
                  onTap: () =>
                      {context.read<GameBloc>().add(StartSlotMachineGame())}),
              _menuPanel(context,
                  imgPath: ImageConstant.imgPokies,
                  name: 'POKIES',
                  onTap: () =>
                      {context.read<GameBloc>().add(StartPokiesGame())}),
              _menuPanel(context,
                  imgPath: ImageConstant.imgRoulette,
                  name: 'ROULETTE',
                  onTap: () =>
                      {context.read<GameBloc>().add(StartRouletteGame())}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuPanel(BuildContext context,
      {String? imgPath, String? name, Function? onTap}) {
    return Expanded(
      child: Container(
        width: 200.h,
        height: 320.v,
        padding: EdgeInsets.symmetric(
            //horizontal: 30.h,
            //vertical: 30.v,
            ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.imgMainPanel,
            ),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.v),
            Expanded(
              //padding: EdgeInsets.only(top: 45.v,bottom: 10.v),
              child: CustomImageView(
                imagePath: imgPath,
                // margin: EdgeInsets.only(bottom: 10.h),
                alignment: Alignment.center,
              ),
            ),
            //SizedBox(height: 20.v),
            Text(
              name ?? '',
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.v),
            Container(
              //padding: EdgeInsets.only(top: 30.v,bottom: 40.v),
              child: CustomElevatedButton(
                decoration: AppDecoration.fillPrimary,
                height: 40.v,
                width: 150.h,
                text: 'PLAY',
                onPressed: () {
                  onTap?.call();
                  // context.read<GameBloc>().add(StartSlotMachineGame());
                },
              ),
            ),
            SizedBox(height: 35.v),
          ],
        ),
      ),
    );
  }
}
