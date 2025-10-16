---
{"publish":true,"created":"2025-08-29T03:58:41Z","modified":"2025-10-16T04:46:55Z","cssclasses":""}
---


modifiedAt: 2025.08.29 금 오후 13:22
---

```base
formulas:
  무제: file.folder
  무제 2: file.mtime.format("YY.MM.DD HH:MM")
properties:
  file.path:
    displayName: path
  file.mtime:
    displayName: updated
  file.size:
    displayName: size
  formula.무제:
    displayName: path
  file.folder:
    displayName: folder
  formula.무제 2:
    displayName: updated
views:
  - type: table
    name: 표
    order:
      - file.name
      - formula.무제 2
      - file.folder
      - file.size
    sort:
      - property: file.mtime
        direction: DESC
      - property: file.folder
        direction: ASC
    columnSize:
      file.name: 560
      formula.무제 2: 216
      file.folder: 401
      file.size: 112
  - type: table
    name: updates
    filters:
      and:
        - note["dg-publish"] == "true"
    order:
      - file.name
      - file.mtime
    sort:
      - property: file.mtime
        direction: DESC
    rowHeight: medium

```
