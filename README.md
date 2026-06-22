# Antigravity 글로벌 룰 & MCP 플러그인 템플릿 (공유/배포용)

본 저장소는 AI 코딩 에이전트인 **Antigravity**의 개발 생산성을 극대화하고, 작업 방식과 품질을 강제하기 위한 **글로벌 룰(Global Rules)** 및 **3대 MCP 연동 플러그인/스킬**의 통합 템플릿 패키지입니다.

이 패키지를 로컬 컴퓨터에 적용하면 에이전트의 코딩 퀄리티가 정형화되며, SQLite, 장기 기억 지식 그래프(Memory), 브라우저 자동화(Playwright) 등 강력한 MCP 도구 지침서가 자동으로 바인딩됩니다.

---

## 🚀 퀵 스타트 (설치 및 동기화)

공유받은 사용자가 자신의 PC 환경에 이 설정을 적용하는 방법입니다.

1. **저장소 클론**:
   ```powershell
   git clone https://github.com/RangBro0/antigravity-global-rules-template.git
   cd antigravity-global-rules-template
   ```

2. **동기화 스크립트 실행**:
   파워쉘(PowerShell) 콘솔에서 아래 명령을 실행합니다:
   ```powershell
   .\sync_config.ps1 -Mode Pull
   ```
    - **자동 감지**: 스크립트가 로컬 PC의 구글 드라이브 마운트 문자(`G:`, `H:`, `I:`)와 `GITHUB_PERSONAL_ACCESS_TOKEN` 환경 변수를 먼저 탐색합니다.
    - **입력 유도**: 감지되지 않을 경우 콘솔 프롬프트로 **구글 드라이브 동기화 경로**와 **GitHub 개인 토큰**을 직접 묻습니다. 구글 드라이브를 사용하지 않는다면 엔터를 눌러 건너뛸 수 있으며, 이 경우 로컬 데이터 보관 폴더(`%USERPROFILE%\.gemini\config\data`)를 기본 로컬 경로로 자동 생성하여 가동되도록 조치합니다. 입력 완료 즉시 플레이스홀더를 치환하여 로컬 설정(`%USERPROFILE%\.gemini\config\mcp_config.json`)을 완성해 줍니다.
    - **설치 모드 선택 (Auto vs Custom)**:
      * **Auto (자동 전체 설치)**: 모든 규칙, 스킬, 플러그인을 일괄 자동 설치합니다. (기본값)
      * **Custom (개별 선택 설치)**: 깃허브 계정이 없거나 동기화를 원치 않고 일부 스킬/규칙만 선별하여 로컬에 설치하고 싶을 때 유용합니다. 스크립트가 각 스킬/플러그인 항목마다 **용도, 목적, 필요한 리소스를 친절히 안내한 후 설치 여부(y/n)**를 묻습니다. 선택하지 않은 MCP 도구는 설정 파일(`mcp_config.json`)에서 자동으로 제외되어 불필요한 실행 에러를 유발하지 않습니다.
    - **연쇄 빌드**: 설정 파일 구성 완료 즉시 로컬 연동 커넥터를 실행하여, 신규 플러그인 빌드와 영문 스킬 가이드를 자동 생성/활성화합니다.

---

## 📂 디렉토리 구조 및 핵심 구성요소

```text
antigravity-global-rules-template/
├── sync_config.ps1                 # 로컬 PC ↔ 저장소 간 동기화 스크립트 (구글 드라이브 연동은 선택 사항)
└── config/                         # Antigravity 실제 로컬 경로(%USERPROFILE%\.gemini\config)와 매핑되는 최신 구성
    ├── mcp_config.json             # MCP 서버 구동 정의 템플릿 (토큰/경로 플레이스홀더화 완료)
    │
    ├── skills/                     # 전역 수동/자동 로드 스킬 폴더
    │   ├── SKILL_A_plugin_mcp_manager/
    │   │   └── SKILL.md            # MCP 서버 및 플러그인 패키징 지침 (영문)
    │   ├── SKILL_C_workflow_skill_creator/
    │   │   └── SKILL.md            # 사용자 워크플로우 분석 및 스킬 자동 추출 가이드 (영문)
    │   └── token_conservation/
    │       └── SKILL.md            # 토큰 절약 및 컨텍스트 메모리 최적화 가이드 (영문)
    │
    └── plugins/                    # 개별 플러그인 패키지 및 규칙 폴더
        ├── custom-global-rules/    # [사용자 전역 규칙 플러그인]
        │   ├── plugin.json
        │   └── skills/
        │       └── custom_global_rules/
        │           ├── SKILL_C_code_quality.md      # 사용자 코드 품질 규칙 (영문)
        │           ├── SKILL_C_custom_skills.md     # 사용자 커스텀 스킬 작성 표준 (영문)
        │           ├── SKILL_C_memory_management.md  # 장기 기억 지식 그래프 관리 지침 (영문)
        │           ├── SKILL_C_project_context_management.md # 작업 범위 고정 및 컨텍스트 관리 지침 (영문)
        │           ├── SKILL_C_response_rules.md    # 한글(국문) 응답 원칙 규칙 (영문)
        │           └── SKILL_C_security_rules.md    # 프록시 및 API 보안 검사 규칙 (영문)
        │
        ├── github-plugin/          # [GitHub MCP 바인딩 플러그인]
        │   ├── plugin.json
        │   └── skills/github_skills/
        │       └── SKILL_A_github.md
        ├── sqlite-plugin/          # [SQLite MCP 바인딩 플러그인]
        │   ├── plugin.json
        │   └── skills/sqlite_skills/
        │       └── SKILL_A_sqlite.md
        ├── memory-plugin/          # [Memory MCP 바인딩 플러그인]
        │   ├── plugin.json
        │   └── skills/memory_skills/
        │       └── SKILL_A_memory.md
        ├── playwright-plugin/      # [Playwright MCP 바인딩 플러그인]
        │   ├── plugin.json
        │   └── skills/playwright_skills/
        │       └── SKILL_A_playwright.md
        │
        ├── chrome-devtools-plugin/ # 크롬 디버깅용 플러그인
        ├── firebase/               # 파이어베이스 연동 플러그인
        ├── google-antigravity-sdk/ # 안티그래비티 전용 SDK 플러그인
        └── modern-web-guidance-plugin/ # 모던 웹 프론트엔드 프리미엄 디자인 가이드
```

---

## 🛠️ 스킬 및 플러그인별 목적/용도 안내

### 📌 스킬 명명 규칙 및 계열 구분
본 템플릿의 스킬 파일은 역할과 규정에 따라 **A계열**과 **C계열**로 명확하게 분류되어 관리됩니다.

| 계열 (Prefix) | 분류 명칭 | 설명 및 세부 목적 |
| :--- | :--- | :--- |
| 🛡️ **`SKILL_A_`** | **Agent / System 계열** | 에이전트 구동 방식, MCP 도구 명세, 플러그인 연동 규격 등 시스템 제어 및 AI 에이전트가 활용할 **도구 사용법**을 영문으로 설명하는 시스템 가이드입니다. |
| 👤 **`SKILL_C_`** | **Custom / User 계열** | 개발 프로젝트 규칙, 코딩 컨벤션, 한국어 응답 강제, 보안 기준 등 사용자가 에이전트에게 지켜야 할 **행동 양식과 제약 조건**을 지정하는 사용자 커스텀 전역 규칙입니다. |

---

### 1. 전역 스킬 (skills/ 하위)
에이전트가 코딩 작업 시 기본적으로 상시 로드하여 적용할 전반적인 제어 스킬들입니다.

* **`SKILL_A_plugin_mcp_manager` (영문)**
  - **용도**: MCP 서버 등록 관리 및 플러그인 패키징 지침
  - **목적**: `mcp_plugin_connector.py` 연동 스크립트를 활용해 새로운 도구(Tool)를 패키징하고, 명명 규칙(`SKILL_C_` vs `SKILL_A_`) 및 아티팩트 국문(한국어) 작성 원칙을 강제합니다.
* **`SKILL_C_workflow_skill_creator` (영문)**
  - **용도**: 해결된 버그나 복잡한 작업 흐름을 영구적인 스킬 파일로 변환
  - **목적**: 작업 중 발견한 최적의 해결 방식을 지식 자산화하여, 에이전트가 향후 유사 태스크를 만났을 때 같은 실수를 반복하지 않고 즉시 지침을 응용하도록 만듭니다.
* **`token_conservation` (영문)**
  - **용도**: 비용 절감 및 컨텍스트 효율 극대화 가이드
  - **목적**: 대용량 프로젝트 탐색 시 불필요한 전체 코드 읽기를 차단하고, `grep_search` 등을 활용해 필요한 부분만 슬라이싱하여 읽도록 유도해 API 비용 및 토큰 소모를 방지합니다.

---

### 2. 사용자 전역 규칙 플러그인 (plugins/custom-global-rules/ 하위)
에이전트의 대화 스타일, 코딩 표준, 보안 규칙 등을 제어하는 규칙 모음입니다. (영문 작성)

* **`SKILL_C_code_quality.md`**
  - **용도**: 소스 코드 품질 및 주석 작성 표준화
  - **목적**: 불필요한 기존 주석 삭제를 금지하고, 변수명/클래스 구조 등 모범적이고 깔끔한 코딩 컨벤션을 준수하도록 강제합니다.
* **`SKILL_C_custom_skills.md`**
  - **용도**: 커스텀 스킬 생성 시의 규격화
  - **목적**: 사용자가 추가하는 `SKILL_C_` 계열 스킬들의 YAML Frontmatter와 Body 구조 표준을 일치시켜 관리 가독성을 높입니다.
* **`SKILL_C_memory_management.md`**
  - **용도**: 지식 그래프 단단기/장기 기억 관리 표준
  - **목적**: 아키텍처나 주요 스키마 분석 결과를 지식 그래프 형태로 Memory MCP에 체계적으로 기록하여 향후 로직 설계 시 참고하도록 지시합니다.
* **`SKILL_C_project_context_management.md`**
  - **용도**: 프로젝트 범위 및 탐색 범위 제어
  - **목적**: 작업 중 에이전트가 임의의 템플릿 폴더나 잘못된 디렉토리에 소스코드를 무분별하게 퍼뜨리지 않도록 작업 범위를 엄격히 고정합니다.
* **`SKILL_C_response_rules.md`**
  - **용도**: 한국어 답변 및 아티팩트 작성 규칙
  - **목적**: 스킬 지침이 영어로 되어 있더라도, 최종 사용자에게 출력되는 보고서, walkthrough, 대화는 반드시 **친절한 한글(한국어)**로 작성하도록 교정합니다.
* **`SKILL_C_security_rules.md`**
  - **용도**: 보안 및 실행 권한 안전 지침
  - **목적**: 인증 정보나 프록시 설정 파일 등 민감 정보가 소스코드 내에 하드코딩되거나 Git에 유출되지 않도록 모니터링 기준을 규정합니다.

---

### 3. MCP 바인딩 플러그인 및 스킬 (plugins/*-plugin/ 하위)
MCP 서버가 가진 도구(Tools)들을 에이전트가 능숙하게 활용하도록 가이드해 주는 스킬 모음입니다. (영문 작성)

* **`github-plugin` (`SKILL_A_github.md`)**
  - **용도**: GitHub API 연동 및 관리 자동화
  - **필수 요건**: 🔑 **GitHub 계정 가입 및 Personal Access Token (PAT) 발급 필수** (설정 시 `GITHUB_PERSONAL_ACCESS_TOKEN` 입력 필요)
  - **목적**: 레포지토리 생성, 브랜치 관리, 풀 리퀘스트 생성, 파일 탐색 등의 GitHub MCP 도구들을 에이전트가 실시간 활용할 수 있도록 돕습니다.
* **`sqlite-plugin` (`SKILL_A_sqlite.md`)**
  - **용도**: SQLite 데이터베이스 연동 및 무결성 검증
  - **필수 요건**: 📂 **구글 드라이브 PC 앱 설치 및 공유 드라이브 마운트 필수** (로컬 SQLite DB 파일 연동 및 동기화 목적, 별도의 API 키는 불필요)
  - **목적**: 데이터베이스 테이블 생성, 쿼리 구동, 스키마 검사 등을 로컬 에이전트가 구글 드라이브와 공유 연동하여 안정적으로 다룰 수 있게 가이드합니다.
* **`memory-plugin` (`SKILL_A_memory.md`)**
  - **용도**: 지식 그래프(Knowledge Graph) 구성
  - **필수 요건**: 📂 **구글 드라이브 PC 앱 설치 및 공유 드라이브 마운트 권장** (장기 기억 json 파일 저장소 공유 목적, 별도의 API 키는 불필요)
  - **목적**: 비정형 아키텍처 구조나 설계 의사결정을 엔티티-관계 형태로 장기 기억 장치에 구조화하여 읽고 쓰는 지침을 제공합니다.
* **`playwright-plugin` (`SKILL_A_playwright.md`)**
  - **용도**: 브라우저 테스팅 및 스크래핑 자동화
  - **필수 요건**: 🌐 **선택 사항 (로컬 Playwright 브라우저 바이너리 설치 필요)** 
    - ⚠️ **주의**: 브라우저 자동화 도구 작동 시 전체 웹 페이지의 HTML/텍스트 구조가 분석용으로 주입되므로, **토큰 사용량(API 비용)이 급격히 증가**할 우려가 큽니다. 이에 따라 이 플러그인은 **선택 사항**이며, 동기화 스크립트 실행 과정에서 Y/N 질문을 통해 설치 여부를 직접 선택할 수 있습니다. (별도 외부 API 가입은 불필요)
  - **목적**: Playwright 브라우저를 백그라운드에서 구동하여 웹 화면 분석, 폼 채우기, 클릭, 스크린샷 획득 등 동적 웹 테스트 지침을 제공합니다.

---

### 4. 기타 모던 개발 가이드 플러그인
* **`modern-web-guidance-plugin`**
  - **용도**: 모던 프론트엔드/백엔드 아키텍처 권장 표준
  - **목적**: Next.js, Vite 등 modern-web을 개발할 때 HTML5 시맨틱 태그 준수, CSS 디자인 일관성(Wow Aesthetic), 미크로-애니메이션 등 프리미엄 디자인 철학을 에이전트가 스스로 준수하여 고품격 UI를 빌드하도록 만드는 지침서입니다.
