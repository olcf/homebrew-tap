class Pkpass < Formula
  include Language::Python::Virtualenv

  url "https://github.com/olcf/pkpass/archive/2.6.0.tar.gz"
  sha256 "cde8d06dfcee955c7398fe0bf07c1240e58994bac967de289ed6e2972a703d37"

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
    url "https://files.pythonhosted.org/packages/b7/82/f7a4ddc1af185936c1e4fa000942ffa8fb2d98cff26b75afa7b3c63391c4/cryptography-3.3.1.tar.gz"
    sha256 "7e177e4bea2de937a584b13645cab32f25e3d96fc0bc4a4cf99c27dc77682be6"
  end

  resource "exrex" do
    url "https://files.pythonhosted.org/packages/68/5a/1f0940e6bc490825bab1d3e9441cd90f6a27d1c6022db1b12772f38de04b/exrex-0.10.5.tar.gz"
    sha256 "3fb8b18fd9832eaff8b13dc042a4f63b13c5d684ee069f70a23ddfc6bcb708f3"
  end

  resource "pem" do
    url "https://files.pythonhosted.org/packages/ae/f8/43fd26ac249cf81350d4d5a68b18fa51e158b93476f7fa5e2f653865ecf4/pem-21.1.0.tar.gz"
    sha256 "dddbc395740ed3fcd2940068d190e7071e8b12a9d57b76a2f080e7ca8397b310"
  end

  resource "pkpass-olcf" do
    url "https://files.pythonhosted.org/packages/2a/09/e251b583f8f688bdaca19e04b3cac27a962f302ca4e14a10bff9ebc44525/pkpass-olcf-2.6.0.tar.gz"
    sha256 "f8c623fd632365df9814fb4f164c638478a3cf688758379d038c66e631f801eb"
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
    url "https://files.pythonhosted.org/packages/a0/a4/d63f2d7597e1a4b55aa3b4d6c5b029991d3b824b5bd331af8d4ab1ed687d/PyYAML-5.4.1.tar.gz"
    sha256 "607774cbba28732bfa802b54baa7484215f530991055bb562efbed5b2f20a45e"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz"
    sha256 "30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259"
  end

  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/69/50/9f29874d835945b845812799edc732ba30c41e9d20431f9f69c8ffb9c670/tqdm-4.56.0.tar.gz"
    sha256 "fe3d08dd00a526850568d542ff9de9bbc2a09a791da3c334f3213d8d0bbbca65"
  end

  resource "utilitybelt" do
    url "https://files.pythonhosted.org/packages/ab/31/343ef1df18ffe822f02b4ca879d1f406275d3187040ac724bcf9158e4669/utilitybelt-0.2.6.tar.gz"
    sha256 "dafdb6a2dbb32e71d67a9cd35afd7c2e4993ec094e7ddb547df4cf46788770a4"
  end

  resource "pyseltongue" do
    url "https://files.pythonhosted.org/packages/c2/a7/c04f531ea1144cfe1c40a0ff1d6a9885cb7142466f481d59653c219a81a8/pyseltongue-1.0.0.tar.gz"
    sha256 "6975d656214d3524b3ede9f204daa77a81ce686f8ae45f78b841ef23f23cf5d6"
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
