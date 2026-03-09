//
//  ContentView.swift
//  swiftbasics
//
//  Created by Michał on 05/03/2026.
//

import SwiftUI

struct ContentView: View {
    @State var skills: [Skill] = [
        Skill(name: "Java 11/17", level: 7, iconName: "cup.and.heat.waves"),
        Skill(name: "Angular 13+", level: 6, iconName: "globe"),
        Skill(name: "Swift", level: 2, iconName: "swift"),
        Skill(name: "Python", level: 4, iconName: "lizard.circle")
    ]
    @State var sortBy: SortOrder = .ascending
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                VStack(spacing: 12) {
                    HStack {
                        Text("👨‍💻")
                            .font(.system(size: 50))
                            .onTapGesture {
                                withAnimation {
                                    if sortBy == .descending {
                                        sortBy = .ascending
                                    } else {
                                        sortBy = .descending
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
                        .clipShape(.rect(cornerRadius: 16))
                    
                    List {
                        ForEach(sortedIndices, id: \.self) { index in
                            NavigationLink(destination: SkillDetailView(skill: $skills[index])) {
                                SkillRowView(skill: $skills[index])
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
    }
    
    var sortedIndices: [Int] {
        skills.indices.sorted { a, b in
            if sortBy == .ascending {
                return skills[a].level < skills[b].level
            } else {
                return skills[a].level > skills[b].level
            }
        }
    }
    
}

#Preview {
    ContentView()
}
