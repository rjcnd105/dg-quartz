---
publish: true
created: 2023-09-27T07:17:10Z
modified: 2025-10-16T04:38:50Z
tags:
  - dotenv
  - token
  - test
cssclasses: ""
---


`2024.07.22 20:37`

안드로이드는 앱이 foreground일때 서버로부터 푸시가 수신되면 자동으로 알림창을 띄워주는 기능이 없어요. 그래서 수신을 받은 후 프로그램적으로 노티를 띄워주는데 이게 로컬 노티입니다.
반면에 iOS는 앱이 foreground일때 알림을 띄워주는 옵션 (`FirebaseMessaging.instance .setForegroundNotificationPresentationOptions`) 이 있어서 요것만 구성해주면 되어요.

***

로그인해서 토큰을 모노레포 루트의 .env.local에 저장
```js
const fs = require('fs')
const dotenv = require('dotenv')

const envFilePath = '../../.env.local'
/**
 * @typedef {Object} ENV
 * @property {string} STUDENT_ID
 * @property {string} STUDENT_PW
 * @property {string} STUDENT_TOKEN
 */
/**
 * @type {ENV}
 */
const existingEnv = dotenv.parse(fs.readFileSync(envFilePath))

fetch('https://~~~.com/login', {
  method: 'POST',
  body: JSON.stringify({
    id: existingEnv.STUDENT_ID,
    password: existingEnv.STUDENT_PW,
  }),
  headers: {
    'Content-Type': 'application/json'
  },
}).then(async (res) => {
  const { data } = await res.json()

  const mergedEnv = { ...existingEnv, STUDENT_TOKEN: data.token }
  const envString = Object.keys(mergedEnv)
    .map((key) => `${key}=${mergedEnv[key]}`)
    .join('\n')

  fs.writeFileSync(envFilePath, envString)

  console.table(Object.assign(mergedEnv))
  console.log(`${envFilePath}에 Token 저장 성공 `)
})

```
