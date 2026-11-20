import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:fresh_list/app.dart';
import 'package:fresh_list/gen/assets.gen.dart';
import 'package:fresh_list/src/core/localization/locale_controller.dart';
import 'package:fresh_list/src/core/theme/color_scheme_seed_controller.dart';
import 'package:fresh_list/src/core/theme/theme_controller.dart';
import 'package:fresh_list/src/core/widgets/error_page.dart';
import 'package:fresh_list/src/core/widgets/launch_failure_app.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main({List<Override> overrides = const []}) async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  GoRouter.optionURLReflectsImperativeAPIs = true;

  try {
    await _init();

    final container = ProviderContainer(overrides: overrides);
    await Future.wait([
      container.read(localeControllerProvider.notifier).init(),
      container.read(themeControllerProvider.notifier).init(),
      container.read(colorPresetControllerProvider.notifier).init(),
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
  // First one to be displayed, so we precache it immediately.
  await GoogleFonts.pendingFonts([
    GoogleFonts.googleSans(fontWeight: .w400),
    GoogleFonts.googleSans(fontWeight: .w500),
    GoogleFonts.googleSans(fontWeight: .w700),
    GoogleFonts.roboto(fontWeight: .w400),
    GoogleFonts.unbounded(fontWeight: .w600),
    GoogleFonts.unbounded(fontWeight: .w700),
  ]);

  // Precache other fonts asynchronously.
  unawaited(_precacheOtherFonts());

  _registerFontsLicenses();
}

Future<void> _precacheOtherFonts() async {
  await GoogleFonts.pendingFonts([
    GoogleFonts.googleSansCode(fontWeight: .w500),
    GoogleFonts.googleSansCode(fontWeight: .w700),
  ]);
}

void _registerFontsLicenses() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(AppAssets.googleFontsOFL);
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}
