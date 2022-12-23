//
//  ContentWebService.swift
//  iOS Test
//
//  Created by shereena on 23/12/2022.
//

import Combine
import Foundation

class ContentWebService {
    let apiKey =  AppConstants.apiKey
    
    func requestContentInformation(start: Int, limit: Int) -> AnyPublisher< ContentModel, Never> {
        
        guard let url = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=\(start)&limit=\(limit)&convert=USD") else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.setValue("ebd33a92-dc4a-4f83-97f2-5a32addaf426", forHTTPHeaderField:  "X-CMC_PRO_API_KEY")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, response in
                do {
                    let decoder = JSONDecoder()
                    let userAvailableMessage = try decoder.decode(ContentModel.self, from: data)
                    return userAvailableMessage
                }
                catch let DecodingError.dataCorrupted(context) {
                    print(context)
                    return ContentModel(status: nil, data: [])
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    return ContentModel(status: nil, data: [])
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    return ContentModel(status: nil, data: [])
                } catch let DecodingError.typeMismatch(type, context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                     return ContentModel(status: nil, data: [])
                } catch {
                    print("error: ", error)
                    return ContentModel(status: nil, data: [])
                }
            }
            .replaceError(with: ContentModel(status: nil, data: []))
            .eraseToAnyPublisher()
    }
    
}
