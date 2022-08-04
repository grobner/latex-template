FROM paperist/texlive-ja

# textlint install 
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN npm install -grobal