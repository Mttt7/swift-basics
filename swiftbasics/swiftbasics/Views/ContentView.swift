//
//  ContentView.swift
//  swiftbasics
//
//  Created by Michał on 05/03/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = SkillsViewModel()
    
    
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
                                    if vm.sortOrder == .descending {
                                        vm.sortOrder = .ascending
                                    } else {
                                        vm.sortOrder = .descending
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
                        // ForEach iteruje po KOPII tablicy sortedSkills
                        // Skill to struct (typ wartościowy) - każde "skill" w pętli to kopia
                        // analogia Java: jak iterowanie po liście prymitywów, nie referencji
                        ForEach(vm.sortedSkills) { skill in
                            // binding(for:) jest potrzebny bo "skill" to kopia
                            // musimy znaleźć ORYGINAŁ w vm.skills po id
                            // żeby zmiany w SkillDetailView trafiły z powrotem do ViewModelu
                            NavigationLink(destination: SkillDetailView(skill: binding(for: skill))) {
                                SkillRowView(skill: skill)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .cornerRadius(20)
                    .scrollDisabled(true)
                    .frame(height: CGFloat(vm.skills.count) * 52)
                    
                }
                .padding()
            }
        }
    }
    
    // Binding to "most" między kopią struct a oryginalnym miejscem w pamięci
    // szukamy oryginału po id, zwracamy referencję ($vm.skills[index])
    // gdyby Skill był class (typ referencyjny) jak w Javie - ta funkcja nie byłaby potrzebna
    func binding(for skill: Skill) -> Binding<Skill> {
        guard let index = vm.skills.firstIndex(where: { $0.id == skill.id }) else {
            fatalError("Skill not found")
        }
        return $vm.skills[index]
    }
    
}

#Preview {
    ContentView()
}
