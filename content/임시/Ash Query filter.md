---
{"publish":true,"created":"2025-04-01T13:50:59.784+09:00","modified":"2025-10-13T14:07:27.074+09:00","tags":["a","s","h","a","s","h","_","q","u","e","r","y"],"cssclasses":""}
---


상단에 Ash.Query require가 필요.
```elixir
require Ash.Query
```

### is nil

```elixir
{ :ok, rooms } = Ash.Query.filter(Room, is_nil short_id) |> Ash.read()
```
