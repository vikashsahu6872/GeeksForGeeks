//
//  Date+Extension.swift
//  GeeksForGeeks
//
//  Created by vikash sahu on 12/05/22.
//

import Foundation


extension Date{
    func toString(withFormat format:String = "MMM d")->String?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
