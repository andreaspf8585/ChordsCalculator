//
//  ContentView.swift
//  ChordsCalculator
//
//  Created by Ανδρέας Γκόγκος on 24/12/20.
//

import SwiftUI

let notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B",  "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C"]

struct ContentView: View {
    @State private var selectedKey = Key.C
    @State private var keyIndex = 0
    @State var majorScale = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B",  "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C"]
    // group 1 chords
    @State var powerChord = ""
    @State var majorChord = ""
    @State var minorChord = ""
    @State var sus2Chord = ""
    @State var sus4Chord = ""
    
    // group 2 chords
    @State var major7 = ""
    @State var minor7 = ""
    @State var dominant7 = ""
    @State var add9 = ""
    @State var minorAdd9 = ""
    @State var add11 = ""
    @State var minorAdd11 = ""
    @State var sixChord = ""
    @State var minorSixChord = ""
    
    // group 3 chords
    @State var major9 = ""
    @State var minor9 = ""
    @State var dominant9 = ""
    @State var major11 = ""
    @State var minor11 = ""
    @State var dominant11 = ""
    @State var major13 = ""
    @State var minor13 = ""
    @State var dominant13 = ""
    
    // group 4 chords
    @State var augmented = ""
    @State var diminished = ""
    @State var b13HalfDiminished = ""
    @State var sharp9 = ""
    @State var b9 = ""
    @State var b13 = ""
    
    // Scales
    @State var ionian = ""
    @State var dorian = ""
    @State var phrygian = ""
    @State var lydian = ""
    @State var mixolydian = ""
    @State var aeolian = ""
    @State var locrian = ""
    
    
    
    
    enum Key: String, CaseIterable, Identifiable {
        case C
        case CSharp = "C#"
        case D
        case DSharp = "D#"
        case E
        case F
        case FSharp = "F#"
        case G
        case GSharp = "G#"
        case A
        case ASharp = "A#"
        case B
        var id: String { self.rawValue }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                AppLogo()
                VStack {
                    HStack{
                        Text("Choose key:")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                        Picker(selectedKey.id, selection: $selectedKey) {
                            Group{
                                Text("C").tag(Key.C)
                                Text("C#").tag(Key.CSharp)
                                Text("D").tag(Key.D)
                                Text("D#").tag(Key.DSharp)
                                Text("E").tag(Key.E)
                                Text("F").tag(Key.F)
                            }
                            Group{
                                Text("F#").tag(Key.FSharp)
                                Text("G").tag(Key.G)
                                Text("G#").tag(Key.GSharp)
                                Text("A").tag(Key.A)
                                Text("A#").tag(Key.ASharp)
                                Text("B").tag(Key.B)
                            }
                        }.pickerStyle(MenuPickerStyle())
                        .foregroundColor(.blue)
                        .font(.system(size: 25))
                        .font(.system(size: 25, weight: .heavy, design: .serif))
                        .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .onChange(of: selectedKey, perform: { value in
                            calculateChords()
                        })
                    }
                    MajorScaleView(majorScale: majorScale)
                }
                TabView {
                    Group1Chords(powerChord: powerChord, majorChord: majorChord, minorChord: minorChord, sus2Chord: sus2Chord, sus4Chord: sus4Chord)
                        .tabItem {
                            Image(systemName: "1.square.fill")
                            Text("Group 1")
                        }
                    Group2Chords(major7: major7, minor7: minor7, dominant7: dominant7, add9: add9, minorAdd9: minorAdd9, add11: add11, minorAdd11: minorAdd11, sixChord: sixChord, minorSixChord: minorSixChord)
                        .tabItem {
                            Image(systemName: "2.square.fill")
                            Text("Group 2")
                        }
                    Group3Chords(major9: major9, minor9: minor9, dominant9: dominant9, major11: major11, minor11: minor11, dominant11: dominant11, major13: major13, minor13: minor13, dominant13: dominant13)
                        .tabItem {
                            Image(systemName: "3.square.fill")
                            Text("Group 3")
                        }
                    Group4Chords(augmented: augmented, diminished: diminished, b13HalfDiminished: b13HalfDiminished, sharp9: sharp9, b9: b9, b13: b13)
                        .tabItem {
                            Image(systemName: "4.square.fill")
                            Text("Group 4")
                        }
                    ScalesView(ionian: ionian, dorian: dorian, phrygian: phrygian, lydian: lydian, mixolydian: mixolydian, aeolian: aeolian, locrian: locrian)
                        .tabItem {
                            Image(systemName: "5.square.fill")
                            Text("Scales")
                        }
                }
                .font(.headline)
                Spacer()
                
            }
        }.onAppear(perform: {
            calculateChords()
        })
    }
    
    func calculateChords(){
        //var keyIndex = 0
        print("Selected key: \(selectedKey.rawValue)")
        for i in 0...11 {
            if selectedKey.rawValue == notes[i] {
                keyIndex = i
            }
        }
        majorScale = [notes[keyIndex],
                      notes[keyIndex + 2],
                      notes[keyIndex + 4],
                      notes[keyIndex + 5],
                      notes[keyIndex + 7],
                      notes[keyIndex + 9],
                      notes[keyIndex + 11],
                      notes[keyIndex + 12],
                      notes[keyIndex + 14],
                      notes[keyIndex + 16],
                      notes[keyIndex + 17],
                      notes[keyIndex + 19],
                      notes[keyIndex + 21],
                      notes[keyIndex + 23],
                      notes[keyIndex + 24],
                      notes[keyIndex + 26],
                      notes[keyIndex + 28],
                      notes[keyIndex + 29],
                      notes[keyIndex + 31],
                      notes[keyIndex + 33],
                      notes[keyIndex + 35],
                      notes[keyIndex + 36],
                      
        ]
        print(majorScale)
        
        powerChord = majorScale[0] + ", " + majorScale[4]
        majorChord = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4]
        minorChord = majorScale[0] + ", " + flatNote(note: majorScale[2]) + ", " + majorScale[4]
        sus2Chord = majorScale[0] + ", " + majorScale[1] + ", " + majorScale[4]
        sus4Chord = majorScale[0] + ", " + majorScale[3] + ", " + majorScale[4]
        
        major7 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + majorScale[6]
        minor7 = majorScale[0] + ", " + flatNote(note: majorScale[2]) + ", " + majorScale[4] + ", " + flatNote(note: majorScale[6])
        dominant7 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + flatNote(note: majorScale[6])
        add9 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + majorScale[8]
        minorAdd9 = majorScale[0] + ", " + flatNote(note: majorScale[2]) + ", " + majorScale[4] + ", " + majorScale[8]
        add11 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + majorScale[10]
        minorAdd11 = majorScale[0] + ", " + flatNote(note: majorScale[2]) + ", " + majorScale[4] + ", " + majorScale[10]
        sixChord = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + majorScale[5]
        minorSixChord = majorScale[0] + ", " + flatNote(note: majorScale[2]) + ", " + majorScale[4] + ", " + majorScale[5]
        
        major9 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + majorScale[6] + ", " + majorScale[8]
        minor9 = majorScale[0] + ", " + flatNote(note: majorScale[2]) + ", " + majorScale[4] + ", " + flatNote(note: majorScale[6]) + ", " + majorScale[8]
        dominant9 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + flatNote(note: majorScale[6]) + ", " + majorScale[8]
        major11 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + majorScale[6] + ", " + majorScale[8] + ", " + majorScale[10]
        minor11 = majorScale[0] + ", " + flatNote(note: majorScale[2]) + ", " + majorScale[4] + ", " + flatNote(note: majorScale[6]) + ", " + majorScale[8] + ", " + majorScale[10]
        dominant11 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + flatNote(note: majorScale[6]) + ", " + majorScale[8] + ", " + majorScale[10]
        major13 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + majorScale[6] + ", " + majorScale[8] + ", " + majorScale[10] + ", " + majorScale[12]
        minor13 = majorScale[0] + ", " + flatNote(note: majorScale[2]) + ", " + majorScale[4] + ", " + flatNote(note: majorScale[6]) + ", " + majorScale[8] + ", " + majorScale[10] + ", " + majorScale[12]
        dominant13 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + flatNote(note: majorScale[6]) + ", " + majorScale[8] + ", " + majorScale[10] + ", " + majorScale[12]
        
        augmented = majorScale[0] + ", " + majorScale[2] + ", " + SharpNote(note: majorScale[4])
        diminished = majorScale[0] + ", " + flatNote(note: majorScale[2]) + ", " + flatNote(note: majorScale[4])
        b13HalfDiminished = majorScale[0] + ", " + flatNote(note: majorScale[2]) + ", " + flatNote(note: majorScale[4]) + ", " + flatNote(note: majorScale[6])
        sharp9 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + flatNote(note: majorScale[6]) + ", " + SharpNote(note: majorScale[8])
        b9 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + flatNote(note: majorScale[6]) + ", " + flatNote(note: majorScale[8])
        b13 = majorScale[0] + ", " + majorScale[2] + ", " + majorScale[4] + ", " + flatNote(note: majorScale[6]) + ", " + majorScale[8] + ", " + majorScale[10] + ", " + flatNote(note: majorScale[12])
        calculateScales(keyIndex: keyIndex)
        
    }
    
    func calculateScales(keyIndex: Int)  {
        ionian = notes[keyIndex] + ", " + notes[keyIndex + 2] + ", " + notes[keyIndex + 4] + ", " + notes[keyIndex + 5] + ", " + notes[keyIndex + 7] + ", " + notes[keyIndex + 9] + ", " + notes[keyIndex + 11] + ", " + notes[keyIndex + 12]
        dorian = notes[keyIndex] + ", " + notes[keyIndex + 2] + ", " + notes[keyIndex + 3] + ", " + notes[keyIndex + 5] + ", " + notes[keyIndex + 7] + ", " + notes[keyIndex + 9] + ", " + notes[keyIndex + 10] + ", " + notes[keyIndex + 12]
        phrygian = notes[keyIndex] + ", " + notes[keyIndex + 1] + ", " + notes[keyIndex + 3] + ", " + notes[keyIndex + 5] + ", " + notes[keyIndex + 7] + ", " + notes[keyIndex + 8] + ", " + notes[keyIndex + 10] + ", " + notes[keyIndex + 12]
        lydian = notes[keyIndex] + ", " + notes[keyIndex + 2] + ", " + notes[keyIndex + 4] + ", " + notes[keyIndex + 6] + ", " + notes[keyIndex + 7] + ", " + notes[keyIndex + 9] + ", " + notes[keyIndex + 11] + ", " + notes[keyIndex + 12]
        mixolydian = notes[keyIndex] + ", " + notes[keyIndex + 2] + ", " + notes[keyIndex + 4] + ", " + notes[keyIndex + 5] + ", " + notes[keyIndex + 7] + ", " + notes[keyIndex + 9] + ", " + notes[keyIndex + 10] + ", " + notes[keyIndex + 12]
        aeolian = notes[keyIndex] + ", " + notes[keyIndex + 2] + ", " + notes[keyIndex + 3] + ", " + notes[keyIndex + 5] + ", " + notes[keyIndex + 7] + ", " + notes[keyIndex + 8] + ", " + notes[keyIndex + 10] + ", " + notes[keyIndex + 12]
        locrian = notes[keyIndex] + ", " + notes[keyIndex + 1] + ", " + notes[keyIndex + 3] + ", " + notes[keyIndex + 5] + ", " + notes[keyIndex + 6] + ", " + notes[keyIndex + 8] + ", " + notes[keyIndex + 10] + ", " + notes[keyIndex + 12]
    }
    
    func flatNote(note: String) -> String {
        var output: String = ""
        if note == "C" {
            output = "B"
        } else {
            for i in 0...11 {
                if note == notes[i] {
                    output = notes[i - 1]
                }
            }
        }
        return output
    }
    
    func SharpNote(note: String) -> String {
        var output: String = ""
        for i in 0...11 {
            if note == notes[i] {
                output = notes[i + 1]
            }
        }
        return output
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AppLogo: View {
    var body: some View {
        VStack(alignment: .center){
            Rectangle()
                .fill(Color.white)
                .frame(height: 4)
            Text("Chords & Scales Calculator")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .medium, design: .default))
                .multilineTextAlignment(.center)
            Rectangle()
                .fill(Color.white)
                .frame(height: 4)
        }
    }
}

struct MajorScaleView: View {
    var majorScale = ["1", "2", "3", "1", "2", "3", "1", "2", "3"]
    var body: some View {
        VStack {
            Text("Major Scale: \(majorScale[0]), \(majorScale[1]), \(majorScale[2]), \(majorScale[3]), \(majorScale[4]), \(majorScale[5]), \(majorScale[6])")
                .foregroundColor(.white)
                .font(.system(size: 25))
                .padding()
            Rectangle()
                .fill(Color.white)
                .frame(height: 4)
        }
    }
}

struct Group1Chords: View {
    var powerChord, majorChord, minorChord, sus2Chord, sus4Chord : String
    
    var body: some View {
        List {
            //VStack(alignment: .leading) {
                Text("GROUP 1")
                    .bold()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 20))
                Text("Power (1 - 5): " + powerChord)
                Text("Major (1 - 3 - 5): " + majorChord)
                Text("Minor (1 - 3b - 5): " + minorChord)
                Text("SUS2 (1 - 2 - 5): " + sus2Chord)
                Text("SUS4 (1 - 4 - 5): " + sus4Chord)
            //}
        }
    }
}

struct Group2Chords: View {
    var major7, minor7, dominant7, add9, minorAdd9, add11, minorAdd11, sixChord, minorSixChord: String
    var body: some View {
        List {
            Text("GROUP 2")
                .bold()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .font(.system(size: 20))
            Text("Major 7 (1 - 3 - 5 - 7): " + major7)
            Text("Minor 7 (1 - 3b - 5 - 7b): " + minor7)
            Text("Dominant 7 (1 - 3 - 5 - 7b): " + dominant7)
            Text("Add9 (1 - 3 - 5 - 9): " + add9)
            Text("Minor Add9 (1 - 3b - 5 - 9): " + minorAdd9)
            Text("Add11 (1 - 3 - 5 - 11): " + add11)
            Text("Minor Add11 (1 - 3b - 5 - 11): " + minorAdd11)
            Text("6 (1 - 3 - 5 - 6): " + sixChord)
            Text("Minor 6 (1 - 3b - 5 - 6): " + minorSixChord)
        }
    }
}

struct Group3Chords: View {
    var major9, minor9, dominant9, major11, minor11, dominant11, major13, minor13, dominant13: String
    var body: some View {
        List {
            Text("GROUP 3")
                .bold()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .font(.system(size: 20))
            Text("Major 9 (1 - 3 - 5 - 7 - 9): " + major9)
            Text("Minor 9 (1 - 3b - 5 - 7b - 9): " + minor9)
            Text("Dominant 9 (1 - 3 - 5 - 7b - 9): " + dominant9)
            Text("Major 11 (1 - 3 - 5 - 7 - 9 - 11): " + major11)
            Text("Minor 11 (1 - 3b - 5 - 7b - 9 - 11): " + minor11)
            Text("Dominant 11 (1 - 3 - 5 - 7b - 9 - 11): " + dominant11)
            Text("Major 13 (1 - 3 - 5 - 7 - 9 - 11 - 13): " + major13)
            Text("Minor 13 (1 - 3b - 5 - 7b - 9 - 11 - 13): " + minor13)
            Text("Dominant 13 (1 - 3 - 5 - 7b - 9 - 11 - 13): " + dominant13)
        }
    }
}

struct Group4Chords: View {
    var augmented, diminished, b13HalfDiminished, sharp9, b9, b13: String
    var body: some View {
        List {
            Text("GROUP 4")
                .bold()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .font(.system(size: 20))
            Text("Augmented (1 - 3 - 5#): " + augmented)
            Text("Diminished (1 - 3b - 5b): " + diminished)
            Text("b13 half diminished (1 - 3b - 5b - 7b): " + b13HalfDiminished)
            Text("#9 (Hendrix chord) (1 - 3 - 5 - 7b - 9#): " + sharp9)
            Text("b9 (1 - 3 - 5 - 7b - 9b): " + b9)
            Text("b13 (1 - 3 - 5 - 7b - 9 - 11 - 13b): " + b13)
        }
    }
}

struct ScalesView: View {
    var ionian, dorian, phrygian, lydian, mixolydian, aeolian, locrian: String
    var body: some View {
        List {
            Text("GROUP 4")
                .bold()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .font(.system(size: 20))
            Text("Ionian: " + ionian)
            Text("Dorian: " + dorian)
            Text("Phrygian: " + phrygian)
            Text("Lydian: " + lydian)
            Text("Mixolydian: " + mixolydian)
            Text("Aeolian: " + aeolian)
            Text("Locrian: " + locrian)
        }
    }
}
