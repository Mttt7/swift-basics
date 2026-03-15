import SwiftUI

struct SkiilFormView: View {
    @EnvironmentObject var vm: SkillsViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var level: Int = 1
    @State private var iconName = "swift"
    @State private var skillToEdit: Skill? = nil
    
    let icons = [
        ("swift", "Swift"),
        ("globe", "Globe"),
        ("cup.and.heat.waves", "Java"),
        ("lizard.circle", "Python"),
        ("star.fill", "Star"),
        ("laptopcomputer", "Laptop"),
        ("terminal", "Terminal"),
        ("hammer", "Hammer")
    ]
    
    var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    init(skillToedit: Skill? = nil) {
        if(skillToedit != nil){
            self.skillToEdit = skillToedit!
            _name = State(initialValue: skillToedit!.name)
            _level = State(initialValue: skillToedit!.level)
            _iconName = State(initialValue: skillToedit!.iconName)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nazwa", text: $name)
                Stepper("Level: \(level)", value: $level, in: 1...7)
                
                Picker("Ikona", selection: $iconName) {
                    ForEach(icons, id: \.0) { icon, label in
                        Label(label, systemImage: icon)
                            .tag(icon)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Anuluj", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Zapisz") {
                        if(skillToEdit != nil) {
                            vm.updateSkill(skillToEdit!, newName: name, newLevel: level, newIconName: iconName)
                        } else {
                            vm.addSkill(name: name, level: level, iconName: iconName)
                        }
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
    SkiilFormView()
        .environmentObject(SkillsViewModel())
}
