import 'package:jackpot_casino/core/app_export.dart';
import 'package:jackpot_casino/widgets/custom_elevated_button.dart';

class SpinButtonPanel extends StatelessWidget {
  final Function? onTap;
  final String amountText;

  const SpinButtonPanel({super.key, this.onTap, required this.amountText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 150,
      decoration: AppDecoration.fillPanel,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'WIN',
              style: theme.textTheme.headlineMedium,
            ),
          ),
          Container(
            child: Text(amountText),
          ),
          CustomElevatedButton(
            decoration: AppDecoration.fillPrimary.copyWith(borderRadius: BorderRadius.circular(5)),
            text: 'SPIN',
            onPressed: () => onTap?.call(),
          ),
        ],
      ),
    );
  }
}
