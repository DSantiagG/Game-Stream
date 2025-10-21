//
//  SearchGame.swift
//  Game Stream
//
//  Created by David Giron on 13/10/25.
//

import Foundation
import Combine

class SearchGameViewModel: ObservableObject {
    
    @Published var gamesFound = [Game]()
    
    func search(gameName: String) {
        
        gamesFound.removeAll()
        
        let gameNameSpaces = gameName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: "https://gamestreamapi.herokuapp.com/api/games/search?contains=\(gameNameSpaces ?? "Witcher")")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            do {
                if let jsonData = data {
                    print("Tamaño del Json: \(jsonData.count) bytes")
                    
                    let decodeData = try
                    
                    JSONDecoder().decode(GameSearch.self, from: jsonData)
                
                    //En un hilo aparte
                    DispatchQueue.main.async {
                        self.gamesFound.append(contentsOf: decodeData.results)
                    }
                }
            } catch {
                print("Error: \(error)")
            }
            
        }.resume()
    }
}
