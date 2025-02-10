//
//  ContentView.swift
//  spotify-view
//
//

import SwiftUI

struct ContentView: View {
    @State private var isPlaying: Bool = false
    @State private var isHeart: Bool = false
    @State private var songProgress: Double = 34
    let totalDuration: Double = 147 // 2:27 in seconds
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                .purple,
                .black
            ]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Image(systemName: "chevron.down")
                    Spacer()
                    Text("PURE")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .bold()
                .foregroundColor(.white)
                .padding()
                

                Image("pure")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 360, height: 360)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding()
                
                HStack {
                    VStack (alignment: .leading){
                        Text("絶体絶命")
                            .font(.title)
                            .bold()
                        Text("Cö Shu Nie")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button {
                        isHeart = !isHeart
                    } label: {
                        Image(systemName: isHeart ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundColor(isHeart ? .green : .white)
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal)
                
                VStack {
                    Slider(value: $songProgress, in: 0...totalDuration)
                        .accentColor(.white)
                        .padding(.horizontal)
                    HStack {
                        Text(formatTime(seconds: songProgress))
                        Spacer()
                        Text("-\(formatTime(seconds: totalDuration - songProgress))")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                }
                
                HStack {
                    Image(systemName: "shuffle")
                    Spacer()
                    Image(systemName: "backward.fill")
                    Spacer()
                    Button {
                        isPlaying = !isPlaying
                    } label: {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 60))
                            .padding()
                    }
                    Spacer()
                    Image(systemName: "forward.fill")
                    Spacer()
                    Image(systemName: "repeat")
                }
                .foregroundColor(.white)
                .font(.title)
                .padding(.horizontal, 40)
                
        
                HStack{
                    Image(systemName: "laptopcomputer")
                        .foregroundColor(.green)
                    Text("Macbook Pro")
                        .font(.footnote)
                        .foregroundColor(.green)
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                    Image(systemName: "list.bullet")
                        .font(.title2)
                    
                }
                .foregroundColor(.white)
                .padding()
            }
        }
        
        /**
         reference:
         https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-a-timer-with-swiftui
        **/
        .onReceive(
            Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        ) { _ in
            if isPlaying && songProgress < totalDuration {
                songProgress += 1
            }
        }
    }
    func formatTime(seconds: Double) -> String{
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, seconds)
        
    }
}

#Preview {
    ContentView()
}
