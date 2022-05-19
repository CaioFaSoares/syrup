//
//  syrupView.swift
//  syrup
//
//  Created by Caio Soares on 11/05/22.
//

/*
 ForEach (daySlices, id: \.id) {
     daySlices in Text("\(daySlices.slice)")
 }
 ForEach (hourSlices, id: \.id) {
     hourSlices in Text("\(hourSlices.slice)")
 }
 */

import SwiftUI


struct syrupView: View {
    
    var body: some View {
        TabView{
            syrupDailyView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Today")
                }
            syrupWeeklyView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("This week")
                }
            syrupConfigView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Config")
                }
        }
    }
}

struct syrupWeeklyView: View {
    var body: some View {
        NavigationView {
            HStack{
                Text("View da semana")
            }
            .navigationTitle("Essa semana")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct syrupConfigView: View {
    var body: some View {
        NavigationView {
            HStack{
                Text("View das configs")
            }
            .navigationTitle("Config")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// Syrup Xcode previews struct

struct syrupView_Previews: PreviewProvider {
    static var previews: some View {
        syrupView()
    }
}

