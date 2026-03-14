import SwiftUI

struct AddSkillView: View {
    @EnvironmentObject var vm: SkillsViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var level: Int = 1
    @State private var iconName = "swift"
    
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
                        vm.addSkill(name: name, level: level, iconName: iconName)
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
    AddSkillView()
        .environmentObject(SkillsViewModel())
}
