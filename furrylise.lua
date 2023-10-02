-- this rah rah :3 :3


local A2 = {};
local A3 = {};
local A4 = {}; -- octave increment starts at A instead of C
local A5 = {};
local A6 = {};

-- format: [note][sharp?][octave]
local MIDI_TABLE = { -- ⚠⚠⚠ index offset!!! (index 1 = midi 0)
	"C-1",
	"C#-1",
	"D-1",
	"D#-1",
	"E-1",
	"F-1",
	"F#-1",
	"G-1",
	"G#-1",
	
	"A0",
	"A#0",
	"B0",
	"C0",
	"C#0",
	"D0",
	"D#0",
	"E0",
	"F0",
	"F#0",
	"G0",
	"G#0",
	
	"A1",
	"A#1",
	"B1",
	"C1",
	"C#1",
	"D1",
	"D#1",
	"E1",
	"F1",
	"F#1",
	"G1",
	"G#1",
	
	"A2",
	"A#2",
	"B2",
	"C2",
	"C#2",
	"D2",
	"D#2",
	"E2",
	"F2",
	"F#2",
	"G2",
	"G#2",
	
	"A3",
	"A#3",
	"B3",
	"C3",
	"C#3",
	"D3",
	"D#3",
	"E3",
	"F3",
	"F#3",
	"G3",
	"G#3",
	
	"A4",
	"A#4",
	"B4",
	"C4",
	"C#4",
	"D4",
	"D#4",
	"E4",
	"F4",
	"F#4",
	"G4",
	"G#4",
	
	"A5",
	"A#5",
	"B5",
	"C5",
	"C#5",
	"D5",
	"D#5",
	"E5",
	"F5",
	"F#5",
	"G5",
	"G#5",

	"A6",
	"A#6",
	"B6",
	"C6",
	"C#6",
	"D6",
	"D#6",
	"E6",
	"F6",
	"F#6",
	"G6",
	"G#6",
	
	"A7",
	"A#7",
	"B7",
	"C7",
	"C#7",
	"D7",
	"D#7",
	"E7",
	"F7",
	"F#7",
	"G7",
	"G#7",
	
	"A8",
	"A#8",
	"B8",
	"C8",
	"C#8",
	"D8",
	"D#8",
	"E8",
	"F8",
	"F#8",
	"G8",
	"G#8",

	"A9",
	"A#9",
	"B9",	
	"C9",
	"C#9",
	"D9",
	"D#9",
	"E9",
	"F9",
	"F#9",
	"G9",
	"G#9",
	
	"A10",
	"A#10",
	"B10",
};

local PORT_TABLE = {
	["A"] = "Titanium",
	["A#"] = "Aerogel",
	["B"] = "Gold",
	["C"] = "Glass",
	["C#"] = "Sand",
	["D"] = "Door",
	["D#"] = "Snow",
	["E"] = "Copper",
	["F"] = "Quartz",
	["F#"] = "Stone",
	["G"] = "Ruby",
	["G#"] = "Asphalt",
}

function getMidi(note_number)
	return MIDI_TABLE[note_number + 1];
end

function getNote(note_str)
	local note = note_str:gmatch("%u#?");
	local octave = note_str:gmatch("%-?%d+");
	
	for n in note do note = n end
	for o in octave do octave = tonumber(o) end
	
	-- todo: fix yandere dev...
	if octave == 2 then
		return A2[note];
	elseif octave == 3 then
		return A3[note];
	elseif octave == 4 then
		return A4[note]
	elseif octave == 5 then
		return A5[note]
	elseif octave == 6 then
		return A6[note]
	end
end

for note, part in PORT_TABLE do
	A2[note] = GetPartFromPort(GetPartFromPort(2, part), "Speaker");
	A3[note] = GetPartFromPort(GetPartFromPort(3, part), "Speaker");
	A4[note] = GetPartFromPort(GetPartFromPort(4, part), "Speaker");
	A5[note] = GetPartFromPort(GetPartFromPort(5, part), "Speaker");
	A6[note] = GetPartFromPort(GetPartFromPort(6, part), "Speaker");
end

local music = {"E", "D", "C", "D", "E", "E", "E",
	"D", "D", "D", "E", "E", "E",
	"E", "D", "C", "D", "E", "E", "E",
	"E", "D", "D", "E", "D", "C"
}

local ms_per_quarter_note = 960;

local furryelise = {
	{d=0,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={56}},{d=240,data={}},{d=0,data={64}},{d=240,data={68}},{d=240,data={71}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={64}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={56}},{d=240,data={}},{d=0,data={64}},{d=240,data={72}},{d=240,data={71}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={56}},{d=240,data={}},{d=0,data={64}},{d=240,data={68}},{d=240,data={71}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={64}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={72}},{d=240,data={71}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={71}},{d=240,data={72}},{d=240,data={74}},{d=240,data={76,48}},{d=240,data={55}},{d=240,data={60}},{d=240,data={}},{d=0,data={67}},{d=240,data={77}},{d=240,data={76}},{d=240,data={74,43}},{d=240,data={55}},{d=240,data={59}},{d=240,data={}},{d=0,data={65}},{d=240,data={76}},{d=240,data={74}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={64}},{d=240,data={74}},{d=240,data={72}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={64}},{d=240,data={64}},{d=240,data={76}},{d=240,data={64}},{d=240,data={76}},{d=240,data={76}},{d=240,data={88}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={68}},{d=240,data={71}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={64}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={72}},{d=240,data={71}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={71}},{d=240,data={72}},{d=240,data={74}},{d=240,data={76,48}},{d=240,data={55}},{d=240,data={60}},{d=240,data={}},{d=0,data={67}},{d=240,data={77}},{d=240,data={76}},{d=240,data={74,43}},{d=240,data={55}},{d=240,data={59}},{d=240,data={}},{d=0,data={65}},{d=240,data={76}},{d=240,data={74}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={64}},{d=240,data={74}},{d=240,data={72}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={64}},{d=240,data={64}},{d=240,data={76}},{d=240,data={64}},{d=240,data={76}},{d=240,data={76}},{d=240,data={88}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={68}},{d=240,data={71}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={64}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={72}},{d=240,data={71}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={58,60,64,72}},{d=120,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={60,57,65,72}},{d=120,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={58,60,55,64,72,67}},{d=120,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={72,53}},{d=240,data={57}},{d=240,data={60}},{d=240,data={57}},{d=240,data={}},{d=0,data={60,77}},{d=240,data={57}},{d=120,data={76}},{d=120,data={}},{d=0,data={76,53}},{d=240,data={58}},{d=240,data={}},{d=0,data={74,62}},{d=240,data={58}},{d=240,data={}},{d=0,data={62,82}},{d=240,data={58}},{d=120,data={81}},{d=120,data={}},{d=0,data={81,53}},{d=240,data={}},{d=0,data={79,64}},{d=240,data={}},{d=0,data={77,58,55,53}},{d=240,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={76,64}},{d=240,data={}},{d=0,data={74,58,55,53}},{d=240,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={72,64}},{d=240,data={}},{d=0,data={70,53}},{d=240,data={57}},{d=240,data={}},{d=0,data={69,60}},{d=240,data={57}},{d=240,data={}},{d=0,data={69,60}},{d=120,data={67}},{d=120,data={}},{d=0,data={69,57}},{d=120,data={70}},{d=120,data={}},{d=0,data={72,53}},{d=240,data={57}},{d=240,data={60}},{d=240,data={57}},{d=240,data={}},{d=0,data={74,60}},{d=240,data={}},{d=0,data={75,57}},{d=240,data={}},{d=0,data={76,52}},{d=240,data={57}},{d=240,data={60}},{d=240,data={}},{d=0,data={76,57}},{d=240,data={}},{d=0,data={77,62,50}},{d=240,data={}},{d=0,data={}},{d=0,data={69,53}},{d=240,data={}},{d=0,data={72,55}},{d=240,data={64}},{d=240,data={55}},{d=240,data={64}},{d=240,data={}},{d=0,data={74,55}},{d=240,data={65}},{d=120,data={71}},{d=120,data={}},{d=0,data={72,60,64}},{d=120,data={79}},{d=120,data={67}},{d=120,data={79}},{d=120,data={}},{d=0,data={}},{d=0,data={69}},{d=120,data={79}},{d=120,data={71,67,65}},{d=120,data={}},{d=0,data={}},{d=0,data={79}},{d=120,data={72,67,64}},{d=120,data={}},{d=0,data={}},{d=0,data={79}},{d=120,data={74,67,65,62}},{d=120,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={79}},{d=120,data={76,60,64,67}},{d=120,data={79}},{d=120,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={84}},{d=120,data={83}},{d=120,data={81,53,57}},{d=120,data={79}},{d=120,data={}},{d=0,data={}},{d=0,data={77}},{d=120,data={74}},{d=120,data={72,55,59}},{d=120,data={79}},{d=120,data={}},{d=0,data={}},{d=0,data={77}},{d=120,data={74}},{d=120,data={72,60}},{d=120,data={79}},{d=120,data={}},{d=0,data={67}},{d=120,data={79}},{d=120,data={69}},{d=120,data={79}},{d=120,data={71,67,65}},{d=120,data={}},{d=0,data={}},{d=0,data={79}},{d=120,data={72,67,64}},{d=120,data={}},{d=0,data={}},{d=0,data={79}},{d=120,data={74,67,65,62}},{d=120,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={79}},{d=120,data={76,60,64,67}},{d=120,data={79}},{d=120,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={84}},{d=120,data={83}},{d=120,data={81,53,57}},{d=120,data={79}},{d=120,data={}},{d=0,data={}},{d=0,data={77}},{d=120,data={76}},{d=120,data={74,55,59}},{d=120,data={79}},{d=120,data={}},{d=0,data={}},{d=0,data={77}},{d=120,data={74}},{d=120,data={76,56,59}},{d=120,data={77}},{d=120,data={}},{d=0,data={}},{d=0,data={76}},{d=120,data={75}},{d=120,data={76}},{d=120,data={71}},{d=120,data={76}},{d=120,data={75}},{d=120,data={76}},{d=120,data={71}},{d=120,data={76}},{d=120,data={75}},{d=120,data={76}},{d=720,data={71}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=720,data={71}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={56}},{d=240,data={}},{d=0,data={64}},{d=240,data={68}},{d=240,data={71}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={64}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={56}},{d=240,data={}},{d=0,data={64}},{d=240,data={72}},{d=240,data={71}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={56}},{d=240,data={}},{d=0,data={64}},{d=240,data={68}},{d=240,data={71}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={64}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={72}},{d=240,data={71}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={71}},{d=240,data={72}},{d=240,data={74}},{d=240,data={76,48}},{d=240,data={55}},{d=240,data={60}},{d=240,data={}},{d=0,data={67}},{d=240,data={77}},{d=240,data={76}},{d=240,data={74,43}},{d=240,data={55}},{d=240,data={59}},{d=240,data={}},{d=0,data={65}},{d=240,data={76}},{d=240,data={74}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={64}},{d=240,data={74}},{d=240,data={72}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={64}},{d=240,data={64}},{d=240,data={76}},{d=240,data={64}},{d=240,data={76}},{d=240,data={76}},{d=240,data={88}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={68}},{d=240,data={71}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={64}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={72}},{d=240,data={71}},{d=240,data={45,69}},{d=120,data={45}},{d=120,data={}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45,64,67,70,73}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={}},{d=120,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={45,74,65,69}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={}},{d=120,data={}},{d=0,data={}},{d=0,data={45,73,76}},{d=120,data={}},{d=120,data={}},{d=0,data={45,74,77}},{d=120,data={}},{d=120,data={}},{d=0,data={45,77,74,68}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={}},{d=120,data={}},{d=0,data={}},{d=0,data={45,77,74,68}},{d=120,data={45}},{d=120,data={}},{d=120,data={}},{d=0,data={}},{d=0,data={45,69,72,76}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={}},{d=120,data={}},{d=0,data={}},{d=0,data={45,38,74,65}},{d=120,data={}},{d=0,data={45,38}},{d=120,data={}},{d=0,data={45,38}},{d=120,data={}},{d=0,data={45,38}},{d=120,data={}},{d=0,data={}},{d=120,data={}},{d=0,data={45,38,72,64}},{d=120,data={}},{d=0,data={}},{d=120,data={}},{d=0,data={45,38,71,62}},{d=120,data={}},{d=0,data={}},{d=120,data={}},{d=0,data={39,45,60,66,69}},{d=120,data={}},{d=0,data={45,39}},{d=60,data={}},{d=60,data={45,39}},{d=60,data={}},{d=60,data={45,39}},{d=15,data={}},{d=105,data={}},{d=120,data={}},{d=0,data={}},{d=0,data={45,60,69,39}},{d=60,data={}},{d=60,data={45,39}},{d=60,data={}},{d=60,data={}},{d=120,data={}},{d=0,data={45,40,69,60}},{d=120,data={}},{d=0,data={45,40}},{d=120,data={}},{d=0,data={}},{d=120,data={}},{d=0,data={45,40,72,64}},{d=120,data={}},{d=0,data={45,40}},{d=120,data={}},{d=0,data={}},{d=120,data={}},{d=0,data={44,40,71,62}},{d=120,data={}},{d=0,data={44,40}},{d=120,data={}},{d=0,data={}},{d=120,data={}},{d=0,data={45,33,69,60}},{d=120,data={}},{d=0,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={}},{d=120,data={}},{d=0,data={45,64,67,70,73}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={}},{d=120,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={45,74,69,65}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={}},{d=120,data={}},{d=0,data={}},{d=0,data={45,73,76}},{d=120,data={}},{d=120,data={}},{d=0,data={45,74,77}},{d=120,data={}},{d=120,data={}},{d=0,data={45,74,77}},{d=120,data={45}},{d=120,data={45}},{d=120,data={45}},{d=120,data={}},{d=120,data={}},{d=0,data={45,74,77}},{d=120,data={45}},{d=120,data={}},{d=120,data={}},{d=0,data={46,77,74}},{d=120,data={46}},{d=120,data={46}},{d=120,data={46}},{d=120,data={46}},{d=120,data={46}},{d=120,data={}},{d=120,data={}},{d=0,data={46,75,67}},{d=120,data={46}},{d=120,data={46}},{d=120,data={46}},{d=120,data={}},{d=120,data={}},{d=0,data={46,74,65}},{d=120,data={}},{d=120,data={}},{d=0,data={46,72,63}},{d=120,data={}},{d=120,data={}},{d=0,data={46,70,65,62}},{d=120,data={46}},{d=120,data={46}},{d=120,data={46}},{d=120,data={}},{d=120,data={}},{d=0,data={}},{d=0,data={46,62,65,69}},{d=120,data={46}},{d=120,data={}},{d=120,data={}},{d=0,data={}},{d=0,data={47,62,65,68}},{d=240,data={47}},{d=240,data={47}},{d=240,data={47}},{d=240,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={47,62,65,68}},{d=240,data={47}},{d=240,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={60,64,69,48}},{d=960,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={71,64,65,52,56}},{d=240,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={60}},{d=160,data={60}},{d=160,data={64}},{d=160,data={69}},{d=160,data={72}},{d=160,data={76}},{d=160,data={74,57,60,64}},{d=160,data={72}},{d=160,data={71}},{d=160,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={69,64,60,57}},{d=160,data={72}},{d=160,data={76}},{d=160,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={81}},{d=160,data={84}},{d=160,data={88}},{d=160,data={86,64,60,57}},{d=160,data={84}},{d=160,data={83}},{d=160,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={81,64,60,57}},{d=160,data={84}},{d=160,data={88}},{d=160,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={93}},{d=160,data={96}},{d=160,data={100}},{d=160,data={98,57,60,64}},{d=160,data={96}},{d=160,data={95}},{d=160,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={94,64,60,57}},{d=160,data={93}},{d=160,data={92}},{d=160,data={}},{d=0,data={}},{d=0,data={}},{d=0,data={91}},{d=160,data={90}},{d=160,data={89}},{d=160,data={88}},{d=160,data={87}},{d=160,data={86}},{d=160,data={85}},{d=160,data={84}},{d=160,data={83}},{d=160,data={82}},{d=160,data={81}},{d=160,data={80}},{d=160,data={79}},{d=160,data={78}},{d=160,data={77}},{d=160,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={68}},{d=240,data={71}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={64}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={72}},{d=240,data={71}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={71}},{d=240,data={72}},{d=240,data={74}},{d=240,data={76,48}},{d=240,data={55}},{d=240,data={60}},{d=240,data={}},{d=0,data={67}},{d=240,data={77}},{d=240,data={76}},{d=240,data={74,43}},{d=240,data={55}},{d=240,data={59}},{d=240,data={}},{d=0,data={65}},{d=240,data={76}},{d=240,data={74}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={57}},{d=240,data={}},{d=0,data={64}},{d=240,data={74}},{d=240,data={72}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={64}},{d=240,data={64}},{d=240,data={76}},{d=240,data={64}},{d=240,data={76}},{d=240,data={76}},{d=240,data={88}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={68}},{d=240,data={71}},{d=240,data={72,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={64}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={75}},{d=240,data={76}},{d=240,data={71}},{d=240,data={74}},{d=240,data={72}},{d=240,data={69,45}},{d=240,data={52}},{d=240,data={}},{d=0,data={57}},{d=240,data={60}},{d=240,data={64}},{d=240,data={69}},{d=240,data={71,40}},{d=240,data={52}},{d=240,data={}},{d=0,data={56}},{d=240,data={64}},{d=240,data={72}},{d=240,data={71}},{d=27,data={60,69,45,33}},{d=1440,data={}},{d=0,data={}},{d=0,data={}},
}
for i, event in furryelise do
	local seconds;
	
	if event.d == 0 then
		seconds = 0;
	else
		local thingy = 960 / event.d;
		seconds = 1 / thingy;
	end
	
	task.wait(seconds);
	
	if next(event.data) == nil then 
		continue 
	end
	
	for i, v in event.data do
		local midi_note = getMidi(v);
		local note = getNote(midi_note);
		
		note:Trigger();
	end
	
end
