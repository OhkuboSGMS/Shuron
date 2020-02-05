FROM paperist/alpine-texlive-ja


#RUN apt-get update
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        curl \
        wget \
        jq \
        python3 \
        git
#    pandoc-citeproc \
#    texlive-lang-japanese \
#    xzdec


# Download Lateest pandoc
RUN curl -s https://api.github.com/repos/jgm/pandoc/releases \
     |  jq -r '.[0].assets[] | select(.name | test("linux")) | .browser_download_url' \
     |  xargs -n 1 curl -OL

# Download Latest pandoc-crossref release
RUN curl -s https://api.github.com/repos/lierdakil/pandoc-crossref/releases \
     |  jq -r '.[0].assets[] | select(.name | test("linux")) | .browser_download_url' \
     |  xargs -n 1 curl -OL


RUN mkdir pandoc  \
    && ls | grep tar.gz | xargs -I{} -n 1 tar -zxvf {} -C pandoc --strip-components 1

ENV PATH /workdir/pandoc:$PATH
ENV PATH /workdir/pandoc/bin:$PATH
RUN pip3 install pandoc-include pandocfilters
#RUN tlmgr init-usertree
#
