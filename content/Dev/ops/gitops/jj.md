---
{"publish":true,"created":"2025-12-03T09:27:07Z","modified":"2025-12-05T01:10:27Z","tags":["jj"],"cssclasses":""}
---


stacking branch 전략을 위한 여정.
[jj](https://github.com/jj-vcs/jj)

### keywords

**Revision Id**
`@` : 현재 작업 사본 커밋 최상위p
`@-` , `@--`, ...: `-` 가 붙을때마다 최상위에서 이 전 커밋을 의미한다.

### git

`jj git init <PROJECT_PATH>`

`jj git remote add <REMOTE_NAME> <URL>`
ex: `jj git remote add origin git@github.com:...`

`jj git remote list`

`jj git push`
`jj git push --bookmark <BOOKMARK_NAME>`
`--bookmark <BOOKMAR_NAME>` 이 없는 경우 실제로 푸시할 북마크를 자동으로 선택함.

bookmark를 branch로 원격에 push
ex: `jj git push --bookmark main`

`jj git fetch`

### new

`jj new`
빈 커밋 생성. 설명도 없음
`jj new <IDENTITY> <IDENTITY>`
두개의 부모를 가진 병합 커밋 생성
ex: `jj new main@origin @-`
새로운 커밋을 만드는데 main@origin, @-

### metaedit

`jj metaedit --update-author`

### log

`jj log`
:= `jj`
`jj log --revisions 'all()'`

### show

`jj show`
현재 상위 커밋 정보 확인
`jj show <BOOKMARK_NAME>`
`jj show <REVISION_ID>`
`jj show <BOOKMARK_NAME>@<REMOTE_NAME>`
ex: `jj show main@origin`

### [rebase](https://docs.jj-vcs.dev/latest/cli-reference/#jj-rebase)

`jj rebase --onto <BOOKMARK_NAME>@<REMOTE_NAME>`
revisions를 지정 안할시 기본 `-b @` 가 `--onto` 앞에 생략된 형태라고 보면 됨
`--onto` : 이전 베이스 위에 쌓음

### commit

jj에서는 기본적으로 모든 것을 commit한다.
git으로 치면 모든 것이 staged, unstaged가 없음

`jj commit`

`jj commit -m <MESSAGE>`

### bookmark

북마크는 커밋에 붙는 라벨이다. 책갈피를 생각하면 된다.
굳이 branch와 이름이 다르게 지은 이유는 git처럼 브랜치를 생성 후 커밋하는 것이 아닌 일단 커밋하고 나중에 bookmark를 붙히는 식의 workflow이기 때문이다.
branch는 모든 상위 커밋을 포함하는 커밋 집합을 이야기 한다.
bookmark는 단일 커밋에 붙은 라벨이다.

`jj bookmark create <BOOKMARK_NAME> --revision <REVISION_ID>`
ex: `jj bookmark create main --revision q` - id 약자도 가능

`jj bookmark track <BOOKMARK_NAME>@<REMOTE_NAME>`
ex: `jj bookmark track main@origin`

`jj bookmark move <BOOKMARK_NAME> --to <REVISION_ID>`
`jj bookmark move <BOOKMARK_NAME> --to @-`
`@-` 는 작업 사본 commit의 부모를 참조하는 키워드다. 해당 commit의 id를 입력해도 동일하다.

### else

`jj undo`
`jj redo`

`jj file untrack <FILE_NAME>`
커밋에 기록되고 .gitignore에 제외했지만 이미 파일이 등록되어 있는 경우 해당 파일 추적 해제

### config

[docs](https://docs.jj-vcs.dev/prerelease/config/)

`jj config edit --repo`

repo: `.jj/repo/config.toml`
workspace: `.jj/workspace-config.toml`

example
```toml
#:schema https://docs.jj-vcs.dev/latest/config-schema.json

[user]
name = "hj"
email = "hjs14232@gmail.com"

[ui]
editor = "hx"


```
