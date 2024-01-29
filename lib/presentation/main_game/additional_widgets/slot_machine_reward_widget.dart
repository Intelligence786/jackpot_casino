import 'package:jackpot_casino/core/app_export.dart';

import '../../../game_components/reward_item.dart';
import '../game_bloc/game_bloc.dart';
import 'information_panel.dart';

class SlotMachineRewardWidget extends StatelessWidget {
  final RewardItem rewardItem;

  const SlotMachineRewardWidget({Key? key, required this.rewardItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(

        //padding: EdgeInsets.only(top: 100.h),
        height: 150.h,
        width: 150.h,

      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: AppDecoration.fillPrimary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: InformationPanel(
                    headerText: rewardItem.name,
                    insideContent: rewardItem.icon,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
