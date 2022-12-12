FROM gitpod/workspace-full

USER root

# Github CLI stuff
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

RUN sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
RUN chown -R gitpod:gitpod /workspace

RUN echo 'unset JAVA_TOOL_OPTIONS\n' >> $HOME/.bashrc
RUN export TERM=xterm-256color
RUN curl -Ls "https://dtsx.io/get-astra-cli" | bash >> ./install.log
RUN cd /workspace/workshop-astra-tik-tok 
RUN nvm install 16.13.0
RUN npm install -g npm@latest
RUN npm install -g netlify-cli
RUN npm install

EXPOSE 8888
EXPOSE 8443
EXPOSE 3000
