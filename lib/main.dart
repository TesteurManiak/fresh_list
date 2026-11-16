import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/app.dart';
import 'package:todo_list/src/core/localization/locale_controller.dart';
import 'package:todo_list/src/core/theme/theme_controller.dart';
import 'package:todo_list/src/core/widgets/error_page.dart';
import 'package:todo_list/src/core/widgets/launch_failure_app.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  GoRouter.optionURLReflectsImperativeAPIs = true;

  try {
    await _init();

    final container = ProviderContainer();
    await Future.wait([
      container.read(localeControllerProvider.notifier).init(),
      container.read(themeControllerProvider.notifier).init(),
    ]);

    runApp(UncontrolledProviderScope(container: container, child: const App()));
  } catch (e, s) {
    log('launch failed', error: e, stackTrace: s, name: 'main');

    // Failure app, running without riverpod scope
    // ignore: riverpod_lint/missing_provider_scope
    runApp(const LaunchFailureApp());
  } finally {
    FlutterNativeSplash.remove();
  }
}

Future<void> _init() async {
  ErrorWidget.builder = (details) => AppErrorPage(details: details);

  await _precacheFonts();
}

Future<void> _precacheFonts() async {
  await GoogleFonts.pendingFonts([
    GoogleFonts.googleSans(fontWeight: .w400),
    GoogleFonts.googleSans(fontWeight: .w500),
    GoogleFonts.googleSans(fontWeight: .w700),
  ]);

  unawaited(_precacheOtherFonts());

  _registerFontsLicenses();
}

Future<void> _precacheOtherFonts() async {
  await GoogleFonts.pendingFonts([
    GoogleFonts.unbounded(fontWeight: .w600),
    GoogleFonts.unbounded(fontWeight: .w700),
    GoogleFonts.googleSansCode(fontWeight: .w500),
    GoogleFonts.googleSansCode(fontWeight: .w700),
    GoogleFonts.nanumPenScript(fontWeight: .w500),
  ]);
}

void _registerFontsLicenses() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}
