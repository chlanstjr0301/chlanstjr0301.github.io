---
title: "{{ time.Format `1월 2일의 기록` (time.AsTime .Date) }}"   # 자동 제목 — 원하면 바꿔도 됨
date: {{ .Date }}   # 날짜 — 타임라인에서의 위치 (자동 입력)
description: ""     # 목록에서 제목 아래 이탤릭 한 줄 미리보기 — 비우면 제목만
math: false         # 수식 쓰려면 true
toc: false          # 일기는 목차 끔 — 긴 글이면 true
draft: true         # 초안 표시 — 이 줄을 지우면(또는 false) 배포된다
---

오늘의 기록. 이미지는 복사해서 Ctrl+V — 이 폴더에 자동 저장된다.

<!-- 수식이 필요하면 위 math를 true로 -->
