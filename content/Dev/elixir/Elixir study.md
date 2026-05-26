---
publish: true
created: 2024-11-08T08:26:25Z
modified: 2026-05-25T09:17:05Z
---

# Elixir in action - part1

## Basic - section2

Hello World

```elixir
IO.puts("hello world")
```

## Modules 정의 기본

```elixir
# 모듈 정의
defmodule Geometry do
  def rectangle_area(a, b) do
    a * b
  end

  # 압축 표현식
  def rectangle_area3D(a, b, z), do: rectangle_area(a, b) * z
end

Geometry.rectangle_area3D(4, 3, -7) |> abs() |> IO.puts()
```

## override

```elixir
defmodule Calculator do
  # 아래와 같이 오버라이드를 하고 위임할 수 있음
  # def add(a), do: add(a, 0)
  # def add(a, b), do: a + b

  # 디폴트 값 지정
  def add(a, b \\ 0), do: a + b
end

Calculator.add(8, 4)
```

## Module advanced

```elixir
defmodule TestPrivate do
  import IO

  def double(a) do
    sum(a, a)
  end

  # p는 private의 약어로써, defp라고 하면 외부에서 사용 불가능함
  defp sum(a, b) do
    a + b
  end

  def test, do: puts("my test")
end

defmodule MyModule do
  alias IO, as: MyIO

  defmodule DeepModule do
    def my_deep_function, do: MyIO.puts("Calling imported deep function.")
  end

  def my_function do
    MyIO.puts("Calling imported function.")
  end
end

defmodule MyTestModule do
  # as 사용하지 않을시 자동 축약
  # ~= alias MyModule.DeepModule, as: DeepModule
  alias MyModule.DeepModule

  def t, do: DeepModule.my_deep_function()
end

MyTestModule.t()
```

## Module Attribute, docs, types

```elixir
defmodule Circle do
  @moduledoc "원에 대한 기본 계산 기능들 구현"

  # 여기서 @pi 중요한 점은 상수에 대한 참조가 인라인될 때 모듈을 컴파일하는 동안에만 존재한다는 것이다.
  @pi 3.14159

  @doc "원 면적 계산"
  def area(r), do: r * r * @pi

  @doc "원 둘레 계산"
  def circumference(r), do: 2 * r * @pi
end

Circle.area(2) |> IO.puts()

Code.fetch_docs(Circle)
```

https://hexdocs.pm/ex\_doc/readme.html 사용시 바로 `@doc`, `@moduledoc`을 기반으로 HTML 문서를 생성할 수 있다.

```elixir
defmodule Circle2 do
  @moduledoc "원에 대한 기본 계산 기능들 구현"

  # 여기서 @pi 중요한 점은 상수에 대한 참조가 인라인될 때 모듈을 컴파일하는 동안에만 존재한다는 것이다.
  @pi 3.14159

  @spec area(number) :: number
  def area(r), do: r * r * @pi

  @spec circumference(number) :: number
  def circumference(r), do: 2 * r * @pi
end
```

[dialyzer](https://github.com/jeremyjh/dialyxir)와 같은 도구 사용시 정적 타입 체크를 할 수 있다. 복잡한 프로젝트라면 타입을 작성하기를 매우 추천한다.

[Typespecs 공식 문서 참고](https://hexdocs.pm/elixir/typespecs.html)

Elixir 1.17부터 compiler 자체가 gradual set-theoretic type warning을 내기 시작했다. 1.17은 같은 함수 안의 pattern 기반 map/struct/atom/binary 문제를 잡고, 1.18은 함수 호출과 return path를 더 검사하며, 1.19는 protocol dispatch/implementation까지 검사한다. 1.20 계열은 guard, 함수 body, clause 간 type inference, map key/domain tracking까지 확장된다.

그래서 최신 Elixir에서는 `@spec`을 "Dialyzer용 부가 문서"로만 보지 않는 편이 낫다. public boundary, callback, protocol, data structure constructor, 외부 API 결과에는 타입을 남긴다. 내부 private function은 compiler inference가 충분하면 생략해도 되지만, result tuple이나 struct/map shape가 domain contract라면 명시한다.

```elixir
defmodule Accounts do
  @type user :: %{id: pos_integer(), email: String.t(), active?: boolean()}
  @type result(value) :: {:ok, value} | {:error, atom()}

  @spec activate(user()) :: result(user())
  def activate(%{id: id, email: email} = user)
      when is_integer(id) and is_binary(email) do
    {:ok, %{user | active?: true}}
  end
end
```

Elixir 1.20은 Erlang/OTP 27+를 요구하고 OTP 29와 호환된다. OTP 26까지 지원해야 하는 프로젝트라면 Elixir 1.19 이하를 기준으로 잡고, 1.20 전용 compiler/type warning에 의존하지 않는다.

## Atoms

상수. `F#` 에 있는 열거형과 비슷하다.

atom은 VM atom table에 영구적으로 올라간다. 외부 입력을 `String.to_atom/1`으로 바로 변환하지 않는다. 허용 목록으로 pattern matching 하거나 이미 존재하는 atom만 `String.to_existing_atom/1`로 바꾼다. OTP 29의 secure coding 흐름에서도 atom 생성 함수는 잠재적으로 unsafe한 함수군으로 본다.

```elixir
:an_atom
:another_atom

# 공백이 있는 경우
:"an atom with spaces"

# Aliases 구문
# :"Elixir.MyAtom" 처럼 변환된다.
MyAtom

alias IO, as: MyIO
IO.puts(MyIO == Elixir.IO)
# -> true
```

```elixir
def parse_status("draft"), do: {:ok, :draft}
def parse_status("published"), do: {:ok, :published}
def parse_status(_), do: {:error, :invalid_status}
```

## Bool

Elixir의 `true`, `false`는 atom이고 `boolean()` type은 `true | false`이다.<br>
`and`, `or`, `not`은 boolean 전용이고 `&&`, `||`, `!`는 truthy/falsy 연산이다. `nil`과 `false`만 falsy다.

Elixir 1.18부터 `unless`는 soft deprecated다. 새 코드에서는 `unless`보다 `if`, `case`, multi-clause function을 쓴다. 양쪽 branch가 값을 반환하고 strict boolean을 기대하면 `case bool do true -> ...; false -> ... end`가 더 명확하다.

```elixir
(true == true) |> IO.puts()

# and
(true and false) |> IO.puts()

# or
(false or true) |> IO.puts()

# not
(not false) |> IO.puts()

# ||, &&, ! 사용 가능
# 5
(nil || false || 5 || true) |> IO.puts()
# 6
(true && 6) |> IO.puts()
IO.puts(!true)

# nil 여부는 boolean predicate로 만든 뒤 not을 쓴다.
not is_nil(:an_atom_other_than_true_or_false)
```

## Tuples

고정된 수의 요소를 그룹화할때 사용

```elixir
person = {"Bob", 25}

# 튜플에서 요소를 추출하려면 Kernel.elem을 사용할 수 있다.
# Kernal 모듈은 auto import 되므로 바로 사용 가능.
age = elem(person, 1)

# 수정하려면 아래와 같이 가능
# {"Bob", 26}
put_elem(person, 1, 26)

# with List

# atom으로 찾을시 {{a: 1}, {b: 2}}로 취급함
# [b: 2]
List.keydelete([a: 1, b: 2], :a, 0)
# {:b, 2}
List.keyfind([a: 1, b: 2], :b, 0)
# {:b, 2}
List.keyfind([a: 1, b: 2], 2, 1)
# List.keyfind([a: 1, b: 2], :c, 0) # nil
```

```elixir
# 수정된 튜플은 항상 이전 버전의 얕은 복사본입니다.
[a, b, c] = [~c"a", ~c"b", ~c"c"]
b2 = ~c"b2"
a_tuple = {a, b, c}
new_tuple = put_elem(a_tuple, 1, b2)

# 리바인드를 하면 가비지 콜렉션이 됩니다.
```

## Lists

목록은 배열처럼 보이지만 singly linked lists처럼 작동한다. 목록으로 작업을 수행하려면 탐색해야한다.
https://hexdocs.pm/elixir/main/List.html

```elixir
prime_numbers = [2, 3, 5, 7]
length(prime_numbers)

# 재귀 목록 정의 (Recursive list definition)
list = [1, 2, 3]
# list = [1 | [2 | [3 | []]]] # 재귀 목록식 정의
# fast, [0, 1, 2, 3]
[0 | list]
# slow, [1, 2, 3, 4]
list ++ [4]

# concats, delets
# [1, 2, 3, 4, 5, 6]
[1, 2, 3] ++ [4, 5, 6]
# [1, 2, 3, true]
[1, true, 2, false, 3, true] -- [true, false]

# head, tail
# [head | tail] = [1, 2, 3]
# head # 1
# tail # [2, 3]

# delete
# [:a, :b, :c]
List.delete([:a, :b, :b, :c], :b)
# [1, 2]
List.delete_at([1, 2, 3], -1)

# foldl, foldr
# {6, -6}
List.foldl([1, 2, 3], {0, 0}, fn x, {a1, a2} -> {a1 + x, a2 - x} end)
# -2
List.foldr([1, 2, 3, 4], 0, fn x, acc -> x - acc end)

# flatten
# [1, 2, 3]
List.flatten([1, [[2], 3]])

# first, last
# 1
List.first([1, 2, 3])
# 3
List.last([1, 2, 3])
# with default, 7
List.last([], 7)

# replace
# [0, 2, 3]
List.replace_at([1, 2, 3], 0, 0)
# [1, 2, 0]
List.replace_at([1, 2, 3], -1, 0)

# zip
# [{1, 3, 5}, {2, 4, 6}]
Enum.zip([[1, 2], [3, 4], [5, 6]])
# to_tuple
# {:share, [:elixir, 163]}
List.to_tuple([:share, [:elixir, 163]])
```

List의 꼬리쪽에 수정하게되면 앞에 있는 요소들을 전부 얕은 복사를 하므로 비용이 크게 든다. <br>
새 요소를 맨 앞으로 푸쉬하면 훨신 비용이 적게 든다

Elixir 1.18부터 `List.zip/1`는 deprecated이고 `Enum.zip/1`을 쓴다. Elixir 1.20 계열에서는 `List.first!/1`, `List.last!/1`도 추가되어 "없으면 터져야 하는" invariant를 명확히 표현할 수 있다.

## Maps

맵은 키와 값이 임의의 용어일 수 있는 키-값 저장소입니다. Elixir에서는 지도를 두 가지 용도로 사용합니다. 이는 동적으로 크기가 조정된 키-값 구조를 강화하는 데 사용되지만 간단한 레코드(잘 정의된 두 개의 이름이 함께 묶인 필드)를 관리하는 데에도 사용됩니다.

OTP 26 이후 map은 record-like data와 dictionary에서 더 공격적으로 최적화됐다. record-like map은 key가 compile-time에 정해져 있고 32개 이하일 때 가장 좋다. 새 인스턴스는 같은 constructor 함수에서 모든 key를 넣어 만들고, 이미 존재해야 하는 key는 `%{map | key: value}` update를 쓴다.

OTP 26부터 `:maps.merge/2`는 small map의 key tuple sharing을 더 잘 활용한다. default가 많은 map을 여러 번 `Map.get(map, key, default)`로 읽는 것보다 default map을 한 번 `Map.merge(defaults, input)` 하는 쪽이 나을 수 있다. OTP 28부터는 compiler가 `maps:put/3` 계열을 map syntax로 rewrite할 수 있고, OTP 29에서는 map을 순회하는 여러 API의 iteration order가 같은 map에 대해 일관되게 정리됐다. 그래도 map order 자체는 business rule로 삼지 않는다. 출력 순서가 중요하면 `Enum.sort/1`를 명시한다.

Elixir 1.20 계열 type checker는 `Map.put/3`, `Map.delete/2`, `Map.fetch!/2`, `Map.update!/3` 같은 연산으로 key가 추가/삭제/필수화되는 흐름까지 추적한다. 그래서 map shape가 domain contract라면 `Map.fetch/2`와 pattern matching을 더 적극적으로 쓰는 편이 warning 품질이 좋다.

```elixir
empty_map = %{}
squares = %{1 => 1, 2 => 4, 3 => 9}

# Map.new로 튜플을 받아 생성 가능
squaresFromTuple = Map.new([{1, 1}, {2, 4}, {3, 9}])

# 4
squares[2]

## Map.get을 사용해서도 가져올 수 있음. 3번째 인자를 넣을시 default 값
# nil
Map.get(squares, 4)
# not_found
Map.get(squares, 4, :not_found)

## 안전하게 값 가져오기
# :ok, :error 와 함께 가져옴
# {:ok, 4}
Map.fetch(squares, 2)
# :error
Map.fetch(squares, 4)
# 값이 없는 경우 예외 발생 시키고자 할때 !를 써줌
# Map.fetch!(squares, 4)

## 값 추가
# Map.put(squares, 4, 16) # %{1 => 1, 2 => 4, 3 => 9, 4 => 16}

## 다음과 같이 map을 사용하여 데이터를 관리하는 것은 엘릭서에서 자주 사용되는 패턴임. 특히 데이터가 동적인 경우!
# 키가 원자인 경우 다음과 같이 짧게 만들 수 있음
bob = %{name: "Bob", age: 25, works_at: "Initech"}

# 값 수정
# %{age: 26, name: "Bob", works_at: "Initrode"}
next_years_bob = %{bob | age: 26, works_at: "Initrode"}
```

```elixir
defaults = %{active?: true, role: :member}

def normalize_user(input) do
  Map.merge(defaults, input)
end

def require_email(user) do
  case Map.fetch(user, :email) do
    {:ok, email} when is_binary(email) -> {:ok, email}
    _ -> {:error, :email_required}
  end
end
```

## Binaries, bitsequence, bitstring, string, Character lists

```elixir
# 바이너리는 바이트 덩어리이다
# 3byte
<<1, 2, 3>>

# 255보다 큰 값을 제공하면 바이트 크기에 맞게 잘립니다.
# <<3>>
<<259>>

# 각 값의 크기를 지정할 수 있으므로 해당 특정 값에 사용할 비트 수를 컴파일러에 알릴 수 있습니다.
# <<1, 3>>
<<259::16>>

# 모든 값의 크기가 8의 배수가 아닌 경우 비트 시퀀스라고 한다.
# <<5::size(3)>>
<<1::1, 0::1, 1::1>>

# <>를 사용하여 바이너리 또는 비트열을 연결할 수 있다.
# <<1, 2, 3, 4>>
<<1, 2>> <> <<3, 4>>
```

binary pattern에서 size가 기존 변수라면 Elixir 1.20 계열부터 pin을 명시하는 방향으로 간다. 새 코드에서는 "값을 새로 bind"하는 것과 "기존 size 값을 사용"하는 것을 분리해서 쓴다.

```elixir
size = 4
<<prefix::binary-size(^size), rest::binary>> = "ping-pong"
# prefix == "ping"
# rest == "-pong"
```

바이너리 문자열

```elixir
# 바이너리 문자열

# 다음과 같이 ${}로 표현식 넣기 가능
str = "Embedded expression: #{3 + 0.14}"

# "\r \n \" \\" 이스케이프 사용 가능

# 줄로 끝날 필요 없음 (linebreak는 \n으로 들어감)
str = "
This is
a multiline string
"

# "\nThis is\na multiline string\n"

# heredocs 표현
str = """
Heredoc must end on its own line ""
ㅎㅎㅎ
"""

# "Heredoc must end on its own line \"\"\n"ㅎㅎㅎ\n

# sigils 표현 - 다음과 같이 따옴표 없이 ~s를 넣어 사용 가능. 따옴표를 포함하려는 경우 유용
str = ~s("Do... or do not. There is no try." -Master Yoda)

# ~S 대문자 사용시 보간이나 이스케이프를 처리하지 않는다
# "Not interpolated \\n value: \#{3 + 0.14}"
str = ~S(Not interpolated \n value: #{3 + 0.14})
```

#### Character lists

일반적으로 바이너리 스트링 (~s)를 더 선호해야 함<br>
ASCII의 범위 내에 있는 정수 코드의 리스트임

Elixir 1.17부터 single-quoted charlist는 deprecated다. charlist가 필요한 Erlang interop, legacy API, file path interop 같은 경우에만 `~c"ABC"`를 명시한다. 일반 application text는 binary string(`"ABC"`)을 쓴다.

```elixir
# ABC
IO.puts([65, 66, 67])

# ~c를 사용해서 생성 가능
# ABC
IO.puts(~c"ABC")

# 작은 따옴표 charlist는 deprecated
# 'ABC' 대신 ~c"ABC"
```

## IO lists

IO 목록은 바이트 스트림을 점진적으로 구축해야 할 때 유용합니다. 목록에 추가하는 것은 O(n) 작업이기 때문에 일반적으로 이 경우 목록은 효과적이지 않습니다. 대조적으로, IO 목록에 추가하는 것은 중첩을 사용할 수 있기 때문에 O(1)입니다.

내부적으로는 구조가 평면화되어 사람이 읽을 수 있는 출력을 볼 수 있습니다. IO 목록을 파일이나 네트워크 소켓으로 보내면 동일한 효과를 얻을 수 있습니다.

반복적으로 문자열을 만들 때 `<>`를 누적하지 말고 iodata를 누적한 뒤 마지막에 `IO.iodata_to_binary/1`를 호출한다. Elixir 1.20 계열에는 `IO.iodata_empty?/1`도 있어 nested iodata가 실제로 빈 출력인지 확인할 수 있다.

```elixir
iolist = []
iolist = [iolist, "This"]
iolist = [iolist, " is"]
iolist = [iolist, " an"]
iolist = [iolist, " IO list."]

# iolist # [[[[[], "This"], " is"], " an"], " IO list."]

# This is an IO list.
IO.puts(iolist)
```

## JSON

Elixir 1.18부터 built-in `JSON` module이 있다. 단순 encode/decode는 stdlib로 충분하다. 기존 Phoenix/Ecto 프로젝트가 `Jason`을 표준으로 쓰고 있으면 일관성을 위해 그대로 둘 수 있지만, 새 라이브러리나 dependency를 줄이고 싶은 작은 tool에서는 `JSON`을 먼저 본다.

`JSON.decode/1`은 `{:ok, term}` / `{:error, reason}`를 반환하고, `JSON.decode!/1`은 실패 시 raise한다. 외부 입력은 bang 함수보다 tuple 반환을 우선한다. network/socket에 바로 쓸 payload는 binary보다 `JSON.encode_to_iodata!/1`가 더 적합할 수 있다.

```elixir
case JSON.decode(payload) do
  {:ok, %{"id" => id}} when is_integer(id) ->
    {:ok, id}

  {:ok, _} ->
    {:error, :invalid_shape}

  {:error, reason} ->
    {:error, reason}
end

JSON.encode_to_iodata!(%{ok: true})
```

## Enum

Enum은 열거 가능한 구조를 다루며 List에만 국한되지 않는다. <br>
Enum의 함수들은 호출되면 모든 열거 가능한 항목을 순회하기 때문에 lazy하게 처리하고 싶다면 Stream 모듈을 사용하시오

Elixir 1.18+에서는 단순 "변환 후 합계/곱"에 `Enum.sum_by/2`, `Enum.product_by/2`를 쓸 수 있다. `Enum.map(... ) |> Enum.sum()`보다 의도가 직접적이고 intermediate list를 만들지 않는다. index 접근이 반복되면 `Enum.at/2` 대신 `Enum.with_index/1`, map, tuple, array 같은 자료구조를 다시 고른다.

[Enum 모듈 문서](https://hexdocs.pm/elixir/main/Enum.html)

[Enum Cheatsheet](https://hexdocs.pm/elixir/main/enum-cheat.html)

```elixir
orders = [%{total: 10}, %{total: 20}, %{total: 30}]

Enum.sum_by(orders, & &1.total)
# 60
```

## 일급 함수(익명 함수, 람다)

명명된 함수에 대해서는 괄호를 쓰지만, 람다는 괄호를 쓰지 않음<br>
변수 뒤에 .을 붙혀서 호출할 수 있음 (.)을 붙혀쓰게끔 하는 것은 명확하게 하기 위함임<br>

다른 함수의 인자로 전달 가능

```elixir
square = fn x -> x * x end

# 16
square.(4)

print_element = fn x -> IO.puts(x) end

Enum.each(
  [1, 2, 3],
  # or fn x -> IO.puts(x) end 직접 써도 무방
  print_element
)

# 1
# 2
# 3
# :ok

## 캡쳐 연산자
# &를 사용해 함수 한정자(모듈 이름, 함수 이름, 인자 개수)를 가져와 람다로 변환한다.
Enum.each(
  [11, 22, 33],
  &IO.puts/1
)

# 인자를 지정하여 람다 함수를 간략하게 만들 수 있음
# fn x, y, z -> x * y + z end
lambda = &(&1 * &2 + &3)

# 10
lambda.(2, 3, 4)

## closure
# 변수가 외부 범위에 속하더라도 참조를 보유함. 선언 시점에서 캡쳐함.
# 그래서 아래 코드에서 5가 가비지 콜렉션이 되지 않음.
outside_var = 5
lambda = fn -> IO.puts(outside_var) end
outside_var = 6
# 5
lambda.()
```

## 그 외 상위 레벨 유형1: Range, Keyword, MapSet, Stream, IO

[Range](https://hexdocs.pm/elixir/Range.html)<br>
[Keyword](https://hexdocs.pm/elixir/Keyword.html)<br>
[MapSet](https://hexdocs.pm/elixir/MapSet.html)<br>
[Stream](https://hexdocs.pm/elixir/Stream.html)

```elixir
## Range
# 범위를 표현하는 map이나 마찬가지므로, 메모리를 거의 차지하지 않음
# 1..2
range = 1..6
# true
2 in range

# [1, 4, 9, 16, 25, 36]
Enum.map(range, &(&1 * &1))

# Elixir 1.17+에서는 감소 range step을 명시한다.
Enum.to_list(10..1//-1)
# [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

## Keyword lists
# 키워드 목록은 각 요소가 두 요소로 구성된 튜플이고 각 튜플의 첫 번째 요소가 원자인 목록의 특별한 경우이다.
# 두 번째 요소는 모든 유형이 될 수 있다.
# 키가 원자인 작은 크기의 키-값 구조에 자주 사용됩니다
# List기반이기 때문에 복잡성은 O(n)이다.
# also [{:monday, 1}, {:tuesday, 2}, {:wednesday, 3}]
days = [monday: 1, tuesday: 2, wednesday: 3]

# 1
Keyword.get(days, :monday)
# nil
Keyword.get(days, :noday)
# 2
days[:tuesday]

# 키워드 목록은 클라이언트가 임의 개수의 선택적 인수를 전달할 수 있도록 하는 데 가장 유용하다.
# 이 패턴은 너무 자주 발생하기 때문에 Elixir에서는 마지막 인수가 키워드 목록인 경우 대괄호를 생략할 수 있다.
# also IO.inspect([100, 200, 300], [width: 3, limit: 1])
IO.inspect([100, 200, 300], width: 3, limit: 1)
# [100, ...]

# 키워드 대신 Map을 사용하는 것이 더 나은지 궁금할 수 있다.
# 키워드 목록에는 동일한 키에 대한 여러 값이 포함될 수 있다.
# 또한 키워드 목록 요소의 순서를 제어할 수 있습니다. 이는 Map에서는 ​​불가능한 일이다.
#
# Elixir 1.17+에는 Keyword.intersect/2-3이 있다.
# 허용된 option subset만 남길 때 직접 reduce하지 않는다.

## MapSet
# javascript의 set과 같다고 보면 됨. 열거 순서를 보장하지 않음
days = MapSet.new([:monday, :tuesday, :wednesday])
MapSet.new([:monday, :tuesday, :wednesday])

MapSet.member?(days, :monday)
# true

MapSet.member?(days, :noday)
# false

days = MapSet.put(days, :thursday)
MapSet.new([:monday, :tuesday, :wednesday, :thursday])

Enum.each(days, &IO.puts/1)
# monday
# thursday
# tuesday
# wednesday
```

## 2: Times, Date, DateTime

[Date](https://hexdocs.pm/elixir/Date.html)<br>
[Time](https://hexdocs.pm/elixir/Date.html)<br>
[DateTime](https://hexdocs.pm/elixir/DateTime.html)<br>
[NativeDateTime](https://hexdocs.pm/elixir/NaiveDateTime.html)

```elixir
## Dates
# ~D sigil을 사용해서 만들 수 있다.
date = ~D[2023-01-31]
# 2023
date.year

## Times
time = ~T[11:59:12.00007]
# 11
time.hour

## Datetime (UTC)
datetime = ~U[2023-01-31 11:59:12.000007Z]
# 2023
datetime.year
# "Etc/UTC"
datetime.time_zone

## NativeDatetime
naive_datetime = ~N[2023-01-31 11:59:12.000007]
# 2023
naive_datetime.year
# 11
naive_datetime.hour
```

Elixir 1.17부터 `Duration`과 `shift/2` 계열 API가 추가됐다. 날짜/시간에 "1개월", "1일" 같은 calendar-aware 변경을 할 때 단순 초/일수 덧셈으로 모델링하지 않는다. timeout도 `to_timeout/1`로 duration keyword를 명시하면 의도가 좋다.

```elixir
~D[2016-01-31]
|> Date.shift(month: 1)
# ~D[2016-02-29]

Process.send_after(self(), :wake_up, to_timeout(hour: 1))
```

## Macro

매크로는 입력 코드의 의미를 변경할 수 있는 Elixir 코드로 구성됩니다. 매크로는 항상 컴파일 타임에 호출됩니다. 입력 Elixir 코드의 구문 분석된 표현을 수신하고 해당 코드의 대체 버전을 반환할 기회가 있습니다.

중요한 점은 매크로가 컴파일 타임 코드 변환기라는 것입니다. 어떤 것이 매크로라는 것을 알 때마다 기본 의미는 그것이 컴파일 타임에 실행되고 대체 코드를 생성한다는 것입니다.

최신 Elixir에서는 macro보다 function, behaviour, protocol을 먼저 고른다. Macro는 DSL surface가 실제로 필요하거나 compile-time code generation이 책임일 때만 둔다. Elixir 1.16+ diagnostics가 좋아졌지만, macro가 만든 코드는 여전히 error span과 dependency tracking을 어렵게 만들 수 있다. macro를 쓸 때는 `quote bind_quoted: ...`로 변수를 명시적으로 주입하고, public macro에는 `@doc`과 예제를 남긴다.

매크로에 대해 배울라면 너무 양이 많으므로 [메타프로그래밍 가이드](https://hexdocs.pm/elixir/quote-and-unquote.html)를 보세요

## Elixir script, Mix, iex

#### Elixir

```shell
# 스크립트 실행
elixir script.exs

# BEAM 인스턴스 종료되지 않게 하려면 --no-halt
elixir --no-halt script.exs
```

<!-- livebook:{"break_markdown":true} -->

#### Mix

Mix 프로젝트를 시작하는 방법에 관계없이 ebin 폴더(.beam 파일이 있는 위치)가 로드 경로에 있으므로 VM이 모듈을 찾을 수 있습니다.

버전 기준:

- Elixir 1.16: OTP 26 시대의 diagnostics, docs, compiler warning 품질 개선이 핵심이다.
- Elixir 1.17: OTP 27 지원, `Duration`, `Date.shift/2`, `to_timeout/1`, 초기 set-theoretic type warning.
- Elixir 1.18: built-in `JSON`, type checking of function calls, `mix format --migrate`, `unless` soft deprecation.
- Elixir 1.19: OTP 28.1+ 지원, protocol type checking, `mix help Mod.fun/arity`, struct update 관련 warning 강화.
- Elixir 1.20 계열: OTP 27+ 필요, OTP 29 호환, guard/body/clause/map operation type inference 강화.

OTP 26까지 지원해야 하는 프로젝트는 Elixir 1.20으로 올릴 수 없다. OTP 26 runtime boundary가 남아있으면 Elixir 1.19 이하를 유지하고, OTP 27+로 올린 뒤 1.20 type checker 이점을 쓴다.

```shell
# 새 프로젝트 시작
mix new my_project

# 컴파일
mix compile

# 테스트
mix test

mix run -e "IO.puts(MyProject.hello())"

# deprecation migration
mix format --migrate

# OTP 27+ profiler
mix profile.tprof
```

## Pattern matching

\= 는 대입이 아닌 패턴 매칭이다.<br>
해당 케이스의 매칭이 아닐경우 에러가 발생한다.<br>
상수를 작성함으로써 특정 케이스에 매칭되도록 할 수 있다.

Elixir 1.17+ compiler는 pattern에서 얻은 type 정보를 warning에 사용한다. map/struct key 오타, 불가능한 binary match, struct field 접근 오류가 더 잘 잡힌다. Elixir 1.18+에서는 recursive variable pattern처럼 절대 matching 될 수 없는 형태가 compile error가 될 수 있으니, 같은 값을 요구하려면 pin(`^`)이나 guard를 명시한다.

### Tuple

```elixir
{name, age} = {"Bob", 25}
{:person, name, age} = {:person, "Bob2", 26}

# 오른 tuple의 2번째가 "Bob2"인 경우 에러가 발생
{:person, "Bob", age} = {:person, "Bob", 27}

# Bob2
IO.puts(name)
# 27
IO.puts(age)

# 대입이 아니기 때문에 아래와 같이 해도 에러가 나지 않음
# 1
1 = 1

## 매칭을 시키기 위해 주로 첫번째에 atom을 넣음
# Either같은 경우 :error, :ok 라는 atom을 자주 사용함.
{:error, reason} = File.read("my_app.config")
{result, reason2} = File.read("my_app.config")

# :error
IO.puts(result)

## _가 붙으면 익명 변수로서, 사용하면 컴파일러가 경고를 띄운다.
{_date, {hour, _, _}} = :calendar.local_time()
# 20
IO.puts(hour)

# 아래와 같이 같은 변수명으로 하면 값이 하나라도 다르면 에러가 발생
{a, a, a} = {127, 127, 127}

# 에러 발생!
# {a, a, a} = {127, 0, 127}

## 변수와 일치시키기 (^)
expected_name = "Bob"
{^expected_name, _} = {"Bob", 25}
# 에러 발생
# {^expected_name, _} = {"Bob2", 25}
```

### List, Map, binary

```elixir
first = 1
[^first, _, third] = [1, 2, 3]

%{age: age} = %{name: "Bob", age: 25}

binary = <<1, 2, 3>>

## 임의의 크기를 기대함
<<b1, rest::binary>> = binary

# rest # <<2, 3>>

## ::를 통해 4비트씩 나눔
<<a::4, b::4>> = <<155>>
# a # 9
# b # 11

## 문자열은 바이너리이므로 문자열에서 비트나 바이트를 추출 가능
<<b1, b2, b3>> = "ABC"
# b1 # 65

## 문자열의 시작 부분을 일치
command = "ping www.example.com"
"ping " <> url = command
# www.example.com
IO.puts(url)
```

### 복합 일치

```elixir
[_, {name, _}, _] = [{"Bob", 25}, {"Alice", 30}, {"John", 35}]

a = b = 1 + 3

date_time = {_, {hour, _, _}} = :calendar.local_time()

# date_time # {{2023, 11, 11}, {21, 32, 34}}
# hour #21
```

### 함수와의 매칭

```elixir
defmodule Geometry2 do
  # 위에서부터 매칭하므로 순서가 중요
  def area({:rectangle, a, b}) do
    a * b
  end

  def area({:square, a}) do
    a * a
  end

  def area({:circle, r}) do
    r * r * 3.14
  end

  # 모든 케이스가 매칭되므로 맨 아래에 와야한다!
  def area(unknown) do
    {:error, {:unknown_shape, unknown}}
  end
end

Geometry2.area({:rectangle, 4, 5})
# 20

Geometry2.area({:square, 5})
# 25

Geometry2.area({:circle, 4})
# 50.24

## 여러 절로 되어 있어도 단일 함수 취급을 받는다
fun = &Geometry2.area/1

# 50.24
fun.({:circle, 4})

# {:error, {:unknown_shape, {:triangle, 1, 2, 3}}}
Geometry2.area({:triangle, 1, 2, 3})

## 다중 절 람다
test_num = fn
  x when is_number(x) and x < 0 -> :negative
  x when x == 0 -> :zero
  x when is_number(x) and x > 0 -> :positive
end

# :positive
test_num.(2)

## 재귀 활용
defmodule Fact do
  def fact(0), do: 1
  def fact(n), do: n * fact(n - 1)
end

# 120
Fact.fact(5)

defmodule ListHelper do
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)
end

# 0
ListHelper.sum([])
# 6
ListHelper.sum([1, 2, 3])
```

### 가드

제한된 형태로 사용가능하다. https://hexdocs.pm/elixir/patterns-and-guards.html#guards 여기서 확인 가능

Elixir 1.20 계열에서는 guard의 type inference가 훨씬 중요해졌다. `when is_integer(id)` 같은 guard는 단순 runtime check가 아니라 이후 body type checking에도 정보를 준다. 비교 연산(`<`, `>`)은 term ordering 때문에 서로 다른 type에도 동작하므로, 숫자 의미라면 `is_number/1`, `is_integer/1` 같은 guard를 먼저 둔다. Elixir 1.19+에서는 `min/2`, `max/2`도 guard에서 사용할 수 있다.

```elixir
defmodule TestNum do
  def test(x) when x < 0 do
    :negative
  end

  def test(x) when x == 0 do
    :zero
  end

  def test(x) when x > 0 do
    :positive
  end
end

TestNum.test(-1)
# :negative

TestNum.test(0)
# :zero

TestNum.test(1)
# :positive

## 숫자가 아닌 값으로 해도 결과가 나온다.
# number < atom < reference < fun < port < pid <tuple < map < list < bitstring (binary)
# 순서에 따라 같은 유형이 아니더라도 <, >로 비교할  수 있기 때문이다.
TestNum.test(:not_a_number)
# :positive

## 그래서 아래와 같이 짜야 함
defmodule TestNum2 do
  def test(x) when is_number(x) and x < 0 do
    :negative
  end

  def test(x) when x == 0 do
    :zero
  end

  def test(x) when is_number(x) and x > 0 do
    :positive
  end
end
```

## 분기 표현

```elixir
defmodule UserExtraction do
  ## if
  def max(a, b) do
    if a >= b, do: a, else: b
  end

  ## Elixir 1.18+에서는 unless보다 if/case를 선호
  def min(a, b) do
    if a < b, do: a, else: b
  end

  ## cond
  # if-else-if 패턴과도 같은 맥락으로 사용
  def call_status(call) do
    cond do
      call.ended_at != nil -> :ended
      call.started_at != nil -> :started
      true -> :pending
    end
  end

  ## case를 태운 후 패턴 매칭
  # 실제로 다중절 방식이랑 차이가 없음
  # defp fun(pattern_1), do: ...
  # defp fun(pattern_2), do: ...

  def max2(a, b) do
    case a >= b do
      true -> a
      false -> b
    end
  end

  # 입력 map의 예
  # %{
  # "login" => "alice",
  # "email" => "some_email",
  # "password" => "password",
  # "other_field" => "some_value",
  # "yet_another_field" => "...",
  # ...
  # }

  # 필드 집합이 잘 정의되어 있고 미리 알려진 경우 원자로 나타낼 수 있다. 즉 아래와 같이 할 수 있다.
  # %{login: "alice", email: "some_email", password: "password"}

  defp extract_login(%{"login" => login}), do: {:ok, login}
  defp extract_login(_), do: {:error, "login missing"}

  defp extract_email(%{"email" => email}), do: {:ok, email}
  defp extract_email(_), do: {:error, "email missing"}

  defp extract_password(%{"password" => password}), do: {:ok, password}
  defp extract_password(_), do: {:error, "password missing"}

  ## case로 작성한다면 굉장히 지저분하게 된다.
  def bad_extract_user(user) do
    case extract_login(user) do
      {:error, reason} ->
        {:error, reason}

      {:ok, login} ->
        case extract_email(user) do
          {:error, reason} ->
            {:error, reason}

          {:ok, email} ->
            case extract_password(user) do
              {:error, reason} ->
                {:error, reason}

              {:ok, password} ->
                %{login: login, email: email, password: password}
            end
        end
    end
  end

  ## with로 이으면 실패시 함수의 결과가 바로 반환된다.
  def extract_user(user) do
    with {:ok, login} <- extract_login(user),
         {:ok, email} <- extract_email(user),
         {:ok, password} <- extract_password(user) do
      {:ok, %{login: login, email: email, password: password}}
    end
  end
end

# {:error, "login missing"}
UserExtraction.extract_user(%{})
# {:error, "email missing"}
UserExtraction.extract_user(%{"login" => "some_login"})

UserExtraction.extract_user(%{
  "login" => "some_login",
  "email" => "some_email"
})

# {:error, "password missing"}

UserExtraction.extract_user(%{
  "login" => "some_login",
  "email" => "some_email",
  "password" => "some_password"
})

# {:ok, %{email: "some_email", login: "some_login", password: "some_password"}}
```

최신 Elixir에서는 `unless`보다 `if`, `case`, multi-clause function을 우선한다. 특히 `if/else`로 값 선택을 할 때 truthy/falsy를 의도한 것인지, strict boolean을 의도한 것인지 구분한다. strict boolean이면 아래처럼 `case`가 더 명확하다.

```elixir
case ready? do
  true -> :run
  false -> :skip
end
```

Elixir 1.20 계열은 `case`, `cond`, `with`에서 occurrence typing을 수행한다. 앞 clause에서 `nil`을 처리하면 뒤 clause는 non-nil이라고 추론하는 식이다. 따라서 expected failure는 `{:ok, value}` / `{:error, reason}` 형태로 맞추고, `with`의 실패 반환 shape도 일관되게 유지하는 편이 compiler warning과 읽기 모두에 좋다.

## 반복

elixir에는 while이 없다. <br>
다만 마지막으로 호출하는 함수에 대한 꼬리재귀 최적화가 되어있어 스택이 쌓이지 않아 추가적인 메모리를 소모하지 않는다.

일반 collection 처리는 재귀보다 `Enum`, `Stream`, comprehension을 먼저 쓴다. 직접 재귀는 early termination, streaming parser, tree/graph traversal처럼 shape 자체가 재귀적인 경우에 둔다. 재귀 함수 안에서 `if/else`로 구조를 나누기보다 head/tail pattern과 guard clause를 여러 절로 나누면 type inference와 readability가 좋아진다.

<!-- livebook:{"reevaluate_automatically":true} -->

```elixir
defmodule IteratorStudy1 do
  def sum_positive_num([]), do: 0

  def sum_positive_num([head | tail]) when is_number(head) and head > 0 do
    head + sum_positive_num(tail)
  end

  def sum_positive_num([_head | tail]), do: sum_positive_num(tail)

  def nagative_list([]), do: []

  def nagative_list([head | tail]) when is_number(head) and head < 0 do
    [head | nagative_list(tail)]
  end

  def nagative_list([_head | tail]), do: nagative_list(tail)

  def sum_nums(enumerable) do
    Enum.reduce(enumerable, 0, &add_num/2)
  end

  defp add_num(num, sum) when is_number(num), do: sum + num
  defp add_num(_, sum), do: sum
end

IteratorStudy1.sum_positive_num([1, 6, 8, 3, -3])

IteratorStudy1.nagative_list([5, 8, 2, -6, -1, 7, -4])

Enum.reduce(
  [1, 2, 3],
  0,
  # + 함수의 2인자 바인드
  &+/2
)

# 6

# 10
IteratorStudy1.sum_nums([1, "not a number", 2, :x, 3, 4])
```

## Comprehensions

https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1

Elixir 1.19+ type checker는 `for` generator가 `Enumerable` protocol을 구현하지 않는 값을 받으면 warning을 낸다. comprehension은 "여러 generator + filter + collect"가 핵심일 때 쓰고, 단순 map/filter 한두 단계면 `Enum`/`Stream`이 더 읽기 쉽다. binary generator에서는 element type이 byte/codepoint인지 명확히 하려면 `<<x <- binary>>`와 `<<x::utf8 <- binary>>`를 구분한다.

```elixir

# 열거형 도우미 역할
for x <- [1, 2, 3] do
  x * x
end

# [{1, 1, 1}, {1, 2, 2}, {2, 1, 2}, {2, 2, 4}, {3, 1, 3}, {3, 2, 6}]
for x <- [1, 2, 3], y <- [1, 2], do: {x, y, x * y}

# 열거형이면 전부 가능
for x <- 1..9, y <- 1..9, do: x * y

# into: 콜렉션 지정
# 아래 같은 경우 Map을 지정해서 Map으로 수집됨
multiplication_table =
  for x <- 1..9, y <- 1..9, x <= y, into: %{} do
    {{x, y}, x * y}
  end

# 42
Map.get(multiplication_table, {6, 7})
# string으로 수집됨
# "helloworld"
for <<c <- " hello world ">>, c != ?\s, into: "", do: <<c>>

languages = [elixir: :erlang, erlang: :prolog, prolog: nil]

for {language, parent} <- languages, grandparent <- [languages[parent]] do
  {language, grandparent}
end

# [elixir: :prolog, erlang: nil, prolog: nil]

# 3 unique: 고유 값만  수집
# [2, 4, 6]
for x <- [1, 1, 2, 3], uniq: true, do: x * 2

## reduce: 누산기로 활용
# 대문자를 무시하고 소문자의 발생 횟수 계산
for <<x <- "AbCabCABc">>, x in ?a..?z, reduce: %{} do
  acc -> Map.update(acc, <<x>>, 1, &(&1 + 1))
end

# %{"a" => 1, "b" => 2, "c" => 1}
```

## Stream

Stream은 lazy한 enum이라 보면 된다. <br>
Stream에 대한 여러 처리는 평가될때 병합되어 계산된다.

Stream은 source가 크거나 무한하거나, 중간 결과를 만들면 손해가 클 때 쓴다. 마지막에는 반드시 `Enum.*`, `Stream.run/1`, `File.write` 같은 consumer가 있어야 실행된다. side effect만 소비한다면 `Enum.to_list()`로 억지 materialize하지 말고 `Stream.run/1`을 쓴다.

```elixir

# 아래 예에서 filter, map 등의 처리들은 여러번 순회가 아닌 한번의 순회에서 처리되도록 병합됨.
# 지연 계산을 하려면 계산을 수행하는 람다를 반환해야 한다.
[9, -1, "foo", 25, 49]
|> Stream.filter(&(is_number(&1) and &1 > 0))
|> Stream.map(&{&1, :math.sqrt(&1)})
|> Stream.with_index()
|> Enum.each(fn {{input, result}, index} ->
  IO.puts("#{index + 1}. sqrt(#{input}) = #{result}")
end)

# 파일 이름을 받아 해당 파일에서 80자보다 긴 모든 줄의 목록을 반환합니다.
defmodule StudyStream do
  def large_lines!(path) do
    File.stream!(path)
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Enum.filter(&(String.length(&1) > 80))
  end
end

## 무한 컬렉션 생성
natural_numbers =
  Stream.iterate(
    1,
    fn previous -> previous + 1 end
  )

# [1, 2, 3, 4, 5, 6, 7]
Enum.take(natural_numbers, 7)

# iex에서 빈 입력을 받으면 중지
# Stream.repeatedly(fn -> IO.gets("> ") end)
#   |> Stream.map(&String.trim_trailing(&1, "\n"))
#   |> Enum.take_while(&(&1 != ""))

# in iex
# > Hello
# > World
# ["Hello", "World"]
```

## 데이터 추상화

```elixir
defmodule TodoList_proto1 do
  def new(), do: %{}

  def add_entry(todo_list, date, title) do
    Map.update(
      todo_list,
      date,
      [title],
      fn titles -> [title | titles] end
    )
  end

  def entries(todo_list, date) do
    Map.get(todo_list, date, [])
  end
end
```

```elixir

# 위의 코드를 Composing abstractions(추상화 구성) 을 통하면 더 깔끔하게 할 수 있다.
# 책임을 별도의 추상화로 추출하는 고전적인 관심사 분리 방법

# 구현을 Map으로 할 시 런타임시 인스턴스 구별이 불가능함. 이러한 경우를 위해 struct(구조체)가 있음
defmodule MultiDict do
  def new(), do: %{}

  def add(dict, key, value) do
    Map.update(dict, key, [value], &[value | &1])
  end

  def get(dict, key) do
    Map.get(dict, key, [])
  end
end

defmodule TodoList_proto2 do
  def new(), do: MultiDict.new()

  def add_entry(todo_list, entry) do
    MultiDict.add(todo_list, entry.date, entry)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end
end

todo_list =
  TodoList_proto2.new()
  |> TodoList_proto2.add_entry(%{date: ~D[2023-12-19], title: "Dentist"})
```

## Struct (구조체)

구조체는 단순한 맵이므로 성능 및 메모리에서 동일한 특성을 갖는다. <br>
하지만 구조체 인스턴스는 맵으로 수행할 수 있는 일부 작업이 작동하지 않는다. (예: enum)

Map.to\_list(one\_half) # \[**struct**: Fraction, a: 1, b: 2] <br>
처럼 **struct** 비트가 있는데, 구조체에 자동으로 포함되어 적절한 런타임 디스패치와 패턴 일치에 사용됩니다.

https://hexdocs.pm/elixir/Kernel.html#defstruct/1

최신 Elixir에서는 struct를 "이름 붙은 map" 이상으로 다루는 편이 좋다. `@enforce_keys`로 constructor invariant를 잡고, public constructor에서 값 검증을 한다. update는 `%{struct | key: value}` 또는 `%Module{struct | key: value}`를 쓰되, Elixir 1.19+에서는 struct update 전에 값이 해당 struct임을 pattern match 하는 흐름이 더 권장된다.

OTP 28/Elixir 1.19 이후 regex literal은 struct default field로 두지 않는다. `defstruct regex: ~r/foo/` 대신 constructor에서 넣는다.

```elixir
defmodule Filter do
  @enforce_keys [:name]
  defstruct [:name, :regex]

  def new(name) when is_binary(name) do
    %Filter{name: name, regex: ~r/foo/}
  end

  def rename(%Filter{} = filter, name) when is_binary(name) do
    %{filter | name: name}
  end
end
```

```elixir

# 만약에 프로그램에서 분수만을 처리한다고 했을때 문제가 생길 여지가 많음.
# 이런 경우 작은 추상화를 하는게 좋음

defmodule Fraction do
  defstruct a: nil, b: nil

  def new(a, b) do
    %Fraction{a: a, b: b}
  end

  def value(%Fraction{a: a, b: b}) do
    a / b
  end

  def add(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) do
    new(a1 * b2 + a2 * b1, b1 * b2)
  end
end
```

```elixir
one_half = %Fraction{a: 1, b: 2}

# success
%Fraction{} = one_half
# %Fraction{} = %{a: 1, b: 2} # fail

# Map과 같이 업데이트 가능
# %Fraction{a: 1, b: 4}
one_quarter = %Fraction{one_half | b: 4}

Fraction.new(1, 2)
|> Fraction.add(Fraction.new(1, 4))
# 0.75
|> Fraction.value()
```

## Inspect

기본적으로 Elixir는 모든 데이터를 공개한다. <br>
Kernel.inspect/1 함수를 재정의하여 출력시 다르게 보이게 할 수는 있다. <br>
디버깅을 하는데 유용하지만 너무 믿지는 말라. <br>

민감한 값이 있는 struct는 `@derive {Inspect, except: [...]}` 또는 custom `Inspect` implementation으로 숨긴다. Elixir 1.18+의 `dbg`는 `if`, `with`, code block 출력이 좋아졌고, Elixir 1.20 계열은 pipe 중간 결과를 더 잘 보여준다. 장기적으로 남길 로그는 `IO.inspect/2`보다 `Logger`를 쓰고, OTP 27+/Elixir 1.17+에서는 `Process.set_label/1`로 process label을 남기면 Logger와 test output 추적이 쉬워진다.

디버깅에는 다음과 같은 매크로도 있다.
https://hexdocs.pm/elixir/Kernel.html#dbg/2

```elixir

# MapSet.new([:monday])
MapSet.new([:monday])
# %{__struct__: MapSet, map: %{monday: []}}
IO.puts(inspect(MapSet.new([:monday]), structs: false))

# 다음과 같이 디버깅을 할 수 있다.
Fraction.new(1, 4)
|> IO.inspect()
|> Fraction.add(Fraction.new(1, 4))
|> IO.inspect()
|> Fraction.add(Fraction.new(1, 2))
|> IO.inspect()
|> Fraction.value()
```

## 증분 ID

```elixir

# id를 키로 하는 예제, 그러면 별도의 ModuleDics 같은 추상화가 필요 없어짐  
defmodule TodoList_proto3 do
  defstruct next_id: 1, entries: %{} 

  @type input_todo_item :: %{date: Date.t(), title: String.t()}
  @type todo_item :: %{id: integer(), date: Date.t(), title: String.t()}
  @type todo_list :: %{integer() => todo_item()}
  @type t :: %TodoList_proto3{next_id: pos_integer(), entries: %{integer() => todo_item()}}
  @type updater :: (todo_item() -> todo_item())

  def new() do
    %TodoList_proto3{}
  end

  # 함수가 중간에 실패한다면 모든 변경사항이 적용되지 않음.
  # 모두 적용 되거나, 모두 안되거나 둘 중 하나임
  @spec add_entry(t(), input_todo_item()) :: t()
  def add_entry(todo_list, entry) do
    # 새 항목의 ID를 설정합니다.
    entry = Map.put(entry, :id, todo_list.next_id)

    # 항목 목록에 새 항목을 추가
    new_entries =
      Map.put(
        todo_list.entries,
        todo_list.next_id,
        entry
      )

    # struct 구조체를 업데이트
    %TodoList_proto3{todo_list | entries: new_entries, next_id: todo_list.next_id + 1}
  end

  @spec entries(t(), Date.t()) :: [todo_item()]
  def entries(todo_list, date) do
    todo_list.entries
    |> Map.values()
    |> Enum.filter(fn entry -> entry.date == date end)
  end

  # 연습과제1 - 항목 업데이트
  @spec update_entry(t(), integer(), updater()) :: t()
  def update_entry(todo_list, entry_id, updater_fun) do
    # Map.fetch/2는 항목을 찾아서 존재하면 {:ok, value}, 없으면 :error를 반환
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList_proto3{todo_list | entries: new_entries}
    end
  end

  # 연습과제2 - 항목 삭제
  @spec delete_entry(t(), integer()) :: t()
  def delete_entry(todo_list, entry_id) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entries = Map.delete(todo_list.entries, old_entry.id)
        %TodoList_proto3{todo_list | entries: new_entries}
    end
  end
end

todo_list =
  TodoList_proto3.new()
  |> TodoList_proto3.add_entry(%{date: ~D[2023-12-19], title: "Dentist"})
  |> TodoList_proto3.add_entry(%{date: ~D[2023-12-20], title: "Shopping"})
  |> TodoList_proto3.add_entry(%{date: ~D[2023-12-19], title: "Movies"})

TodoList_proto3.entries(todo_list, ~D[2023-12-19])
|> IO.inspect(pretty: true, label: "hihi2")

todo_list =
  TodoList_proto3.update_entry(
    todo_list,
    1,
    &Map.put(&1, :date, ~D[2023-12-20])
  )

inspect(todo_list)

## 업데이트 도우미 매크로
# 재귀적으로 변경 후 상위 단에 상위 요소를 불변적으로 업데이트한다.
# @see https://hexdocs.pm/elixir/Access.html
# Kernel Module의 put_in, get_in, update_in, get_and_update_in
todo_map = %{
  1423 => %{date: ~D[2023-12-19], title: "Dentist"},
  8232 => %{date: ~D[2023-12-20], title: "Shopping"},
  9423 => %{date: ~D[2023-12-19], title: "Movies"}
}

todo_map = put_in(todo_map[8232].title, "Theater")
# put_in(todo_map, [8232, :title], "Theater")

TodoList_proto3.delete_entry(todo_list, 2)
```

## csv file -> todolist 연습문제

### 요구사항

파일을 읽어서 TodoList의 모양을 반환해라

```elixir
defmodule TodoList_proto3.CsvImporter do
  @spec from_file(Path.t()) :: TodoList_proto3.t()
  def from_file(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn v ->
      [date, name] = String.split(v, ",", trim: true)
      %{date: Date.from_iso8601!(date), title: name}
    end)
    |> Enum.reduce(TodoList_proto3.new(), &TodoList_proto3.add_entry(&2, &1))
  end
end

TodoList_proto3.CsvImporter.from_file(
  "/Users/hj/study/elixir-action/livebook/2024_03_24/10_26_57ke/files/data.csv"
)
```

## References

- https://github.com/elixir-lang/elixir/blob/v1.16/CHANGELOG.md
- https://github.com/elixir-lang/elixir/blob/v1.17/CHANGELOG.md
- https://github.com/elixir-lang/elixir/blob/v1.18/CHANGELOG.md
- https://github.com/elixir-lang/elixir/blob/v1.19/CHANGELOG.md
- https://github.com/elixir-lang/elixir/blob/v1.20/CHANGELOG.md
- https://hexdocs.pm/elixir/main/gradual-set-theoretic-types.html
- https://www.erlang.org/blog/otp-26-highlights/
- https://www.erlang.org/blog/highlights-otp-29/
- https://www.erlang.org/doc/system/maps.html
