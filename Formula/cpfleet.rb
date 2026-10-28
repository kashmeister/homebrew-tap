class Cpfleet < Formula
  desc "Manage several CircuitPython boards over Wi-Fi from the command line"
  homepage "https://github.com/kashmeister/cpfleet"
  url "https://github.com/kashmeister/cpfleet/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "04065d41a3c0ee87e051b78abb7924a8efde1dcfef1052803eff9aca800196aa"
  license "MIT"
  head "https://github.com/kashmeister/cpfleet.git", branch: "main"

  uses_from_macos "python"

  def install
    libexec.install "cpfleet"
    (bin/"cpfleet").write <<~SH
      #!/bin/bash
      PYTHONPATH="#{libexec}${PYTHONPATH:+:$PYTHONPATH}" exec python3 -m cpfleet "$@"
    SH
  end

  def caveats
    <<~EOS
      cpfleet talks to boards running CircuitPython's web workflow. Start with:
        cpfleet password        # the boards' CIRCUITPY_WEB_API_PASSWORD
        cpfleet add <board IP>  # it finds the other boards that one sees

      `cpfleet provision` and `cpfleet firmware` (setting up boards over USB) also need:
        brew install esptool mtools
      `cpfleet lib` needs circup (pipx install circup).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cpfleet --version")
    ENV["CPFLEET_HOME"] = (testpath/"config").to_s
    assert_match "no boards yet", shell_output("#{bin}/cpfleet ls")
  end
end
