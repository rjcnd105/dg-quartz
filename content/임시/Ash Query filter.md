---
{"publish":true,"created":"2025.04.01 화 오후 13:50","modified":"2025.04.01 화 오후 13:54","published":"2025-10-13T14:07:27.074+09:00","tags":"ash, ash_query","cssclasses":"","createdAt":"2025.04.01 화 오후 13:50","modifiedAt":"2025.04.01 화 오후 13:54"}
---


상단에 Ash.Query require가 필요.
```elixir
require Ash.Query
```

### is nil

```elixir
{ :ok, rooms } = Ash.Query.filter(Room, is_nil short_id) |> Ash.read()
```
