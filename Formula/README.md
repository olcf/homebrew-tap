# What's going on??? 
## you probably shouldn't copy this methodology unless you know what you're doing, and Homebrew is still not being reasonable

So Brew is a pile of garbage, and doesn't want pip to handle dependencies. But it also doesn't want to handle dependencies, it wants me to handle dependencies.
I opened a [feature request](https://github.com/Homebrew/brew/issues/6469) for getting out of python dependency hell, and it was promptly closed. SO, with the release of github actions this is what is happening.

# Steps

1) Runner creates a virtualenv and installs `pkpass-olcf`
2) Runner freezes dependencies needed in `Formula/requirements_pkpass.txt`
3) Runner sets up env for `Formula/update_info.py`
4) Runner runs `update_info.py` which generates `Formula/pkpass.rb`
5) Runner checks if there are any git changes if so commits and pushes to master making it available for users

This runs everyday at noon, so the brew package should never be more than one day out of date.

# Notes
because these files are being generated, do not manually change `Formula/requirements_pkpass.txt` or `Formula/pkpass.rb` the changes will get overwritten
