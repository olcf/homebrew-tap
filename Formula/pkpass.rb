class Pkpass < Formula
  include Language::Python::Virtualenv

  url "https://github.com/olcf/pkpass/archive/2.1.1.tar.gz"
  sha256 "e063e160b73773f963d0e9e634070a99010fb694e9595ee745447c2bda0714c5"

  depends_on "libyaml"
  depends_on "openssl"
  depends_on "python"

  def install
    venv = virtualenv_create(libexec)
    venv.pip_install "-rrequirements.txt"
    venv.pip_install_and_link buildpath
  end
end
