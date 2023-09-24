//
//  BeatSetup.swift
//  Metronome Watch App
//
//  Created by Dimitris Provatas on 24/9/23.
//

import SwiftUI


struct BeatSetup: View {
    @Binding var isBeatSetupShown: Bool;
    
    @Binding var timeSignatureUpper: Int;
    @Binding var timeSignatureLower: Int;
    @Binding var isOddMeter: Bool;
    
    @State private var selectedTimeSignatureUpper: Int = 4;
    @State private var selectedTimeSignatureLower: Int = 4;
    
    var body: some View {
        VStack {
            HStack {
                Picker("", selection: $selectedTimeSignatureUpper) {
                    ForEach([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16], id: \.self) {
                        Text("\($0)");
                    }
                };
                Picker("", selection: $selectedTimeSignatureLower) {
                    ForEach([1,2,4,8,16], id: \.self) {
                        Text("\($0)");
                    }
                };
            }
            
            Spacer();
            
            Button("Save", action: {
                timeSignatureLower = selectedTimeSignatureLower;
                timeSignatureUpper = selectedTimeSignatureUpper;
                
                isOddMeter = timeSignatureLower > 4 && timeSignatureUpper > 4 && timeSignatureUpper % 2 == 1;
                
                isBeatSetupShown = false;
            });
        }
    }
}
