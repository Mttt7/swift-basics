import Foundation
internal import Combine


final class SkillsViewModel: ObservableObject {
    @Published var skills: [Skill] = [
        Skill(name: "Java 11/17", level: 7, iconName: "cup.and.heat.waves"),
        Skill(name: "Angular 13+", level: 6, iconName: "globe"),
        Skill(name: "Swift", level: 2, iconName: "swift"),
        Skill(name: "Python", level: 4, iconName: "lizard.circle")
    ]

    // private(set) = getter publiczny, setter prywatny
    // analogia Java: publiczny getter + prywatny setter
    // nikt z zewnątrz nie może zrobić: vm.sortedSkills = []
    @Published private(set) var sortedSkills: [Skill] = []

    // didSet = property observer, odpala się automatycznie PO zmianie wartości !!!
    // analogia Java: setter który oprócz przypisania wywołuje dodatkową metodę
    // dzięki temu sortedSkills zawsze jest aktualne - liczymy tylko gdy coś się zmieni
    // (zamiast przeliczać przy każdym renderze widoku jak robiłaby computed property)
    @Published var sortOrder: SortOrder = .ascending {
        didSet { applySort() }
    }

    init(skills: [Skill]? = nil, sortOrder: SortOrder = .ascending) {
        if let skills {
            self.skills = skills
        }
        self.sortOrder = sortOrder
        // pierwsze sortowanie przy tworzeniu ViewModelu
        applySort()
    }

    // private - nikt spoza klasy nie może wywołać tej metody bezpośrednio
    // jedyna droga zmiany sortedSkills prowadzi przez zmianę sortOrder
    private func applySort() {
        sortedSkills = skills.sorted { a, b in
            sortOrder == .ascending ? a.level < b.level : a.level > b.level
        }
    }
}
