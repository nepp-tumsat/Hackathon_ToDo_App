# Hackathon_ToDo_App
## 概要
ハッカソンで、タスクをクリアするごとに経験値が貯まりレベルアップできるモバイルTodoアプリをチーム開発しました。


<img src="https://user-images.githubusercontent.com/85020730/206708059-254d80c2-0138-4f76-94b9-45b5a15882b1.png" width="405" height=850px> <img src="https://user-images.githubusercontent.com/85020730/206708775-ea4d8256-e9ee-4911-b907-3329301880f2.png" width="405" height=850px>

## 使用技術
### フロント
- Swift
### バック
- Go(Echo)

## ブランチ管理

mainブランチからdevelopブランチを切り、develop-Backend, develop-iOSのように切り、feat/○○でそれぞれ作業していく。

## iOSアプリのセットアップ
CocoaPodsを利用
```
pod update
```
もしくは
```
pod install
```

## goサーバーとdbサーバー起動
Makefileを使用
```
make run-docker
```
ビルドし直す時は
```
make reRun-docker
```

