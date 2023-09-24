//
//  BeatCircles.swift
//  Metronome Watch App
//
//  Created by Dimitris Provatas on 24/9/23.
//

import SwiftUI


struct BeatCircles: View {
    var isPlaying: Bool;
    var currentBeat: Int;
    var timeSignatureUpper: Int;
    var isOddMeter: Bool;
    
    var body: some View {
        HStack {
            // First Beat
            Circle()
                .fill(isPlaying && currentBeat == 1 ? FIRST_BEAT_COLOR : INACTIVE_BEAT_COLOR)
                .frame(width: BEAT_CIRCLE_SIZE, height: BEAT_CIRCLE_SIZE);
            
            // Other Beats
            if timeSignatureUpper > 1 {
                ForEach(2...timeSignatureUpper, id: \.self) {
                    let beatColor: Color = isPlaying && currentBeat == $0
                    ? (isOddMeter
                       ? ($0 % 2 == 0
                          ? OTHER_SUB_BEAT_COLOR
                          : OTHER_BEAT_COLOR)
                       : OTHER_BEAT_COLOR)
                    : INACTIVE_BEAT_COLOR;
                    
                    let circleSize: CGFloat = isOddMeter && $0 % 2 == 0 ? SUBBEAT_CIRCLE_SIZE : BEAT_CIRCLE_SIZE
                    
                    Circle()
                        .fill(beatColor)
                        .frame(width: circleSize, height: circleSize);
                }
            }
        }
    }
}
