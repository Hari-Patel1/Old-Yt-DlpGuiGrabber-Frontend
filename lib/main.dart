import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "home/logic/elements/settings_bloc.dart";
import "home/ui/pages/home_page.dart";
import "util.dart";
import "theme.dart";
import "home/logic/pages/home_bloc.dart";

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => SettingsBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Roboto", "DM Sans");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
