cask "multi-profile-for-claude" do
  version "0.1.0"
  sha256 "5206ce1bb8583575b85acb644355a11bc00c1c4e7cdac34827900746db0bd072"

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

  uninstall quit: "io.github.manhduc-nguyen.multiprofileforclaude"

  zap trash: [
    "~/Applications/Claude Profiles",
    "~/Library/Application Support/MultiProfileForClaude",
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
