# iOS App ポートフォリオ
### 【Leef】  
個人飲食店向け食材在庫共有アプリ  

App Store: https://apps.apple.com/jp/app/leef/id1581382040

<img width="150" src="https://user-images.githubusercontent.com/66956155/142572777-f244a1ed-9375-46b0-8339-e0bc18928d8e.png"><img width="150" src="https://user-images.githubusercontent.com/66956155/142573052-d07a715f-6d8a-447c-9c78-f810ad6989c8.png"><img width="150" src="https://user-images.githubusercontent.com/66956155/142573205-f30e638d-289b-4482-a1da-a8d73a431af4.png">

<img width="150" src="https://user-images.githubusercontent.com/66956155/142573436-26c318aa-7016-4455-aa1e-01c57f48f4e6.png">　<img width="150" src="https://user-images.githubusercontent.com/66956155/142573600-9fd0ff9f-ab63-47a8-b8dd-71e08f0fdb61.png">　<img width="150" src="https://user-images.githubusercontent.com/66956155/142573604-c3d683ba-3d9f-4abb-9814-f4e4b7b49700.png">　<img width="150" src="https://user-images.githubusercontent.com/66956155/142573612-6ced4d82-5aa7-495d-81cf-783b33b6bb37.png">　<img width="150" src="https://user-images.githubusercontent.com/66956155/142573619-e7c310bf-2a83-4268-bb6e-6da4380f9121.png">



## 概要
### Appコンセプト
個人飲食店の廃棄予定の食材をアプリで情報発信・共有しフードロス削減を促進  

### 解決したい課題
コロナの影響による飲食店の食材廃棄の増加

### 現状
食材にこだわる個人経営の飲食店では廃棄することを避けるために、近所の同業者、身内などに仕入れた食材を提供し消費を助けてもらうことがある

### 解決策
優先的に消費したい食材や無償で提供できる食材の情報をアプリを通じて消費者に発信し、フードロス削減を促す

## 使用技術
* Swift 5.4.2<br>
* Xcode 12.5.1<br>
### DB
* Firebase  
  Authentication / Cloud Firestore / Storage
### ユーザー認証
* Twitter API
### 静的コード解析
* SwiftLint
### テスト
* ユニットテスト
  * XCTest
* UIテスト
  * XCUITest

## 使用ライブラリ
* 画像キャッシュ  
  * [Nuke](https://github.com/kean/Nuke) 
* 画像ビューア  
  * [ImageViewer.swift](https://github.com/michaelhenry/ImageViewer.swift)  
* インディケーター
  * [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)  
* Neumorphism UI
  * [NeumorphismTab](https://github.com/touyou/NeumorphismTab)  
  * [SoftUIView](https://github.com/hmhv/SoftUIView)  
* アニメーション
  * [lottie-ios](https://github.com/airbnb/lottie-ios)  


ライブラリ管理にはCocoaPodsを使用

## 機能
* ユーザー登録、ログイン、ログアウト
  * Twitterログイン
  * Appleサインイン
* 投稿機能
  * 画像投稿
  * コメント投稿
* 投稿タイムライン表示
* Twitter連携
* ユーザー報告


## その他
* StoryBoard / Xib不使用
  * AutoLayoutをコードで実装  
* スクリーンショットはSketchで作成
