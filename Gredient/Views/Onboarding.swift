//
//  Onboarding.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-25.
//

import SwiftUI
import AVKit

struct Onboarding: View {
    @Binding var shouldShowOnboarding: Bool
    var body: some View {
        TabView{
            PageView(title: "Welcome to Gredient!",
                     subtitle: "Gredient is an app that allows parents to verify if food products are safe for the whole family to eat.",
                     showsDismissButton: false,
                     showVideoPlayer: false,
                     videoResource: "personalize",
                     shouldShowOnboarding: $shouldShowOnboarding
            )
            
            PageView(title: "Personalize",
                     subtitle: "Create family members and enter allergy and dietary restriction information.",
                     showsDismissButton: false,
                     showVideoPlayer: true,
                     videoResource: "personalize",
                     shouldShowOnboarding: $shouldShowOnboarding
            )
            
            PageView(title: "Scan",
                     subtitle: "Scan food products to get information about ingredients and additives.",
                     showsDismissButton: false,
                     showVideoPlayer: true,
                     videoResource: "scan",
                     shouldShowOnboarding: $shouldShowOnboarding
            )
            
            PageView(title: "Learn",
                     subtitle: "Review previously scanned items to understand the ingredients and additives more.",
                     showsDismissButton: true,
                     showVideoPlayer: true,
                     videoResource: "learn",
                     shouldShowOnboarding: $shouldShowOnboarding
            )
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct PageView: View {
    let title: String
    let subtitle: String
    let showsDismissButton: Bool
    let showVideoPlayer: Bool
    let videoResource: String
    var player = AVPlayer()
    @Binding var shouldShowOnboarding: Bool

    var body: some View {
        VStack{
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            if (showVideoPlayer){
                VideoPlayer(player: player)
                    .onAppear{
                        if player.currentItem == nil{
                            let item = AVPlayerItem(url: Bundle.main.url(forResource: videoResource, withExtension: "mp4")!)
                            player.replaceCurrentItem(with: item)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            player.play()
                        })
                    }
                    .scaledToFit()
                    .padding()
            }else{
                Image(systemName: "leaf")
                    .foregroundColor(.green)
                    .font(.system(size: 60))
                    .padding()
            }

            
            Text(subtitle)
                .multilineTextAlignment(.center)
            
            if showsDismissButton{
                Button(action: {
                    shouldShowOnboarding.toggle()
                }, label: {
                    Text("Get Started")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(6)
                })
                .padding()
            }
        }
    }
}


//struct Onboarding_Previews: PreviewProvider {
//    static var previews: some View {
//        Onboarding()
//    }
//}
