//
//  ContentView.swift
//  swiftbasics
//
//  Created by Michał on 05/03/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack{
            Color.blue
                .ignoresSafeArea()
            VStack(spacing: 12) {
                HStack {
                    Text("👨‍💻")
                        .font(.system(size: 50))
                    Text("Michał")
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .tracking(2)
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                }
                
                
                Text("IOS developer in progress")
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    
            }
            .padding()
        }
       
        
    }
}

#Preview {
    ContentView()
}
