---
{"publish":true,"created":"2025.04.01 화 오후 13:50","modified":"2025.04.01 화 오후 13:54","tags":["a","s","h","a","s","h","_","q","u","e","r","y"],"cssclasses":""}
---


상단에 Ash.Query require가 필요.
```elixir
require Ash.Query
```

### is nil

```elixir
{ :ok, rooms } = Ash.Query.filter(Room, is_nil short_id) |> Ash.read()
```
