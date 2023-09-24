//
//  ContentView.swift
//  Metronome Watch App
//
//  Created by Dimitris Provatas on 21/9/23.
//

import SwiftUI


struct MainView: View {
    @State private var bpm: Double = INITIAL_BPM;
    @State private var bpmToTimeout: Double = 60 / INITIAL_BPM;
    
    @State private var isPlaying: Bool = false;
    @State private var metronomeTimer: Timer = Timer.init(timeInterval: 1, repeats: true, block: {_ in});
    
    @State private var currentBeat = 0;
    @State private var timeSignatureUpper = 4;
    @State private var timeSignatureLower = 4;
    @State private var isOddMeter = false;
    
    @State private var isBeatSetupShown = false;
    
    func manageHaptics() {
        currentBeat = currentBeat >= timeSignatureUpper
        ? 1
        : currentBeat + 1;
        
        CURRENT_DEVICE_INTERFACE.play(
            currentBeat == 1
            ? METRONOME_HAPTIC_TYPE_FIRST
            : METRONOME_HAPTIC_TYPE_NORMAL
        );
    }
    
    func setupHaptics() {
        metronomeTimer.invalidate();
        
        if !isPlaying {
            currentBeat = 0;
            return;
        }
        
        manageHaptics();
        metronomeTimer = Timer.scheduledTimer(withTimeInterval: bpmToTimeout / (isOddMeter ? 2 : 1), repeats: true, block: {_ in
            manageHaptics();
        });
    }
    
    var body: some View {
        VStack {
            ZStack {
                // Main Circle
                Circle()
                    .stroke(Color.purple, lineWidth: 4)
                    .frame(width: 100, height: 100);
                
                // BPM Text
                Text("\(Int(bpm))")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .focusable()
                    .digitalCrownRotation(detent: $bpm, from: 1.0, through: 400.0, by: 1.0, sensitivity: .low, isContinuous: true, isHapticFeedbackEnabled: true, onChange:  {_ in
                        bpmToTimeout = 60 / bpm;
                        currentBeat = 0;
                        setupHaptics();
                    })
                    .onTapGesture {
                        isPlaying.toggle();
                        setupHaptics();
                    };
            };
            
            Spacer();
            
            // Beats
            BeatCircles(isPlaying: isPlaying, currentBeat: currentBeat, timeSignatureUpper: timeSignatureUpper, isOddMeter: isOddMeter)
                .onTapGesture {
                    // Stop current
                    isPlaying = false;
                    setupHaptics();
                    
                    // Get the Beat Setup
                    isBeatSetupShown = true;
                }
                .fullScreenCover(isPresented: $isBeatSetupShown, content: {
                    BeatSetup(isBeatSetupShown: $isBeatSetupShown, timeSignatureUpper: $timeSignatureUpper, timeSignatureLower: $timeSignatureLower, isOddMeter: $isOddMeter);
                })
        };
    };
}

#Preview {
    MainView();
}
