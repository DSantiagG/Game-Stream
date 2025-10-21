//
//  ViewModel.swift
//  Game Stream
//
//  Created by David Giron on 10/10/25.
//

import Foundation
import Combine


class GamesViewModel: ObservableObject {
    
    //Se publica
    @Published var gamesInfo = [Game] ()
    
    init() {
        let url = URL(string: "https://gamestreamapi.herokuapp.com/api/games")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            do {
                if let jsonData = data {
                    print("Tamaño del Json: \(jsonData.count) bytes")
                    let decodeData = try
                        JSONDecoder().decode([Game].self, from: jsonData)
                    
                    //En un hilo aparte
                    DispatchQueue.main.async {
                        self.gamesInfo.append(contentsOf: decodeData)
                    }
                }
            } catch {
                print("Error: \(error)")
            }
            
        }.resume()
    }
    
}
