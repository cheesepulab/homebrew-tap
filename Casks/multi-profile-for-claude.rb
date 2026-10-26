cask "multi-profile-for-claude" do
  version "0.1.1"
  sha256 "ddafbe8735c2b2bc8c04da7f0c9a6fd9d58c004aa10ce7538b319432c9d6e423"

  url "https://github.com/cheesepulab/multi-profile-for-claude/releases/download/v#{version}/Multi-Profile-for-Claude-#{version}.zip"
  name "Multi Profile for Claude"
  desc "Run several Claude desktop accounts side by side"
  homepage "https://github.com/cheesepulab/multi-profile-for-claude"

  depends_on macos: :ventura

  app "Multi Profile for Claude.app"

  # The app is not notarized by Apple, so clear the download quarantine flag.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Multi Profile for Claude.app"],
        must_succeed: false
  end

  # Also the bundle ID that builds before 0.1.1 used.
  uninstall quit: [
    "io.github.cheesepulab.multiprofileforclaude",
    "io.github.manhduc-nguyen.multiprofileforclaude",
  ]

  zap trash: [
    "~/Applications/Claude Profiles",
    "~/Library/Application Support/MultiProfileForClaude",
    "~/Library/Preferences/io.github.cheesepulab.multiprofileforclaude.plist",
    "~/Library/Preferences/io.github.manhduc-nguyen.multiprofileforclaude.plist",
  ]

  caveats <<~EOS
    Multi Profile for Claude is not notarized by Apple, so this cask removes the
    download quarantine flag after installing it.

    `brew uninstall --zap` also removes your profile apps and their data.
    Terminal commands such as claude-work are removed by the app
    (Profiles → Remove All Profiles…) or can be deleted from ~/.local/bin.
  EOS
end
