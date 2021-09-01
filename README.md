# FruitMart
스윗한SwiftUI 과일마트 프로젝트 따라하기

## 초기 프로젝트 구조
```
FruitMart
├─Source
│  ├─Application
│  │  ├─AppDelegate.swift
│  │  └─SceneDelegate.swift
│  │      
│  └─User Interface
│     └─Home
│          
├─Resources
│  ├─Assets.xcassets    // 이미지와 색 설정
│  └─ProductData.json   // 더미 데이터 (read-only)
│  
├─Supporting Files
│  ├─LaunchScreen.stiryboard
│  └─Info.plist
│  
└─Preview Content
   └─Preview Assets.xcassets

```

- xcode로 프로젝트 실행 후 FruitMart > Build Settings > Packaging 에서 Info.plist File 을 FruitMart/Supporting Files/Info.plist 로 정확하게 입력!

- ContentView.swift 파일을 Home.swift 파일로 변경하였기 때문에 기존 ContentView() 를 사용한 부분을 Home() 으로 변경!       
  (Home.swift, SceneDelegate.swift 파일 수정)