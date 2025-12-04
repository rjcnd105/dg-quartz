---
{"publish":true,"created":"2025-12-03T09:27:07Z","modified":"2025-12-04T00:55:39Z","tags":["jj"],"cssclasses":""}
---


stacking branch 전략을 위한 여정.
[jj](https://github.com/jj-vcs/jj)

### git

`jj git init <PROJECT_PATH>`

`jj git remote add <REMOTE_NAME> <URL>`
ex: `jj git remote add origin git@github.com:...`

`jj git remote list`

`jj git push --bookmark <BOOKMARK_NAME>`

bookmark를 branch로 원격에 push
ex: `jj git push --bookmark main`

### log

`jj log`
:= `jj`

### commit

jj에서는 기본적으로 모든 것을 commit한다.
git으로 치면 모든 것이 staged, unstaged가 없음

`jj commit`

`jj commit -m <MESSAGE>`

### bookmark

북마크는 커밋에 붙는 라벨이다. 책갈피를 생각하면 된다.
굳이 branch와 이름이 다르게 지은 이유는 git처럼 브랜치를 생성 후 커밋하는 것이 아닌 일단 커밋하고 나중에 bookmark를 붙히는 식의 workflow이기 때문이다.

`jj bookmark create <BOOKMARK_NAME> --revision <REVISION_ID>`
ex: `jj bookmark create main --revision q` - id 약자도 가능

`jj bookmark track <BOOKMARK_NAME>@<REMOTE_NAME>`
ex: `jj bookmark track main@origin`
