//
//  Extensions.swift
//  IMDTest
//
//  Created by Agil Febrianistian on 9/21/17.
//  Copyright © 2017 Agil Febrianistian. All rights reserved.
//

import Foundation

extension Date {
    static var formatter = DateFormatter()
    func toString() -> String {
        Date.formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "d,MMM yy HH:mma", options: 0, locale: Locale(identifier: "en-GB"))
        return Date.formatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sZ"
        return dateFormatter.date(from: self)!
    }
}
