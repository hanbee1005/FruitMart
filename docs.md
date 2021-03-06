# 주요 기능 (이론)

### NavigationView
내비게이션 스택을 이용해 콘텐츠 뷰들을 관리하는 컨테이너 뷰

- 기본 형태
```swift
NavigationView {
  // 나타내고자 하는 뷰
  Image("SwiftUI")
}
```

- 내비게이션 바 타이틀(NavigationBarTitle) : 나타내고자 하는 뷰의 수식어로 추가
```swift
NavigationView {
  ...
    .navigationBarTitle("네비게이션 바 타이틀", displayMode: .large) // displayMode: .large, .inline
}
```

- 내비게이션 바 아이템(NavigationBarItems) : 나타내고자 하는 뷰의 수식어로 추가
```swift
let leadingItem = Button(action: {...}) {Image(systemName: "...")}
let trailingItem = Button(action: {...}) {Image(systemName: "...")}

return NavigationView {
  ...
    .navigationBarItems(leading: leadingItem, trailing: trailingItem)
}
```

- 내비게이션 링크(NavigationLink) : 지정한 목적지로 이동할 수 있도록 만들어진 버튼
```swift
NavigationView {
  NavigationLink(destination: 이동하고자하는_뷰) {
    Image("SwiftUI")
  }
  .navigationTitle("내비게이션 링크")
}
```

- 내비게이션 바 히든(NavigationBarHidden) : 내비게이션 바 또는 뒤로가기 버튼 숨기기
```swift
NavigationView {
  ...
    .navigationBarHidden(true)
}
```
```swift
let destination = Text("Destination View")
  .navigationBarButtonHidden(true)

return NavigationView {
  NavigationLink(destination: destination) {
    Image("SwiftUI").renderingMode(.original)
  }
  .navigationBarTitle("내비게이션 바 백버튼 히든")
}
```

- NavigationViewStyle
  + Default
  + Stack
  + DoubleColumn
```swift
NavigationView { ... }
  .navigationViewStyle(StackNavigationViewStyle)  // 스타일 지정
```

### List
하나의 열에 여러 개의 행으로 표현되는 UI를 구성하는 뷰 (= UITableView)

- 정적 콘텐츠

- 동적 콘텐츠
  + Range<Int>
    ```swift
    // Half-Open Range Oparator만 사용 가능
    List(0..<100) {
      Text("\($0)")
    }
    ```
  + RandomAcessCollection
    - id 식별자 지정 (Hashable 프로토콜을 준수하는 경우 self 입력 가능, 기본 타입 대부분이 준수)
    ```swift
    List(["A", "B", "C", "D", "E"], id: \.self) { ... }

    struct User: Hashable { ... }
    List([User(name: "steve"), User(name: "James")], id: \.name) { ... }
    ```
    - identifiable 프로토콜 채택
    ```swift
    struct Animal: Identifiable {
      let id = UUID()  // id의 타입은 UUID 외에도 Hashable을 준수하는 모든 타입 사용 가능
      ...
    }

    List([Animal(name: "Tory"), Animal(name: "Lilly")]) { ... }  // id 생략
    ```

- ForEach를 활용하여 정적, 동적 컨텐츠 조합 가능

- Section
```swift
let fruits = ["Apple", "Banana", "Peach"]
let drinks = ["Coke", "Water", "Juice"]

let titles = ["Fruits", "Drinks"]
let data = [fruits, drinks]

List {
  ForEach(data.indices) { index in
    Section(
      header: Text(titles[index]).font(.title),
      footer: HStack { Spacer(); Text("\(data[index].count)건") }
    ) {
        ForEach(data[index], id: \.self) {
          Text($0)
        }
    }
  }
}
```

- ListStyle
  + DefaultList
  + PlainList
  + GroupedList

### GeometryReader

### TabView

### ViewModifier
커스텀 수식어를 만들 수 있도록 해주는 것

```swift
struct CustomViewModifier: ViewModifier {
  var borderColor: Color = .red

  func body(content: Content) -> some View {
    ...
  }
}

// #1
Text("Custom ViewModifier")
  .modifier(CustomViewModifier(borderColor: .blue))

// #2
ModifiedContent(content: Text("Custom ViewModifier"),
                  modifier: CustomViewModifier(borderColor: .blue))
```

### @State, @Binding

### @EnvironmentObject

### UIViewController, UIView 호환 