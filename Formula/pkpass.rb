class Pkpass < Formula
  include Language::Python::Virtualenv

  url "https://github.com/olcf/pkpass/archive/2.0.1.tar.gz"
  sha256 "ebe793b2c2a3e521befd152864466fdfa5078d945ef1fa7972ac75ef7e31e09c"

  depends_on "libyaml"
  depends_on "openssl"
  depends_on "python"

  def install
    venv = virtualenv_create(libexec)
    venv.pip_install "-rrequirements.txt"
    venv.pip_install_and_link buildpath
  end
end
