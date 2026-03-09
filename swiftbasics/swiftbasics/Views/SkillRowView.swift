//
//  SkillRowView.swift
//  swiftbasics
//
//  Created by Michał on 06/03/2026.
//

import SwiftUI

struct SkillRowView : View {
    @Binding var skill: Skill
    
    var body: some View {
        HStack {
            Image(systemName: skill.iconName)
            Text(skill.name)
            HStack{
               Spacer()
                ForEach(1...skill.level, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
    
}
