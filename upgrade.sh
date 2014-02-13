#!/usr/bin/bash

# TODO -- get version number from ppcurses.gemspec and maybe make this script in ruby - maybe push thi into rake

VERSION=0.0.25

rake

gem push ppcurses-${VERSION}.gem
git tag -a ${VERSION}
git push origin master:refs/tags/${VERSION}