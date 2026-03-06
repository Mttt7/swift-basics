//
//  ContentView.swift
//  swiftbasics
//
//  Created by Michał on 05/03/2026.
//

import SwiftUI

struct ContentView: View {
    let skills: [Skill] = [
        try! Skill(name: "Java 11/17", level: 7, iconName: "cup.and.heat.waves"),
        try! Skill(name: "Angular 13+", level: 6, iconName: "globe"),
        try! Skill(name: "Swift", level: 2, iconName: "swift"),
        try! Skill(name: "Python", level: 4, iconName: "lizard.circle")
    ]
    @State var sortBy: String = "DESC"
    
    
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            VStack(spacing: 12) {
                HStack {
                    Text("👨‍💻")
                        .font(.system(size: 50))
                        .onTapGesture {
                            withAnimation {
                                if sortBy == "DESC" {
                                    sortBy = "ASC"
                                } else {
                                    sortBy = "DESC"
                                }
                            }
                        }
                    Text("Michał")
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .tracking(2)
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                }
                
                
                Text("IOS developer in progress")
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                
                List(skills.sorted(by: getSortableBy)) { skill in
                    HStack {
                        Image(systemName: skill.iconName)
                        Text(skill.name)
                        HStack{
                           Spacer()
                            ForEach(1...skill.level, id: \.self) { num in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .cornerRadius(20)
                
                .scrollDisabled(true)
                .frame(height: CGFloat(skills.count) * 52)
                    
            }
            .padding()
        }
       
        
    }
    
    func getSortableBy(_ a: Skill, _ b: Skill) -> Bool {
        if sortBy == "ASC" {
            return a.level < b.level
        } else {
            return a.level > b.level
        }
    }
        
}

#Preview {
    ContentView()
}
