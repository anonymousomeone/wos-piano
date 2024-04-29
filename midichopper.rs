use std::fs;

use midly::Format;
use midly::Header;
use midly::MetaMessage;
use midly::Smf;
use midly::TrackEvent;
use midly::num::u28;
use midly::num::u7;
use midly::write;

#[derive(Debug)]
struct Track<'a> {
    delta: u28,
    events: Vec<TrackEvent<'a>>,
    noteOn: bool,
    key: Option<u7>,
}

impl Track<'_> {
    pub fn new() -> Track<'static> {
        Track {
            delta: 0.into(),
            events: Vec::new(),
            noteOn: false,
            key: None,
        }
    }
}

fn main() {
    let bytes = fs::read("calam (1).mid").unwrap();
    let smf = Smf::parse(&bytes).unwrap();

    let mut tracks: Vec<Track> = Vec::new();

    tracks.push(Track::new());
    
    let mut delta_sum = 0;
    // let mut num = 0;

    for event in smf.tracks.get(0).unwrap() {
        // println!("{} / {}", num, smf.tracks.get(0).unwrap().len());

        // num += 1;

        let mut event = event.clone();
        delta_sum += midly::num::u28::as_int(event.delta);

        let msg = match event.kind {
            midly::TrackEventKind::Midi { channel: _, message } => message,

            _ => {
                tracks[0].events.push(event.to_owned());
                continue
            },
        };

        match msg {
            midly::MidiMessage::NoteOff { key, vel: _ } => {
                // println!("off: {}", key);
                match find_track(&tracks, key) {
                    Some(idx) => {
                        for i in 0..tracks.len() {
                            if i == idx { continue; }
        
                            tracks[i].delta += event.delta;
                        }
                        
                        let track = &mut tracks[idx];
        
                        event.delta += track.delta;
                        track.delta = 0.into();
        
                        let ev = midly::TrackEventKind::Midi { 
                            channel: midly::num::u4::from_int_lossy(idx as u8), 
                            message: msg,
                        };

                        event.kind = ev;

                        track.events.push(event);
                        track.noteOn = false;
                        track.key = None;
                    }

                    None => {
                        println!("err!! raaj: {}", key);
                    }
                }
            },
            midly::MidiMessage::NoteOn { key, vel: _ } => {
                // println!("on: {}", key);

                match find_unoccupied_track(&tracks) {
                    Some(idx) => {
                        for i in 0..tracks.len() {
                            if i == idx { continue; }

                            tracks[i].delta += event.delta;
                        }


                        let track = &mut tracks[idx];

                        event.delta += track.delta;
                        track.delta = 0.into();

                        let ev = midly::TrackEventKind::Midi { 
                            channel: midly::num::u4::from_int_lossy(idx as u8), 
                            message: msg,
                        };

                        event.kind = ev;

                        track.events.push(event);
                        track.noteOn = true;
                        track.key = Some(key);
                    }
                    None => {
                        for i in 0..tracks.len() {
                            tracks[i].delta += event.delta;
                        }
                        
                        let mut track = Track::new();
        
                        event.delta = delta_sum.into();

                        let ev = midly::TrackEventKind::Midi { 
                            channel: midly::num::u4::from_int_lossy(tracks.len() as u8), 
                            message: msg,
                        };

                        event.kind = ev;
        
                        track.events.push(event);
                        track.noteOn = true;
                        track.key = Some(key);
        
                        tracks.push(track);
                    }
                }
            }
            _ => {},
        };

    }

    println!("{}", tracks.len());

    let mut result = Vec::new();

    for i in 1..tracks.len() {
        let event = TrackEvent {
            delta: 0.into(),
            kind: midly::TrackEventKind::Meta(MetaMessage::MidiChannel(midly::num::u4::from_int_lossy(i as u8))),
        };

        tracks[i].events.insert(0, event);

        let event = TrackEvent {
            delta: 0.into(),
            kind: midly::TrackEventKind::Meta(MetaMessage::EndOfTrack),
        };

        tracks[i].events.push(event);
    }

    let header = Header {
        format: Format::Parallel,
        timing: smf.header.timing,
    };

    let mut t: Vec<Vec<TrackEvent>> = Vec::new();

    for track in tracks {
        t.push(track.events);
    }

    let _ = write(&header, &t, &mut result);

    let _ = fs::write("./out.midi", result);
}
fn find_unoccupied_track(tracks: &Vec<Track>) -> Option<usize> {
    // return Some(0);

    for i in 0..tracks.len() {
        let track = &tracks[i];

        if !track.key.is_some() {
            return Some(i);
        }
    }

    // println!("aaa");
    return None;
}

fn find_track(tracks: &Vec<Track>, key: u7) -> Option<usize> {
    // return 0;

    for i in 0..tracks.len() {
        let track = &tracks[i];
        
        match track.key {
            Some(k) => {
                // println!("{} == {}: {}", k, key, k == key);

                if k == key { 
                    return Some(i);
                }
            }

            None => continue,
        }

    }

    return None;
}
