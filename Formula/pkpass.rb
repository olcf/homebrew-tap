class Pkpass < Formula
  include Language::Python::Virtualenv

  url "https://github.com/olcf/pkpass/archive/2.4.6.tar.gz"
  sha256 "30af211678815fd5768adb4d620b8ea289844bbc5eca17fc7c13ef21c859801d"

  depends_on "libyaml"
  depends_on "openssl"
  depends_on "python"

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/f7/09/88bbe20b76ca76be052c366fe77aa5e3cd6e5f932766e5597fecdd95b2a8/cffi-1.14.2.tar.gz"
    sha256 "ae8f34d50af2c2154035984b8b5fc5d9ed63f32fe615646ab435b05b132ca91b"
  end

  resource "colored" do
    url "https://files.pythonhosted.org/packages/b2/16/04827e24c14266d9161bd86bad50069fea453fa006c3d2b31da39251184a/colored-1.4.2.tar.gz"
    sha256 "056fac09d9e39b34296e7618897ed1b8c274f98423770c2980d829fd670955ed"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/bf/ac/552fc8729d90393845cc3a2062facf4a89dcbe206fa78771d60ddaae7554/cryptography-3.0.tar.gz"
    sha256 "8e924dbc025206e97756e8903039662aa58aa9ba357d8e1d8fc29e3092322053"
  end

  resource "exrex" do
    url "https://files.pythonhosted.org/packages/68/5a/1f0940e6bc490825bab1d3e9441cd90f6a27d1c6022db1b12772f38de04b/exrex-0.10.5.tar.gz"
    sha256 "3fb8b18fd9832eaff8b13dc042a4f63b13c5d684ee069f70a23ddfc6bcb708f3"
  end

  resource "pem" do
    url "https://files.pythonhosted.org/packages/36/bb/c761f992d2982320ccf5e8ffd57c4997a53beaa3af706bb4129e406c822e/pem-20.1.0.tar.gz"
    sha256 "2763631a5ffe55f1f21fa34abafdba174a8eeb670d84f66dcfd7a523b44608f6"
  end

  resource "pkpass-olcf" do
    url "https://files.pythonhosted.org/packages/b1/64/6a3430ccd92f8940e17c36a169fd45eef2929284fc10a74831dd42a28eb7/pkpass-olcf-2.4.6.tar.gz"
    sha256 "8f7571ee8ccfcdda206218d8b8647448b040b738bae1191827cf7a5110421f4a"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/0f/86/e19659527668d70be91d0369aeaa055b4eb396b0f387a4f92293a20035bd/pycparser-2.20.tar.gz"
    sha256 "2d475327684562c3a96cc71adf7dc8c4f0565175cf86b6d7a404ff4c771f15f0"
  end

  resource "pyperclip" do
    url "https://files.pythonhosted.org/packages/f6/5b/55866e1cde0f86f5eec59dab5de8a66628cb0d53da74b8dbc15ad8dabda3/pyperclip-1.8.0.tar.gz"
    sha256 "b75b975160428d84608c26edba2dec146e7799566aea42c1fe1b32e72b6028f2"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/be/ed/5bbc91f03fa4c839c4c7360375da77f9659af5f7086b7a7bdda65771c8e0/python-dateutil-2.8.1.tar.gz"
    sha256 "73ebfe9dbf22e832286dafa60473e4cd239f8592f699aa5adaf10050e6e1823c"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/64/c2/b80047c7ac2478f9501676c988a5411ed5572f35d1beff9cae07d321512c/PyYAML-5.3.1.tar.gz"
    sha256 "b8eac752c5e14d3eca0e6dd9199cd627518cb5ec06add0de9d32baeee6fe645d"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz"
    sha256 "30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259"
  end

  resource "utilitybelt" do
    url "https://files.pythonhosted.org/packages/ab/31/343ef1df18ffe822f02b4ca879d1f406275d3187040ac724bcf9158e4669/utilitybelt-0.2.6.tar.gz"
    sha256 "dafdb6a2dbb32e71d67a9cd35afd7c2e4993ec094e7ddb547df4cf46788770a4"
  end

  resource "pyseltongue" do
    url "https://files.pythonhosted.org/packages/d0/f5/3b656493616752c2edff15e3103cc0a1393d1a43f30a8aea33b39f172e45/pyseltongue-0.3.5.tar.gz"
    sha256 "61d547d089c84a87ec8a757e75909d39b892dad9dac9d34d5cf77272ed1fb5cb"
  end

  def install
    ENV.prepend_path "PATH", Formula["python"].opt_libexec/"bin"
    ENV["SDKROOT"] = MacOS.sdk_path if MacOS.version <= :sierra
    ENV.append_to_cflags "-fno-stack-check" if DevelopmentTools.clang_build_version >= 1010
    ENV.prepend "CPPFLAGS", "-I#{MacOS.sdk_path}/usr/include/ffi"

    venv = virtualenv_create(libexec, "python3")
    venv.pip_install_and_link buildpath
    virtualenv_install_with_resources
  end
end
