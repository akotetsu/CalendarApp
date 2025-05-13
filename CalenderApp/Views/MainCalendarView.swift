// Views/MainCalendarView.swift
import SwiftUI

struct MainCalendarView: View {
    // @State private var displayedMonth: Date = Date() // これだと毎回現在時刻になる
    // 表示の中心となる月。常にその月の1日に正規化して保持します。
    // Date().startOfMonth() は Date+Extensions.swift で定義した拡張を使います。
    @State private var displayedMonth: Date = Date().startOfMonth()

    // TabViewの現在の選択ページを管理します。
    // 0: 前の月, 1: 表示中の月 (displayedMonth), 2: 次の月
    // 初期表示は中央の「表示中の月」なので 1 を設定します。
    @State private var selectedTab: Int = 1

    // CalendarHelperのインスタンスを生成・保持します。
    // このインスタンスを各MonthViewに渡します。
    private let calendarHelper = CalendarHelper()

    // TabViewに表示するための月の配列を計算します。
    // displayedMonth が変わると、この配列も自動的に再計算されます。
    private var monthsToDisplay: [Date] {
        [
            displayedMonth.addingMonths(-1), // displayedMonth の1ヶ月前の月
            displayedMonth,                  // displayedMonth 自身
            displayedMonth.addingMonths(1)   // displayedMonth の1ヶ月後の月
        ]
    }

    var body: some View {
        VStack {
            // ヘッダー部分: 現在表示されている中心の年月を表示
            // (MonthView内にも年月表示はありますが、全体としてのヘッダーとしても便利です)
            Text(displayedMonth.yearMonthFormatted)
                .font(.title) // メインのタイトルなので少し大きめに
                .padding(.vertical) // 上下にパディング

            TabView(selection: $selectedTab) {
                // monthsToDisplay 配列 (3つの月) のそれぞれに対して MonthView を作成
                // index (0, 1, 2) と月 (date) を使ってループ
                ForEach(Array(monthsToDisplay.enumerated()), id: \.offset) { index, monthDate in
                    MonthView(monthToDisplay: monthDate, calendarHelper: calendarHelper)
                        .tag(index) // 各ページにユニークなタグを設定 (selectedTabと連動)
                }
            }
            // TabViewのスタイルをページング形式に設定
            // indexDisplayMode: .never でページインジケータ (下部の点々) を非表示にします。
            .tabViewStyle(.page(indexDisplayMode: .never))
            // selectedTab の値が変更された時（つまりユーザーがスワイプした時）に処理を実行
            .onChange(of: selectedTab) { newSelectedTab in
                // このクロージャは、ユーザーのスワイプ操作が完了し、
                // selectedTab の値が実際に変わった後に呼び出されます。

                // スワイプ方向に応じて displayedMonth を更新
                if newSelectedTab == 0 { // 左のページ(前月)にスワイプされた場合
                    displayedMonth = displayedMonth.addingMonths(-1)
                } else if newSelectedTab == 2 { // 右のページ(翌月)にスワイプされた場合
                    displayedMonth = displayedMonth.addingMonths(1)
                }

                // displayedMonth が更新されると、monthsToDisplay が再計算され、
                // TabView の中身（3つのMonthView）が新しい月のセットに変わります。
                // この時点では、selectedTab は 0 または 2 のままなので、
                // 見た目上は新しい月セットの端のページが表示されてしまいます。

                // これをユーザーには常に中央のページからスワイプしているように見せるため、
                // selectedTab を中央のインデックス (1) に戻します。
                // ただし、この変更はUIの更新サイクルの中で適切に行うため、
                // DispatchQueue.main.async を使って、現在の更新処理が一段落した後に実行します。
                if newSelectedTab != 1 { // 端のページにスワイプした場合のみ処理
                    DispatchQueue.main.async {
                        self.selectedTab = 1 // TabViewの表示を中央のページにリセット
                    }
                }
            }
        }
    }
}

#Preview {
    MainCalendarView()
}
