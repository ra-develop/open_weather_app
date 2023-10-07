import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../services/utils/hex_to_color.dart';

class WaitingViewArgs {
  final Duration? duration;
  final String? message;
  final Widget? infoIcon;
  final bool linearMode;

  WaitingViewArgs({
    this.message,
    this.duration,
    this.infoIcon,
    this.linearMode = false,
  });
}

class WaitingView extends HookWidget {
  const WaitingView({
    Key? key,
    this.message,
    this.duration,
    this.infoIcon,
    this.linearMode = false,
  }) : super(key: key);

  final Duration? duration;
  final String? message;
  final Widget? infoIcon;
  final bool linearMode;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: HexColor("#F31753"));
    final total = duration?.inSeconds ?? 1;
    final step = 1 / (total == 0 ? 1 : total);
    final counter = useState(0.0);
    final controller = useAnimationController(
        duration: duration ?? const Duration(seconds: 1));
    controller.stop();
    controller.addListener(() {
      counter.value = controller.value;
    });
    controller.forward();
    if (message != null) {
      developer.log(message!, name: "WaitingView");
    }
    // controller.repeat(reverse: true);
    return Scaffold(
      body: Visibility(
        visible: !linearMode,
        replacement: Container(
          height: 60,
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 5,
            child: LinearProgressIndicator(
              value: (duration != null && duration != Duration.zero)
                  ? counter.value
                  : null,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: (duration == null || counter.value <= 1)
                  ? infoIcon != null
                      ? SizedBox(
                          width: 50,
                          height: 50,
                          child: infoIcon,
                        )
                      : Text(
                          "",
                          style: textStyle,
                        )
                  : Text(
                      ((total - counter.value / step) + 1).toInt().toString(),
                      style: textStyle),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: (duration != null && duration != Duration.zero)
                      ? counter.value
                      : null,
                  // semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.2),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  message != null ? message.toString() : '',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // )
          ],
        ),
      ),
    );
  }
}
