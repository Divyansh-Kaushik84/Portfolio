import SwiftUI
import AVFoundation

struct realShowOfUI: View {
    @State var rotation = 0.0
    @State var playButton = true
    @State private var audioPlayer: AVAudioPlayer?
    @State private var currentTrackIndex = 0
    @State private var gradientShift = 0.0
    
    let tracks = ["sunflower", "tumblrGirls", "winningSpeech", "ladyKiller"]
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    Button(action: {
                        if playButton {
                            playTrack()
                        } else {
                            changeTrack()
                        }
                        playButton = false
                    }) {
                        Image(systemName: (playButton ? "play" : "forward"))
                            .resizable()
                            .frame(width: playButton ? 20 : 30, height: 20)
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: playButton ? 25 : 30, style: .continuous)
                                    .frame(width: playButton ? 50 : 60, height: playButton ? 50 : 60)
                                    .shadow(color: .black , radius: 10).opacity(0.7)
                                    .foregroundColor(.black)

                            )
                    }
                    .onAppear {
                        withAnimation {
                            gradientShift = 1
                        }
                    }

                }
                .padding(.trailing, 25)
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: 290, height: 340)
                        .foregroundColor(Color(hue: 0.649, saturation: 0.977, brightness: 0.172)).shadow(color: .black,radius: 10)
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: 500, height: 200)
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [.orange, .yellow, .orange, .yellow]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .rotationEffect(.degrees(rotation))
                        .mask {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(lineWidth: 7)
                                .frame(width: 285, height: 336)
                        }
                    Text("You really thought that was my portfolio...\n\n  Didn't You?")
                        .frame(width: 260, height: 340)
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                }
                .onAppear {
                    withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                }
                .edgesIgnoringSafeArea(.all)
                
                
                NavigationLink("Shall WE?", destination: ContentView())
                    .bold()
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 75)
                    .background(Color(hue: 0.649, saturation: 0.977, brightness: 0.172))
                    .cornerRadius(30)
                    .padding()
                    .shadow(color: .black,radius: 5)
                
                Spacer()
                
                Text("\" You are the best project you will ever work on. \"")
                    .multilineTextAlignment(.center)
                    .bold()
                    .font(.callout)
                    .foregroundColor(.white)
                Spacer()

            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [ Color(hue: 0.649, saturation: 0.977, brightness: 0.372) ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .hueRotation(Angle(degrees: gradientShift * 45))
                .animation(.linear(duration: 5).repeatForever(autoreverses: false))
            ).edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden()
    }
    
    func playTrack() {
        let trackName = tracks[currentTrackIndex]
        if let soundURL = Bundle.main.url(forResource: trackName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Unable to play sound: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found.")
        }
    }
    
    func changeTrack() {
        audioPlayer?.pause()
        currentTrackIndex = (currentTrackIndex + 1) % tracks.count
        playTrack()
    }
}

#Preview {
    realShowOfUI()
}
