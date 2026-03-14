import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: SkillsViewModel
    @State private var showResetAlert = false
    @State private var showAddSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
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
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showResetAlert = true
                    } label: {
                        Label("Reset", systemImage: "arrow.counterclockwise")
                    }
                    .tint(.white)

                    Button {
                        showAddSheet = true
                    } label: {
                        Label("Dodaj", systemImage: "plus")
                    }
                    .tint(.white)
                }
            }
            .alert("Reset poziomów", isPresented: $showResetAlert) {
                Button("Anuluj", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    vm.reset()
                }
            } message: {
                Text("Czy na pewno chcesz zresetować wszystkie poziomy?")
            }
            .sheet(isPresented: $showAddSheet) {
                AddSkillView()
                    .environmentObject(vm)
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
        .environmentObject(SkillsViewModel())
}
