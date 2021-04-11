//
//  ContentView.swift
//  Dad Jokes
//
//  Created by Charles Eison on 12/5/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var jokeManager = JokeManager()
    
    var body: some View {
        Text(jokeManager.joke.setup)
        Text(jokeManager.joke.punchline)
            .padding()
        
        Button("New Joke") {
            jokeManager.fetchData()
        }
        .onAppear { jokeManager.fetchData() }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
