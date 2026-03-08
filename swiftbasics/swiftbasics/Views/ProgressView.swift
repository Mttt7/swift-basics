//
//  ProgressView.swift
//  swiftbasics
//
//  Created by Michał on 08/03/2026.
//

import SwiftUI

struct SkillProgressView: View {
    var progress: Int
    var maxProgress: Int = 7

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.black)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.green)
                    .frame(width: geo.size.width * (CGFloat(progress) / CGFloat(maxProgress)))
            }
        }
        .frame(width:350, height: 50)
    }
}

#Preview {
    SkillProgressView(progress: 5)
}
