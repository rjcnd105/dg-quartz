---
{"publish":true,"created":"2025-08-01T01:20:19Z","modified":"2025-11-27T02:17:08Z","cssclasses":""}
---


### dev

|                   |                          |
| ----------------- | ------------------------ |
| nix flake, direnv | local db 실행, env setting |
| mise              | server, app 개발 툴 종속성 관리  |
| docker            |                          |
| kuber             |                          |

### server

|                |                          |
| -------------- | ------------------------ |
| elixir         | 언어                       |
| phoenix        | 서버 framework             |
| ash            | 리소스 framework            |
| ash typescript | (server) model 동기화 + rpc |
| ash events     | 작업 추적, 로그                |
| ash ai         | ai context 제공            |
| Beacon CMS     | cms                      |
| postgress      | db                       |
| docker(bake)   | 빌드                       |

### app

|                 |                          |
| --------------- | ------------------------ |
| react-native    | 앱                        |
| expo            | 앱 framework              |
| expo-dev-client | expo go 사용 x             |
| expo router     | 라우팅                      |
| eas             | expo build helper        |
| ash typescript  | (client) model 동기화 + rpc |
| unistyle        | style 라이브러리              |
| reanimated      | 애니메이션 라이브러리              |
| zod, arktype    | 스키마                      |
| mise            | ios, android 종속성 관리      |
| bunjs           | 모듈 관리, 패키지 관리            |

### web

|                |                          |
| -------------- | ------------------------ |
| tanstack start |                          |
| react          |                          |
| ash typescript | (client) model 동기화 + rpc |
| legend state   |                          |
| tailwind+css   | 스타일링                     |
| mise           |                          |
| zod, arktype   | 스키마                      |
| bunjs          | 모듈 관리, 패키지 관리            |

#### poc

상태관리
[signalium](https://github.com/Signalium/signalium)

로직
[runner](https://github.com/bluelibs/runner)
