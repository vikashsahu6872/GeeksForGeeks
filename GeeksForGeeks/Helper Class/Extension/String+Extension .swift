//
//  String+Extension .swift
//  GeeksForGeeks
//
//  Created by vikash sahu on 12/05/22.
//

import Foundation

extension String{
    func toDate(withFormat format:String = "yyyy-MM-dd HH:mm:ss")->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
