class Pkpass < Formula
  include Language::Python::Virtualenv

  url "https://github.com/olcf/pkpass/archive/2.5.4.tar.gz"
  sha256 "eb7f1ab74cf69902f1a501e01c85c3cddf626aec5288c629be10f8a847872ad1"

  depends_on "libyaml"
  depends_on "openssl"
  depends_on "python"

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/66/6a/98e023b3d11537a5521902ac6b50db470c826c682be6a8c661549cb7717a/cffi-1.14.4.tar.gz"
    sha256 "1a465cbe98a7fd391d47dce4b8f7e5b921e6cd805ef421d04f5f66ba8f06086c"
  end

  resource "colored" do
    url "https://files.pythonhosted.org/packages/b2/16/04827e24c14266d9161bd86bad50069fea453fa006c3d2b31da39251184a/colored-1.4.2.tar.gz"
    sha256 "056fac09d9e39b34296e7618897ed1b8c274f98423770c2980d829fd670955ed"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/70/62/8c39b26e1944c68787b3cb6eac098e18236816074896bb8bcb205a629a6b/cryptography-3.3.tar.gz"
    sha256 "d9f1e520f2ee08c5a88e1ae0b31159bdb13da40a486bea3e9f7d338564850ea6"
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
    url "https://files.pythonhosted.org/packages/76/53/3b39e5ee6bdfa43447c4bb33adf5a93f467716e5df1ab1787cc39d8cf28f/pkpass-olcf-2.5.4.tar.gz"
    sha256 "aaa641f57d3e7d82621a279f0a63d26a79300e1946f0ed582108100aad839144"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/0f/86/e19659527668d70be91d0369aeaa055b4eb396b0f387a4f92293a20035bd/pycparser-2.20.tar.gz"
    sha256 "2d475327684562c3a96cc71adf7dc8c4f0565175cf86b6d7a404ff4c771f15f0"
  end

  resource "pyperclip" do
    url "https://files.pythonhosted.org/packages/6f/4c/0b1d507ad7e8bc31d690d04b4f475e74c2002d060f7994ce8c09612df707/pyperclip-1.8.1.tar.gz"
    sha256 "9abef1e79ce635eb62309ecae02dfb5a3eb952fa7d6dce09c1aef063f81424d3"
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
    url "https://files.pythonhosted.org/packages/5e/cd/0f69852c47aa0f89e3f6edbdbd043ec27173a006bc4990788822cc0239e0/pyseltongue-0.3.6.tar.gz"
    sha256 "631264b199965d78b0305cfd2a12e01ff3e4e660d0bec0aa88663b041eda0e55"
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
