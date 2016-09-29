# This script opens all sound files in the specified text file and associated TextGrids, 
# pauses for the user to check and possibly alter the TextGrid, 
# then saves the new TextGrid in the same directory if applicable.

# Jevon Heath, 5/6/15
# modified for Windows by Andrew Cheng 9/2016

# Put praat script in same folder as all .wav files and associated TextGrids.
# In cmd: ls ./*.wav > files.txt
# This creates a .txt file that is a list of all .wav files in the folder

form Check Textgrids for .wav files listed in this file
	comment Name of directory:
	text directory ./
	comment Name of text file:
	text textfile files.txt
endform

Read Strings from raw text file... 'directory$'/'textfile$'
fileList$ = selected$ ("Strings")
n = Get number of strings

# Open each sound file and its associated TextGrid so the TextGrid can be manipulated. 
# Once the user clicks "Continue", the TextGrid is saved and the next soundfile is opened.

for i to n
	select Strings 'fileList$'
	soundfile$ = Get string... i
	Read from file... 'directory$'/'soundfile$'
	soundname$ = selected$ ("Sound")
	Read from file... 'directory$'/'soundname$'.TextGrid
	plus Sound 'soundname$'
	View & Edit
	beginPause("Any edits?")
	clicked = endPause("Continue", "Save and Continue", 1)
	select TextGrid 'soundname$'
	if clicked = 2
		Save as text file... 'directory$'/'soundname$'.TextGrid
	endif
	plus Sound 'soundname$'
	Remove
endfor