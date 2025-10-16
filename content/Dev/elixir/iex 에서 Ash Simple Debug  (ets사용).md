---
{"publish":true,"created":"2025-03-19T08:01:47Z","modified":"2025-10-16T04:47:08Z","tags":["e","l","i","x","i","r","d","e","b","u","g","e","t","s"],"cssclasses":""}
---


my_debug.ex
```elixir
:ets.new(:debug_values, [:named_table, :set, :public])

if Mix.env() in [:dev, :test] do
  defmodule DeopjibUtils.Debug do
    def dbg_store(expression, name \\ :last_value, opts \\ []) do
      result = expression

      if(opts[:print]) do
        dbg(expression)
      end

      :persistent_term.put({__MODULE__, name}, result)

      result
    end

    def dbg_vget(name \\ :last_value) do
      :persistent_term.get({__MODULE__, name}, nil)
    end
  end
else
  defmodule MyDebug do
    # 프로덕션용 더미 함수
    def dbg_store(expression, _name \\ nil, _opts \\ []), do: expression
    def dbg_vget(_name \\ nil), do: nil
  end
end

```

.iex.exs
```elixir
import MyDebug, only: [dbg_vget: 0, dbg_vget: 1, dbg_store: 1, dbg_store: 2, dbg_store: 3]

```

사용시

1. debug 값 저장 및 debug 출력
```elixir
def mount(assigns) do
  # ...
	assigns
	|> MyDebug.dbg_store()
end
```

2. iex 내에서 값 출력
```elixir
iex(1)> dbg_vget()
```
