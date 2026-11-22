---
title: '{{ replace (replaceRE `^\d{4}-\d{2}-\d{2}-?` "" .Name) "-" " " }}'   # 글 제목 — 한글로 고쳐 쓰면 됨
slug: ''            # 영문 URL. new-post가 글 이름으로 채운다 — 비우면 폴더명(날짜 포함)이 URL이 된다
date: {{ .Date }}   # 작성일 — 목록 정렬 기준 (자동 입력)
tags: []            # 예: [HBM, SK하이닉스]
description: ''     # 카드에 보일 한두 줄 요약
math: false         # 수식 쓰려면 true
toc: true           # 목차 — 짧은 글이면 false
draft: true         # 초안 표시 — 이 줄을 지우면(또는 false) 배포된다
# cover: "파일명.png"  # (선택) 카드 썸네일 — 없으면 본문 첫 그림 자동
---

무엇을 분석하는지, 결론이 무엇인지 두세 문장으로 먼저 쓴다.

이미지는 복사해서 Ctrl+V — 이 폴더에 자동 저장된다.

참고자료는 각주로 단다[^1].

[^1]: 출처 설명. 링크도 된다: [기사·리포트 제목](https://example.com)
