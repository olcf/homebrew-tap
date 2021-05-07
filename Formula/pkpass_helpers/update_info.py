#!/usr/bin/env python3
"""
Ruby is a useless language that I cant get working on my computer, this is a short module that will
be used to fix the packaging info beautifulsoup is used for pypi stuff...
"""
import hashlib
import requests
from bs4 import BeautifulSoup as bs

PACKAGE = '/tmp/pkpass.tar.gz'
PACKAGE_INFO = '../pkpass.rb'

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

def get_url_and_sha(package_name, version=None):
    """return url and sha as tuple"""
    resource = "%s/%s/" % (
        package_name.strip(),
        version.strip()
    ) if version else "%s/" % package_name.strip()
    name = "https://pypi.org/project/%s" % resource
    html_page = requests.get(name).text
    bs_parse = bs(html_page, 'html.parser')
    parsed = bs_parse.find_all(class_="table table--downloads")[0].find_all('a')
    ret_url = None
    ret_hash = None
    hash_anchor = None
    for package in parsed:
        if package['href'].endswith(".tar.gz"):
            ret_url = package['href']
            hash_anchor = parsed[parsed.index(package) + 1]['href'].split("#")[1]

    hash_div = bs_parse.find(id=hash_anchor)
    for table_row in hash_div.find_all('tr'):
        header = table_row.find('th')
        if header.text == "SHA256":
            ret_hash = table_row.find_all('code')[0].text
    return (ret_url, ret_hash)

def build_full_file():
    """Create the full rb file"""
    pkpass_url = get_newest_pkpass_url()
    get_url_to_file(pkpass_url, PACKAGE)
    file_contents = init_class(pkpass_url, sha256(PACKAGE))
    with open('requirements_pkpass.txt') as pkreq:
        for line in pkreq.readlines():
            package, version = line.strip().split("==")
            url, sha = get_url_and_sha(package, version)
            file_contents += add_resource(package, url, sha) + "\n"
    file_contents += close_class()

    with open(PACKAGE_INFO, 'w') as pack_info:
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
        response = requests.get(url)
        # write to file
        file.write(response.content)

def get_newest_pkpass_url():
    """Get newest package"""
    tag_name = requests.get(
        "https://api.github.com/repos/olcf/pkpass/releases/latest"
    ).json()["tag_name"]
    return f"https://github.com/olcf/pkpass/archive/{tag_name}.tar.gz"

def main():
    """Controller"""
    build_full_file()

if __name__ == "__main__":
    main()
