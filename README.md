# 🚀 안티그래비티 글로벌 룰 및 커스텀 스킬 백업

이 레포지토리는 안티그래비티(Antigravity) 에이전트의 전역 규칙(Global Rules) 및 커스텀 스킬들을 백업하고, 다른 컴퓨터에서 원클릭으로 쉽게 복구/설치하기 위한 보관소입니다.

## 📁 구성 요소
* `plugins/custom-global-rules/`: 소통, 보안, 코드품질, 스킬제작 등의 전역 동작 정책 스킬 4종
* `skills/workflow-skill-creator/`: 완료된 작업을 신규 스킬로 자동 패키징해주는 에이전트 스킬
* `skills/SKILL_A_plugin_mcp_manager/`: MCP 서버 수동 연동 및 동기화 도구 스킬
* `install.ps1`: 다른 PC에 원클릭으로 자동 이식해 주는 파워쉘 스크립트

---

## 📥 다른 컴퓨터에 자동 설치 및 복구 방법 (Windows)

1. 이 레포지토리를 다른 컴퓨터의 적당한 경로에 `git clone` 받습니다.
2. 클론받은 폴더 내에서 PowerShell을 열고 아래 명령어를 실행합니다.
   ```powershell
   # 스크립트 실행 권한 허용 (필요한 경우)
   Set-ExecutionPolicy Bypass -Scope Process -Force
   
   # 자동 설치 스크립트 실행
   .\install.ps1
   ```
3. 설치가 완료되면 **안티그래비티 에이전트 프로그램을 완전히 재시작**합니다.

---

## ✍️ 수동 설치 방법 (직접 복사)
스크립트 실행이 불가능한 경우, 아래 경로에 맞춰 수동으로 폴더를 복사해 주십시오.

1. **플러그인 복사:**
   - 원본: `plugins/custom-global-rules`
   - 대상: `C:\Users\<사용자명>\.gemini\config\plugins\custom-global-rules`
2. **스킬 복사:**
   - 원본: `skills/workflow-skill-creator`
   - 대상: `C:\Users\<사용자명>\.gemini\config\skills\SKILL_C_workflow_skill_creator`
   - 원본: `skills/SKILL_A_plugin_mcp_manager`
   - 대상: `C:\Users\<사용자명>\.gemini\config\skills\SKILL_A_plugin_mcp_manager`
