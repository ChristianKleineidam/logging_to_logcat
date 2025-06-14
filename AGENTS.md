## Development Setup

Run `tool/setup.sh` to install Flutter (if necessary) and fetch this package's
dependencies before executing tests or examples:

```bash
bash tool/setup.sh
```

**Note**: Install all required software during this setup step. Network access
available when `tool/setup.sh` runs may not be granted later in the workflow.

# Maintainer Guidelines

The iOS plugin sources under `ios/` are intentionally unused. The `pubspec.yaml` declares only an Android plugin, making this package Android-only.

Contributors should leave the iOS code untouched and **avoid adding an iOS entry** to `pubspec.yaml` unless actively developing iOS support.
