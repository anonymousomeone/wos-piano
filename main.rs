use std::{fs, io::Write};
use midly::Smf;

struct MidiEvent {
    delta: u16,
    on: Vec<u8>,
    off: Vec<u8>
}

impl MidiEvent {
    pub fn new() -> MidiEvent {
        MidiEvent { delta: 0, on: vec![], off: vec![] }
    }
}

fn main() {
    let bytes = fs::read("fnaf.mid").unwrap();
    let smf = Smf::parse(&bytes).unwrap();

    let mut fin = String::new();
    let mut midi = MidiEvent::new();

    println!("speed: {:?}", smf.header.timing);
    println!("format: {:?}", smf.header.format);

    let mut i = 0;

    for event in smf.tracks.get(0).unwrap() {
        
        // println!("{:?}", event);

        let msg = match event.kind {
            midly::TrackEventKind::Midi { channel, message } => message,
            _ => continue,
        };

        if event.delta != 0 {
            fin += &dump(midi);
            
            midi = MidiEvent::new();
            midi.delta = event.delta.as_int().try_into().unwrap();
        }

        match msg {
            midly::MidiMessage::NoteOff { key, vel } => {
                midi.off.push(key.as_int());
            },
            midly::MidiMessage::NoteOn { key, vel } => {
                midi.on.push(key.as_int());
            }
            _ => continue,
        };

    }

    fin += &dump(midi);

    // println!("{}", fin);

    let mut file = fs::File::create("r.txt").unwrap();
    file.write_all(fin.as_bytes()).unwrap();
}

fn dump(event: MidiEvent) -> String {
    let mut res = String::new();
    let on = event.on;
    let off = event.off;


    res += &("{d=".to_owned() + &event.delta.to_string() + ",o={");
    for i in 0..on.len() {
        let k = on.get(i).unwrap();
        
        res += &k.to_string();
        
        if i + 1 == on.len() {
            res += "";
        } else {
            res += ",";
        }
    }
    res += "},f={";

    for i in 0..off.len() {
        let k = off.get(i).unwrap();
        
        res += &k.to_string();
        
        if i + 1 == off.len() {
            res += "";
        } else {
            res += ",";
        }
    }

    res += "}},";

    return res;
}
