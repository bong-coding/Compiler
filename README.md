
# 📘 Project1 - Lex 기반 C 코드 토큰 분석기

## 🧾 Overview

이 프로젝트는 **Lex (Lexical Analyzer Generator)** 를 사용하여 간단한 C 프로그램을 분석하고, 각 **토큰(token)** 의 종류와 내용을 출력하는 프로그램입니다.  
특히 **중첩된 주석**과 **범위 연산자(`..`)** 를 정확하게 처리할 수 있도록 구현되어 있습니다.

---


## 🔍 핵심 기능 설명

### ✅ 중첩된 주석 처리

Lex의 `start condition` 기능을 활용하여 **중첩 주석**을 정확하게 지원합니다.

| 조건     | 처리 내용                                           |
|----------|-----------------------------------------------------|
| `/*`     | `Comment` 모드 진입, `depth` 값을 1 증가             |
| `*/`     | `depth` 값을 1 감소, `depth`가 0이 되면 `Normal` 모드로 전환 |
| 기타 문자 | `Comment` 모드에서는 무시됨                         |

- 프로그램은 `main()` 함수에서 `BEGIN Normal;`로 시작합니다.
- `Comment` 모드에서는 `/*`, `*/` 외의 입력은 모두 무시됩니다.
- `depth`를 활용해 중첩된 주석 구조를 정확히 인식하고 처리합니다.

### ✅ `..` 연산자 처리

`1..5`와 같이 연속된 점(`.`)을 **범위 연산자(`..`)** 로 인식합니다.

- Lex의 **Lookahead 기능**(`/` 연산자 사용)을 이용하여 `. .` 연산자를 감지합니다.
- 실수(`float`) 리터럴인 `1.5`와 구분되도록 구현합니다.

예: `1..5` 입력 시 다음과 같이 토큰화됩니다:

## 📥 Input

- 중첩된 주석 (`/* ... /* ... */ ... */`)
- 범위 연산자 `..` (예: `1..5`)


예시 입력:

```c
/************************
/* nested comments */
************************/
struct _point {
  float x, y, z;
  int color;
} point[20];

struct _line {
  struct _point *p[2];
  int color;
  float meter = 0.5;
} line[20];
1..50

```
## 📤 Output

각 토큰에 대해 다음과 같은 정보를 출력합니다:

- **토큰 종류**: `KEY`, `ID`, `OP`, `INT`, ...
- **Lexeme**: 해당 토큰이 실제로 어떤 문자열인지 출력
