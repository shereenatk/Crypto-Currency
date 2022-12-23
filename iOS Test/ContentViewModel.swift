//
//  ContentViewModel.swift
//  iOS Test
//
//  Created by shereena on 23/12/2022.
//

import Combine
import Foundation

class ContentViewModel: ObservableObject {
    var startIndex: Int = 1
    private static let apiHandler = ContentWebService()
    
    @Published var listDetails: ContentModel =  ContentModel(status: nil, data: [])
    @Published var endIndex: Int = 4
    @Published var isLoading: Bool = true
    
    private lazy var currencyPublisher: AnyPublisher<ContentModel, Never> = {
        $listDetails
            .debounce(for: 0.8, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { listDetails -> AnyPublisher<ContentModel, Never> in
                ContentViewModel.apiHandler.requestContentInformation(start: self.startIndex, limit: self.endIndex)
            }
            .receive(on: DispatchQueue.main)
//            .share()
//            .print("share")
            .eraseToAnyPublisher()
    }()
    
    //     call to network functions
    func getCurrencyDetails(start: Int, end: Int) {
        isLoading = true
        startIndex = start
        endIndex = end
        currencyPublisher
            .assign(to: &$listDetails)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
        }
    }
    
    
}


