---
{"publish":true,"aliases":[],"created":"2025.10.02 목 오후 17:31","modified":"2025.10.13 월 오후 12:22","published":"2025-10-13T12:22:09.331+09:00","tags":["typescript"],"cssclasses":"","createdAt":"2025.10.02 목 오후 17:31","modifiedAt":"2025.10.13 월 오후 12:22","};\n```\n\n위와 같이 에러에 대한 선언을 해주고 S.make (Schema Make)와 AST.setAnnotation을 통해 기존의 AST에 대한 Annotation을 추가한다.\n\n### SchemaError Annotation을 가져오기 위한 함수 정의\n\n먼저 함수 합성을 도와줄 유틸을 하나 만들었다.\n\n@fp-ts/core/Function의 compose를 flip시키면 제네릭 타입이 unknown으로 깨지더라... 그래서 새로 정의했음.\n\n```typescript\n// 함수 합성을 순차적으로 시키는 함수 (compose의 revserse)\n// const composeR = flip(compose);\n// compose를 flip시키면 generic타입이 깨져서 새로 만듦\n// composeR ":"(a -> b) -> (b -> c) -> a -> c","    flow(ab, bc);\n```\n\n나만의 꿀팁인데 주석으로 하스켈식 타입선언을 적어두면 **[composeR ":"(a -> b) -> (b -> c) -> a -> c]** 특히 core한 함수인 경우 직관적인때가 많다.","\ncomposeR은 첫번째로 a -> b 함수를 받고 두번째로 b -> c 함수를 받은 다음 a를 받아 c를 리턴하게끔 함수를 순차합성하는 함수라는 것을 알 수 있다.\n\ncompose의 경우 역순차 합성이라 **[compose ":"(b -> c) -> (a -> c) -> a -> c]** 처럼 되어있다.","\nschema에 해당 annotation이 있으면 Some<AnnotationX>, 없으면 None으로 던져준다. \n\ngetAnnotationX에도 Option을 사용함으로써 값이 있음과 없음이 명백하다.\n\n예를 들어 undefined 같은 값으로 정의해둔 에러가 있음과 없음을 구분하려면 이것이 에러 값이 undefined인지 에러가 없는 건지 구분할 수 없을 것이다.\n\n여기서 일반적인 케이스인 경우에 첫번째로 검출된 에러만 필요하므로 첫번째 에러만 가져와서 넘겨주는 코드를 작성했다.\n\n위에 4. ParseResult에서 정의된 것처럼 **실패했을 경우 Left<NonEmptyReadonlyArray<ParseError>>**를 리턴하기 때문에 NonEmptyReadonlyArray<ParseError>를 받아서 맨 첫번째의 ParseError만 추출하는 함수를 끼워주면 앞으로 쭉 편한할 것이다.\n\n```typescript\n// 지정한 AnnotationX에 대한 첫번째 Error의 Annotation을 가져온다.\n// getFirstAnnotationX ":"<A>AnnotationGetter<A> -> NonEmptyReadonlyArray<PR.ParseError> -> Option<A>","composeR ":"(a -> b) -> (b -> c) -> a -> c","compose ":"(b -> c) -> (a -> c) -> a -> c"}
---


## 과거 2023.2.6에 [작성했던 글](https://gggururu.tistory.com/107)

---

선행으로 [Either](https://gcanti.github.io/fp-ts/modules/Either.ts.html)과 [Option](https://gcanti.github.io/fp-ts/modules/Option.ts.html)에 대한 이해가 필요합니다.

 fp-ts가 3버전으로 개발하면서 기존의 [io-ts](https://github.com/gcanti/io-ts)를 [fp-ts/schema](https://github.com/fp-ts/schema)가 대체하게 된다.

아직 레포가 생성된지 오래되지 않아 부족한 것이 있겠지만, 기존의 io-ts보다 훨신 진일보한 모습에 반해 파고들게 되었다.

zod에 대비해 뚜렷한 강점도 보이고 fp-ts를 기존에 사용하던 유저라면 같이 쓰기에 훨신 강력할 수 있을 것 같다.

사용하기에 앞서 먼저 사전 지식에 대해 설명하겠다.

#### 0. AST

AST 유형은 ADT(대수 데이터 유형), 즉 구조체 및 튜플과 같은 공용체에 대한 명세서이다.

Schema에서의 AST는 더 대략적이고 작은 부분을 다룬다.

밑에 설명할 Schema는 AST의 wrapper라고 이해하면 쉽다.

#### 1. Schema

스키마는 유효성 검사, 변환을 하기 위해 작성된 명세서이며 이 스키마에 유효성 검사를 추가하던 데이터 변환을 추가하던 무조건 Schema가 리턴된다.

이 점이 zod랑은 다른 좋은 점이다. zod는 변환을 하거나 하면 다른 타입을 가지게 된다.

그로 인해 endomorphism를 활용한 관계를 활용할 수 있다. pipe를 통해 스키마를 이음으로써 간단하게 유효성 검사∙변환을 추가할 수 있다. 

기본적으로 string, number, date 등등의 primitive한 타입들의 스키마는 다 만들어놓았으며 기본적인 필터들도 여러가지 만들어 놓았다. 

#### 2. Decode

```
const myDecoder = decode(mySchema)
```

스키마를 통해 디코더를 생성한다.  

이 데이터를 받아 스키마의 명세에 따라 유효성 검사∙변환을 실행하는 주체이다.

#### 3. ParseResult

```
type ParseResult<A> = Either<NonEmptyReadonlyArray<ParseError>, A>;
```

ParseResult는 Either이다.

**성공했을시** 스키마 명세를 거친 최종 값을 Right<A>로 내뱉고

**실패했을시** Left<NonEmptyReadonlyArray<ParseError>>를 내뱉는다.

NonEmptyReadonlyArray이기 때문에 Left이면 첫번째 에러는 무조건 있다고 가정해도 된다.

배열형태로 에러를 내뱉는 이유는 구조체나 튜플 배열 형태를 유효성 검사를 할 수도 있으므로 에러가 여러개가 될 수 있기 때문.

#### 4. ParseError

```typescript
type ParseError = Type | Index | Key | Missing | Unexpected | UnionMember;
```

ParseError는 여러 유형의 에러 종류에 대한 유니온 타입이다.

설명은 [https://github.com/fp-ts/schema/blob/main/src/ParseResult.ts](https://github.com/fp-ts/schema/blob/main/src/ParseResult.ts) 여기에 주석으로 굉장히 잘 설명해놓았으니 가서 읽으면 이해하기 쉽다.

```typescript
export interface Type {
    readonly _tag: "Type";
    readonly expected: AST.AST;
    readonly actual: unknown;
}

export interface Key {
    readonly _tag: "Key";
    readonly key: PropertyKey;
    readonly errors: NonEmptyReadonlyArray<ParseError>;
}

...
```
여기서 우리가 선언하는 대부분의 유효성 검사 실패는 **Type**이라는 것만 알아 두자. 

그리고 expected에 아래 설명할 Annotation이 포함된다.

#### 5. Annotation

주석 스키마. 스키마에 여러 주석들을 달 수 있다.

이 주석은 기본적으로 선언해둔 여러가지가 있으며 각 명세가 실패하면 그 다음에 오는 주석을 적용시킨다.

[https://github.com/fp-ts/schema#annotations](https://github.com/fp-ts/schema#annotations) 참고

```typescript
export type Custom = unknown;
export declare const CustomId = "@fp-ts/schema/annotation/CustomId";

export type Message<A> = (a: A) => string;
export declare const MessageId = "@fp-ts/schema/annotation/MessageId";

export type Identifier = string;
export declare const IdentifierId = "@fp-ts/schema/annotation/IdentifierId";

export type Title = string;
export declare const TitleId = "@fp-ts/schema/annotation/TitleId";

export type Description = string;
export declare const DescriptionId = "@fp-ts/schema/annotation/DescriptionId";

export type Examples = ReadonlyArray<unknown>;
export declare const ExamplesId = "@fp-ts/schema/annotation/ExamplesId";

export type JSONSchema = object;
export declare const JSONSchemaId = "@fp-ts/schema/annotation/JSONSchemaId";

export type Documentation = string;
export declare const DocumentationId = "@fp-ts/schema/annotation/DocumentationId";
```

기본적으로 만들어놓은 주석은 위와 같다.

그러나 나만의 Annotation을 추가하기도 굉장히 쉬우므로 스키마가 실패했을시 다음 Annotation이 ParseError에 적용되는 것을 활용하여 나만의 Error Annotation을 만든 후 추가할 것이다.

---

## 코드

### Import

```typescript
import * as S from "@fp-ts/schema";
import * as E from "@fp-ts/core/Either";
import * as AST from "@fp-ts/schema/AST";
import * as PR from "@fp-ts/schema/ParseResult";
import * as O from "@fp-ts/core/Option";
import * as ID from "@fp-ts/core/Identity";

import { compose, flow, pipe } from "@fp-ts/core/Function";
import { LazyArg } from "@fp-ts/core/src/Function";
import { NonEmptyReadonlyArray } from "@fp-ts/core/ReadonlyArray";
```

위와 같이 내가 사용할 것들을 import 하였다.

### 에러 정의

```typescript
interface ErrorData<T extends string> {
  message: string;
  code: T;
}

export const SchemaErrorId = "@fp-ts/schema/annotation/SchemaError" as const;

export const schemaError =
  <T extends string>(errorData: ErrorData<T>) =>
  <A>(self: S.Schema<A>): S.Schema<A> =>
    S.make(AST.setAnnotation(self.ast, SchemaErrorId, errorData));

const unknownError: ErrorData<"unknown"> = {
  code: "unknown",
  message: "알 수 없는 에러가 발생했습니다.",
};
```

위와 같이 에러에 대한 선언을 해주고 S.make (Schema Make)와 AST.setAnnotation을 통해 기존의 AST에 대한 Annotation을 추가한다.

### SchemaError Annotation을 가져오기 위한 함수 정의

먼저 함수 합성을 도와줄 유틸을 하나 만들었다.

@fp-ts/core/Function의 compose를 flip시키면 제네릭 타입이 unknown으로 깨지더라... 그래서 새로 정의했음.

```typescript
// 함수 합성을 순차적으로 시키는 함수 (compose의 revserse)
// const composeR = flip(compose);
// compose를 flip시키면 generic타입이 깨져서 새로 만듦
// composeR :: (a -> b) -> (b -> c) -> a -> c
const composeR =
  <A, B>(ab: (a: A) => B) =>
  <C>(bc: (b: B) => C) =>
    flow(ab, bc);
```

나만의 꿀팁인데 주석으로 하스켈식 타입선언을 적어두면 **[composeR :: (a -> b) -> (b -> c) -> a -> c]** 특히 core한 함수인 경우 직관적인때가 많다.

composeR은 첫번째로 a -> b 함수를 받고 두번째로 b -> c 함수를 받은 다음 a를 받아 c를 리턴하게끔 함수를 순차합성하는 함수라는 것을 알 수 있다.

compose의 경우 역순차 합성이라 **[compose :: (b -> c) -> (a -> c) -> a -> c]** 처럼 되어있다.

[https://fp-ts.github.io/core/modules/Function.ts.html#compose](https://fp-ts.github.io/core/modules/Function.ts.html#compose) 

 [Function.ts

Function overview Added in v1.0.0 Table of contents instances getMonoid Unary functions form a monoid as long as you can provide a monoid for the codomain. Signature export declare const getMonoid: (Monoid: any) => () => any Example import { Predicate } fr

fp-ts.github.io](https://fp-ts.github.io/core/modules/Function.ts.html#compose)

이 compose의 특성을 이용해서 flow내에서 함수 합성을 하는 과정에서 아주 유용하므로 알아두는게 좋다.

그 후 error 태그에 대해 스위치문으로 각각에 행동을 정의해주면 된다.

나는 ParseError의 1depth 까지만 Type 에러가 있을 경우 Some, 아닌 경우 None을 리턴하는 방식으로 했는데, 더 깊은 뎁스까지 탐색하고 싶다면 재귀로 바꾸면 된다.  

```typescript
type AnnotationGetter<T> = (annotated: AST.Annotated) => O.Option<T>;
const getError = AST.getAnnotation<ErrorData<string>>(SchemaErrorId);

// ParseError를 받아 해당 에러의 ast를 통해 Annotation을 가져온다.
const getAnnotationX =
  <A>(getter: GetAnnotation<A>) =>
  (e: PR.ParseError): O.Option<A> => {
    switch (e._tag) {
      case "Missing":
      case "Index":
      case "Unexpected":
        return O.none();
      case "Key":
      case "UnionMember": {
        for (const error of e.errors) {
          if (error._tag !== "Type") continue;

          const annotation = getter(error.expected);
          if (O.isSome(annotation)) return annotation;
        }
        return O.none();
      }
      case "Type": {
        return getter(e.expected);
      }
    }
  };
```

[AST.getAnnotation](https://github.com/fp-ts/schema#annotations)은 fp-ts/schema/AST에 있는 함수로서 해당하는 AnnotationId를 사용해 schema의 ast로 부터 해당 Option<annotation>을 추출한다. 해당 annotation이 있을지 없을지 모르므로 Option 값으로 던져준다. 

schema에 해당 annotation이 있으면 Some<AnnotationX>, 없으면 None으로 던져준다. 

getAnnotationX에도 Option을 사용함으로써 값이 있음과 없음이 명백하다.

예를 들어 undefined 같은 값으로 정의해둔 에러가 있음과 없음을 구분하려면 이것이 에러 값이 undefined인지 에러가 없는 건지 구분할 수 없을 것이다.

여기서 일반적인 케이스인 경우에 첫번째로 검출된 에러만 필요하므로 첫번째 에러만 가져와서 넘겨주는 코드를 작성했다.

위에 4. ParseResult에서 정의된 것처럼 **실패했을 경우 Left<NonEmptyReadonlyArray<ParseError>>**를 리턴하기 때문에 NonEmptyReadonlyArray<ParseError>를 받아서 맨 첫번째의 ParseError만 추출하는 함수를 끼워주면 앞으로 쭉 편한할 것이다.

```typescript
// 지정한 AnnotationX에 대한 첫번째 Error의 Annotation을 가져온다.
// getFirstAnnotationX :: <A>AnnotationGetter<A> -> NonEmptyReadonlyArray<PR.ParseError> -> Option<A>
export const getFirstAnnotationX = flow(
  getAnnotationX,
  composeR((errors: NonEmptyReadonlyArray<PR.ParseError>) => errors[0]),
);
```

flow는 첫번째 함수의 인자를 받는다 **가정**하고 pipe처럼 이어준다.

composeR로 함수합성을 통해서 **NonEmptyReadonlyArray<PR.ParseError> -> Option<A> 이 중간다리 역할로 적용**되어 합성되었다.

원래라면 **getAnnotationX는 2차 함수의 인자로 단일 ParseError을 받으므로 flow로 잇지 못했을 것이다.**

그러나 그 중간다리의 역할로 **composeR**를 사용해 **NonEmptyReadonlyArray<ParseError> -> ParseError** 을 해주는 함수를 껴넣음으로써 잇는게 가증해진 것이다.

함수형적인 패턴을 활용해 Lazy dependency injection이 이렇게나 쉽다는 것을 알 수 있다.

심지어 내가 원하는 부분에 툭 추가해서 injection 되는 데이터를 이렇게 바꿀 수도 있지 않은가

이제 내가 설정한 에러 외의 변환이나 키가 없거나 하는 예외케이스가 있을 수 있으니 그런 경우에 발생할 defaultError를 미리 받아 던지게 할 것이다. 

```typescript
// Right인 경우는 Schema에설정해 놓은 에러, Left인 경우는 defaultError로 구분할 수 있다.
export const firstErrorWithDefault = (defaultError: ErrorData<string>) =>
  flow(getFirstAnnotationX(getError), ID.map(E.fromOption(() => defaultError)));
```

복잡성을 덜기 위해 getFirstAnnotationX의 1차 함수의 인자로 위에서 정의했던 getError 함수를 바인딩 해 주었다.

flow(getFirstAnnotationX(getError) 의 결과는 **getError함수를 바인딩 해줌으로써 1차 함수의 결과**가 나오고, **flow의 첫번째 인자로 들어감으로써 나중에 입력 받겠다는 Lazy dependency의 효과를 지니게 되어 2차 함수의 결과를 가정**하기 때문에 **Option<A>**가 리턴된다.

[ID.map](https://fp-ts.github.io/core/modules/Identity.ts.html#map)은 이럴 경우에 유용하다. 파이프의 앞쪽의 결과를 그대로(Identity) 사용할 경우 그 값에 적용할 함수를 넘겨주게 된다.

이게 흔히들 말하는 기본적인 [functor(펑터)](https://ncatlab.org/nlab/show/functor)의 적용이다.

[E.fromOption](https://fp-ts.github.io/core/modules/Either.ts.html#fromoption)의 앞의 E는 Either의 약자이다.

즉 **Option을 Either로 변환하면서 Right<A>의 경우 Some<A>, None인 경우에는 defaultError가 들어있는 Left<ErrorData<string>>를 반환**한다.

근데 아까 말했듯이 **Some인 경우에는 schema에 정의해둔 에러이므로** 즉

**right(schema의 에러) or left(defaultError)** 가 되는 것이다

위의 함수를 사용해서 Left인지 Right인지 알면 내가 설정해둔 에러랑 디폴트 에러(설정하지 않은 예외 에러)랑 구분할 수 있다.

그러나 나는 에러는 하나로 퉁친 방식을 사용하고 싶으므로 Left값과 Right값을 합쳐준다.

```typescript
// 위의 Right, Left 케이스를 하나로 합친다.
export const getFirstErrorWithDefault = flow(
  firstErrorWithDefault,
  compose(E.merge),
);
```

compose는 합성될 함수를 역순 (b -> c) -> (a -> b)로 받으므로 flow내에서 b -> c에 대한 함수의 내용을 미리 바인딩시켜 합성시킬 수 있다.

이 점에서 아주 유용하다.

[E.merge](https://fp-ts.github.io/core/modules/Either.ts.html#merge)를 사용하면 **Either의 Left, Right의 값을 union** 시켜서 받을 수 있다.

그렇다면 **Left, Right 구분이 필요 없으므로 Either를 벗긴 값이 나온다.**

즉 기존에 Either<ErrorData<string>>을 리턴하던 것에서 **ErrorData<string>을 리턴**하는 것으로 바꾼다.

그렇게 하면 내가 설정한 에러랑 디폴트 에러랑 구분할 수 없지만 ErrorData내에 code가 있으므로 여전히 에러를 식별할 수 있기 때문이다.

이제 일일히 에러일때의 처리를 하기 귀찮으므로 손쉽게 ParseResult를 통해 에러를 가져와야 할 것이다. 

여기서 나는 두가지의 함수를 작성했다.

하나는 Either로 리턴해서 에러가 발생하지 않았을때는 right(성공), left(실패)로 구분하는 함수.

또 하나는 굳이 내가 성공 값을 알 필요 없는 경우 Option으로 리턴해서 Some(실패), None(성공)로 구분하는 함수.

사실 첫번째 함수로만 사용해도 상관 없지만... 그냥 심심해서 두번째 것을 만들었다.

```typescript
// 1. ParseResult가 성공시 Right 값 리턴, 실패시 Left 
export const resultWithDefaultError = flow(
  getFirstErrorWithDefault,
  (errorFn) =>
    <A>(r: PR.ParseResult<A>) =>
      pipe(r, E.mapLeft(errorFn)),
);

// 2. ParseResult로 에러 여부 판별. none인 경우 에러가 없음을 의미한다.
export const result2ErrorWithDefault = flow(
  getFirstErrorWithDefault,
  (errorFn) =>
    <A>(r: PR.ParseResult<A>) =>
      pipe(E.getLeft(r), O.map(errorFn)),
);
```

이제 에러를 검출할 함수들을 다 만들었으니 스키마를 정의하고 디코딩을 해보겠다.

### 스키마 정의

```typescript
export const nameSchema = pipe(
  S.string,
  S.minLength(1),
  schemaError({
    code: "최소글자수미만",
    message: "한글자 이상 입력해줘",
  }),
  S.maxLength(8),
  schemaError({
    code: "최대글자수초과",
    message: "8글자 이하로 입력해줘",
  }),
  S.filter((s) => !/[^\w\s]/.test(s)),
  schemaError({
    code: "특수문자불가",
    message: "특수문자는 사용할 수 없어",
  }),
);

export const amountSchema = pipe(
  S.string,
  S.transform(S.number, Number.parseInt, String.toString),
  S.filter((n) => !Number.isNaN(n)),
  schemaError({
    code: "올바른형태아님",
    message: "숫자만 입력해줘",
  }),
  S.greaterThan(0),
  schemaError({
    message: "0원 넘게 입력해줘",
    code: "최소금액미만",
  }),
  S.lessThan(100000000),
  schemaError({
    message: "1억원 미만으로 입력해줘",
    code: "최대금액초과",
  }),
);
```

구조체 형태, 튜플, 배열 형태로도 할 수 있지만 일단 귀찮아서 이렇게만 했다.

### 디코딩 예

```typescript
const amountFail1 = S.decode(amountSchema)("123456789");
result2ErrorWithDefault(unknownError)(amountFail1); /*?*/
// some({message: '1억원 미만으로 입력해줘', code: '최대금액초과'})

const amountFail2 = S.decode(amountSchema)("천만원");
result2ErrorWithDefault(unknownError)(amountFail2); /*?*/
// some({message: '숫자만 입력해줘', code: '올바른형태아님'})

const amountFail3 = S.decode(amountSchema)("0");
result2ErrorWithDefault(unknownError)(amountFail3); /*?*/
// some({message: '0원 넘게 입력해줘', code: '최소금액미만'})

const amountSuccess = S.decode(amountSchema)("12345678");
const amountSuccessCase =
  resultWithDefaultError(unknownError)(amountSuccess); /*?*/
// right(12345678)

const nameFail1 = S.decode(nameSchema)("123456789");
const nameFailCase = result2ErrorWithDefault(unknownError)(nameFail1); /*?*/
// some({message: '8글자 이하로 입력해줘', code: '최대글자수초과'})

const nameFail2 = S.decode(nameSchema)("");
result2ErrorWithDefault(unknownError)(nameFail2); /*?*/
// some({message: '한글자 이상 입력해줘', code: '최소글자수미만'})

const nameFail3 = S.decode(nameSchema)("hihi!");
result2ErrorWithDefault(unknownError)(nameFail3); /*?*/
// some({message: '특수문자는 사용할 수 없어', code: '특수문자불가'})

const nameSuccess = S.decode(nameSchema)("42");
const nameSuccessCase =
  result2ErrorWithDefault(unknownError)(nameSuccess); /*?*/
// none

O.isSome(nameFailCase); /*?*/
// true
O.isNone(nameSuccessCase); /*?*/
// true

if (E.isRight(amountSuccessCase)) amountSuccessCase.right; /*?*/
// 12345678
```

보시다시피 잘 작동한다.

default error 내가 정하지 않은 에러가 나는 케이스는 배열의 올바르지 않은 index에 접근하거나, 구조체 형태에서 키가 없는 프로퍼티에 접근하는 것과 같은 기타 예외 상황에 날 것이다.

타입클래스와 함수형의 패턴을 활용하면 이렇게 각각의 과정을 작성하며 변화하는 형태를 전부 남길 수 있다.

순수하기 때문에 보시다시피 함수 합성이 매우 쉽고 중간 과정을 전부 다른 함수의 합성 과정에 활용 할 수 있다는 장점이 있다.

특히나 dependency injection의 방식이 매우 우아하지 않은가?

객체지향형으로 작성했을시에는 처음에 dependency injection을 하고 나서 그 값을 바꾸려면 사이드 이펙트가 필연적으로 발생할 수 밖에 없는데 함수지향형으로 작성하면 depencency ineject 방식이 Lazy하므로 그 과정을 블록 교체하듯이 바꿀 수 있다.

fp-ts/schema이 zod와 비견되는 장점이라면.. 스키마 정의의 형태들을 훨신 재활용하기 좋고(필터, 조건, 에러 everything is ast) Option, Either 기반으로 작성되어 throw되지 않는 에러 검출에 특화되어 있으며 모든 ast를 직접 정의할 수 있으므로 무한한 확장이 가능하다는 것이다.

다만... 사용하려면 fp-ts를 사용하는 것은 필수이다.

fp-ts를 사용한 함수지향형적 어플리케이션을 작성한다면 아주 좋은 선택지가 될 것이다.

객체지향적으로 어플리케이션을 작성한다 하더라도 함수적 패턴을 사용하여 합을 맞추면 객체지향에서 발생하는 허점을 매꿔주고 효율성을 증대시킬 수 있다. 그러니 pipe, flow, Option, Either 개념 부터 시작해서 천천히 적용하시는 것을 추천한다.  

[전체 코드는 여기서 봐주세요](https://github.com/rjcnd105/my-new-playgound/blob/main/apps/playground/src/lib/fpts/mySchemaError.ts)
