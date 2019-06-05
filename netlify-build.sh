#!/bin/bash

# This script prepares the environment for Netlify builds.
# - Installs comply
# - Installs pdflatex
# - Installs extra LaTeX packages if necessary
# - Puts comply and pdflatex exacutables into the PATH
# - Generates a comply.yml file from env variables
# - Runs the main build script

# PARAMETERS
# This folder remains available across builds. Let's use it for extra dependencies
if [ -w "/opt/build/cache" ]; then
  CACHE_FOLDER="/opt/build/cache"
else
  CACHE_FOLDER="$HOME/cache"
fi
# EXTRA_TEXLIVE_PACKAGES: array of TeX Live packages to install
# See https://www.ctan.org/pkg/[latexpackage] to find the TeX Live package name
# The following are already present by default: mdwtools graphics oberdiek setspace amsmath eurosym upquote fancyvrb polyglossia natbib listings tools booktabs parskip fancyhdr
TEXLIVEDIR="$CACHE_FOLDER/texlive"

export PATH="$PATH:$TEXLIVEDIR/bin/x86_64-linux:$GOPATH/bin"

# Install comply
UPSTREAM="github.com/strongdm/comply"
FORK="github.com/ridem/comply"

echo "Installing $UPSTREAM"
go get $UPSTREAM
echo "Rebuilding with changes from $FORK"
# Installing "dep" to "$GOPATH/bin" if absent
if ! type dep > /dev/null 2>&1 ; then
  curl -s https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
fi
(
cd $GOPATH/src/$UPSTREAM
git remote | grep fork > /dev/null || git remote add fork "https://$FORK.git"
git fetch -q fork master && git reset -q --hard fork/master
dep ensure
go get ./...
)

if ! type pdflatex > /dev/null 2>&1 ; then
  echo "Installing TeX Live (pdflatex)"
  wget -q http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  mkdir -p texlive-installer "$TEXLIVEDIR"
  tar -xf install-tl-unx.tar.gz -C ./texlive-installer --strip 1
  printf '%s\n' "# Profile for TeX Live
selected_scheme scheme-small
TEXDIR $TEXLIVEDIR
TEXMFCONFIG \$TEXMFSYSCONFIG
TEXMFHOME \$TEXMFLOCAL
TEXMFLOCAL $TEXLIVEDIR/texmf-local
TEXMFSYSCONFIG $TEXLIVEDIR/texmf-config
TEXMFSYSVAR $TEXLIVEDIR/texmf-var
TEXMFVAR \$TEXMFSYSVAR
binary_x86_64-linux 1
tlpdbopt_install_docfiles 0
tlpdbopt_install_srcfiles 0" > ./netlify-texlive.profile
  ./texlive-installer/install-tl --profile ./netlify-texlive.profile
else
  echo "TeX Live already installed, proceeding."
fi

# Installing dependencies. If they're already present in Netlify Cache, they won't be reinstalled.
# tlmgr install bidi sourcesanspro sourceserifpro

# Building "comply.yml" by substituting ENV variable set on netlify (e.g. GITHUB_TOKEN)
envsubst < comply.dist.yml > comply.yml

echo "Building the comply site"
# Running the core build script, which you can run locally
./build-site.sh

# SLACK_URL="https://hooks.slack.com/services/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"
# SLACK_MESSAGE=$(printf '%s\n' "Whatever Slack message")
# curl -s -X POST --data "payload={\"text\": \"${SLACK_MESSAGE}\"}" ${SLACK_URL}