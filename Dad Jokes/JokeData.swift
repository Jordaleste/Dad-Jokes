//
//  JokeData.swift
//  Dad Jokes
//
//  Created by Charles Eison on 12/5/20.
//

import Foundation

struct Jokes: Decodable {
    
    var setup: String = ""
    var punchline: String = ""
    var id: Int = 1
    var type: String = ""
}
