//
//  CalendarHelper.swift
//  CalenderApp
//
//  Created by 原里駆 on 2025/05/08.
//

import Foundation

struct CalendarHelper {
    
    let calendar: Calendar
    
    init(calendar: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = Locale(identifier: "ja_JP")
        cal.firstWeekday = 1
        return cal
    }()) {
        self.calendar = calendar
    }
    
    //指定された月の日付情報を生成
    func generateDaysInMonth(for month: Date) -> (days: [Date?], monthName: String) {
        //基準となる月の初日を取得
        guard let monthStartDate = calendar.date(from: calendar.dateComponents([.year, .month], from: month)) else {
            return ([], month.yearMonthFormatted)
        }
        
        //表示用の年月文字列を生成(YYYY年M月)
        let displayMonthName = monthStartDate.yearMonthFormatted
        
        //その月の日数を取得
        guard let daysInMonth = calendar.range(of: .day, in: .month, for: monthStartDate)?.count else {
            return ([], displayMonthName)
        }
        
        //その月の初日の曜日を取得
        let firstDayWeekday = calendar.component(.weekday, from: monthStartDate)
        
        //カレンダーグリッドに表示する日付の配列を作成 (42マス分を想定)
        var days: [Date?] = []
        
        // (a) 月の初日より前の空白マスを埋める
        let emptyCellsAtStart = (firstDayWeekday - calendar.firstWeekday + 7) % 7
        for _ in 0..<emptyCellsAtStart {
            days.append(nil)
        }
        
        // (b) その月の日付を配列に追加
        for dayOffset in 0..<daysInMonth {
            // monthStartDate (その月の1日) から dayOffset 日だけ進んだ日付を計算
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: monthStartDate) {
                days.append(date)
            } else {
                days.append(nil) // 万が一計算失敗したらnil
            }
        }
        
        // (c) 残りのマスを空白 (nil) で埋めて、常に42マスにする (6行 x 7列)
        let totalCells = 42 // 一般的なカレンダーは6行表示
        while days.count < totalCells {
            days.append(nil)
        }
        
        return (days, displayMonthName)
    }
    
    //曜日のヘッダー文字列を返す
    func weekdaySymbols() -> [String] {
        return calendar.veryShortWeekdaySymbols
    }
}
