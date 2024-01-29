import '../core/app_export.dart';
import '../game_data/player_stats.dart';
import 'reward_item.dart';

List<RewardItem> rewards = [
  RewardItem(
    name: 'Full Energy',
    icon: CustomImageView(
      imagePath: ImageConstant.imgContentBottle,
    ),
    effect: () {},
  ),
  RewardItem(
    name: 'Full Heat',
    icon: CustomImageView(
      imagePath: ImageConstant.imgContentCristall,
    ),
    effect: () {
      PlayerStats.incraseBalance(100);
    },
  ),
  RewardItem(
    name: 'Parrot',
    icon: CustomImageView(
      imagePath: ImageConstant.imgContentBomb,
    ),
    effect: () {},
  ),
  RewardItem(
    name: 'Oops!',
    icon: Align(
      alignment: Alignment.center,
      child: Text(
        'Nothing...',
        style: CustomTextStyles.titleMediumWhiteA700,
      ),
    ),
    effect: () {},
  ),
];

class SlotMachineRewardsPull {
  static bool getRewardItem(List<int> indexes) {
    int first = indexes[0];
    bool isReward = false;
    for (var index in indexes) {
      if (first == index) {
        isReward = true;
      } else {
        isReward = false;
        break;
      }
    }
    return isReward;
  }
}

class RuletteRewardsPull {
  static double getRewardItem(int indexe) {
    List<RewardItem> returnedItems = [
      rewards[2],
      rewards[0],
      rewards[1],
      rewards[0],
      rewards[1],
      rewards[2],
      rewards[0],
      rewards[2],
      rewards[0],
      rewards[1],
      rewards[2],
      rewards[0],
    ];

    List<double> rewardCount =[
      20,
      10000,
      0,
      1000,
      20,
      5000,
      0,
      12000,
      50,
      6000,
      0,
      0,
      50000
    ];
    return rewardCount[indexe];
  }
}
