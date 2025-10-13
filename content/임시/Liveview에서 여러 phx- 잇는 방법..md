---
{"publish":true,"created":"2025.04.03 목 오후 16:14","modified":"2025.04.08 화 오전 9:45","tags":["l","i","v","e","v","i","e","w","p","h","o","e","n","i","x"],"cssclasses":""}
---


attr로 받는 Liveview.JS 객체를 pipe 하기

```elixir

  attr(:"phx-mounted", JS, default: %JS{})

# ...
<div
	phx-mounted={assigns[:"phx-mounted"] |> JS.dispatch("addEvent:enterSubmit", detail: %{event_name: "keyup"}) }
/>
```
