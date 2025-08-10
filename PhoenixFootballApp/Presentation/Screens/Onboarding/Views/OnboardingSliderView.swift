//
//  SliderView.swift
//  PhoenixFootballApp
//
//  Created by Md Shofiulla on 10/3/25.
//
import SwiftUI
struct OnboardingSliderView: View {
    
    var sliderItem: OnboadingViewItem
    
    var body: some View {
        VStack(spacing: 16) {
            Text(sliderItem.title)
                .font(.manrope(.bold, size: 32))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.53, green: 0.81, blue: 0.92))
            
            Text(sliderItem.text)
                .font(.manrope(.regular, size: 14))
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.76, green: 0.76, blue: 0.78))
            
            Image(sliderItem.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 212)
            
            
        }
        .padding()
    }
}
