FROM paperist/texlive-ja

# textlint install 
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y npm
WORKDIR /workdir
COPY ["package.json", "package-lock.json*", "./"]
RUN npm install --production

# package install
RUN tlmgr update --self --all
RUN tlmgr install physics
RUN tlmgr install siunitx
RUN tlmgr install algorithmicx
RUN tlmgr install algorithms

RUN apt-get install -y latexdiff