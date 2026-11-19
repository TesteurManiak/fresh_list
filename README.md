<p align="center">
  <img src="docs/icon.png" alt="FreshList app icon" width="128">
</p>

<h1 align="center">FreshList</h1>

<p align="center">A Flutter application to manage your grocery list.</p>

<p align="center">
  <img src="https://img.shields.io/github/license/TesteurManiak/fresh_list" alt="GitHub License">
  <a href="https://github.com/TesteurManiak/fresh_list/actions/workflows/release-apk.yml"><img src="https://github.com/TesteurManiak/fresh_list/actions/workflows/release-apk.yml/badge.svg" alt="Build & Release Signed APK"></a>
</p>

## Screenshots

| Home | Add an entry | Settings |
| --- | --- | --- |
| <img src="docs/screenshots/home-with-entry.png" alt="Home screen" width="250"> | <img src="docs/screenshots/add-entry.png" alt="Add an entry" width="250"> | <img src="docs/screenshots/settings.png" alt="Settings" width="250"> |

| Language switcher | French | Dark theme |
| --- | --- | --- |
| <img src="docs/screenshots/language-switcher.png" alt="Language switcher" width="250"> | <img src="docs/screenshots/settings-fr.png" alt="Settings in French" width="250"> | <img src="docs/screenshots/settings-dark.png" alt="Settings in dark theme" width="250"> |

The screenshots are generated with Flutter Driver on a booted iOS simulator:

```sh
flutter drive \
  --driver=test_driver/screenshots.dart \
  --target=test_driver/app.dart \
  -d <simulator id>
```

## Generate localizations

```sh
flutter gen-l10n
```

## Precompile SVGs

```sh
dart run vector_graphics_compiler \
  --input-dir assets/icons/svg/raw \
  --out-dir assets/icons/svg/precompiled
```

Then run `build_runner` to generate the appropriate accessors.

## TODOs

* Improve Material 3 Expressive UI
  - Add/Edit entry sheet
* Manage multiple lists
* Collaborative list edition with [Nearby Connections](https://developers.google.com/nearby/connections/overview)
* In-app updates

## Credits

* [Expressive components](https://github.com/kamranbekirovyz/bunpod/tree/main/packages) from [Kamran Bekirov](https://github.com/kamranbekirovyz)

