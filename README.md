# <img width="200" height="100" alt="logo" src="https://github.com/user-attachments/assets/7cde32c0-f76c-4cf0-b3bf-260befb360a1" />
  
<p align="center">  
  <img width="800" height="400" alt="image" src="https://github.com/user-attachments/assets/7f0e0645-fdf2-43a7-ab38-86f08377e466" />  
</p>  

# <img src="https://github.com/user-attachments/assets/b7c69bb0-3579-4074-8eca-e7966128fffb" height="50"/> Cherrish 서비스 소개
> 미용 의료부터 관리 루틴까지, 개인의 추구미에 맞는 관리의 방향을 정리하고, 다운타임&일정 중복을 방지하는 뷰티 캘린더


<br/>

## <img src="https://github.com/user-attachments/assets/ac0bd614-bf51-4fde-9727-f6f3d70dafa2" height="40"/>Cherrish 주요 기능
- 피부 고민 키워드 기반 시술 리스트
- 시술 다운타임 설정 및 디데이 여유기간 시각화
- AI가 짜주는 챌린지 루틴 추천
- 챌린지 기반 체리 게이미피케이션
<br />

## 🍎 iOS Developers
| <img src = "https://github.com/user-attachments/assets/2fc03587-f05a-45ee-a69f-288c1a978746" height = "25"> 이나연(Lead)<br/>[@Lee Nayeon](https://github.com/y-eonee) | <img src = "https://github.com/user-attachments/assets/175d7547-646a-48a8-95c8-4b8285012ad4" height = "25"> 공수민<br/>[@sum130](https://github.com/sum130) | <img src = "https://github.com/user-attachments/assets/53b25645-c9db-449c-9a6d-711fefdaa1c4" height = "25"> 어재선<br/>[@JaeSun](https://github.com/wotjs020708) | <img src = "https://github.com/user-attachments/assets/1f68623f-42e6-4f4d-a027-b3b1816f9a0a" height = "25"> 송성용<br/>[@soseoyo](https://github.com/soseoyo12) |
| :---: | :---: | :---: | :---: |
| <p align="center"><img src="https://github.com/user-attachments/assets/00617dc1-3de8-4583-85fc-230b49d9c253" width="260"/></p> | <p align="center"><img src="https://github.com/user-attachments/assets/66c10d29-37cd-4eeb-be02-9d14e2704cd7" width="260"/></p> | <p align="center"><img src="https://github.com/user-attachments/assets/73f0f19c-ff71-429f-8fb9-87763f712cef" width="260"/></p> | <p align="center"><img src="https://github.com/user-attachments/assets/c44d4de2-f5e8-4f5b-9ed4-a88f295dfd5a" width="260"/></p> |
| `캘린더` `마이` | `챌린지` | `시술` | `홈` `온보딩` |
<br />

<br />

## <img src = "https://github.com/user-attachments/assets/175d7547-646a-48a8-95c8-4b8285012ad4" height = "40"> Tech Stack
| 기술/도구 | 선정 이유 |
| --- | --- |
| SwiftUI | 코드의 간결성과 직관성을 통해 빠르고 쉽게 사용자 인터페이스를 설계하고 유지보수가 가능 |
| Clean Architecture | 각 계층의 책임 분리를 명확하게 함으로써 앱의 확장성과 유지보수성을 높이기 위함. 테스트 용이한 구조 |
| MVVM | 비즈니스 로직과 UI 로직을 분리하기 위해 유지보수성을 높이기 위함 | 

<br />

## <img src = "https://github.com/user-attachments/assets/53b25645-c9db-449c-9a6d-711fefdaa1c4" height = "40"> Git Flow 
1. Issue를 생성한다.
2. 현재 브랜치가 아닌 main 브랜치에서 Branch Naming Rule을 따르는 브랜치를 생성한다.
3. 이슈에 작성한 내용을 기반으로 기능을 구현한다. (+ 커밋)
4. add - commit - push - 간략한 PR 과정을 거친다.
5. PR 올린 후 팀원들과 공유하여 merge 한다.
6. merge 이후에는 로컬에서도 main으로 이동하여 pull 받는다.

<br />
 
## <img src = "https://github.com/user-attachments/assets/1f68623f-42e6-4f4d-a027-b3b1816f9a0a" height = "40"> Convention
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

## <img src="https://github.com/user-attachments/assets/dda04d78-e3c9-4d87-ad1f-3f0bd94b1d5c" height = "40"> 📂 Foldering
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
