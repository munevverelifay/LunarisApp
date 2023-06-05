//
//  DayRoutineResponse.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 4.06.2023.
//

import Foundation

struct DailyRoutineResponse: Codable {
    let mon, tue, wed, thu: [String]
    let fri, sat, sun: [String]
}
