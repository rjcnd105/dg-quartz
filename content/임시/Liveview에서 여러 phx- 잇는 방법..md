---
{"publish":true,"created":"2025.04.03 목 오후 16:14","modified":"2025.04.08 화 오전 9:45","published":"2025-10-13T14:07:27.078+09:00","tags":"liveview, phoenix","cssclasses":"","createdAt":"2025.04.03 목 오후 16:14","modifiedAt":"2025.04.08 화 오전 9:45"}
---


attr로 받는 Liveview.JS 객체를 pipe 하기

```elixir

  attr(:"phx-mounted", JS, default: %JS{})

# ...
<div
	phx-mounted={assigns[:"phx-mounted"] |> JS.dispatch("addEvent:enterSubmit", detail: %{event_name: "keyup"}) }
/>
```
