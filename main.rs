use midly::num::u28;
use midly::Format;
use midly::Header;
use midly::Smf;
use midly::TrackEvent;

use std::fs;
use std::iter::Peekable;

#[derive(Debug)]
struct Track<'a> {
    delta: u28,
    index: usize,
    events: Vec<TrackEvent<'a>>,
}

fn main() {
    let bytes = fs::read("sonydivers.mid").unwrap();
    let mut smf = Smf::parse(&bytes).unwrap();

    let events: Vec<TrackEvent> = parse(smf.tracks);

    let header = Header {
        format: Format::Parallel,
        timing: smf.header.timing,
    };

    let mut t: Vec<Vec<TrackEvent>> = Vec::new();
    let mut result = Vec::new();

    t.push(events);

    let _ = midly::write(&header, &t, &mut result);

    let _ = fs::write("./out.midi", result);

}

fn parse(tracks_raw: Vec<Vec<TrackEvent>>) -> Vec<TrackEvent> {
    let mut result: Vec<TrackEvent> = Vec::new();

    let mut tracks: Vec<Track> = Vec::new();

    for track in tracks_raw {
        let mut events = Vec::new();
        for event in track {
            events.push(event);
        }

        let track = Track {
            delta: 0.into(),
            index: 0,
            events
        };

        tracks.push(track);
    }

    let parsing = true;
    
    while parsing {


    }

    result
}

/**
 * returns index
 */
fn get_next_event(tracks: &Vec<Track>) -> usize {
    
}