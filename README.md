# Homebrew tap

Homebrew casks for my Mac apps.

## Multi Profile for Claude

Run several Claude desktop accounts side by side on your Mac. Source and details: [cheesepulab/multi-profile-for-claude](https://github.com/cheesepulab/multi-profile-for-claude).

```bash
brew install --cask manhduc-nguyen/tap/multi-profile-for-claude
```

Update with `brew upgrade --cask multi-profile-for-claude`, remove with `brew uninstall --cask multi-profile-for-claude` (add `--zap` to also delete profile apps and their data).

## About the quarantine step

The app is free and isn't notarized by Apple, so its cask clears macOS's download quarantine flag after installing. That one `xattr` command, in `postflight_steps` in [`Casks/multi-profile-for-claude.rb`](Casks/multi-profile-for-claude.rb), is the only command this tap runs. Read the cask before installing if you want to check.
