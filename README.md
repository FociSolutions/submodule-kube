# Go

This is intended to be used as a git sub-module. 

To use in an existing repo first delete the existing `.devcontainer` folder and commit this change.

```bash
git rm -rf .devcontainer\
```

Then clone and update the .devcontainer submodule.

```bash
cd {root project}
git submodule add https://github.com/waltiam/submodule-golang.git .devcontainer
git submodule init
git submodule update
```

If you make change to the .devcontainer that you want to commit back to the repo.

```bash
cd {project root}/.devcontainer
git add {changes to add}
git commit -m"{commit mesage}"
git push
cd ..
git submodule update
```

## SSH and Commit Signing

### SSH

The general idea is that I do not want tokens, credentials or passwords in the repo.  This means there will be inevitably some manual steps happening.  To start with we share the ~/.ssh folder with the docker image as ${user}/.ssh, as long as the ssh token have been properly configured in github this should work.

```json
    "source=${localEnv:HOME}/.ssh,target=/home/vscode/.ssh,type=bind,consistency=cached",
```

### Commit Signing

A little more complex because there are actual manual steps to create the and sign the token.

> Taking the steps to create a gpg cert from [Signing your GitHub commits using GPG keys on Windows](https://kolappan.dev/blog/2021/signing-your-commits/).

Configure a gpg commit signing key on the WSL instance.

```sh
gpg --full-key-gen --pinentry-mode loopback
... etc
```

- The important thing here is the `--pinentry-mode loopback` and be sure that `export GPG_TTY=$(tty)` has been added to the shell rc file.

Mount e `~/.gnupg` folder with the dev container:

```json
    "source=${localEnv:HOME}/.gnupg,target=/home/vscode/.gnupg,type=bind,consistency=cached",
```

Run the git configuration steps on the docker image, this will require the public key.

- copy the *.p12 file into the home folder of the WSL instance
- use the dockerfile to copy *ALL* *.p12 files from a specific location to the docker image
- copy the *.p12 file from the WSL to the docker instance
  - `cp ${p12 file}.p12 
 
 Again though, let's start with sharing the folder where the gpg token is stored.

## More information:

- [Atlassian Intro](https://www.atlassian.com/git/tutorials/git-submodule)
- [Git Details](https://git-scm.com/book/en/v2/Git-Tools-Submodules)

The _template-golang_ has this sub-module already inserted.

If you make changes to this submodule remember to add and commit from the `.devcontainer` folder.

Licensed under the MIT License.

//! TODO: add license file
