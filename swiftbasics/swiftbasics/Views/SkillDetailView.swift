//
//  SkillDetailView.swift
//  swiftbasics
//
//  Created by Michał on 08/03/2026.
//

import SwiftUI

struct SkillDetailView: View {
    var skill: Skill
    
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            VStack{
                ZStack{
                    ZStack{
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.white, Color.white.opacity(0.2)],
                                    startPoint: .leading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 120, height: 120)
                            .overlay(
                                    Circle().stroke(Color.black, lineWidth: 6)
                                )
                        Image(systemName: skill.iconName)
                            .font(.system(size: 67))
                            .padding(24)
                    }
                }
                Text(skill.name)
                    .font(.largeTitle)
                HStack{
                    ForEach(1...skill.level, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 31))
                    }
                }
                SkillProgressView(progress: skill.level)
                    .padding(10)
                Spacer()
            }
        }
       
    }
}


#Preview {
    SkillDetailView(
        skill: Skill(
            name: "Swift",
            level: 3,
            iconName: "swift"
        )
    )
}
