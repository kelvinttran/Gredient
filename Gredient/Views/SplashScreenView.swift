//
//  SplashScreenView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-14.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            MainView()
        } else{
            ZStack {
                Color.green
                    .ignoresSafeArea()
                VStack{
                    VStack{
                        Image(systemName: "leaf")
                            .font(.system(size: 80))
                        Text("Gredient")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        withAnimation{
                            self.isActive = true
                        }
                    }
                }
            }
            
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
