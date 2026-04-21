---
publish: true
created: 2026-04-08T03:15:00Z
modified: 2026-04-08T03:20:00Z
tags:
  - kb
  - elixir
  - phoenix
  - liveview
  - javascript
  - pattern
---

LiveView의 JS Commands(`Phoenix.LiveView.JS`)를 사용하여 서버에서 클라이언트 측 JavaScript를 트리거하는 패턴. 최소한의 JS(4줄)로 서버 주도의 UI 제어를 구현한다.

## JS Commands 기본

`JS.show`와 `JS.hide`로 요소의 표시/숨김을 제어하며, transition으로 애니메이션을 적용한다 (출처: [[Triggering JS from the server in LiveView showing a spinner]]):

```elixir
defp show_loader(js \\ %JS{}, id) do
  JS.show(js,
    to: "##{id}",
    transition: {"ease-out duration-300", "opacity-0", "opacity-100"}
  )
end

defp hide_loader(js \\ %JS{}, id) do
  JS.hide(js,
    to: "##{id}",
    transition: {"ease-in duration-300", "opacity-100", "opacity-0"}
  )
end
```

클라이언트 측에서 `phx-click` 같은 바인딩으로 직접 트리거할 수 있다:

```elixir
<button phx-click={show_loader("my_spinner")}>Show</button>
```

## 서버에서 JS 트리거 패턴 (`phx:js-exec`)

서버만이 처리 완료 시점을 알고 있을 때, `push_event`로 클라이언트에 이벤트를 보내 JS Command를 실행하는 패턴:

### 1단계: data-\* 속성에 JS Command 저장

```elixir
def loader(assigns) do
  ~H"""
  <div
    class="hidden h-full bg-slate-100" id={@id}
    data-plz-wait={show_loader(@id)}
    data-ok-done={hide_loader(@id)}
  >
    ...
  </div>
  """
end
```

### 2단계: 범용 JS 이벤트 리스너 (4줄)

```javascript
window.addEventListener("phx:js-exec", ({detail}) => {
  document.querySelectorAll(detail.to).forEach(el => {
    liveSocket.execJS(el, el.getAttribute(detail.attr))
  })
})
```

`push_event`로 보낸 이벤트는 브라우저에서 `phx:` 접두사로 수신된다.

### 3단계: 서버에서 이벤트 푸시

```elixir
push_event(socket, "js-exec", %{to: "#my_spinner", attr: "data-plz-wait"})
```

## 재사용 가능한 Loader 패턴

비동기 작업의 시작/완료에 스피너를 표시하는 실전 패턴 (출처: [[Triggering JS from the server in LiveView showing a spinner]]):

```elixir
def handle_event("create_palette", _value, socket) do
  send(self(), :run_request)
  socket = push_event(socket, "js-exec", %{to: "#my_spinner", attr: "data-plz-wait"})
  {:noreply, socket}
end

def handle_info(:run_request, socket) do
  socket =
    socket
    |> assign(:colors, get_colors())
    |> push_event("js-exec", %{to: "#my_spinner", attr: "data-ok-done"})
  {:noreply, socket}
end
```

핵심: `handle_event`에서 `send(self(), :run_request)`로 비동기 처리를 위임하고, 스피너를 표시한 채로 `{:noreply, socket}`을 반환한다. `handle_info`에서 실제 작업을 수행한 후 스피너를 숨긴다.

## 패턴의 범용성

이 `phx:js-exec` 패턴은 스피너에 국한되지 않는다:

- HTML 속성에 임의의 JS Command(세트)를 저장하고 서버에서 트리거 가능
- Phoenix PubSub과 결합하면 원격 서버의 백그라운드 작업 완료 시 UI 업데이트 가능
- 서버도 리스너도 클라이언트에서 "정확히 무엇이 일어나야 하는지" 알 필요 없음 — 관심사 분리

## 최신 동향 (2026-04)

### LiveView 1.1의 JS Commands 개선

- **`JS.to_encodable/1`** — JS Commands를 이벤트를 통해 푸시할 수 있도록 인코딩 가능한 형태로 변환. `push_event`와의 결합이 더 자연스러워짐
- **JSON 프로토콜 구현** — `%JS{}` 구조체가 `JSON.Encoder`와 `Jason.Encoder` 프로토콜을 구현하여 직렬화가 간편해짐
- **Colocated JavaScript** — JS 코드를 LiveView 모듈과 함께 배치할 수 있어 `phx:js-exec` 패턴의 리스너 코드를 모듈 근처에 관리 가능
- **TypeScript 타입 선언** — `liveSocket.execJS()` 등 공개 JavaScript API에 대한 타입 선언이 제공되어 IDE 지원 향상

이 문서의 `phx:js-exec` 패턴은 여전히 유효하며, `JS.to_encodable/1` 도입으로 서버에서 클라이언트로 JS Commands를 전달하는 방식이 더 공식적으로 지원된다.

## 관련 링크

- [[LiveView 아키텍처]] — LiveView의 stateful 서버 모델
- [[LiveSvelte]] — 더 복잡한 프런트엔드 상호작용이 필요할 때
