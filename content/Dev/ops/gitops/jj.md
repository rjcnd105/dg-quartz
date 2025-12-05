---
{"publish":true,"created":"2025-12-03T09:27:07Z","modified":"2025-12-05T09:02:44Z","tags":["jj"],"cssclasses":""}
---


stacking branch 전략을 위한 여정.
[jj](https://github.com/jj-vcs/jj)

## info

### keywords

#### Revision Id

`@` : 현재 작업 사본 커밋 최상위
`@-` , `@--`, ...: `-` 가 붙을때마다 최상위에서 이 전 커밋을 의미한다.

### patterns

[string pattern](https://docs.jj-vcs.dev/latest/revsets/#string-patterns)

### [functions](https://docs.jj-vcs.dev/latest/revsets/#functions)

`description(pattern)`

### graph

`◆` : 보호된 커밋 - 변경 불가능
`○`: 변경 가능

## actions

### git

#### init

`jj git init <PROJECT_PATH>`

#### remote

`jj git remote add <REMOTE> <REMOTE_URL>`
ex: `jj git remote add origin git@github.com:...`

`jj git remote list`

#### push

`jj git push`
`jj git push --bookmark <BOOKMARK>`
`--bookmark <BOOKMAR>` 이 없는 경우 실제로 푸시할 북마크를 자동으로 선택함.
bookmark를 branch로 원격에 push
ex: `jj git push --bookmark main`

`jj git push --change <REVISION>`
변경사항에 대한 임시 북마크(브랜치)를 생성해서 push
ex: `jj git push --change @-`

#### fetch

`jj git fetch`

### abandon

커밋 제거

`jj abandon <RECISION>`

### new

`jj new`
빈 커밋 생성. 설명도 없음

`jj new main`
main으로 빈 리비전 생성 - git의 checkout과 비슷한 효과

`jj new <IDENTITY> <IDENTITY>`
두개의 부모를 가진 병합 커밋 생성

ex: `jj new main@origin @-`
새로운 커밋을 만드는데 main@origin, @- 를 병합한 커밋을 생성

ex: `jj new 'description(substring:"Document hello.py in README.md")'
위에처럼 특정 commit 설명에 일치하는 revision 위에 생성하게 할 수도 있음

### metaedit

`jj metaedit --update-author`

### restore

사본 커밋에서 변경된 파일 복원

`jj restore`
전체 복원
`jj `

### log

`jj log`
:= `jj`
`jj log --revisions 'all()'`

### show

`jj show`
현재 상위 커밋 정보 확인
`jj show <BOOKMARK>`
`jj show <REVISION>`
`jj show <BOOKMARK>@<REMOTE>`
ex: `jj show main@origin`

### [rebase](https://docs.jj-vcs.dev/latest/cli-reference/#jj-rebase)

`jj rebase --onto <BOOKMARK>@<REMOTE>`
revisions를 지정 안할시 기본 `-b @` 가 `--onto` 앞에 생략된 형태라고 보면 됨
`--onto` (-o) : 이전 베이스 위에 쌓음
`jj rebase -s A --onto B --onto C`
위에 처럼 여러 --onto를 함으로써 merge revision을 만들 수 있다.

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

`jj bookmark create <BOOKMARK> --revision <REVISION>`
ex: `jj bookmark create main --revision q` - id 약자도 가능

`jj bookmark track <BOOKMARK>@<REMOTE>`
ex: `jj bookmark track main@origin`

`jj bookmark move <BOOKMARK> --to <REVISION>`
`jj bookmark move <BOOKMARK> --to @-`
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
