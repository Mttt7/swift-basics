import Foundation


struct Skill: Identifiable {
    var id = UUID()
    var name: String
    var level: Int
    var iconName: String
    
    init(name:String, level: Int = 1, iconName: String) {
        self.name = name
        self.level = max(1, min(level, 7))
        self.iconName = iconName
    }
}
