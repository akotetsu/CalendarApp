//
//  Date+Extensions.swift
//  CalenderApp
//
//  Created by 原里駆 on 2025/05/08.
//

import Foundation

extension Date {
    //指定されたカレンダーに基づいて、その月の最初の日を返す
    func startOfMonth(using calendar: Calendar = .current) -> Date {
        //calendar.dataComponentsは、指定された日付から特定の要素(年、月、日など)を取り出す。
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return calendar.date(from: components)! //ここではnilが帰ることはないと想定
    }
    
    //指定された月数だけ進んだ (または戻った) 月の最初の日を返す。
    func addingMonths(_ months: Int, using calendar: Calendar = .current) -> Date {
        guard let newDate = calendar.date(byAdding: .month, value: months, to: self) else {
            return self
        }
        
        return newDate.startOfMonth(using: calendar)
    }
    
    /// 年月を "YYYY年M月" の形式で返すプロパティ
    var yearMonthFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY年M月" // "MM"にすると0埋め (例: 05月)
        formatter.locale = Locale(identifier: "ja_JP") // 日本語表記にする場合
        return formatter.string(from: self)
    }
}
