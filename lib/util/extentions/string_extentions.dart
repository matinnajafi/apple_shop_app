import 'dart:ui';

// convert String to Color ==> '1DB68B' to Color(0xff1DB68B)
extension ColorExtentions on String? {
  Color parseToColor() {
    String colorString = '0xff${this}';
    int hexColor = int.parse(colorString);

    return Color(hexColor);
  }
}
