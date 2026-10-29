cask "gitlab-client-for-mac" do
  version "0.1.0"
  sha256 "70ae95e5e12bb78c8d34f6597bb2072323d206bdce1a029d7e59e57954fc0fef"

  url "https://github.com/cheesepulab/gitlab-client-for-mac/releases/download/v#{version}/GitLab-Client-#{version}.zip"
  name "GitLab Client"
  desc "Native client for GitLab servers whose web UI you can't reach"
  homepage "https://github.com/cheesepulab/gitlab-client-for-mac"

  depends_on macos: :sonoma

  app "GitLab Client.app"

  # The app is not notarized by Apple, so clear the download quarantine flag.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/GitLab Client.app"],
        must_succeed: false
  end

  uninstall quit: "io.github.cheesepulab.gitlabclient"

  zap trash: [
    "~/Library/Application Support/GitLabClient",
    "~/Library/Caches/GitLabClient",
    "~/Library/Preferences/io.github.cheesepulab.gitlabclient.plist",
  ]

  caveats <<~EOS
    GitLab Client is not notarized by Apple, so this cask removes the
    download quarantine flag after installing it.

    Your GitLab tokens are kept in the macOS Keychain and are not removed by
    `brew uninstall --zap`. Sign out or revoke them in Settings → Domains first,
    or delete the "io.github.cheesepulab.gitlabclient" items in Keychain Access.
  EOS
end
