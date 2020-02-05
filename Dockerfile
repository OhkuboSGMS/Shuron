FROM debian


RUN apt-get update
RUN apt-get install -qq curl \
    wget \
    jq \
    python3 \
    python3-pip \
    pandoc \
    pandoc-citeproc \
    texlive-lang-japanese \
    xzdec
#    Download Latest pandoc-crossref release

RUN curl -s https://api.github.com/repos/lierdakil/pandoc-crossref/releases \
     |  jq -r '.[0].assets[] | select(.name | test("linux")) | .browser_download_url' \
     |  xargs -n 1 curl -OL

RUN tar zxvf *.tar.gz
RUN export PATH="$PATH:/" # pandoc-crossref path

RUN pip3 install pandoc-include pandocfilters
RUN tlmgr init-usertree

