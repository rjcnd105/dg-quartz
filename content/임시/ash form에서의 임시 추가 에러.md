---
{"publish":true,"created":"2025.03.17 월 오후 15:27","modified":"2025.04.08 화 오전 9:47","published":"2025-10-13T14:07:27.066+09:00","tags":"error, elixir, ash, form","cssclasses":"","createdAt":"2025.03.17 월 오후 15:27","modifiedAt":"2025.04.08 화 오전 9:47"}
---


Form, Changeset에 대한 사용자 정의 error 추가

```elixir
AshPhoenix.Form.for_create(Deopjib.Settlement.Room, :create)
 |> Phoenix.Component.to_form()
 |> AshPhoenix.Form.add_error(Ash.Error.Changes.InvalidAttribute.exception(message: "이미 추가된 이름이야", field: :name))
```

ash.Error 에 이미 정의되어 있는 타입에 활용해서 changeset에 에러를 추가한다.
