# 🍒 Cherrish

## ✨ 서비스 소개 
미용 의료부터 관리 루틴까지, 개인의 추구미에 맞는 관리의 방향을 정리하고, 다운타임&일정 중복을 방지하는 뷰티 캘린더

<br />

## 🍎 iOS Developers
| <p align="center"><img src="https://github.com/user-attachments/assets/00617dc1-3de8-4583-85fc-230b49d9c253" width="260"/></p> | <p align="center"><img src="https://github.com/user-attachments/assets/66c10d29-37cd-4eeb-be02-9d14e2704cd7" width="260"/></p> | <p align="center"><img src="https://github.com/user-attachments/assets/73f0f19c-ff71-429f-8fb9-87763f712cef" width="260"/></p> | <p align="center"><img src="https://github.com/user-attachments/assets/c44d4de2-f5e8-4f5b-9ed4-a88f295dfd5a" width="260"/></p> |
| --- | --- | --- | --- |
| <p align="center">[이나연(Lead)](https://github.com/y-eonee)</p> | <p align="center">[공수민](https://github.com/sum130)</p> | <p align="center">[어재선](https://github.com/wotjs020708)</p> | <p align="center">[송성용](https://github.com/soseoyo12)</p> |

<br />

## 🧑‍💻역할 분배 

| 이나연 (lead) | 아키텍처 및 DIContainer 설계, 탭바 및 네트워크 세팅, `캘린더` , `마이페이지` 구현  |
| --- | --- |
| 공수민 | `챌린지` 페이지 구현 |
| 송성용 | `Home`, `Onboarding`, `Information View` 구현, `CustomPicker`구현 |
| 어재선 | `시술 일정 추가 화면`  구현 |

<br />

## ⚒️ Tech Stack
| 기술/도구 | 선정 이유 |
| --- | --- |
| SwiftUI | 코드의 간결성과 직관성을 통해 빠르고 쉽게 사용자 인터페이스를 설계하고 유지보수가 가능 |
| Clean Architecture | 각 계층의 책임 분리를 명확하게 함으로써 앱의 확장성과 유지보수성을 높이기 위함. 테스트 용이한 구조 |
| MVVM | 비즈니스 로직과 UI 로직을 분리하기 위해 유지보수성을 높이기 위함 | 

<br />

## 🔀 Git Flow 
1. Issue를 생성한다.
2. 현재 브랜치가 아닌 main 브랜치에서 Branch Naming Rule을 따르는 브랜치를 생성한다.
3. 이슈에 작성한 내용을 기반으로 기능을 구현한다. (+ 커밋)
4. add - commit - push - 간략한 PR 과정을 거친다.
5. PR 올린 후 팀원들과 공유하여 merge 한다.
6. merge 이후에는 로컬에서도 main으로 이동하여 pull 받는다.

<br />
 
## 📌 Convention
### Code Style
[Swift 스타일 쉐어 가이드](https://github.com/StyleShare/swift-style-guide)를 따릅니다.

### Commit
| 태그       | 설명                                                                 |
|------------|----------------------------------------------------------------------|
| `feat`     | 새로운 기능 구현 시 사용                                              |
| `style`    | 스타일 및 UI 기능 구현 시 사용                                        |
| `fix`      | 버그나 오류 해결 시 사용                                              |
| `docs`     | README, 템플릿 등 프로젝트 내 문서 수정 시 사용                        |
| `setting`  | 프로젝트 관련 설정 변경 시 사용                                       |
| `add`      | 사진 등 에셋이나 라이브러리 추가 시 사용                              |
| `refactor` | 기존 코드를 리팩토링하거나 수정할 때 사용                             |
| `chore`    | 별로 중요한 수정이 아닐 때 사용                             |
| `hotfix`   | 급하게 develop에 바로 반영해야 하는 경우 사용 |

### Commit Message Rule
1. 반드시 **소문자**로 작성합니다.
2. 한글로 작성합니다.
3. 제목이 **50자**를 넘지 않도록, 간단하게 명령조로 작성합니다.

```markdown
feat: #1 로그인 기능 구현

add: #2 이미지 에셋 추가
```
<br/>
<br/>


## 📂 Foldering
```
🍒 Cherrish-iOS
├── 📁 Cherrish-iOS
│   ├── 📄 Info
│   ├── 📁 App
│   ├── 📁 Core
│   ├── 📁 Data
│   │   ├── 📁 Persistence
│   │   └── 📁 Repository
│   ├── 📁 Domain
│   │   ├── 📁 Interface
│   │   ├── 📁 Model
│   │   └── 📁 UseCase
│   ├── 📁 Presentation
│   │   ├── 📁 Feature
│   │   └── 📁 Global
│   ├── 📁 Resource
│   └── 📁 Assets
```
