import 'package:jackpot_casino/game_data/player_stats.dart';
import 'package:jackpot_casino/widgets/custom_icon_button.dart';

import '../../../core/app_export.dart';

class BalancePanel extends StatefulWidget {
  final Function? plusTap;
  final Function? minusTap;

  const BalancePanel({super.key, this.plusTap, this.minusTap});

  @override
  State<BalancePanel> createState() => _BalancePanelState();
}

class _BalancePanelState extends State<BalancePanel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          onTap: () => widget.plusTap?.call(),
          height: 50,
          width: 50,
          decoration: AppDecoration.circleButton(),
          child: Center(
            child: Text(
              '+',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.h),
          height: 60.v,
          width: 200.h,
          decoration: AppDecoration.fillPrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'BALANCE',
                style: theme.textTheme.headlineMedium,
              ),
              Text(
                PlayerStats.balance.toStringAsFixed(0),
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        CustomIconButton(
          onTap: () => widget.minusTap?.call(),
          height: 50,
          width: 50,
          decoration: AppDecoration.circleButton(),
          child: Center(
              child: Text(
            '-',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontSize: 30, color: Colors.white),
          )),
        ),
      ],
    );
  }
}
