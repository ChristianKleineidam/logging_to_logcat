## Development Setup

Run `tool/setup.sh` to install Flutter (if necessary) and fetch this package's
dependencies before executing tests or examples:

```bash
bash tool/setup.sh
```

# Maintainer Guidelines

The iOS plugin sources under `ios/` are intentionally unused. The `pubspec.yaml` declares only an Android plugin, making this package Android-only.

Contributors should leave the iOS code untouched and **avoid adding an iOS entry** to `pubspec.yaml` unless actively developing iOS support.
