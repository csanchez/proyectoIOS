//
//  Date.swift
//  AppIIS
//
//  Created by tecnologias on 04/11/22.
// https://www.shawnbaek.com/posts/how-to-get-the-date-you-want-using-the-calendar

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.date(
        byAdding: .day,
        value: 0,
        to: midNight)!
    }

    var yesterday: Date {
        return Calendar.current.date(
        byAdding: .day,
        value: -1,
        to: midNight)!
    }

    var tomorrow: Date {
        return Calendar.current.date(
        byAdding: .day,
        value: 1,
        to: midNight)!
    }

    var dayAfterTomorrow: Date {
        return Calendar.current.date(
        byAdding: .day,
        value: 2, to: midNight)!
    }

    var midNight: Date {
        Calendar.current.date(
        bySettingHour: 00,
        minute: 0,
        second: 0,
        of: self)!
    }

    var militaryTime: Date {
        Calendar.current.date(
        bySettingHour: 23,
        minute: 59,
        second: 59, of: self)!
    }

    var noon: Date {
        Calendar.current.date(
        bySettingHour: 12,
        minute: 0,
        second: 0,
        of: self)!
    }

    var month: Int {
        Calendar.current.component(.month,  from: self)
    }

    var isLastDayOfMonth: Bool {
        tomorrow.month != month
    }

    /*var startOfThisWeek: Date {
        let weekDay = CalendarWeekDay(
            rawValue: Calendar.current.component(.weekday, from: self)
        )!
        return Calendar.current.date(
            byAdding: .day,
            value: weekDay.startOfWeek(.sun)!,
            to: startOfDay)!
    }

    var beforeStartOfBiWeek: Date {
        let weekDay = CalendarWeekDay(
            rawValue: Calendar.current.component(
            .weekday,
            from: self)
        )!
        return Calendar.current.date(
        byAdding: .day,
        value: weekDay.beforeStartOfBiWeek,
        to: startOfDay)!
    }*/

    var startOfMonth: Date {
        return Calendar.current.date(
            from: Calendar.current.dateComponents(
                [.year, .month],
                from: Calendar.current.startOfDay(for: self)
            ))!
    }

    var endOfMonth: Date {
        return Calendar.current.date(
            byAdding: DateComponents(month: 1, day: -1),
            to: startOfMonth.militaryTime
        )!
    }
    
    
    
    
    
}


