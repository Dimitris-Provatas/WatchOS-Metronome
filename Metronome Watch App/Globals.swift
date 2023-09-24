//
//  Globals.swift
//  Metronome Watch App
//
//  Created by Dimitris Provatas on 24/9/23.
//

import SwiftUI

let INITIAL_BPM = 120.0;
let CURRENT_DEVICE_INTERFACE: WKInterfaceDevice = WKInterfaceDevice.current();

let METRONOME_HAPTIC_TYPE_FIRST : WKHapticType = WKHapticType.failure;
let METRONOME_HAPTIC_TYPE_NORMAL: WKHapticType = WKHapticType.start;
let METRONOME_HAPTIC_TYPE_SUB   : WKHapticType = WKHapticType.click;

let FIRST_BEAT_COLOR: Color = Color.green;
let OTHER_BEAT_COLOR: Color = Color.yellow;
let OTHER_SUB_BEAT_COLOR: Color = Color.red;
let INACTIVE_BEAT_COLOR: Color = Color.gray;

let BEAT_CIRCLE_SIZE: CGFloat = 20;
let SUBBEAT_CIRCLE_SIZE: CGFloat = 15;
