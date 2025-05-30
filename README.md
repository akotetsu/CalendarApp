# CalenderApp (SwiftUI練習用カレンダー)

## 概要

このリポジトリは、SwiftおよびSwiftUIの学習と練習のために作成した、シンプルな月表示カレンダーアプリケーションのソースコードです。
主な機能として、横スクロールによる月移動が可能なカレンダーUIを備えています。

## 主な機能

* **月表示カレンダー**:
    * 各月の日付をグリッド形式で表示します。
    * その月の1日が何曜日か考慮し、日付の開始位置を正しく配置します。
    * 曜日ヘッダー（日〜土）を表示します。
* **横スクロールによる月移動**:
    * 左右へのスワイプ操作で、前後の月にスムーズに移動できます。
    * `TabView` のページングスタイルを利用して実装しています。
* **年月表示**:
    * 現在表示しているカレンダーの年月を画面上部に表示します。

## 作成目的

* Swift言語およびSwiftUIフレームワークの基本的な使い方を習得する。
* Swiftの `Date` 型や `Calendar` クラスを用いた日付処理、およびそれらを扱うロジックの実装に慣れる。
* SwiftUIにおける `TabView` を利用したページングUIの構築方法を理解する。
* ビューのコンポーネント化、状態管理（`@State`など）、データフローについての理解を深める。
* 将来的に個人開発プロジェクトでカレンダー機能を実装するための基礎技術を固める。

## 使用技術

* **言語**: Swift
* **UIフレームワーク**: SwiftUI

## プロジェクト構成

本プロジェクトは、役割ごとにフォルダを分けて管理しています。

* `Models/`:
    * `Date+Extensions.swift`: `Date` 型の拡張機能を定義し、日付計算（月の初日取得、月の加減算など）を容易にします。
* `Views/`:
    * `MonthView.swift`: ひと月分のカレンダー表示を担当するビューです。
    * `MainCalendarView.swift`: `MonthView` をまとめ、横スクロールによる月移動機能を提供するメインのビューです。
* `Utils/`:
    * `CalendarHelper.swift`: 指定された月のカレンダー表示に必要な日付データ（日付の配列、曜日シンボルなど）を生成するロジックを提供します。
* `CalenderAppApp.swift` (または `<あなたのプロジェクト名>App.swift`): アプリケーションのエントリーポイントです。

## 今後の学習・拡張アイデア

この基本機能をベースに、以下のような機能追加の練習が考えられます。

* 日付セルタップ時のイベント処理（日付選択機能など）
* 「今日」の日付を視覚的にハイライトする機能
* 特定の日付にイベントマーカー（例：点）を表示する機能
* 祝日データの取得と表示
* より詳細なデザインカスタマイズ（フォント、カラーテーマ、セルの形状変更など）
* 特定の日付へジャンプする機能（例：年月ピッカーの利用）

---

このプロジェクトは、個人の学習とスキルアップを目的として作成されました。 (作成日: 2025年5月)
