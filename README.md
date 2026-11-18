<p align="center">
  <img src="docs/icon.png" alt="FreshList app icon" width="128">
</p>

<h1 align="center">FreshList</h1>

<p align="center">A Flutter application to manage your grocery list.</p>

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

## Precompile SVGs

```sh
dart run vector_graphics_compiler \
  --input-dir assets/icons/svg/raw \
  --out-dir assets/icons/svg/precompiled
```

## TODO

* Manage multiple lists
* Improve Material 3 Expressive UI
  - Add/Edit entry sheet
