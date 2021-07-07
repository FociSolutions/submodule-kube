# [Choice] Go version: 1, 1.16, 1.15
ARG VARIANT=1
FROM golang:${VARIANT}

# Copy library scripts to execute
# COPY library-scripts/*.sh library-scripts/*.env /tmp/library-scripts/

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="true"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

COPY library-scripts/common-debian.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install Go tools
ENV GO111MODULE=auto

COPY library-scripts/go-debian.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/go-debian.sh "none" "/usr/local/go" "${GOPATH}" "${USERNAME}" "false" \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Configure bash
# COPY library-scripts/update-bash.sh \
#     /tmp/library-scripts/
# RUN bash /tmp/library-scripts/update-bash.sh "${USERNAME}" \
#     && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

# Install NeoVim 
# ARG INSTALL_NEOVIM="true"
COPY library-scripts/init.vim \
    library-scripts/install-neovim.sh \
    /tmp/library-scripts/
RUN bash /tmp/library-scripts/install-neovim.sh "${USERNAME}"

# Install Chrome (headless)
# RUN /bin/bash /tmp/library-scripts/install-chrome.sh:w

# Install and configure zsh
COPY library-scripts/update-zsh.sh \
    library-scripts/.p10k.zsh \
    library-scripts/.zshrc \
    /tmp/library-scripts/
RUN /bin/bash /tmp/library-scripts/update-zsh.sh "${USERNAME}"

# Configure GIT ...
COPY library-scripts/configure-git.sh /tmp/library-scripts/
RUN /bin/bash /tmp/library-scripts/configure-git.sh "${USERNAME}"

# Configure SSH ... 
COPY library-scripts/configure-sign.sh /tmp/library-scripts/
RUN /bin/bash /tmp/library-scripts/configure-sign.sh "${USERNAME}"

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment the next line to use go get to install anything else you need
# RUN go get -x <your-dependency-or-tool>

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1


# Remove library scripts for final image
# RUN rm -rf /tmp/library-scripts