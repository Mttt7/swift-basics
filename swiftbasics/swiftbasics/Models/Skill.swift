import Foundation


struct Skill: Identifiable {
    var id = UUID()
    let name: String
    let level: Int
    let iconName: String
    
    init(name:String, level: Int = 1, iconName: String) {
        self.name = name
        self.level = max(1, min(level, 10))
        self.iconName = iconName
    }
}
