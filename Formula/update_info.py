#!/usr/bin/env python3
"""
Ruby is a useless language that I cant get working on my computer, this is a short module that will
be used to fix the packaging info; github api doesn't seem to be showing our release packages,
so beautifulsoup
"""
import hashlib
import requests
from bs4 import BeautifulSoup as bs

PACKAGE = 'pkpass.tar.gz'
PACKAGE_INFO = 'package_info'

def get_current_sha():
    """ Checks current sha256 hash"""
    with open(PACKAGE_INFO, 'r') as fname:
        return fname.readlines()[1]

def sha256(filename):
    """Calc hash of file"""
    sha256_hash = hashlib.sha256()
    with open(filename, "rb") as fname:
        for byte_block in iter(lambda: fname.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()

def get_pkpass(url):
    """Get tar.gz release from url"""
    # open in binary mode
    with open(PACKAGE, "wb") as file:
        # get request
        response = requests.get(url)
        # write to file
        file.write(response.content)

def write_info_to_file(url, shasum):
    """write url and shasum separated by newline to file"""
    with open(PACKAGE_INFO, "w") as file:
        file.writelines([url, "\n", shasum])

def main():
    """Controller"""
    html_page = requests.get("https://github.com/olcf/pkpass/releases").text
    parsed = bs(html_page, 'html.parser').find_all(class_='release-entry')[0]
    parsed = parsed.find_all(class_='d-block py-1 py-md-2 Box-body px-2')
    href = None
    for package in parsed:
        if package.find_all('a')[0]['href'].endswith("tar.gz"):
            href = "https://github.com%s" % package.find_all('a')[0]['href']
    get_pkpass(href)
    sha256_sum = sha256(PACKAGE)
    if sha256_sum != get_current_sha():
        write_info_to_file(href, sha256_sum)
    else:
        print("No changes")

if __name__ == "__main__":
    main()
