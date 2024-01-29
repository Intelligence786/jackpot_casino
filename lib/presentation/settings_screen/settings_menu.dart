import 'package:flutter/cupertino.dart';
import 'package:jackpot_casino/core/app_export.dart';
import 'package:jackpot_casino/widgets/app_bar/custom_app_bar.dart';

import '../../widgets/custom_icon_button.dart';
import '../main_game/game_bloc/game_bloc.dart';
import '../main_game/additional_widgets/information_panel.dart';

class SettingsMenu extends StatefulWidget {
  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  bool sound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidgets:   CustomIconButton(
          height: 40.h,
          width: 40.h,
          decoration: AppDecoration.circleButton(),
          onTap: () {
            context.read<GameBloc>().add(OpenMainMenu());
          },
          // padding: EdgeInsets.all(4.h),
          child: Icon(Icons.arrow_back_ios_sharp, size: 20,),
        ),
        actionWidgets: Container(
          padding: EdgeInsets.all(4.h),
          child: Text(
            'SETTINGS',
            style: theme.textTheme.headlineLarge,
          ),
        ),
      ),
     // backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        //padding: EdgeInsets.only(top: 100.h),
        height: 150.h,
        width: 150.h,
      ),
      body: Stack(
        children: [
          CustomImageView(
            fit: BoxFit.fitHeight,
            height: 1000.h,
            imagePath: ImageConstant.imgBgMain,
            // margin: EdgeInsets.only(top: 10.h),
            alignment: Alignment.topCenter,
            //color: Colors.,
          ),
          Center(
            child: Container(
              width: 400.h,
              height: 300.v,
              decoration: AppDecoration.fillPanel,
              child: Container(
                child: InformationPanel(
                  headerText: '',
                  insideContent: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'MUSIC',
                            style: theme.textTheme.headlineMedium,
                          ),
                          Container(
                              height: 50,
                              child: CupertinoSwitch(
                                activeColor: appTheme.primary,
                                  trackColor: Colors.black38,
                                  value: sound,
                                  onChanged: (value) {
                                    setState(() {
                                      sound = !sound;
                                    });
                                  }))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SOUND',
                            style: theme.textTheme.headlineMedium,
                          ),
                          Container(
                              height: 50,
                              child: CupertinoSwitch(
                                  activeColor: appTheme.primary,
                                  trackColor: Colors.black38,
                                  value: sound,
                                  onChanged: (value) {
                                    setState(() {
                                      sound = !sound;
                                    });
                                  }))
                        ],
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'TERM OF USE',

                            style: theme.textTheme.headlineMedium,
                          ),
                        ),
                        height: 40.v,
                      ),
                      Container(
                        height: 40.v,
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'PRIVACY POLICY',
                            style: theme.textTheme.headlineMedium,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
