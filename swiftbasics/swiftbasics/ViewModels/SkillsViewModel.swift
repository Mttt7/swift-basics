import Foundation
import Combine


final class SkillsViewModel: ObservableObject {
    @Published var skills: [Skill] = [] {
        didSet {
            applySort()
            saveSkillsToUserDefaults()
        }
    }

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

    private enum Keys {
        static let skills = "skills.v1"
    }
    
    init(skills: [Skill]? = nil, sortOrder: SortOrder = .ascending) {
        // 1. domyślne skille jako fallback
        self.skills = getDefaultSkills()
        // 2. UserDefaults nadpisuje domyślne (zapisane dane użytkownika)
        if let savedSkills = loadSkillsFromUserDefaults() {
            self.skills = savedSkills
        }
        // 3. argument z init ma najwyższy priorytet (np. w testach)
        if let skills {
            self.skills = skills
        }
        self.sortOrder = sortOrder
        applySort()
    }
    
    public func reset() {
        skills = getDefaultSkills() // didSet automatycznie woła applySort() i saveSkillsToUserDefaults()
    }
    
    public func addSkill(name: String, level: Int, iconName: String) {
        let newSkill = Skill(name: name.trimmingCharacters(in: .whitespaces), level: level, iconName: iconName)
        skills.append(newSkill) // didSet automatycznie woła applySort() i saveSkillsToUserDefaults()
    }

    // private - nikt spoza klasy nie może wywołać tej metody bezpośrednio
    // jedyna droga zmiany sortedSkills prowadzi przez zmianę sortOrder
    private func applySort() {
        sortedSkills = skills.sorted { a, b in
            sortOrder == .ascending ? a.level < b.level : a.level > b.level
        }
    }
    
    private func saveSkillsToUserDefaults() {
        let encoded = try? JSONEncoder().encode(self.skills)
        UserDefaults.standard.set(encoded, forKey: Keys.skills)
    }
    
    private func loadSkillsFromUserDefaults() -> [Skill]? {
        guard let data = UserDefaults.standard.data(forKey: Keys.skills) else { return nil }
        do {
            return try JSONDecoder().decode([Skill].self, from: data)
        } catch {
            print("Błąd dekodowania skillów: \(error)")
            return nil
        }
    }
    
    private func getDefaultSkills() -> [Skill] {
        return [
            Skill(name: "Java 11/17", level: 7, iconName: "cup.and.heat.waves"),
            Skill(name: "Angular 13+", level: 6, iconName: "globe"),
            Skill(name: "Swift", level: 2, iconName: "swift"),
            Skill(name: "Python", level: 4, iconName: "lizard.circle")
        ]
    }
}
