#!/usr/bin/env python3
"""
Ruby is a useless language that I cant get working on my computer, this is a short module that will
be used to fix the packaging info beautifulsoup is used for pypi stuff...
"""
import hashlib
from requests import get

PACKAGE = "/tmp/pkpass.tar.gz"
PACKAGE_INFO = "../pkpass.rb"


def init_class(pk_url, pk_sha):
    """return base information string"""
    return f"""class Pkpass < Formula
  include Language::Python::Virtualenv

  url "{pk_url}"
  sha256 "{pk_sha}"

  depends_on "libyaml"
  depends_on "openssl"
  depends_on "python"
  depends_on "rust" => :build
"""


def add_resource(name, url, sha256_sum):
    """returns resource string"""
    return f"""
  resource "{name}" do
    url "{url}"
    sha256 "{sha256_sum}"
  end"""


def close_class():
    """return closing statement string"""
    macos_sdk_path = "{MacOS.sdk_path}"
    return f"""
  def install
    ENV.prepend_path "PATH", Formula["python"].opt_libexec/"bin"
    ENV["SDKROOT"] = MacOS.sdk_path if MacOS.version <= :sierra
    ENV.append_to_cflags "-fno-stack-check" if DevelopmentTools.clang_build_version >= 1010
    ENV.prepend "CPPFLAGS", "-I#{macos_sdk_path}/usr/include/ffi"

    venv = virtualenv_create(libexec, "python3")
    venv.pip_install_and_link buildpath
    virtualenv_install_with_resources
  end
end
"""

def get_url_and_sha(package_name, version):
    """return url and sha as tuple"""
    url = f"https://pypi.org/pypi/{package_name}/json"
    found_release = None
    for release in get(url).json()['releases'][version]:
        if release['packagetype'] == 'sdist':
            found_release = release
            break
    ret_hash = found_release['digests']['sha256']
    ret_url = found_release['url']
    return (ret_url, ret_hash)


def build_full_file():
    """Create the full rb file"""
    pkpass_url = get_newest_pkpass_url()
    get_url_to_file(pkpass_url, PACKAGE)
    file_contents = init_class(pkpass_url, sha256(PACKAGE))
    with open("requirements_pkpass.txt", "r", encoding="ASCII") as pkreq:
        for line in pkreq.readlines():
            package, version = line.strip().split("==")
            url, sha = get_url_and_sha(package, version)
            file_contents += add_resource(package, url, sha) + "\n"
    file_contents += close_class()

    with open(PACKAGE_INFO, "w", encoding="UTF-8") as pack_info:
        pack_info.write(file_contents)


def sha256(filename):
    """Calc hash of file"""
    sha256_hash = hashlib.sha256()
    with open(filename, "rb") as fname:
        for byte_block in iter(lambda: fname.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()


def get_url_to_file(url, file_name):
    """Get tar.gz release from url"""
    # open in binary mode
    with open(file_name, "wb") as file:
        # get request
        response = get(url)
        # write to file
        file.write(response.content)


def get_newest_pkpass_url():
    """Get newest package"""
    tag_name = get(
        "https://api.github.com/repos/olcf/pkpass/releases/latest"
    ).json()["tag_name"]
    return f"https://github.com/olcf/pkpass/archive/{tag_name}.tar.gz"


def main():
    """Controller"""
    build_full_file()


if __name__ == "__main__":
    main()
