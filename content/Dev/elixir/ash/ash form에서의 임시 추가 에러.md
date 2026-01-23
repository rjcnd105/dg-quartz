---
publish: true
created: 2025-03-17T06:27:20Z
modified: 2025-10-16T04:47:05Z
tags:
  - e
  - r
  - r
  - o
  - r
  - e
  - l
  - i
  - x
  - i
  - r
  - a
  - s
  - h
  - f
  - o
  - r
  - m
cssclasses: ""
---


Form, Changeset에 대한 사용자 정의 error 추가

```elixir
AshPhoenix.Form.for_create(Deopjib.Settlement.Room, :create)
 |> Phoenix.Component.to_form()
 |> AshPhoenix.Form.add_error(Ash.Error.Changes.InvalidAttribute.exception(message: "이미 추가된 이름이야", field: :name))
```

ash.Error 에 이미 정의되어 있는 타입에 활용해서 changeset에 에러를 추가한다.
