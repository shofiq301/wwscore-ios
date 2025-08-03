//
//  VideoPlayerPage.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 7/27/25.
//

import APIFootball
import AVKit
import Combine
import InfiniteScrollView
import SUIRouter
import SwiftUI
import WrappingHStack
import XSwiftUI

struct VideoPlayerPage: View {
    let urls: [URLElement]
    
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
    @EnvironmentObject var themeManager: ThemeManager
    
    @State private var showFullScreen = false
    @State private var selectedUrl: URLElement?
    @State private var player: AVPlayer?
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var isPlaying = false
    @State private var showControls = true
    @State private var currentTime: Double = 0
    @State private var duration: Double = 0
    @State private var volume: Float = 0.5
    @State private var showQualityPicker = false
    @State private var isBuffering = false
    
    // Timer for hiding controls
    @State private var controlsTimer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Video Player Container
                videoPlayerContainer(geometry: geometry)
                
                // Content Area
                if !showFullScreen {
                    contentArea
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeManager.currentTheme.background.sd900)
        .appBar(
            title: "LIVE STREAM",
            trailing: {
                Button(action: toggleFullScreen) {
                    Image(systemName: showFullScreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                        .foregroundColor(themeManager.currentTheme.text.primary)
                }
            },
            leading: {
                AppBackButton {
                    cleanup()
                    pilot.pop()
                }
            }
        )
        .onAppear {
            setupInitialPlayer()
        }
        .onDisappear {
            cleanup()
        }
        .statusBarHidden(showFullScreen)
    }
    
    // MARK: - Video Player Container
    @ViewBuilder
    private func videoPlayerContainer(geometry: GeometryProxy) -> some View {
        ZStack {
            // Video Player
            if let player = player {
                VideoPlayerView(player: player, showFullScreen: $showFullScreen)
                    .aspectRatio(showFullScreen ? nil : 16/9, contentMode: .fit)
                    .frame(
                        width: showFullScreen ? geometry.size.width : nil,
                        height: showFullScreen ? geometry.size.height : nil
                    )
                    .clipped()
                    .onTapGesture {
                        toggleControlsVisibility()
                    }
            } else {
                // Loading/Error State
                Rectangle()
                    .fill(Color.black)
                    .aspectRatio(showFullScreen ? nil : 16/9, contentMode: .fit)
                    .frame(
                        width: showFullScreen ? geometry.size.width : nil,
                        height: showFullScreen ? geometry.size.height : nil
                    )
                    .overlay(
                        Group {
                            if isLoading {
                                VStack(spacing: 16) {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(1.5)
                                    Text("Loading video...")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                }
                            } else if let error = errorMessage {
                                VStack(spacing: 16) {
                                    Image(systemName: "exclamationmark.triangle")
                                        .font(.system(size: 40))
                                        .foregroundColor(.red)
                                    Text("Failed to load video")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .semibold))
                                    Text(error)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.center)
                                    Button("Retry") {
                                        setupPlayer(for: selectedUrl)
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                                .padding()
                            }
                        }
                    )
            }
            
            // Video Controls Overlay
            if showControls && player != nil {
                videoControlsOverlay
            }
            
            // Buffering Indicator
            if isBuffering {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.2)
                    Text("Buffering...")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .padding(.top, 8)
                }
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
            }
        }
    }
    
    // MARK: - Video Controls Overlay
    @ViewBuilder
    private var videoControlsOverlay: some View {
        VStack {
            // Top Controls
            HStack {
                // Live Indicator
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                    Text("LIVE")
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .bold))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.black.opacity(0.6))
                .cornerRadius(15)
                
                Spacer()
                
                // Quality Button
                Button(action: { showQualityPicker.toggle() }) {
                    Text(selectedUrl?.label ?? "AUTO")
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .semibold))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Spacer()
            
            // Center Play/Pause Button
            Button(action: togglePlayPause) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .opacity(0.9)
            }
            
            Spacer()
            
            // Bottom Controls
            VStack(spacing: 12) {
                // Progress Bar (for non-live content)
                if duration > 0 {
                    HStack(spacing: 12) {
                        Text(formatTime(currentTime))
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .medium))
                        
                        Slider(value: $currentTime, in: 0...duration) { editing in
                            if !editing {
                                player?.seek(to: CMTime(seconds: currentTime, preferredTimescale: 1))
                            }
                        }
                        .accentColor(.blue)
                        
                        Text(formatTime(duration))
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .medium))
                    }
                    .padding(.horizontal, 20)
                }
                
                // Control Buttons
                HStack(spacing: 30) {
                    // Volume Control
                    HStack(spacing: 8) {
                        Image(systemName: volume == 0 ? "speaker.slash" : "speaker.2")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                        
                        Slider(value: $volume, in: 0...1) { _ in
                            player?.volume = volume
                        }
                        .frame(width: 80)
                        .accentColor(.white)
                    }
                    
                    Spacer()
                    
                    // Fullscreen Button
                    Button(action: toggleFullScreen) {
                        Image(systemName: showFullScreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.4), Color.clear, Color.clear, Color.black.opacity(0.4)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
    
    // MARK: - Content Area
    @ViewBuilder
    private var contentArea: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Quality Selection Section
                qualitySelectionSection
                
                // Stream Information
                streamInfoSection
                
                // Additional Options
                //additionalOptionsSection
            }
            .padding()
        }
        .background(themeManager.currentTheme.background.sd800)
    }
    
    // MARK: - Quality Selection Section
    @ViewBuilder
    private var qualitySelectionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "tv")
                    .foregroundColor(themeManager.currentTheme.primaryDefault)
                    .font(.system(size: 20))
                
                Text("Video Quality")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(themeManager.currentTheme.textDefault)
                
                Spacer()
                
            }
            
            WrappingHStack(urls, id: \.self, spacing: .constant(12), lineSpacing: 12) { urlElement in
                QualityButton(
                    urlElement: urlElement,
                    isSelected: selectedUrl?.label == urlElement.label,
                    onSelect: {
                        selectedUrl = urlElement
                        setupPlayer(for: urlElement)
                    },
                    themeManager: themeManager
                )
            }
        }
        .padding()
        .background(themeManager.currentTheme.background.sd700)
        .cornerRadius(12)
    }
    
    // MARK: - Stream Info Section
    @ViewBuilder
    private var streamInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "info.circle")
                    .foregroundColor(themeManager.currentTheme.primaryDefault)
                    .font(.system(size: 20))
                
                Text("Stream Information")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(themeManager.currentTheme.text.primary)
            }
            
            VStack(spacing: 12) {
                StreamInfoRow(
                    title: "Status",
                    value: isPlaying ? "Live" : "Stopped",
                    icon: "dot.radiowaves.left.and.right",
                    valueColor: isPlaying ? .green : .red
                )
                
                StreamInfoRow(
                    title: "Quality",
                    value: selectedUrl?.label ?? "Auto",
                    icon: "tv.circle"
                )
                
                StreamInfoRow(
                    title: "Protocol",
                    value: "HLS",
                    icon: "network"
                )
                
                if let url = selectedUrl?.url {
                    StreamInfoRow(
                        title: "Source",
                        value: URL(string: url)?.host ?? "Unknown",
                        icon: "server.rack"
                    )
                }
            }
        }
        .padding()
        .background(themeManager.currentTheme.background.sd700)
        .cornerRadius(12)
    }
    
    // MARK: - Additional Options Section
    @ViewBuilder
    private var additionalOptionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "gearshape")
                    .foregroundColor(themeManager.currentTheme.primaryDefault)
                    .font(.system(size: 20))
                
                Text("Player Options")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(themeManager.currentTheme.textDefault)
            }
            
            VStack(spacing: 12) {
                OptionButton(
                    title: "Picture in Picture",
                    subtitle: "Play video in a floating window",
                    icon: "pip.enter",
                    action: enablePictureInPicture
                )
                
                OptionButton(
                    title: "Share Stream",
                    subtitle: "Share this live stream",
                    icon: "square.and.arrow.up",
                    action: shareStream
                )
                
                OptionButton(
                    title: "Report Issue",
                    subtitle: "Report playback problems",
                    icon: "exclamationmark.bubble",
                    action: reportIssue
                )
            }
        }
        .padding()
        .background(themeManager.currentTheme.background.sd700)
        .cornerRadius(12)
    }
    
    // MARK: - Helper Functions
    private func setupInitialPlayer() {
        selectedUrl = urls.first
        setupPlayer(for: selectedUrl)
    }
    
    private func setupPlayer(for urlElement: URLElement?) {
        guard let urlElement = urlElement,
              let url = URL(string: urlElement.url) else {
            errorMessage = "Invalid video URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // Clean up existing player
        player?.pause()
        
//        player = nil
        
        if let player = player{
           
            player.replaceCurrentItem(with: AVPlayerItem(url: url))
        }else{
            let newPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
            player = newPlayer
        }
        
        // Create new player
        //let newPlayer = AVPlayer(url: url)
        player?.volume = volume
        
      
        
        // Set up player observers
        if let newPlayer = player{
            setupPlayerObservers(for: newPlayer)
        }
       
        
     //   player = newPlayer
        
        // Auto-play
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            player?.play()
            isLoading = false
            isPlaying = true
        }
    }
    
    private func setupPlayerObservers(for player: AVPlayer) {
        // Add time observer
        player.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 1),
            queue: .main
        ) { time in
            currentTime = time.seconds
            
            if let duration = player.currentItem?.duration {
                self.duration = duration.seconds
            }
        }
        
        // Add status observer
        player.currentItem?.publisher(for: \.status)
            .sink { status in
                switch status {
                case .readyToPlay:
                    isLoading = false
                    errorMessage = nil
                case .failed:
                    isLoading = false
                    errorMessage = player.currentItem?.error?.localizedDescription ?? "Playback failed"
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    @State private var cancellables = Set<AnyCancellable>()
    
    private func togglePlayPause() {
        guard let player = player else { return }
        
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
        
        // Show controls briefly
        showControlsTemporarily()
    }
    
    private func toggleFullScreen() {
        withAnimation(.easeInOut(duration: 0.3)) {
            showFullScreen.toggle()
        }
    }
    
    private func toggleControlsVisibility() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showControls.toggle()
        }
        
        if showControls {
            showControlsTemporarily()
        }
    }
    
    private func showControlsTemporarily() {
        controlsTimer?.invalidate()
        showControls = true
        
        controlsTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            withAnimation(.easeInOut(duration: 0.2)) {
                showControls = false
            }
        }
    }
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func cleanup() {
        player?.pause()
        player = nil
        controlsTimer?.invalidate()
        cancellables.removeAll()
    }
    
    // MARK: - Action Functions
    private func enablePictureInPicture() {
        // Implement PiP functionality
    }
    
    private func shareStream() {
        // Implement share functionality
    }
    
    private func reportIssue() {
        // Implement report functionality
    }
}

// MARK: - Supporting Views

struct QualityButton: View {
    let urlElement: URLElement
    let isSelected: Bool
    let onSelect: () -> Void
    
    let themeManager: ThemeManager
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 8) {
                // Quality indicator
                Circle()
                    .fill(qualityColor)
                    .frame(width: 8, height: 8)
                
                Text(urlElement.label)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isSelected ? .white : themeManager.currentTheme.textDefault)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? themeManager.currentTheme.primaryDefault : themeManager.currentTheme.background.sd600)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                isSelected ? themeManager.currentTheme.primaryDefault : themeManager.currentTheme.backgroundDefault,
                                lineWidth: 1
                            )
                    )
            )
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
    
    private var qualityColor: Color {
        switch urlElement.label.uppercased() {
        case "HD", "FHD": return .green
        case "SD": return .orange
        case "MD": return .yellow
        default: return .blue
        }
    }
}

struct StreamInfoRow: View {
    let title: String
    let value: String
    let icon: String
    var valueColor: Color = .primary
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(themeManager.currentTheme.textDefault)
                .frame(width: 20)
            
            Text(title)
                .foregroundColor(themeManager.currentTheme.textDefault)
                .font(.system(size: 14))
            
            Spacer()
            
            Text(value)
                .foregroundColor(valueColor == .primary ? themeManager.currentTheme.textDefault : valueColor)
                .font(.system(size: 14, weight: .medium))
        }
    }
}

struct OptionButton: View {
    let title: String
    let subtitle: String
    let icon: String
    let action: () -> Void
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(themeManager.currentTheme.primaryDefault)
                    .font(.system(size: 18))
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .foregroundColor(themeManager.currentTheme.textDefault)
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(subtitle)
                        .foregroundColor(themeManager.currentTheme.text.sd300)
                        .font(.system(size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Image(systemName: "chevron.right")
                    .foregroundColor(themeManager.currentTheme.text.sd300)
                    .font(.system(size: 12))
            }
            .padding()
            .background(themeManager.currentTheme.background.sd600)
            .cornerRadius(8)
        }
    }
}
