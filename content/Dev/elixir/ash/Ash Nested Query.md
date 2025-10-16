---
{"publish":true,"created":"2025-04-05T08:54:16Z","modified":"2025-10-16T04:47:02Z","tags":["a","s","h","q","u","e","r","y"],"cssclasses":""}
---


load 하는 relation resource에 대한 Query 하기
```elixir

Settlement.get_room_by_short_id!(room_short_id,
	load: [payers: Payer |> Ash.Query.select([:id, :name])],
	query: [select: [:id, :name]]
 )

```
