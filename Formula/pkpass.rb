class Pkpass < Formula
  include Language::Python::Virtualenv

  url "https://github.com/olcf/pkpass/archive/2.1.0.tar.gz"
  sha256 "7ceaf0a78cbc3dadb93b8d85d1c9af3546d7029a15bf43b81058d8de728791d8"

  depends_on "libyaml"
  depends_on "openssl"
  depends_on "python"

  def install
    venv = virtualenv_create(libexec)
    venv.pip_install "-rrequirements.txt"
    venv.pip_install_and_link buildpath
  end
end
