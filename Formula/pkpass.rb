class Pkpass < Formula
  include Language::Python::Virtualenv

  url "https://github.com/olcf/pkpass/archive/2.6.5.tar.gz"
  sha256 "0bf1f4f2b6ef955a1c48324958ce4a90e20fabcc61eb3c6b09e94ed93cee8fed"

  depends_on "libyaml"
  depends_on "openssl"
  depends_on "python"
  depends_on "rust" => :build

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/2e/92/87bb61538d7e60da8a7ec247dc048f7671afe17016cd0008b3b710012804/cffi-1.14.6.tar.gz"
    sha256 "c9a875ce9d7fe32887784274dd533c57909b7b1dcadcc128a2ac21331a9765dd"
  end

  resource "colored" do
    url "https://files.pythonhosted.org/packages/b2/16/04827e24c14266d9161bd86bad50069fea453fa006c3d2b31da39251184a/colored-1.4.2.tar.gz"
    sha256 "056fac09d9e39b34296e7618897ed1b8c274f98423770c2980d829fd670955ed"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/9b/77/461087a514d2e8ece1c975d8216bc03f7048e6090c5166bc34115afdaa53/cryptography-3.4.7.tar.gz"
    sha256 "3d10de8116d25649631977cb37da6cbdd2d6fa0e0281d014a5b7d337255ca713"
  end

  resource "exrex" do
    url "https://files.pythonhosted.org/packages/68/5a/1f0940e6bc490825bab1d3e9441cd90f6a27d1c6022db1b12772f38de04b/exrex-0.10.5.tar.gz"
    sha256 "3fb8b18fd9832eaff8b13dc042a4f63b13c5d684ee069f70a23ddfc6bcb708f3"
  end

  resource "mock" do
    url "https://files.pythonhosted.org/packages/e2/be/3ea39a8fd4ed3f9a25aae18a1bff2df7a610bca93c8ede7475e32d8b73a0/mock-4.0.3.tar.gz"
    sha256 "7d3fbbde18228f4ff2f1f119a45cdffa458b4c0dee32eb4d2bb2f82554bac7bc"
  end

  resource "pem" do
    url "https://files.pythonhosted.org/packages/48/57/78c8edb8a241fe2ae8f19bc7d5fe73c2f23e648fd38408e821fb6929f784/pem-21.2.0.tar.gz"
    sha256 "c491833b092662626fd58a87375d450637d4ee94996ad9bbbd42593428e93e5a"
  end

  resource "pkpass-olcf" do
    url "https://files.pythonhosted.org/packages/da/9a/eba062609cdab506c3411ebc6da573bf0c91b65115b5302a98159e03eb7a/pkpass-olcf-2.6.5.tar.gz"
    sha256 "9b0aa6cbc5ecd805042f71aaeaca31275d43140f5908d468f9d466aaaa0b94fc"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/0f/86/e19659527668d70be91d0369aeaa055b4eb396b0f387a4f92293a20035bd/pycparser-2.20.tar.gz"
    sha256 "2d475327684562c3a96cc71adf7dc8c4f0565175cf86b6d7a404ff4c771f15f0"
  end

  resource "pyperclip" do
    url "https://files.pythonhosted.org/packages/a7/2c/4c64579f847bd5d539803c8b909e54ba087a79d01bb3aba433a95879a6c5/pyperclip-1.8.2.tar.gz"
    sha256 "105254a8b04934f0bc84e9c24eb360a591aaf6535c9def5f29d92af107a9bf57"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/be/ed/5bbc91f03fa4c839c4c7360375da77f9659af5f7086b7a7bdda65771c8e0/python-dateutil-2.8.1.tar.gz"
    sha256 "73ebfe9dbf22e832286dafa60473e4cd239f8592f699aa5adaf10050e6e1823c"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/a0/a4/d63f2d7597e1a4b55aa3b4d6c5b029991d3b824b5bd331af8d4ab1ed687d/PyYAML-5.4.1.tar.gz"
    sha256 "607774cbba28732bfa802b54baa7484215f530991055bb562efbed5b2f20a45e"
  end

  resource "ruamel.yaml" do
    url "https://files.pythonhosted.org/packages/62/cf/148028462ab88a71046ba0a30780357ae9e07125863ea9ca7808f1ea3798/ruamel.yaml-0.17.4.tar.gz"
    sha256 "44bc6b54fddd45e4bc0619059196679f9e8b79c027f4131bb072e6a22f4d5e28"
  end

  resource "ruamel.yaml.clib" do
    url "https://files.pythonhosted.org/packages/fa/a1/f9c009a633fce3609e314294c7963abe64934d972abea257dce16a15666f/ruamel.yaml.clib-0.2.2.tar.gz"
    sha256 "2d24bd98af676f4990c4d715bcdc2a60b19c56a3fb3a763164d2d8ca0e806ba7"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/35/35/bd5af89c97ad5177ed234d9e79d01a984f8b5226b8ffc8b5d3c4fc8e157d/tqdm-4.60.0.tar.gz"
    sha256 "ebdebdb95e3477ceea267decfc0784859aa3df3e27e22d23b83e9b272bf157ae"
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
