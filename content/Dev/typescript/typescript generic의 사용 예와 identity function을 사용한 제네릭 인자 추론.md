---
{"publish":true,"created":"2025.10.02 목 오후 17:50","modified":"2025.10.14 화 오후 15:17","published":"2025-10-14T15:17:18.160+09:00","tags":["typescript"],"cssclasses":"","createdAt":"2025.10.02 목 오후 17:50","modifiedAt":"2025.10.14 화 오후 15:17"}
---


## 과거 2022.5.15에 [작성했던 글](https://gggururu.tistory.com/101)

---

```typescript
// 1. 타입을 추론하는 함수는 다음과 같이 작성
type MakeTuple = <T>(v: T) => [T, T]
const makeTuple: MakeTuple = (v) => [v, v] // OK
const tenTuple = makeTuple(10) // type: [number, number]

// 2. 타입을 선언시 명시하고 싶다면
type TypedMakeTuple<T> = (v: T) => [T, T]
const makeNumberTuple: TypedMakeTuple<number> = (v) => [v, v]
const oneTuple = makeNumberTuple(1) // type: [number, number]


// _MakeTuple은 망한 코드 (에러나 경고는 안남... 걍 주의하세요)
// _MakeTuple<T>와 <T>(v:T)에서의 T는 명백히 다른 T이며 _MakeTuple<T>의 T는 버려진다.
type _MakeTuple<T> = <T>(v: T) => [T, T]
```

![[env/첨부파일/101_1.png]]

위 코드에서의 3번 방식인 identity function을 활용하면 형태(타입클래스)는 지키면서 세부 구현에 대한 제네릭 인자는 추론을 맡길 수 있다.

위에서 나온 타입클래스가 무엇인지에 대한 내용은 여기에 잘 설명되어 있다. (type이나 class가 아닙니다)

[https://paulgray.net/typeclasses-in-typescript/](https://paulgray.net/typeclasses-in-typescript/)​
