//
//  HomeScreenViewModel.swift
//  GeeksForGeeks
//
//  Created by vikash sahu on 12/05/22.
//

import SwiftUI

class HomeScreenViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var alertItem : AlertItem?
    @Published var isError : Bool = false
    @Published var firstTopItem : Item? = nil
    @Published var allRegularItem : [Item] = []
    
    //below varible used for pull to refresh features
    @Published var started = false
    @Published var released = false
    @Published var startOffset : CGFloat = 0
    @Published var offset : CGFloat = 0
    
    func getAllNewsFeeds(){
        print("getAllNewsFeeds.....")
        isLoading = true
        let request = NewsFeedAPIRequest.getNewsFeedRequest()
        
        APIService.shared.load(request: request) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                started = false
                released = false
                switch result {
                case .success(let data):
                
                    guard let data = data else { return }
                    if let firstItem = data.items.first{
                        firstTopItem = firstItem
                    }
                    allRegularItem = data.items.filter( {$0 != firstTopItem})
                  
                
                case .failure(let error):
                    switch error {
                        case .badURL:
                        alertItem = AlertContext.unknowError
                            
                        case .badResponse(_):
                        alertItem = AlertContext.unknowError
                            
                        case .url(_):
                        alertItem = AlertContext.unknowError
                            
                        case .parsing(_):
                        alertItem = AlertContext.unknowError
                            
                        case .unknown:
                        alertItem = AlertContext.unknowError
                        
                    }
                    isError = true
                }
            }
        }
    }
}
