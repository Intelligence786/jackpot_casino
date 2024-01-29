import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: appTheme.primary,
        borderRadius: BorderRadius.circular(15),
      );

  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.7),
      );

  static BoxDecoration get fillPanel => BoxDecoration(
      color: appTheme.violet,
      border: Border.all(color: appTheme.green, width: 5),
      borderRadius: BorderRadius.circular(10));

  static BoxDecoration circleAround(bool isChoosed,{Color color = Colors.red} ) {
    return BoxDecoration(
      color: Colors.transparent,
      shape: BoxShape.circle,
      border: Border.all(color: isChoosed?color: Colors.grey, width: 3),
    );
  }

  static BoxDecoration circleButton() {
    return BoxDecoration(
      color: appTheme.primary,
      shape: BoxShape.circle,
      border: Border.all(color: appTheme.green, width: 3),
    );
  }

  static BoxDecoration get rouletteCircleGradient=> BoxDecoration(
    border: Border.all(color: appTheme.green, width: 5),
    shape: BoxShape.circle,
    gradient: LinearGradient(
      begin: Alignment(0.5, -1.8),
      end: Alignment(0.5, 1.8),
      //stops: [0, 0.8, 1], // Добавляем стопы
      colors: [
       appTheme.greenDarker, // Черный в начале
       appTheme.greenLight
      ],
    ),
  );

  static BoxDecoration get fillWhiteOnBoard => BoxDecoration(
      color: appTheme.whiteA700.withOpacity(0.7),
      borderRadius: BorderRadius.circular(10));

  static BoxDecoration get gradientVinetka => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, -1.8),
          end: Alignment(0.5, 1.8),
          //stops: [0, 0.8, 1], // Добавляем стопы
          colors: [
            Colors.black.withOpacity(1), // Черный в начале
           Colors.transparent, // Прозрачный в середине
            Colors.black.withOpacity(1), // Черный в конце
          ],
        ),
      );

  static BoxDecoration get gradientTealToGreen => BoxDecoration(
    color: appTheme.violet,
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
