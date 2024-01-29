import 'package:jackpot_casino/core/app_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? titleWidgets;
  final Widget? actionWidgets;

  const CustomAppBar({super.key, this.titleWidgets, this.actionWidgets});

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      forceMaterialTransparency: true,
      // title: Text('My Game'),
      title: titleWidgets,
      actions: [
        actionWidgets ?? Container(),
      ],
    );
  }
}
