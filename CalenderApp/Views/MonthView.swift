// Views/MonthView.swift
import SwiftUI

struct MonthView: View {
    // このビューが表示する対象の月 (通常はその月の1日)
    let monthToDisplay: Date
    // 日付計算を行うためのヘルパー
    let calendarHelper: CalendarHelper

    // monthToDisplay と calendarHelper から、実際に表示する日付データと年月タイトルを取得
    // このプロパティは MonthView が描画される際に計算されます。
    private var monthData: (days: [Date?], monthName: String) {
        calendarHelper.generateDaysInMonth(for: monthToDisplay)
    }

    // 曜日ヘッダーの文字列 ("日", "月", ...) を取得
    private var weekdaySymbols: [String] {
        calendarHelper.weekdaySymbols()
    }

    // LazyVGrid のための列定義。7列で、各列は利用可能なスペースを均等に分割します。
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack(spacing: 15) { // 各要素間の垂直方向のスペース
            // 1. 年月タイトル (例: "2025年5月")
            Text(monthData.monthName)
                .font(.title2) // フォントサイズを少し大きめに
                .fontWeight(.semibold) // 少し太字に
                .padding(.bottom, 5) // タイトルと曜日ヘッダーの間に少しスペース

            // 2. 曜日ヘッダー (日 月 火 水 木 金 土)
            HStack(spacing: 0) { // 曜日間のスペースはなし (frameで制御するため)
                ForEach(weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.caption) // 曜日は少し小さめのフォント
                        .frame(maxWidth: .infinity) // 各曜日が均等な幅を持つように
                        .padding(.vertical, 5) // 上下に少しパディング
                }
            }

            // 3. 日付グリッド
            LazyVGrid(columns: columns, spacing: 10) { // 行間・列間のスペース
                // monthData.days は Date? の配列 (42個の要素)
                // ForEachで0から配列の要素数-1までループし、インデックスを取得
                ForEach(0..<monthData.days.count, id: \.self) { index in
                    // 配列から日付 (Date?) を取り出す
                    if let date = monthData.days[index] {
                        // 日付が存在する場合 (nilではない場合)
                        // その日付の日コンポーネント (例: 1, 15, 31) を表示
                        Text("\(calendarHelper.calendar.component(.day, from: date))")
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity) // セル内で中央揃え、かつ幅を最大に
                            .frame(height: 35)          // セルの高さを固定
                            .background(
                                Circle() // 日付を円で囲む (デザイン例)
                                    .fill(Color.blue.opacity(0.1)) // 淡い青色
                            )
                            // .padding(2) // 円と数字の間に少し余白
                    } else {
                        // 日付が存在しない場合 (nil のマス)
                        // 何も表示しない Text を配置してスペースを確保
                        Text("")
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                    }
                }
            }
            Spacer() // 他のコンテンツがなければ、VStack全体を上寄せにする
        }
        .padding() // VStack全体にパディング
    }
}
