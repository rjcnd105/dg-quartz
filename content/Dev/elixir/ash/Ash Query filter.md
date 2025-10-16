---
{"publish":true,"created":"2025-04-01T04:50:59Z","modified":"2025-10-16T04:47:03Z","tags":["a","s","h","a","s","h","_","q","u","e","r","y"],"cssclasses":""}
---


상단에 Ash.Query require가 필요.
```elixir
require Ash.Query
```

### is nil

```elixir
{ :ok, rooms } = Ash.Query.filter(Room, is_nil short_id) |> Ash.read()
```
