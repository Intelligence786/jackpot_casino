import 'package:fluttericon/octicons_icons.dart';
import 'package:jackpot_casino/core/app_export.dart';
import 'package:jackpot_casino/game_data/player_stats.dart';
import 'package:jackpot_casino/widgets/app_bar/custom_app_bar.dart';
import 'package:jackpot_casino/widgets/custom_elevated_button.dart';

import '../../widgets/custom_icon_button.dart';
import '../main_game/game_bloc/game_bloc.dart';

class PresentMenu extends StatefulWidget {
  @override
  State<PresentMenu> createState() => _PresentMenuState();
}

class _PresentMenuState extends State<PresentMenu> {
  late SharedPreferences _prefs;
  late DateTime _lastOpenTime = DateTime.now();
  late bool _canOpenBox = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    _startTimer();
  }


  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _lastOpenTime = DateTime.fromMillisecondsSinceEpoch(
      _prefs.getInt('lastOpenTime') ?? 0,
    );
    _updateCanOpenBox();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {

      _updateCanOpenBox();

      setState(() {});
    });
  }

  void _updateCanOpenBox() {
    final currentTime = DateTime.now();
    final nextOpenTime = _lastOpenTime.add(Duration(hours: 24));
    _canOpenBox = currentTime.isAfter(nextOpenTime);
  }

  void _openBox() {
    if (_canOpenBox) {
      PlayerStats.incraseBalance(200);
      _lastOpenTime = DateTime.now();
      _prefs.setInt('lastOpenTime', _lastOpenTime.millisecondsSinceEpoch);

      // Обновляем состояние
      _updateCanOpenBox();
      setState(() {});
    } else {
      // Показываем сообщение, что ящик еще не доступен
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ящик можно открыть только раз в 24 часа.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(
        titleWidgets:
        CustomIconButton(
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
            'PRESENT',
            style: theme.textTheme.headlineLarge,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
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
          Container(
            //height: 500,

            // decoration: AppDecoration.fillPrimary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageView(
                      imagePath: _canOpenBox
                          ? ImageConstant.imgChestOpened
                          : ImageConstant.imgChestClosed,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            height: 180.v,
                            width: 350.h,
                            decoration: AppDecoration.fillPanel,
                            child: Center(
                                child: Text(
                              _canOpenBox
                                  ? 'We give you 200 coins for\ndaily login. We are waiting\nyou in next day.'
                                  : 'Every 24 hours you can\nget your daily reward',
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40.v,
                          width: 150.h,
                          child: CustomElevatedButton(
                            decoration: AppDecoration.fillPrimary.copyWith(
                                borderRadius: BorderRadius.circular(10)),
                            height: 150,
                            isDisabled: !_canOpenBox,
                            onPressed: () {
                              _openBox();
                            },
                            text: !_canOpenBox
                                ? 'NEXT: ${_timeUntilNextOpen()}'
                                : 'GET REWARD',
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _timeUntilNextOpen() {
    final nextOpenTime = _lastOpenTime.add(Duration(hours: 24));
    final timeDifference = nextOpenTime.difference(DateTime.now());
    final hours = timeDifference.inHours;
    final minutes = (timeDifference.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (timeDifference.inSeconds % 60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }
}
