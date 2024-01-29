import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Title text style
  static get titleLargeBold => theme.textTheme.titleLarge!.copyWith(
        fontFamily: 'AlfaSlabOne',
        fontWeight: FontWeight.w700,
      );

  static get titleMediumGray90001 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray90001,
      );

  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w900,
      );

  static get titleMediumWhiteA700Black => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray900,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w900,
      );

  static get titleMediumWhiteA700_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
