import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006b2a),
      surfaceTint: Color(0xff006e2c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff008737),
      onPrimaryContainer: Color(0xfff7fff2),
      secondary: Color(0xff36693e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb5eeb7),
      onSecondaryContainer: Color(0xff3b6d42),
      tertiary: Color(0xff006370),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2d7c89),
      onTertiaryContainer: Color(0xffebfbff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff4fcef),
      onSurface: Color(0xff161d16),
      onSurfaceVariant: Color(0xff3d4a3d),
      outline: Color(0xff6d7b6c),
      outlineVariant: Color(0xffbccab9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b322a),
      inversePrimary: Color(0xff5ae077),
      primaryFixed: Color(0xff78fd91),
      onPrimaryFixed: Color(0xff002108),
      primaryFixedDim: Color(0xff5ae077),
      onPrimaryFixedVariant: Color(0xff00531f),
      secondaryFixed: Color(0xffb8f0b9),
      onSecondaryFixed: Color(0xff002108),
      secondaryFixedDim: Color(0xff9dd49f),
      onSecondaryFixedVariant: Color(0xff1e5128),
      tertiaryFixed: Color(0xffa4eefd),
      onTertiaryFixed: Color(0xff001f24),
      tertiaryFixedDim: Color(0xff88d2e0),
      onTertiaryFixedVariant: Color(0xff004e59),
      surfaceDim: Color(0xffd4dcd0),
      surfaceBright: Color(0xfff4fcef),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeef6ea),
      surfaceContainer: Color(0xffe8f0e4),
      surfaceContainerHigh: Color(0xffe3ebde),
      surfaceContainerHighest: Color(0xffdde5d9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004016),
      surfaceTint: Color(0xff006e2c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff007e33),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff093f19),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff45784b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003c45),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff267784),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fcef),
      onSurface: Color(0xff0c130c),
      onSurfaceVariant: Color(0xff2d392d),
      outline: Color(0xff495648),
      outlineVariant: Color(0xff637162),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b322a),
      inversePrimary: Color(0xff5ae077),
      primaryFixed: Color(0xff007e33),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006326),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff45784b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2d5f35),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff267784),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff005e6a),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc1c9bd),
      surfaceBright: Color(0xfff4fcef),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeef6ea),
      surfaceContainer: Color(0xffe3ebde),
      surfaceContainerHigh: Color(0xffd7dfd3),
      surfaceContainerHighest: Color(0xffccd4c8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003411),
      surfaceTint: Color(0xff006e2c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff005520),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003411),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff20532a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003138),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff00515c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fcef),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff232f23),
      outlineVariant: Color(0xff404c3f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b322a),
      inversePrimary: Color(0xff5ae077),
      primaryFixed: Color(0xff005520),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003c14),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff20532a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff043b16),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff00515c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003940),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb3bbb0),
      surfaceBright: Color(0xfff4fcef),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffebf3e7),
      surfaceContainer: Color(0xffdde5d9),
      surfaceContainerHigh: Color(0xffcfd7cb),
      surfaceContainerHighest: Color(0xffc1c9bd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff5ae077),
      surfaceTint: Color(0xff5ae077),
      onPrimary: Color(0xff003913),
      primaryContainer: Color(0xff04a747),
      onPrimaryContainer: Color(0xff00300f),
      secondary: Color(0xff9dd49f),
      onSecondary: Color(0xff013913),
      secondaryContainer: Color(0xff1e5128),
      onSecondaryContainer: Color(0xff8cc28f),
      tertiary: Color(0xff88d2e0),
      onTertiary: Color(0xff00363e),
      tertiaryContainer: Color(0xff2d7c89),
      onTertiaryContainer: Color(0xffebfbff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e150e),
      onSurface: Color(0xffdde5d9),
      onSurfaceVariant: Color(0xffbccab9),
      outline: Color(0xff879485),
      outlineVariant: Color(0xff3d4a3d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde5d9),
      inversePrimary: Color(0xff006e2c),
      primaryFixed: Color(0xff78fd91),
      onPrimaryFixed: Color(0xff002108),
      primaryFixedDim: Color(0xff5ae077),
      onPrimaryFixedVariant: Color(0xff00531f),
      secondaryFixed: Color(0xffb8f0b9),
      onSecondaryFixed: Color(0xff002108),
      secondaryFixedDim: Color(0xff9dd49f),
      onSecondaryFixedVariant: Color(0xff1e5128),
      tertiaryFixed: Color(0xffa4eefd),
      onTertiaryFixed: Color(0xff001f24),
      tertiaryFixedDim: Color(0xff88d2e0),
      onTertiaryFixedVariant: Color(0xff004e59),
      surfaceDim: Color(0xff0e150e),
      surfaceBright: Color(0xff343b33),
      surfaceContainerLowest: Color(0xff091009),
      surfaceContainerLow: Color(0xff161d16),
      surfaceContainer: Color(0xff1a211a),
      surfaceContainerHigh: Color(0xff252c24),
      surfaceContainerHighest: Color(0xff2f372f),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff72f78b),
      surfaceTint: Color(0xff5ae077),
      onPrimary: Color(0xff002d0d),
      primaryContainer: Color(0xff04a747),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb2eab4),
      onSecondary: Color(0xff002d0d),
      secondaryContainer: Color(0xff689d6c),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff9ee8f7),
      onTertiary: Color(0xff002a31),
      tertiaryContainer: Color(0xff519ba9),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e150e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd2e0ce),
      outline: Color(0xffa8b6a5),
      outlineVariant: Color(0xff869484),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde5d9),
      inversePrimary: Color(0xff005420),
      primaryFixed: Color(0xff78fd91),
      onPrimaryFixed: Color(0xff001504),
      primaryFixedDim: Color(0xff5ae077),
      onPrimaryFixedVariant: Color(0xff004016),
      secondaryFixed: Color(0xffb8f0b9),
      onSecondaryFixed: Color(0xff001504),
      secondaryFixedDim: Color(0xff9dd49f),
      onSecondaryFixedVariant: Color(0xff093f19),
      tertiaryFixed: Color(0xffa4eefd),
      onTertiaryFixed: Color(0xff001418),
      tertiaryFixedDim: Color(0xff88d2e0),
      onTertiaryFixedVariant: Color(0xff003c45),
      surfaceDim: Color(0xff0e150e),
      surfaceBright: Color(0xff3f463e),
      surfaceContainerLowest: Color(0xff040904),
      surfaceContainerLow: Color(0xff181f18),
      surfaceContainer: Color(0xff222a22),
      surfaceContainerHigh: Color(0xff2d352c),
      surfaceContainerHighest: Color(0xff384037),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc2ffc4),
      surfaceTint: Color(0xff5ae077),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff56dc74),
      onPrimaryContainer: Color(0xff000f02),
      secondary: Color(0xffc5fec6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff99d09b),
      onSecondaryContainer: Color(0xff000f02),
      tertiary: Color(0xffd0f7ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff84cedc),
      onTertiaryContainer: Color(0xff000d11),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0e150e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe6f4e2),
      outlineVariant: Color(0xffb8c7b5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde5d9),
      inversePrimary: Color(0xff005420),
      primaryFixed: Color(0xff78fd91),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff5ae077),
      onPrimaryFixedVariant: Color(0xff001504),
      secondaryFixed: Color(0xffb8f0b9),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff9dd49f),
      onSecondaryFixedVariant: Color(0xff001504),
      tertiaryFixed: Color(0xffa4eefd),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff88d2e0),
      onTertiaryFixedVariant: Color(0xff001418),
      surfaceDim: Color(0xff0e150e),
      surfaceBright: Color(0xff4a5249),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1a211a),
      surfaceContainer: Color(0xff2b322a),
      surfaceContainerHigh: Color(0xff363d35),
      surfaceContainerHighest: Color(0xff414940),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
