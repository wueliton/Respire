//
//  HomeView.swift
//  Restart
//
//  Created by Paulo Wueliton on 14/11/21.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    @State private var musics: Array<String> = ["Two Moons - Bobby Richards","Lens - Bobby Richards","Glacier - Patrick Patrikios","Underwater Exploration - Godmode","On the Island - Godmode","Dolphin-esque - Godmode","Eternal Garden - Dan Henig","Nebular Focus - Dan Henig","Violet Spirit - Dan Henig"]
    let audioPlay: AudioPlayer!
    
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - HEADER
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(
                        Animation
                            .easeInOut(duration: 4)
                            .repeatForever()
                        , value: isAnimating
                    )
            }
            
            // MARK: - CENTER
            Text("Mente e corpo têm uma conexão única. Cuide-se para mantê-los equilibrados.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            // MARK: - FOOTER
            Spacer()
            
            Button(action: {
                withAnimation {
                    isOnBoardingViewActive = true
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Recomeçar")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } //: VSTACK
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                audioPlay.fileName = musics.randomElement()!
                audioPlay.fileType = "mp3"
                audioPlay.playSound()
                isAnimating = true
            })
        })
        .onDisappear(perform: {
            audioPlay.stopSound()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(audioPlay: AudioPlayer())
    }
}
