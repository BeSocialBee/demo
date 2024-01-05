import 'dart:async';
import 'package:collectify/screens/home.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '/flutter_flow/flutter_flow_icon_button.dart';

class DailySpin extends StatefulWidget {
  DailySpin({Key? key}) : super(key: key);
  @override
  _DailySpinState createState() => _DailySpinState();
}

class _DailySpinState extends State<DailySpin> {
  late Future<Map<String, dynamic>> user;
  late StreamController<num> countdownStreamController =
      StreamController<num>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Close the stream controller when the widget is disposed
    countdownStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FortuneWheelPage();
  }
}

class FortuneWheelPage extends HookWidget {
  static const kRouteName = 'FortuneWheelPage';
  FortuneWheelPage({
    Key? key,
  }) : super(key: key);
  static void go(BuildContext context) {
    context.goNamed(kRouteName);
  }

  @override
  Widget build(BuildContext context) {
    final alignment = useState(Alignment.topCenter);
    final selected = useStreamController<int>();
    final selectedIndex = useStream(selected.stream, initialData: 0).data ?? 0;
    final isAnimating = useState(false);

    void handleRoll() {
      selected.add(
        roll(Constants.fortuneValues.length),
      );
    }

    return LayoutWithButton(
        selectedIndex: selectedIndex,
        isAnimating: isAnimating,
        alignment: alignment,
        selected: selected);
  }
}

class LayoutWithButton extends StatefulWidget {
  LayoutWithButton({
    super.key,
    required this.selectedIndex,
    required this.isAnimating,
    required this.alignment,
    required this.selected,
  });

  final int selectedIndex;
  final ValueNotifier<bool> isAnimating;
  final ValueNotifier<Alignment> alignment;
  final StreamController<int> selected;

  @override
  State<LayoutWithButton> createState() => _LayoutWithButtonState();
}

class _LayoutWithButtonState extends State<LayoutWithButton> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    void handleRoll() {
      Provider.of<BoolProvider>(context, listen: false).updateBoolValue(false);
      widget.selected.add(
        roll(Constants.fortuneValues.length),
      );
      Future.delayed(Duration(seconds: 3), () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('You luck one!'),
              content: Text(
                  'You won: ${Constants.fortuneValues[widget.selectedIndex]}'),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    }

    bool available = (widget.isAnimating.value ||
        !Provider.of<BoolProvider>(context).isSpinnable);
    return AppLayout(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 8),
            RollButtonWithPreview(
              selected: widget.selectedIndex,
              items: Constants.fortuneValues,
              onPressed: available ? null : handleRoll,
            ),
            Expanded(
              child: FortuneWheel(
                animateFirst: false,
                alignment: widget.alignment.value,
                selected: widget.selected.stream,
                onAnimationStart: () => widget.isAnimating.value = true,
                onAnimationEnd: () => widget.isAnimating.value = false,
                onFling: handleRoll,
                hapticImpact: HapticImpact.heavy,
                indicators: [
                  FortuneIndicator(
                    alignment: widget.alignment.value,
                    child: TriangleIndicator(),
                  ),
                ],
                items: [
                  for (var it in Constants.fortuneValues)
                    FortuneItem(child: Text(it), onTap: () => print(it))
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}

class LayoutWithTimer extends StatelessWidget {
  const LayoutWithTimer({
    super.key,
    required this.selectedIndex,
    required this.isAnimating,
    required this.alignment,
    required this.selected,
  });

  final int selectedIndex;
  final ValueNotifier<bool> isAnimating;
  final ValueNotifier<Alignment> alignment;
  final StreamController<int> selected;

  @override
  Widget build(BuildContext context) {
    void handleRoll() {
      selected.add(
        roll(Constants.fortuneValues.length),
      );
    }

    return AppLayout(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 8),
            //DailyCountdown(),
            SizedBox(height: 8),
            Expanded(
              child: FortuneWheel(
                animateFirst: false,
                alignment: alignment.value,
                selected: selected.stream,
                onAnimationStart: () => isAnimating.value = true,
                onAnimationEnd: () => isAnimating.value = false,
                onFling: handleRoll,
                hapticImpact: HapticImpact.heavy,
                indicators: [
                  FortuneIndicator(
                    alignment: alignment.value,
                    child: TriangleIndicator(),
                  ),
                ],
                items: [
                  for (var it in Constants.fortuneValues)
                    FortuneItem(child: Text(it), onTap: () => print(it))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyCountdown extends StatelessWidget {
  final StreamController<num> countdownStreamController;
  const DailyCountdown({
    super.key,
    required this.countdownStreamController,
  });
  String twoDigits(num n) {
    return n >= 10 ? "$n" : "0$n";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Closing in: ', style: TextStyle(fontSize: 18)),
        StreamBuilder<num>(
          stream: countdownStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              num secondsRemaining = snapshot.data!;
              num hours = secondsRemaining ~/ 3600;
              num minutes = (secondsRemaining % 3600) ~/ 60;
              num seconds = secondsRemaining % 60;

              return Text(
                '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}',
                style: TextStyle(fontSize: 18),
              );
            } else {
              return Container(); // Placeholder widget
            }
          },
        ),
      ],
    );
  }
}

class AppLayout extends StatelessWidget {
  final Widget child;

  const AppLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF14181B),
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF61ADFE),
        automaticallyImplyLeading: false,
        title: Text(
          'Card Details',
          textAlign: TextAlign.center,
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: child,
    );
  }
}

class Constants {
  static List<String> get fortuneValues => const <String>[
        '\$0',
        '\$50',
        '\$10',
        '\$20',
        '\$100',
        '\$5',
        '\$200',
        '\$70',
      ];
}

int roll(int itemCount) {
  return Random().nextInt(itemCount);
}

typedef IntCallback = void Function(int);

class RollButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const RollButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Roll'),
      onPressed: onPressed,
    );
  }
}

class RollButtonWithPreview extends StatelessWidget {
  final int selected;
  final List<String> items;
  final VoidCallback? onPressed;

  const RollButtonWithPreview({
    Key? key,
    required this.selected,
    required this.items,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: [
        RollButton(onPressed: onPressed),
      ],
    );
  }
}

// ======================================================================= //
typedef ThemeModeBuilder = Widget Function(BuildContext, ThemeMode);

abstract class ThemeModeProvider {
  ThemeMode get themeMode;

  void changeThemeMode(ThemeMode mode);

  static ThemeModeProvider of(BuildContext context) {
    final state = context.findAncestorStateOfType<_ThemeModeScopeState>();
    if (state == null) {
      throw Error();
    }
    return state;
  }
}

class ThemeModeScope extends StatefulWidget {
  final ThemeModeBuilder builder;

  const ThemeModeScope({required this.builder});

  @override
  _ThemeModeScopeState createState() => _ThemeModeScopeState();
}

class _ThemeModeScopeState extends State<ThemeModeScope>
    implements ThemeModeProvider {
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get themeMode => _mode;

  void changeThemeMode(ThemeMode mode) {
    setState(() {
      _mode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => widget.builder(context, _mode),
    );
  }
}

class KevlatusColors {
  static const MaterialColor blue =
      MaterialColor(_bluePrimaryValue, <int, Color>{
    50: Color(0xFFE7F0FC),
    100: Color(0xFFC3DBF8),
    200: Color(0xFF9BC3F4),
    300: Color(0xFF73AAF0),
    400: Color(0xFF5598EC),
    500: Color(_bluePrimaryValue),
    600: Color(0xFF317EE6),
    700: Color(0xFF2A73E3),
    800: Color(0xFF2369DF),
    900: Color(0xFF1656D9),
  });
  static const int _bluePrimaryValue = 0xFF3786E9;

  static const MaterialColor blueAccent =
      MaterialColor(_blueAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_blueAccentValue),
    400: Color(0xFFA4BFFF),
    700: Color(0xFF8BADFF),
  });
  static const int _blueAccentValue = 0xFFD7E3FF;

  static const MaterialColor gold =
      MaterialColor(_goldPrimaryValue, <int, Color>{
    50: Color(0xFFFCF3E7),
    100: Color(0xFFF8E2C4),
    200: Color(0xFFF4CE9D),
    300: Color(0xFFF0BA75),
    400: Color(0xFFECAC58),
    500: Color(_goldPrimaryValue),
    600: Color(0xFFE69534),
    700: Color(0xFFE38B2C),
    800: Color(0xFFDF8125),
    900: Color(0xFFD96F18),
  });
  static const int _goldPrimaryValue = 0xFFE99D3A;

  static const MaterialColor goldAccent =
      MaterialColor(_goldAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_goldAccentValue),
    400: Color(0xFFFFCBA6),
    700: Color(0xFFFFBC8C),
  });
  static const int _goldAccentValue = 0xFFFFE9D9;

  static const MaterialColor blueDark =
      MaterialColor(_blueDarkPrimaryValue, <int, Color>{
    50: Color(0xFFF3F8FE),
    100: Color(0xFFE1EDFC),
    200: Color(0xFFCDE1FA),
    300: Color(0xFFB9D5F7),
    400: Color(0xFFAACCF6),
    500: Color(_blueDarkPrimaryValue),
    600: Color(0xFF93BDF3),
    700: Color(0xFF89B5F1),
    800: Color(0xFF7FAEEF),
    900: Color(0xFF6DA1EC),
  });
  static const int _blueDarkPrimaryValue = 0xFF9BC3F4;

  static const MaterialColor blueDarkAccent =
      MaterialColor(_blueDarkAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_blueDarkAccentValue),
    400: Color(0xFFFCFDFF),
    700: Color(0xFFE3EEFF),
  });
  static const int _blueDarkAccentValue = 0xFFFFFFFF;
}

final ThemeData lightTheme = ThemeData.from(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: KevlatusColors.blue,
    accentColor: KevlatusColors.goldAccent,
    backgroundColor: Color(0xFFFAFAFA),
  ),
);

final ThemeData darkTheme = ThemeData.from(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: KevlatusColors.blueDark,
    accentColor: KevlatusColors.goldAccent,
    backgroundColor: Color(0xFF555555),
    brightness: Brightness.dark,
  ),
);
