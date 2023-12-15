import 'package:clock/clock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

@riverpod
Clock appClock(AppClockRef ref) => clock;
