import SwiftUI
import AVFoundation

struct realShowOfUI: View {
    @State var rotation = 0.0
    @State var playButton = true
    @State private var audioPlayer: AVAudioPlayer?
    @State private var currentTrackIndex = 0
    @State private var gradientShift = 0.0
    @State private var trigger = false
    
    let tracks = ["sunflower", "tumblrGirls", "winningSpeech", "ladyKiller"]
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                HStack {
                    Button(action: {
                        trigger.toggle()
                        audioPlayer?.pause()}) {
                        Image(systemName: (playButton ? "" : "pause"))
                            .resizable()
                            .frame(width: playButton ? 0 : 20, height: playButton ? 0 : 20)
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: playButton ? 25 : 30, style: .continuous)
                                    .frame(width: playButton ? 0 : 60, height: playButton ? 0 : 60)
                                    .shadow(color: .black , radius: 10).opacity(0.7)
                                    .foregroundColor(.black)
                            )
                    }
                    .onAppear {
                        withAnimation {
                            gradientShift = 1
                        }
                    }

                    Spacer()
                    Button(action: {
                        trigger.toggle()
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
                .padding(.horizontal, 25)
                
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
                
                VStack {
                    Button(action: {
                        trigger.toggle()
                    }) {
                        GlitchTextView("Shall WE?", trigger: trigger)
                    }
                }
                .font(.system(size: 35, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 200, height: 75)
                .background(Color(hue: 0.649, saturation: 0.977, brightness: 0.172))
                .cornerRadius(30)
                .padding()
                .shadow(color: .black, radius: 5)
                .onAppear {
                    startGlitchEffect()
                }

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
                    gradient: Gradient(colors: [Color(hue: 0.649, saturation: 0.977, brightness: 0.372)]),
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
    
    func startGlitchEffect() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            trigger.toggle()
        }
    }
    
    @ViewBuilder
    func GlitchTextView(_ text: String, trigger: Bool) -> some View {
        ZStack {
            GlitchText(text: text, trigger: trigger) {
                LinearKeyframe(GlitchFrame(top: -5, center: 0, bottom: 0, shadowOpacity: 0.2), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: -5, center: -5, bottom: -5, shadowOpacity: 0.6), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: -5, center: -5, bottom: 5, shadowOpacity: 0.8), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: 5, center: 5, bottom: 5, shadowOpacity: 0.4), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: 5, center: 0, bottom: 5, shadowOpacity: 0.1), duration: 0.1)
                LinearKeyframe(GlitchFrame(), duration: 0.1)
            }
            GlitchText(text: text, trigger: trigger, shadow: .green) {
                LinearKeyframe(GlitchFrame(top: -10, center: 0, bottom: 0, shadowOpacity: 0.3), duration: 0.02)
                LinearKeyframe(GlitchFrame(top: -10, center: -10, bottom: -10, shadowOpacity: 0.5), duration: 0.02)
                LinearKeyframe(GlitchFrame(top: -10, center: -10, bottom: 10, shadowOpacity: 0.7), duration: 0.02)
                LinearKeyframe(GlitchFrame(top: 10, center: 10, bottom: 10, shadowOpacity: 0.8), duration: 0.02)
                LinearKeyframe(GlitchFrame(top: 10, center: 0, bottom: 10, shadowOpacity: 0.4), duration: 0.02)
                LinearKeyframe(GlitchFrame(), duration: 0.02)
            }
        }
    }
}

#Preview {
    realShowOfUI()
}
