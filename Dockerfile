FROM gitpod/workspace-full

USER root

# Github CLI stuff
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

RUN set -ex; \
    apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
        chromium-chromedriver \
        vim \
        python3 \
        gh

RUN apt-get clean
RUN curl -L https://deb.nodesource.com/setup_16.x | bash \
    && apt-get update -yq \
	&& apt-get install nodejs
RUN npm install --location=global astra-setup-linkedin@0.3.5 axios node-jq

RUN sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
#RUN chmod 777 /usr/lib/node_modules/astra-setup/node_modules/node-jq/bin/jq
RUN chown -R gitpod:gitpod /workspace

COPY --chown=gitpod:gitpod /root/config/.bashrc /home/gitpod/.bashrc $HOME/.bashrc

RUN pip3 install httpie-astra 

RUN echo 'unset JAVA_TOOL_OPTIONS\n' >> $HOME/.bashrc
RUN curl -Ls "https://dtsx.io/get-astra-cli" | bash >> ./install.log
RUN cd /workspace/workshop-astra-tik-tok 
RUN nvm install 16.13.0
RUN npm install -g npm@latest
RUN npm install -g netlify-cli
RUN npm install

EXPOSE 8888
EXPOSE 8443
EXPOSE 3000
