class Mactouch < Formula
  desc "Touchscreen driver for macOS: makes USB touch screen monitors work on a Mac"
  homepage "https://github.com/kashmeister/mactouch"
  url "https://github.com/kashmeister/mactouch/archive/refs/tags/v3.3.0.tar.gz"
  sha256 "6951f6383d217e93045372d3be0aec14aac8f5faa1ab881cc0b25293b8ddc998"
  license "MIT"
  head "https://github.com/kashmeister/mactouch.git", branch: "main"

  depends_on macos: :ventura

  def install
    system "./build.sh"
    prefix.install "build/MacTouch.app"
    (bin/"mactouch").write <<~SH
      #!/bin/bash
      exec "#{opt_prefix}/MacTouch.app/Contents/MacOS/MacTouch" "$@"
    SH
  end

  service do
    run [opt_prefix/"MacTouch.app/Contents/MacOS/MacTouch"]
    keep_alive successful_exit: false
    process_type :interactive
    log_path "#{Dir.home}/Library/Logs/MacTouch.log"
    error_log_path "#{Dir.home}/Library/Logs/MacTouch.log"
  end

  def caveats
    <<~EOS
      Start MacTouch now and at every login:
        brew services start mactouch

      Then enable MacTouch in System Settings > Privacy & Security under both
      Input Monitoring and Accessibility. If it is not listed, add
        #{opt_prefix}/MacTouch.app
      with the + button. The grants survive upgrades.

      `mactouch --check` lists the touch screens MacTouch sees; `mactouch --help` lists its options.
      Don't also run the copy that ./install.sh installs from a source checkout.
    EOS
  end

  test do
    assert_match "self-test passed", shell_output("#{bin}/mactouch --self-test")
  end
end
