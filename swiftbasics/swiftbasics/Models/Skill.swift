import Foundation


struct Skill: Identifiable {
    var id = UUID()
    let name: String
    let level: Int
    let iconName: String
    
    init(name:String, level: Int = 1, iconName: String) throws {
        guard (1...10).contains(level) else {
            throw InvalidLevelError(level: level)
        }
        self.name = name
        self.level = level
        self.iconName = iconName
    }
}
