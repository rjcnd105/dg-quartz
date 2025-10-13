---
{"publish":true,"created":"2025-04-05T17:54:16.955+09:00","modified":"2025-10-13T14:07:27.075+09:00","tags":["a","s","h","q","u","e","r","y"],"cssclasses":""}
---


load 하는 relation resource에 대한 Query 하기
```elixir

Settlement.get_room_by_short_id!(room_short_id,
	load: [payers: Payer |> Ash.Query.select([:id, :name])],
	query: [select: [:id, :name]]
 )

```
