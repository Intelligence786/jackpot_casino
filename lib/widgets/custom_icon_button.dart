import '../core/app_export.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
    this.radius,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final double? radius;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: Container(
          height: height ?? 0,
          width: width ?? 0,
          decoration: decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 0),
              ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              customBorder: const CircleBorder(),
              child: Container(

                padding: padding ?? EdgeInsets.zero,

                child: child,
              ),
              onTap: onTap,
            ),
          ),
        ),
      );
}
