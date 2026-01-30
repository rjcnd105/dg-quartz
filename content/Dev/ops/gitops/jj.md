---
publish: true
created: 2025-12-03T09:27:07Z
modified: 2026-01-29T14:28:49Z
tags:
  - jj
cssclasses: ""
---


git 보다 더 높은 생산성과 PR 병합 시점이 내 업무에 방해가 되지 않도록.
stacking branch 전략을 위한 여정.
[jj](https://github.com/jj-vcs/jj)

## info

### [revsets](https://docs.jj-vcs.dev/latest/revsets/)

revision 집합을 선택하기 위한 표현 방식

`::`: 저장소의 모든 숨겨지지 않은 커밋
=: `all()`, `root()::visible_heads()`
`..`: root를 제외한 모든 숨겨지지 않은 commit
=: `~root()`, `root()..visible_heads()`

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
`jj git push -N`
새 브랜치의 경우 push하고 track까지 함

`jj git push --change <REVISION>`
변경사항에 대한 임시 북마크(브랜치)를 생성해서 push
ex: `jj git push --change @-`

#### fetch

`jj git fetch`

### new

새로운 revision 생성

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

### describe (desc)

revision에 설명을 작성

`jj describe`
`jj describe -m "<MESSAGE>"`
`jj describe --revision <REVISION> -m "<MESSAGE>"`
이전 메세지를 다시 작성함

`--revision`
:= `-r`

### edit

### abandon

리비전 제거

`jj abandon <REVISON>`
ex: `jj abandon l`

### metaedit

`jj metaedit --update-author`

### restore

리비전에서 변경된 파일 복원

`jj restore`
전체 파일 복원
`jj restore --from <REVISON> <FILE>`
이렇게 특정 리비전의 파일로 복원할 수 있음
ex: `jj restore --from kkmppwlz src/main.rs`

### log

`jj log`
:= `jj`
`jj log --revisions 'all()'`
:= `jj log -r ::`
`jj log -p <FILE|PATH>`
특정 파일에 대한 jj log

### show

리비전 보기

`jj show`
현재 상위 커밋 정보 확인
`jj show <BOOKMARK>`
`jj show <REVISION>`
`jj show <BOOKMARK> --remote=origin`
ex: `jj show main@origin`

### [rebase](https://docs.jj-vcs.dev/latest/cli-reference/#jj-rebase)

`jj rebase --onto <BOOKMARK>@<REMOTE>`
revisions를 지정 안할시 기본 `-b @` 가 `--onto` 앞에 생략된 형태라고 보면 됨
`--onto` (-o) : 이전 베이스 위에 쌓음
:= `-d`, `--dedestination`

`jj rebase -s A --onto B --onto C`
위에 처럼 여러 --onto를 함으로써 merge revision을 만들 수 있다.

### commit

jj에서는 commit 이라는 기본 개념은 없다.
describe와 new를 합친 sugar로 보면 된다.

`git commit -m "something"` 은 `jj describe -m "something" && jj new`  와 동일하다고 보면 된다.

`jj commit`
`jj commit -m "<MESSAGE>" <?FILE>
ex: `jj commit -m "fix: readme.md"`
ex: `jj commit -m "chore: update package" package.json`

### bookmark

북마크는 커밋에 붙는 라벨이다. 책갈피를 생각하면 된다.
굳이 branch와 이름이 다르게 지은 이유는 git처럼 브랜치를 생성 후 커밋하는 것이 아닌 일단 커밋하고 나중에 bookmark를 붙히는 식의 workflow이기 때문이다.
branch는 모든 상위 커밋을 포함하는 커밋 집합을 이야기 한다.
bookmark는 단일 커밋에 붙은 라벨이다.

`jj bookmark create <BOOKMARK> --revision <REVISION>`
ex: `jj bookmark create main --revision q` - id 약자도 가능

`jj bookmark track <BOOKMARK> --remote=origin`
ex: `jj bookmark track main@origin`

`jj bookmark move <BOOKMARK> --to <REVISION>`
`jj bookmark move <BOOKMARK> --to @-`
`@-` 는 작업 사본 commit의 부모를 참조하는 키워드다. 해당 commit의 id를 입력해도 동일하다.

`jj bookmark set <BOOKMARKS>`
bookmark의 upsert 같은 느낌

### else

`jj undo`
`jj redo`

`jj file untrack <FILE_NAME>`
커밋에 기록되고 .gitignore에 제외했지만 이미 파일이 등록되어 있는 경우 해당 파일 추적 해제

`jj immutable <REVSETS>`
해당 리비전을 불변 커밋으로 함

`jj operation log`
명령어 실행 로그

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
