//
//  JokeManager.swift
//  Dad Jokes
//
//  Created by Charles Eison on 12/5/20.
//

import Foundation

//api docs: https://github.com/15Dkatz/official_joke_api

class JokeManager: ObservableObject {
    
    //the didset completionhandler is being used in the widget
    @Published var joke = Jokes() {
      didSet {
        completionHandler?(joke)
    }}
    
    //This is called in our widget
    var completionHandler: ((Jokes) -> Void)?
    
    func fetchData() {
        if let url = URL(string: "https://official-joke-api.appspot.com/random_joke") {
            //let session = URLSession(configuration: .default)
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Jokes.self, from: safeData)
                            DispatchQueue.main.async {
                                self.joke = results
                            }
                        } catch {
                            print("Error: \(error)")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}
