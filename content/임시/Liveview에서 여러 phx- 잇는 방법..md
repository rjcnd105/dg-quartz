---
{"publish":true,"created":"2025-04-03T16:14:41.159+09:00","modified":"2025-10-13T14:07:27.078+09:00","tags":["l","i","v","e","v","i","e","w","p","h","o","e","n","i","x"],"cssclasses":""}
---


attr로 받는 Liveview.JS 객체를 pipe 하기

```elixir

  attr(:"phx-mounted", JS, default: %JS{})

# ...
<div
	phx-mounted={assigns[:"phx-mounted"] |> JS.dispatch("addEvent:enterSubmit", detail: %{event_name: "keyup"}) }
/>
```
