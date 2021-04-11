//
//  JokeWidget.swift
//  JokeWidget
//
//  Created by Charles Eison on 12/5/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), setup: "Stand by for Dad-Joke", punchline: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        //Be sure to add Widget Targets to JokeManager AND JokeData
        let jokeManager = JokeManager()
        jokeManager.completionHandler = { joke in
            
            let entry = SimpleEntry(date: Date(), setup: joke.setup, punchline: joke.punchline)
            completion(entry)
        }
        jokeManager.fetchData()
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let jokeManager = JokeManager()
        jokeManager.completionHandler = { joke in
            let entry = SimpleEntry(date: Date(), setup: joke.setup, punchline: joke.punchline)
            let timeToRefresh = Date().addingTimeInterval(60*60*1)
            let timeline = Timeline(entries: [entry], policy: .after(timeToRefresh))
            completion(timeline)
        }
        jokeManager.fetchData()
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let setup: String
    let punchline: String
}

struct JokeWidgetEntryView : View {
    var entry: Provider.Entry
    //add JokeWidget to assets target
    var imageToUse = Int.random(in: 1...9)
    
    var body: some View {
        ZStack {
            Image("dad\(imageToUse)")
                .resizable()
                .opacity(0.7)
            VStack {
                Text(entry.setup)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    
                Text(entry.punchline)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
            }
        }
    }
}

@main
struct JokeWidget: Widget {
    let kind: String = "JokeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            JokeWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Dad Jokes")
        .description("Random Dad Jokes displayed right on your home screen")
    }
}

struct JokeWidget_Previews: PreviewProvider {
    static var previews: some View {
        JokeWidgetEntryView(entry: SimpleEntry(date: Date(), setup: "Joke setup", punchline: "Joke punchline"))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
