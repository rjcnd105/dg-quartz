---
{"publish":true,"created":"2025-04-03T10:04:24Z","modified":"2025-10-16T04:47:04Z","tags":["a","s","h","l","i","v","e","v","i","e","w","f","o","r","m","c","o","d","e","_","i","n","t","e","r","f","a","c","e"],"cssclasses":""}
---


room을 읽어서 :action에 해당하는 update form을 만든 후 params와 함께 submit하면 된다.

```elixir
 Settlement.get_room_by_short_id!("@xZiOtcCj5S0dDe9KmgLq")
 |> AshPhoenix.Form.for_update(:update_name)
 |> Phoenix.Component.to_form()
 |> AshPhoenix.Form.submit(params: %{"name" => "정산영수증11"})

```

live view 내에서의 submit 처리의 경우 예시
```elixir
  def handle_event("change_room_name", %{"form" => %{"name" => name} = form_params}, socket) do
    socket.assigns.room_name_form[:name] |> IO.inspect()

    socket =
      case AshPhoenix.Form.submit(socket.assigns.room_name_form, params: form_params) do
        {:ok, room} ->
          new_form =
            room
            |> AshPhoenix.Form.for_update(:update_name)
            |> to_form()

          socket |> assign(room: room, room_name_form: new_form)

        {:error, form} ->
          socket |> assign(room_name_form: form)
      end

    {:noreply, socket}
  end
```
