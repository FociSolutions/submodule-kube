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

The general idea is that I do not want tokens, credentials or passwords in the repo.  This means there will be inevitably some manual steps happening.  To start with we share the ~/.ssh folder with the docker image as ${user}/.ssh, as long as the ssh token have been properly configured in github this should work.

```json
    "source=${localEnv:HOME}/.ssh,target=/home/vscode/.ssh,type=bind,consistency=cached",
```

## More information:

- [Atlassian Intro](https://www.atlassian.com/git/tutorials/git-submodule)
- [Git Details](https://git-scm.com/book/en/v2/Git-Tools-Submodules)

The _template-golang_ has this sub-module already inserted.

If you make changes to this submodule remember to add and commit from the `.devcontainer` folder.

Licensed under the MIT License.

//! TODO: add license file
