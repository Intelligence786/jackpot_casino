import '../../../core/app_export.dart';

class InformationPanel extends StatelessWidget {
  final String? headerText;
  final Widget insideContent;

  const InformationPanel(
      {Key? key, this.headerText, required this.insideContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.v,
      width: 400.h,
      child: Stack(
        children: [
          Container(
            // width: 388.h,
            padding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 14.v,
            ),

            child: Container(

                child: Center(child: insideContent)),
          ),
        ],
      ),
    );
  }
}
