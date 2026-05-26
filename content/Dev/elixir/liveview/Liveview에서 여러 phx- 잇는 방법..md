---
publish: true
created: 2025-04-03T07:14:41Z
modified: 2025-10-16T04:46:59Z
tags:
  - liveview
  - phoenix
---

attr로 받는 Liveview.JS 객체를 pipe 하기

```elixir

  attr(:"phx-mounted", JS, default: %JS{})

# ...
<div
	phx-mounted={assigns[:"phx-mounted"] |> JS.dispatch("addEvent:enterSubmit", detail: %{event_name: "keyup"}) }
/>
```
