//
//  AlertItem.swift
//  GeeksForGeeks
//
//  Created by vikash sahu on 12/05/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message : Text
    var dismissButton: Alert.Button
}

enum AlertContext{
    static let unknowError =    AlertItem(title: Text("Error"),
                                          message: Text("Something went wrong, please try again later."),
                                          dismissButton: .default(Text("OK")))
    
    static let internetError =  AlertItem(title: Text("Network unavailable"), message:
                                            Text("No internet connection. Make sure that Wi-Fi or mobile data is turened on, then try again."),
                                          dismissButton: .default(Text("OK")))
}
