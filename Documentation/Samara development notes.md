# SAMARA: Saccade Analysis, Measurement and Research Application


Samara is software designed to analyse data exported from the iView .IDF
eye movement recordings to a text file, with an associated file
specifying stimulus events occurring during the recording.


#### Samara 001.rbp Thu 15 Sep 2005
- Development begun under RB 2005 Release 3.
- Began creating major required classes (eg dataPoint, stimulus, data,
set, session, dataParser, App, chartWindow, chart).
- Implemented code to read in SMP data lines from txt file, and store
in session and set objects.  Currently ignores MSG lines.
- Began creating chartWindow and its communication with the session
object.


#### Samara 002.rbp Fri 16 Sep 2005
- Can now plot any set of a given session (raw data only) 


#### Samara 003.rbp Fri 16 Sep 2005
- made the dataPoint class a subclass of the dictionary class.  This
allows its components (eg x,y, t, etc) to be accessed via a text key
rather than by fixed dot notation references.  This will allow the same
code to be used for plotting different components, determined by a
string key which specifies the components to be accessed. 
- removed invalid data samples from being displayed and introducing
spurious spikes into the data display.
- implemented zooming of the data.


#### Samara 004.rbp Mon 19 Sep 2005**

- Can now parse and display stimulus info from Saskia's first expt.


#### Samara 005.rbp Wed 21 Sep 2005**

- Adding ability to scroll graph forward and backward in time (can
already zoom in and out).


#### Samara 006.rbp Wed 21 Sep 2005**

- Began labeling of axis.
- enabled display of two graphs (currently horiz and vert eye posn).
- began implementation of drawing and movement of measurement cursors


#### Samara 007.rbp Fri 23 Sep 2005**

- finalised implementation of movement of measurement cursors by single
samples and 10% jumps


#### Samara 008.rbp Fri 23 Sep 2005**

- Added calculation and display of velocities.  
- Changed the 'polarity' of plotted points as previously graphs were
being plotted from a top-left origin.


#### Samara 009.rbp Mon 26 Sep 2005**

- added an optimisation to the chart plotting whereby a vector object
is created for a data point only if the object has an extent greater
than one pixel.  This reduces the amount of samples being drawn over the
top of each other to no visible effect, but slowing down the display
markedly.  As an example, 86s of data plotted with 3 graphs (h & v eye
posn, h velocity) required 57553 object2Ds without the optimisation but
only 14198 with it.   When the data was zoomed to be only 0.7 s, both
methods produced exactly the same count of 489, to be expected, as the
change in each sample is able to be plotted visibly over the range of
pixels.
- added ability to select all or individual cursors, and then move them
as a group or independently depending upon the selection state.
- allowed cursors to bump and drag each other to ensure that they
always maintain their relative temporal order.
- changed dataParser to return a session rather than a boolean
- created measurementWindow class to display results of an individual
saccade measurement


#### Samara 010.rbp Mon 26 Sep 2005**

- implemented conversion of read data from pixels to degrees.
- began calculating and displaying measured statistics from a saccade


#### Samara 011.rbp Tue 27 Sep 2005**

- Replaced the vector drawing of the eye data and stimuli with bitmap
drawing, which greatly increased the speed of non-recalculated
redrawing, such as when moving cursors. NB the cursors remain as
vectors, and are set as the object property of the bitmap picture.  This
means they can be moved easily without having to redraw the underlying
data.
- Implemented semi-auto detection of saccades- requires a higher
threshold than EMMA (150 vs 30 deg/s) to avoid being tripped by the
higher noise level in the iView data.


#### Samara 012.rbp Wed 28 Sep 2005**

- revisited parsing and display of stimuli to properly deal with
overlap stimuli.
- gap 'stimuli' are no longer created as stimuli in their own right,
but rather a gap/overlap value is added to each true stimulus.
- adding 'clone' method to stimulus class to make the dataParser run
correctly with the more sophisticated stimulus parsing.
- added ability to detect the closest stimulus to a saccade onset when
measuring the saccade.
- added amplitude to the stimulus, in addition to its position.


#### Samara 013.rbp Wed 28 Sep 2005**

- added some stimulus statistics to saccade measurements.
- numerous other small changes


#### Samara 014.rbp Mon 03 Oct 2005**

- added 5th cursor, ability to 'compress' cursors, further measurement
features.


#### Samara 015.rbp Tue 04 Oct 2005**

- made horizontal arrow key behaviour closer to EMMA's (eg added alt
arrow facility) and allowed cursors to 'stick' in their time positions
when the data was moved, unless they fell out of bounds.

- reversed drawing of cursors so they were drawn in the right order
when overlaid.

- measurement window can now change some elements of the sent saccade
measurements (eg description of antisaccade errors, comment).  If the
measurement is accepted, it is sent back to the iViewSet instance for
storage.

- added "About" menuitem and help menu but not implemented


#### Samara 016.rbp Wed 05 Oct 2005**

- Re-factored to shift responsibility for importing from the App to the
chartWindow.  The app now opens with a blank default chart window, with
all controls disabled until data is imported.  Creation of new documents
is now separated from the import data command, which can be chosen only
if a window is already open and hasn't already had data imported.
- Importing is now done using a thread so that progress feedback can be
given in a statusWindow (modified from a class in the DIS generator
project).


#### Samara 017.rbp Wed 05 Oct 2005**

- given to Saskia (OS X) for initial testing.
- implemented exporting of saccade measurements to a text file.
- removed automated setting of y axis ranges as this lead to changes
when the graph was redrawn over different time samples.  Now just uses
fixed ranges.  Will need to allow user to adjust this in the future as
per EMMA.
- deleted original dataParser class as it has now been superseded by an
equivalent thread class.
- chartWindow now has a title from the imported file
- the wait cursor now displays when switching to a set that takes a
while to display.


#### Samara 018.rbp Wed 05 Oct 2005**

- began calculation of measures conditional upon saccade task type.

#### Samara 019.rbp Thu 06 Oct 2005**

- added various gain measures.
- correctly work out anti-saccade and pro-saccade stimulus positions
and amplitudes.
- added a staticText to display units (eg deg, ms) to the measurement
window.
- added a global log function to output method names as an aid in
debugging (still have random non-responsiveness problem).


#### Samara 019.rbp Thu 06 Oct 2005**

- added display of cursor coordinates to main window.
- added an about window, purloined from the DIS generator project.


#### Samara 020.rbp Thu 06 Oct 2005**

- many minor tweaks
- added ability to drag the picture in the chartCanvas to the desktop
as a picture clipping.  Unsure if this will work in Windows.

#### Samara 021.rbp Fri 07 Oct 2005**

- Overhauled the exception handling by adding a global method which is
passed both the exception and a string giving the location where it
occurred.  This will allow the display of the error type, which
previously was not gathered.  
- Found that the iView lab geometry had changed.  Stimuli labeled as at
9, 12, and 15 deg were actually at 8, 10.5, and 13 deg (as the monitor
had been moved from 430 mm to 500 mm from the subject, but stimulus
images had not been updated to compensate).  Hence changed values in
parser thread and in measure method.  Data now appears to match stimuli
better.
- added logging of messages to the system debug log, viewable with the
console app, via the iViewSet.storeMeasurement method.
- also logs individual saccade measurements to the debugLog so they can
be salvaged if the program becomes non-responsive before the data is
saved


#### Samara 022.rbp Wed 12 Oct 2005**

- added ability to apply and un-apply simple triangular filtering.
- upgraded triangular filter to be bi-directional, thus removing the
phase shift applied when only going forwards in the data.
- upgraded velocity calculation from single differences to central
difference differentiation.  Now much smoother velocity data. 
- added ability to skip Tower of London sets which could sometimes be
recorded within a saccade file.


#### Samara 023.rbp Thu 13 Oct 2005**

- added facility for manual re-calibration of the data, using the
'EMMA calibration updated.xls' speadsheet to calculate the values.


#### Samara 024.rbp Thu 13 Oct 2005**

- added up/down arrow scaling of y axes, including ctrl key for
velocity scaling.
- fixed non-responsiveness bug: due to an infinite loop in the
detectNextSaccade method when the last cursor happened to be positioned
exactly on a sample whose velocity value exceeded the threshold.  The
algorithm would then attempt to search backwards for a zero point, but
the lower bound of the search region was that sample itself.  Got around
this by making the lower bound the position of the second cursor, which
would usually give a bit of wiggle room to search through (plus the
second cursor is generally at a zero point).
- shifted from Mach-O to PEF executable as apparently produces better
debug information.  Also smaller, and possibly faster in this particular
app?  Need to test this.
- switched on 'includeFunctionNames' to aid future debugging of the
compiled app.  Having solved the most pressing bug,  turned off my own
logging to the console (can easily be reinstated by uncommenting in the
gLog method).  Also switched off the onscreen log which was not that
useful anyway.  Now means less crap put in the console log and so more
usable in terms of getting at logged saccade measurements if required.
- added the data filename to each measurement to serve as a label for
the session the data came from.
- changed the priority of the data parsing thread from the default (5)
to 10, which increased the speed of parsing the data file.
- moved initial filtering and velocity calculation of each set from the
import stage to the first time a set is displayed.  This makes the
initial importing stage much faster, but switching to a new set for the
first time is now slower.
- deleted several classes that had been created but never actually used
in the project (ie 'measure', 'parametersForSet')
- added a way of forcing (via modifier keys when 'return' was pushed) a
stimulus adjacent to the automatically selected one to be used in cases
where the stimulus selection algorithm did not correctly match a saccade
to its corresponding stimulus.
- display the stimulus number as one of the cursor stats.
- re-arranged classes into folders in the IDE.
- NB found a bug in the data parser thread in which stimulus amplitudes
were assigned incorrectly: if they had a fractional part, it was
truncated to an integer.  Watch this in future- when assigning a value
to a dictionary, which is a variant, and expression like '= -1 \*
position' will force the number to an integer.  '= -1.00 \* position'
seems to work.
- also corrected other errors where gain values were formatted to
positive numbers regardless of sign.


#### Samara 025.rbp Mon 17 Oct 2005.**  

- fixed major bug in the way stimuli were parsed and created which
meant that extra stimuli were created in the gap and overlap blocks,
with incorrect latencies and gap values returned in some situations. 
Simplified the stimulus parsing code considerably.
- added sixth cursor for full characterisation of anti-saccades.
- added '8' key which 'compresses' the higher cursors to the position
of cursor 3.


#### Samara 026.rbp Thu 20 Oct 2005 (became the official 1.0 version 21 Oct)
- added latencies for all cursors and explicit position for cursor 2.
- if possible, the next saccade is automatically detected when a
measurement has been accepted.
- the cursor can now move at an intermediate speed: holding down
'shift' plus the left or right arrow shifts the cursors by 5 samples
(standard speed = 1 sample; with control key = 1/15th of the time range
displayed).
- added window to display the set's list of saccade measurements.  Can
be viewed but not edited.
- became the official 1.0 version on 21 October.  Now issued for true
measurements.
- This version has been compiled under Linux and seems to work well
although it has not been thoroughly tested.


#### Samurai 001.rbp Dec 2005**

**Development was continued in this parallel stream to begin the
extension of Samara to import arm movement data from the HDF5 files
produced in the MoVElab.**

- Integrated calls to the HDF libraries that were first tested in the
simple app "HDF reader 001.rbp" into the Samara source code.  Compiles
and runs well under OS X and can open, extract, and display arm data. 
Does not run correctly under Linux due to a problem in calling functions
in the HDF Lite library.
- The library names are set as conditional global constants with values
for Mac OS X and Linux.
- Two global modules were created to contain HDF specific things which
may be useful in other projects.

	**HDF5\_declare\_wrappers:** this module contains global methods which
wrap the declares to the HDF libraries.  Not all of these calls are
actually used and so a number could actually be culled.  This is because
it was found to be most practical to use some of the HDF lite methods,
which made some of the calls to the main HDF library redundant (some
seemed impossible to achieve via REALbasic, hence the move to use some
of HDF Lite calls).

	**MM\_HDF5\_methods:**this module currently contains only two methods
which are there simply to wrap some declares while handling the creation
and parsing of memory blocks so the calling code is relieved of this. 
If no additional methods are created, these should probably just be
folded into the HDF5\_declare\_wrappers module.
- Implemented arm data access by creating a new data importing thread. 
When the user chooses to import MoVE data, this thread is selected
rather than the one used for importing iView data.  When the more
general iView data message system is implemented, we will need to
implement a third such thread in a similar way, leaving the first only
to open the files from Saskia's first experiment.
- That is, the object oriented nature of the program means that once
the data is imported, it can proceed regardless of where the data came
from as the data are represented internally by dataPoint and  stimulus
classes and so on that are quite abstract.
- However, the iViewSet class now has a property ("sourceOfData as
string") which allows it and other objects to know whether it was
sourced from the iView or MoVE systems.  This allows source-specific
things to be achieved.  For example, default axis limits which make
sense for eye data are not suitable for arm data.  Also measurements
will need to be made in different ways and with different units.
- The class structure based on iView concepts is retained (e.g.,
session, set, etc) but note that this will not always map neatly to the
way in which MoVE experiments are conducted.  Currently, what is
specified as a \<trial\>\</trial\> in the MoVE specification files maps
to an iViewSet.  This is appropriate where such a trial contains many
movements (such as predictive movements between two alternating
targets), but less so when a trial contains only one movement (as in the
adaptation tests where each trial consists of a movement to a single
target).


#### Samurai 002.rbp Fri 30 Dec 2005**

- worked on creating the necessary 3D data for arm movements plus the
1D pythagorean displacement data.  Realised that the latter is only
valid for movements centred on the origin.  e.g for predictive movements
between two points not collinear with the origin, this value is really
not very useful.  Will either need to ignore it, or somehow create a
'false' origin between the two targets and calculate all displacements
relative to that.  There is a 'type' attribute for the trial in the HDF
files- if we could access that then we could distinguish between
predictive and other tests.  To achieve rapid progress however, it may
simply be easier to let the user define which sort of test it is before
importing begins.
- allowed stimuli to be plotted in z and magnitude graphs.  Allowed all
graphs to be scaled on the y axis.
- clipped drawing in each graph panel so that y axis values were not
plotted outside the bounds of the graph's frame.
- made interface display data values of cursor positions with correct
units and numerical format depending on source of data.
- began implementing measurement of arm movement parameters.  The
'measure' method of the data class now splits off to two different
methods depending on whether the data is iView or MoVE.
- Allowed the user to select which sensor's data to import (not
currently specified in the H5 file).


#### Samurai 003.rbp Mon 09 Jan 2006 

- Implemented Butterworth filtering for the arm data.  This now
produces acceptably smooth acceleration data for real use.  2nd order 
Butterworth low-pass filter for a sampling freq of 240 Hz and a cut-off
freq of 10Hz., designed to be used bi-directionally, giving an effective
cutoff freq of 8 Hz.  See source code for coefficients.
- In the chart plotData method, set useOldRenderer to true.  This made
drawing much faster and only marginally uglier.
- reintroduced the optimisation from Samara.009 which was used to
reduce the number of vector elements drawn.  It is still useful when
drawing with bitmaps: a line is not drawn if its start and end points
are the same pixel.  Found on a typical arm file of approx. 30 s with a
six components plotted that this saved  approx. 26000 calls to drawLIne
when initially displaying the whole image.  The benefits of the
optimisation should decrease when the data is zoomed in, as each sample
is more likely to be separated by more than a pixel.


#### Samurai 004.rbp Thu 12 Jan 2006 

- kept in a separate folder with renamed versions of the libraries as
the aliases don't seem to work on the home iBook.
- tidied up arm movement measures.


#### Samurai 005.rbp Tue 24 Jan 2006 

- Maybe solved the problem with Samurai.04 above: seemed to be an
incorrect path specified in the constant to the HDF library file.

**Began developing in RB 2006 R1.**  Objected to 'UByte' in the
declare to H5FOpen- replaced with new UInt8 class name.

- Added H5Gget\_num\_objs declare to find the number of trials in an
HDF5 file.
- Consequently now able to import all trials in a file, not just
trial\_0001.  Each trial becomes an instance of the iViewSet class. 
Therefore this version can now at least open visually- and memory-guided
tests with multiple single movement trials.
- implemented a call to H5Fis\_hdf5 to check whether the file selected
for import is actually an HDF5 file and allow a graceful retort if accidentally trying to open something else. 


#### Samurai 006.rbp Mon 20 Feb 2006**

- added ability to stop the importing process for HDF file between
trials.  Still to be implemented for iView importing. 
- added total number of sets to be imported in the HDF import progress
window.
- changed velocity calculation from simple linear central differences
to polynomial interpolation for both eye and arm data.
- arm velocities (or more properly speeds) are now calculated on the 3D
data to produce a single absolute value rather than previously where
they were calculated for each component.  NB the dependent variable was
always calculated in this way when measurements were made, but now this
value is continuously available and doesn't need to calculated in the
measureArmMovement method.
- change arm velocity detection threshold to 0.15 m/s to correspond to
the online version in the MoVElab, and the "effective zero" value to
0.10 m/s (up from 0.05 m/s).  The latter change was due to the new
method of detecting movements using the 3D speed rather than the x
component velocity alone.


#### Samurai 007.rbp Thu 23 Feb 2006 

- changed the automatic movement start and end points from being where
velocities fell below a certain threshold (5 deg/s for eyes and 5 cm/s
for arms) to where the movement was at a local minimum.
- made cursors default to being 'on' for each set when it is first
displayed.
- enabled selective Quartz plotting, only when there are less than 1000
samples to plot, in order to reach a compromise between aesthetics and
performance.
- made overall appearance nicer, with white background & lighter plot
frame.  Also added some spacing at the top of the canvas (mTopSpace
property) which necessitated all drawing code to be updated to plot at
the appropriate vertical coordinates.
- deleted unused declares to the HDF libraries.
- added a new declare to get string attributes from the HDF file, and a
wrapper method to handle creating and parsing the required memory block.
- allowed keyboard switching between sets



#### Samurai 008.rbp Fri 24 Feb 2006 

- Implemented background importing of MoVE sets.  So can now begin
working with the first set(s) while others continue to be imported. 
Don't expect the app to be as responsive while importing continues,
however.
- The main chartWindow class now has methods for displaying progress
text and for showing a progress wheel for such background processes (in
place of the old method of displaying progress in a modal sheet/window).



#### Samurai 009.rbp Mon 27 Feb 2006 

- Implemented background importing for eye data as well.  The app
responsiveness is quite poor as each iView set is quite large and
requires a lot of time to both import and process in parallel.
- The responsiveness of the app is also quite poor when quitting, at
least when running from the IDE.  Is the thread terminating properly? 
It seems to be, from the debug log. 
- Data sets now keep track of how many invalid data points they contain
in a public property.  This is displayed in the chartWindow.


#### Samurai 010.rbp Tue 028 Feb 2006 

- Realised that each set (in its constructor) created two windows as
properties (for making and editing measurements).  This was OK for
previous data containing only a few sets but is grossly inefficient now
that MoVE data can be imported which can contain hundreds of sets, each
possibly with only one measurable movement.  Rectified this so that each
session object now holds just one instance of each sort of window, which
are accessed by each of its iViewSets.
- Can now export the movement traces for a given set to a text file in
response to the user pushing 'h'. 
- Measurements from multiple sets can now be collated into a single
file containing all measurements in the session


#### Samurai 011.rbp Fri 03 Mar 2006 - First version compiled successfully for Windows 

- If selected, traces for each measured set can be exported at the same
time as saccade measurements.
- added fourth cursor to arm data measurements
- shifted responsibility for the measurementWindow to the session class
rather than the iViewSet
- added fourth cursor to arm movement measurements.
- enabled measurement of ballistic, visual and memory arm trials.
- tidied up measurements and added some fields.
- get attributes form HDF file such as group, subject ID, sex
- now check the HDF type attribute of each stimulus so don't create
stimuli from text and beep events.
- can now draw tickMarks on y axes, and y gridlines (plus added
background colour to graph frame).

 
#### Samurai 011.rbp Fri 03 Mar 2006 

- Contains a series of minor fixes for Windows compatibility. 
Flickering eliminated for some operations, largely by using the optional
'false' parameter to the chartCanvas refresh command.  Flickering seems
to persist when holding down the control or alt key but not the shift
key when moving cursors.
- using arrow keys triggers erroneous changes in the values of the
popup buttons in Windows.

 
#### Samurai 012.rbp Fri 24 Mar 2006 

- HDF parser now reads the gain and feedback tags for each trial. 
These are also now reported when arm movements are measured.
- When the gain value is not 1.0, extra targets are drawn on screen at
a scaled location to represent where the subject  is actually heading
to.  Note that measurements are still taken relative to the 'real'
target.  So apparent errors will have to be compensated for by
correcting the data for trials when a feedback gain manipulation is
applied. 
- verified that the software is able to handle repeated/duplicate
trials with the same index number, and trials which don't occur in order
of their index value.
- added platform specific constant  kWindowTitleBarHeight to the
chartWindow class to allow for placing the window correctly on different
platforms.
- compiled for Windows but the HDF libraries don't seem to access HDF
files successfully.
- worked around keyboard activation of UI elements in Windows by
shifting the focus to the canvas in the gotFocus event of those
controls.  Works but leaves cosmetic artifact of multiple apparent
control highlights.  Note that some controls (e.g. upDownArrows) have a
setting of acceptFocus, but popup menus don't.


#### Samara 027.rbp Wed 17 May 2006 (Shifted back to Samara naming scheme as the HDF elements are now firmly incorporated (at least for OS X) and further eye-movement specific development now required.) 
- beginning of attempts to read in XML messages sent from Experimenter.
- changed format of time axis values to include a -ve sign if present
(chart.plotdata method), as sometimes there are erroneous values in the
MoVE data.
- began parsing the iView text file header to extract values like the
screen size, distance, etc, rather than hardwiring them as constants
from Saskia's first experiment.
- added sampleRate property to session class.  May be useful for
filtering eye data as allows session to choose filter for correct
frequency.
- removed session property of the parserThread (couldn't see why it was
that in the first place).  Made it a local variable.
- now read in the first line of the iView file after the header.  This
gives the labels for each column.  Allows us to read files with variable
numbers of columns (previously assumed only five columns with fixed
contents (Time, Type, Set, X, Y) but there can be other variables
selected).   At present just search for X and Y gaze data for one eye,
but should be able to extend to other variables and both eyes.  Other
data (e.g. pupil diameter) is ignored for the time being.
- removed restriction that wouldn't open files which didn't fit
Saskia's stimulus scheme (i.e. her Tower of London files).
- noticed and rectified possible bug where
countOfInvalidPointsInThisSet wasn't reset to zero each time a new iView
set was created.
- ended with ability to open new iView files but ignore stimulus
messages


#### Samara 028.rbp Thu 18 May 2006 

- extensively reworked the parser thread to add creation of stimuli
from XML strings embedded in the iView data.
- TGT\_DEF strings can be used to set template values for stimuli with
the same name.
- added several new methods to the thread to make the Run method
smaller.  Created a number of thread properties to allow those methods
to have access to variables generated within the Run method.


#### Samara 029.rbp Mon 22 May 2006 

- implemented new Butterworth filters for eye data (at 240 and 350 Hz).
- revised parserThread class to handle TGT\_DEF messages better.
- added a "File Close" menu item. 
- copied the old parser thread from Samurai 012 and installed it as a
third way to open files: this will allow us to still open Saskia's old
files.  The new implementation has broken the ability to read her stuff
as we used to have to do very idiosyncratic things to deduce the test
type and stimuli based solely on her image messages.  Renamed the
parserThreads to iViewParserThread and oldiViewParserThread.


#### Samara 30.rbp Sun 28 May 2006 

- added vestigial plotCrossHair method to chart class.  Outputs the
time value to the console.  Will need to implement drawing of the
cursor, or simply outputting text values to the window.  Note that
calculating the y value is trickier as will need to store arrays of
several constants as those values change for each plot depending on the
unit being displayed in a given plot.
- added calculation of stimulus amplitude to the iViewParserThread. 
Currently just x amplitude: really should generalise this.
- fixed bug in the display of saccade data where there could be an
array bounds exception (due to not taking account of  uBound being zero
based while the listbox listCount is 1 based).
- added some wait cursor calls for slow routines like filtering and
restoring raw calibration data.  Doesn't work for switching sets for
some reason. 


#### Samara 31.rbp Wed 31 May 2006 

- added page setup and printing.  Considerable re-factoring required.
- now scale the absolute spacings and text sizes in the chart plotData
method to take account of differences required when printing at a higher
resolution than the screen.
- now also set some colour values at the start of the plotData method
so that printing uses only black, white, and grey, whereas plotting to
the screen uses a variety of colours.
- Squashed 'multiple appearance of measurementWindow bug' (Win XP
only).  Was due to a Windows-specific RB bug in which dismissing that
dialog generated a spurious return-key keydown event, causing the
measurementWindow to be opened a second time (the second time, the
keydown did not re-occur, so there was no infinite loop).  The
work-around is to ignore the user pushing the return key in Windows (use
the enter key instead).
- Added text fields to the chartWindow to allow the subject's Group,
ID, and Sex to be edited.  This info is extracted automatically from
MoVE data but needs to be entered manually for iView data.
- the iViewSession class now stores an array of cached pictures, one
per iViewSet (created when each set is first displayed).
- added code to the mouseWheel event of the chartCanvas so that the
scroll wheel now changes the vertical scale of the graphs when the mouse
is over the canvas.


#### Samara 32.rbp Fri 30 Jun 2006 

- attempts to clean up circular references to stop memory leaks when a
document is closed..
- removed non-encapsulated reference in iViewSet to its parent
session's dataWindow.  Now the data is sent to the session for display. 
And related changes


#### Samara 33.rbp Mon 17 Jul 2006  Released as version 2.3, build 5. 
- Began using autoIncrementversioninformation
- Made extensive changes in order to implement post hoc calibration,
including addition of new PostHocCalibration class and associated window
and other GUI subclasses.
- began adding some functions to a new "Analysis" menu to decrease
reliance on remembering all the keypresses.
- fixed keydown bug where holding down 'control' caused a double redraw
when moving cursors, causing the interface to be noticeably more
sluggish than it should have been.  Was due to an error in the if/thens
in the session's respondToArrowKeys method.  Needed to add some 'return'
statements after some of the ifs.
- noticed that stimulus position values showed a rounding error of up
to 0.02 deg.  This is due to the original rounding of calculated
stimulus positions to integer pixels (i.e. given a desired angle, say
+15 deg, calculate the screen position in pixels required to produce
it).  Accordingly, Samara now rounds its angular stimulus positions to
the nearest 0.05 deg.  (i.e. it re-calculates the angular position from
the pixel position, so any rounding error in the pixels is transferred
back to the angular position).  Eye position data is not rounded (it is
given to sub-pixel accuracy anyway).  Note that this means that stimulus
positions should not be intended to be any more precise than the nearest
0.05 degree location.

 
#### Samara 34.rbp Tue 01 Aug 2006 Released as version 2.3.1, build 6. 

- Fixed exception when attempting to edit saccade measurements when
none had been made.
- Removed legacy code in the iViewParserThread that erroneously gave
the last stimulus a very long duration.


#### Samara 35.rbp Wed 02 Aug 2006.   Released as version 2.3.2, build 7, 03 Aug 2006. 

- although apparently only a bug release, this actually involved major
rewriting of the HDF5parserThread and associated HDF declares and
wrappers.
- added declare to  H5LTget\_attribute\_float to access the version
number from the root level HDF attributes.
- added declare to  H5LTget\_attribute\_int to access the primarySensor
number from the root level HDF attributes.
- added determineHDFfileVersionNumber and
determinePrimarySensorFromFile methods to the HDF5parserThread to make
use of the above.
- added MMGetSolitaryDouble to allow more precision than achievable
when using MMGetSolitaryFloat for accessing  trial\_start\_vrpn\_time,
which otherwise has too many significant digits. 
- HDF5parserThread: now takes account of trial\_start\_vrpn\_time,
which links the time in the tracker data to time 0.0 in the experiment,
when it is present.
- modified the HDF5ImportSettingsWindow and HDF5parserThread.run to be
able to either manually set the primarySensor number or extract it from
the file (if it exists).  This also allows the user to override an
erroneous value recorded in the file.


#### Samara 36.rbp Fri 03 Aug 2006  Released as version 2.3.3, build 8, 07 Aug 2006. 

- added predictive value to test type popup for eye analysis.
- added getNearestStimulusNumberInDirection to data object so that when
analysing predictive saccades, an extra constraint is added in that not
just the temporally closest stimulus is associated with the saccade, but
the temporally closest moving in the same direction.
- also done for analysing arm data, but not tested.
- changed session.date property to a string rather than a variant as no
proper value seemed to be being set during iView importing (not
currently set in HDF importing).


#### Samara 37.rbp Mon 07 Aug 2006  Released as version 2.3.4, build 10, 16 Aug 2006. 

- changed selfPacedStimulusAmplitude constant to 20 deg from 26.  NB
the code in data.measureSaccade needs to be updated so that it doesn't
use a constant to interpret self paced stimuli but instead properly
responds to the Experimenter XML messages.
- changed HDF5ImporterThread to create correct set numbering despite
the HDF file occasionally labeling each set with an index value of zero.
- had used a test of whether /trial\_000n/index returned a value to
determine whether a given trial existed in the file.  This wasn't useful
as sometimes trials exist but don't have an index value.  So implemented
a more correct check by calling H5LTfind\_dataset to check if a given
object exists.  Also needed to implement h5Gopen to get a handle to the
group objects (e.g. /trial\_0001).  
- Also implemented H5LTfind\_attribute as a corresponding function for
checking attribute existence, but **NB** the HDF library doesn't seem to
connect for this function.
- moved the reading of a number of set attributes into a separate
method (getSetAttributesFromFile) and out of the run event of the
importer thread.
- made extensive changes to cater for occasional dropped Liberty
packets, which lead to NaNs in the data, which Samara was not able to
handle.  When they are frequent (as they can be, at up to every 6th
sample), just not adding that sample doesn't work, as it adds noise into
the filtering/velocity calculation.  So now these NaN samples have
interpolated values for t, x, y, and z created.  This is currently a
fragile method, as it assumes that successive samples will never be
NaNs, and that the first and last samples will be valid.
- also fixed the getNearestStimulusNumberInDirection method, which was
unable to deal with the amplitude of MoVE stimuli.  NB this is still
restricted to 1D comparisons (left vs rightward only).


#### Samara 38.rbp Thu 17 Aug 2006  Released as version 2.3.5, build 1, 21 Aug 2006. 

- some HDF files were somehow saved without any stimulus information,
meaning Samara could not process them.  Made the code robust to this so
that now the files can be opened and it is clear that arm data exists
but that there are no stimuli.
- added robustness to the data.interpolateNaNs method so that it could
handle runs of NaN data samples (previously assumed that they occurred
in isolation, flanked by good samples.
- fixed filtering methods.  Butterworth filtering propagated NaN values
through the data.  Triangular and None filtering didn't deal with the z
coordinate properly.
- fixed a bug in the set measureArmMovement method where the direction
of movement of the arm in the x direction was not correctly classified
as leftward or rightward.  Seemed to be due to a very strange behaviour
of the relevant if-then statement, in which evaluating the test
expression in a temp variable first gave the expected result but
evaluating it in the 'if' statement did not.


#### Samara 39.rbp Tue 22 Aug 2006  unreleased 

- changed the processing of the iView text file header, which used to
be a for/next loop until realised that the number of lines in the header
could vary.  e.g. the "\#\# Calibration Targets:"  line could be omitted
when custom calibration targets were used.


#### Samara 40.rbp Wed 30 Aug 2006 unreleased 

- realised that adding the ability to view both left and right eyes
would necessitate a major re-factoring.  The dataPoint class was changed
from a simple dictionary subclass to a proper custom class with the
ability to introspect its source (iView or MoVE) and return values
accordingly, especially in the iView cases, where it needs to be able to
return x and y values for either eye as appropriate, and be able to do
future things like deal with pupil values.  This will also make it
possible for MoVE data to be more generalisable too, perhaps reporting
values form more than one sensor.
- implemented, but at this stage not fully for MoVE data.


#### Samara 41.rbp Thu 31 Aug 2006 unreleased 

- designed to allow display of binocular data.
- shifted filter selection to the Analysis menu, away from the main
interface window where it had been a popup.
- removed checkbox for showing cursors, and shifted that function to a
new View menu.
- now keep set selector popup button disabled unless there is actually
more than one set to choose from.
- in some old MoVE files, the stimulus\_type metadata wan't recorded. 
Accordingly, some beeps stayed in as stimuli and mucked up the
plotting.  An extra check is now done on stimuli which get through the
stimulus\_type checking such that they are deleted if their spatial
coordinates are NaNs (which is the case for beep stimuli).
- added a Constructor for dataPoint which takes a MoVE/iView parameter
and an integer (default = 1) stating the number of channels per sample
(i.e. 2 for binocular eye data, 1 for monocular, 1 for standard arm data
data (but possibly more in the future if we want to look at multiple
sensors)).
- now imports binocular eye data.
- displaying is still a kludge, based on hardwired string values set in
the session.displaySet method
- dropped saccade trigger threshold to 75 deg/s from 150 deg/s.


#### Samara 42.rbp Thu 07 Sep 2006.  Released as version 2.4, build 1,
08 Sep 2006. 

- There were major problems with the encapsulation between the iViewSet
and Data classes.  The iViewSet needed to know too much about internal
matters of the Data class, while their separation made it difficult to
implement new features, such as saccade counting.  The most logical
solution seemed to be to abolish the Data class, and to fold its methods
and properties into the iViewSet class, many of which were duplicated
there anyway.
- fixed bugs with keeping set selector popup button disabled unless
there is actually more than one set to choose from.
- extracted the code from the iViewSet.detectNextSaccade method into
private detectNextFastMovementInRange and
numberOfSaccadesBetweenFirstAndLastCursors methods and a public
moveCursorsToNextMovement method.  This means that movement detection is
no longer tied to cursor movement, so that the movement detection
algorithm can be used for other purposes, such as counting the number of
saccades within a given interval.
- implemented saccade counting between the first and last cursors.  The
velocity detection threshold was lowered to 30 deg/s to pick up smaller
corrective saccades, but when used for primary saccade detection (e.g.
when moving the cursors automatically), 80 deg/s is used so that the
cursors don't get caught up with small saccades made during fixations
(but still lower than the old value of 150 deg/s).
- removed "Feedback visible" and "Gain applied to feedback" from eye
measurements as they actually apply only to MoVE data and were
mistakenly added to the eye statistics once measured.
- now read in the test type from the iView file, specified in the
Samara CONFIG XML message.
- disabled the FileImportMoVE menu as that code is not functioning at
present.


#### Samara 43.rbp Thu 07 Sep 2006.  Released as version 2.4.1, build 1, 11 Sep 2006. 

- Amended saccade counting to enforce a refractory period constraint
between successive saccades so as not to get false detections due to
fast dynamic overshoots at the end of a primary saccade.

	**Released as version 2.4.1, build 2, 12 Sep 2006.**

- Revised inter-saccade interval for saccade counting down from 80 ms
to 40 ms.

	**Unreleased:**

- Added to the dataPoint class to allow MoVE data to be imported again.


#### Samara 44.rbp Tue 12 Sep 2006.  Released as version 2.5, build 1, 13 Sep 2006.

- tidied up the session.editSaccadeData \> set.editSaccadeData \>
session.displayDataFromSet loop.  The session should just request the
measurements from the set, and if non-nil, display them.
- made the DataListBox a custom class rather than a standard listBox
instance.
- added a new ExtendsModule.  Currently this contains only a method to
extend the dictionary class to allow a dictionary to produce a cloned
copy of itself, as the stimulus class already does, but for all
dictionaries.  
- Implemented deleting of rows in the dataListBox by the user.  The
iViewSet now sends a cloned copy of the measurement dictionaries so that
any editing or deleting will not affect the original iViewSet
measurements property because it is would otherwise be passed as an
array byref.
- Implemented editing individual cells of measurement data by the user.
- Switched off ability to sort measurements by column as otherwise the
listBox display might get out of sync with the stored measurement array
of dictionaries.  But no reason why this couldn't be re-enabled in the
future, just be rewriting the stored array of data each time the display
is sorted.
- now offers a warning if the user tries to close a session that
contains at least one set with unsaved data.
- added a "Save" menuitem item in addition to the existing "Save As..."
but currently this just works as another save as.. (i.e. it doesn't
retain a folderitem for appending to).  Note that the menu enabling does
work correctly.  i.e. Save As... is always enabled if there is data,
whereas Save is enabled only if there are unsaved changes.

	**Released as version 2.5.1, build 1, 15 Sep 2006**

- Extensive changes to the HDF5parserThread to correct for further
problems with a version of the Tardis bug and occasional incorrect
trialStartVRPNTime attributes
- incorrect trial\_000n/duration values were leading to problems with
incorrect drawing of stimuli.  The set duration is now calculate
indirectly from the number of samples in the trial.  As this includes
extra data after the end of the regular stimuli, the final stimulus may
be depicted as appearing longer than it actually did?


#### Samara 45.rbp Fri 15 Sep 2006.  Released as version 2.6, build 2, 15 Sep 2006 

- removed storage of old values in the dataPoint velocity arrays, as
new velocities are always calculated each time the filtering changes.
- added acceleration properties and methods to the dataPoint class
- for clarity, removed the commented out code for useAlternatingColours
in the chart.plotData method.
- added acceleration calculation.  Used to be done in the calculate
velocities method by differentiating the velocities, but must have been
dropped when the velocity calculation algorithm was upgraded.  
Currently just done for arm data, but removing one if/then statement
would enable it for eye data too.
- now graphs accelerations for arm data
- for MoVE data, the vx and ax graphs are now combination graphs, with
multiple series overlaid on the same axes.  e.g. the x,y, and z
velocities and the normed velocity are all superimposed.
- the user can now select which graphs will be displayed via checking
or unchecking menu items in the View menu.  This updates in the UI
automatically when the user switches from one document to another.  i.e.
the settings apply to all sets within a session, but different
concurrently-open sets can have their own settings.


#### Samara 46.rbp Mon 18 Sep 2006.  Released as version 2.6.1, build 3, 19 Sep 2006

- the displayed data is now truncated so that any recording prior to
the onset of the first stimulus is not displayed.  The presence of
non-displayed data is indicated by the first x-axis value being non-zero
when a set is first displayed.  This truncation does happen if there are
no stimuli, as has happened in some problematic HDF files.
- now automatically detect the first movement when a set is displayed
for the first time.
- corrected an error in the measureArmMovement method in which the
primary duration was reported twice, once with its correct label and
once again, labeled correction time.  The correction time is now the
intended value.
- fixed bug that must have been there since Samara 31.rbp.  After the
re-factoring required for printing, moving the cursors ended up
re-drawing the graph completely each time: somehow I didn't notice the
slow down.  The problem was that the iViewSession was not actually
populating its array of cached pictures with anything other than nil. 
Simply adding the line "mGraphPic(mSelectedSetIndex) = selectedPicture"
to the iViewSession.displaySet method fixed things.  NB the session
needs to maintain the array of stored pictures.  The iViewSet cannot
store its own picture because it only receives a graphics object for
drawing into.
- reinstated the drawing of a random coloured dot to make such
re-drawing problems clear in the future.
- to support the random colouring, added a random property to the app
instance.
- removed the chartCanvas.plotCurrentObjects methods as it did not seem
to be used anymore.
- began implementing a global gTime method for optimising.
- commented out the gLog calls throughout.  Just reinstate them when
needed. 


#### Samara 47.rbp Wed 20 Sep 2006.  Released as version 2.7, build 1, 21 Sep 2006

- began re-writing iViewSet.measureArmMovement to include new
measures.  To do that, needed to define a startStimulusPosition and
destinationStimulusPosition for each task (previously had only the
latter, labeled stimulusPosition). 
- implemented calculation of arm initial directional error, based on
the positions at both 80 ms after movement onset and at peak velocity. 
- implemented calculation of arm path length, by adding the distances
between consecutive samples from cursor 0 to cursor 4.
- changed the measurementWindow to display the measurements in a
scrolling text box rather than in static texts, as the number of
statistics is getting too large to display otherwise.  The listBox
remembers any lines which have been selected so that they remain
highlighted on subsequent measurements.

	**Released as version 2.7.1, build 1, 16 Oct 2006**

- changed calls to window and canvas.refresh to take the optional false
parameter to stop erasing before redrawing.  This might help reduce
flicker on Windows a bit more.
- fixed bug where pushing 'n' when in the last set would cause an array
bounds exception.

	**Also released several informal Universal Binary builds for Yuki's
MacBook. **Found that worked for eye movement analysis (once universal
Quesa framework was installed), but arm movement didn't work, even when
Daniel had compiled the associated HDF libraries for Intel.

	**Released as version 2.7.2, build 2, 28 Nov 2006**

- fixed bug in which self-paced arm movements to one side had a
stimulus amplitude of 0 and hence INF values for gain, PEA, etc.
- fixed bug in which the trial type value for each arm movement (and ?
eye movement) was set to "" when the measured was displayed prior to
storage.   

	**Released as version 2.7.3, build 1, 28 Nov 2006**

- fixed bug in which the beginning of an arm movement was auto-detected
at the point of peak velocity rather than the actual beginning of the
movement.  This was evident only in cases of continuous reciprocating
arm movements where the beginning of one movement occurred immediately
(i.e. the next sample) following the same time as the end of the
previous one.


#### Samara 48.rbp Tue 19 Dec 2006.

- Began implementing re-importing of measurement text files and
exporting of movement velocity profiles.
- encapsulated exporting of measurements within the iViewSet class (had
been in the iViewSession).
- improved addDataColumn method of dataTracesForExport class (removed
needless columnNumber parameter).
- fixed cancelClose event where immediately quitting caused an
exception as the window did not have a sessionObject instance.
- added getMovementProfiles method to the iViewSet class and
exportProfiles method to the iViewSession to allow exporting multiple
movement velocity profiles.
- added a velocity measure to exported traces.
- added menu item to allow re-attaching measurements from a saved
file.  Only enabled when a data session exists and when no measurements
have been made.  i.e. presently you can't import saved measurements and
overwrite ones in memory.


#### Samara 49.rbp Mon 22 Jan 2007.  Compiled with RB 20007 Release 1. 

- imported the OxMath classes to allow all usage of RB's vector3D
classes to be replaced by the OxMVector3 class.  RB's vector classes
actually require RB3D/Quesa, so removing them allows the project to have
one less external dependency, which currently causes problems with Mac
Intel builds.
- replaced "vector1.minus(vector2)" syntax with "vector1 - vector2"
- also had to introduce clunky two line constructions like this:

	tempVec = samples(3).vector - destinationStimulusPosition

	finalErrAmpl =  tempVec.length  // in place of the one line
previous version as these new classes cause errors doing this in one
line


#### Samara 50.rbp Tue 20 Feb 2007 

- NB This file contains changes made to importing of iView files.  It
doesn't incorporate the changes made by Daniel.
- There has been a bug fix in iView which means that MSG lines now have
a set number, which they didn't previously.  We need to deal with this
seamlessly.  The current quick and dirty change means that old files
won't be read correctly (stimuli will be ignored).  A related bug is
that a message such as a config msg which is the first line in a new set
now gets applied to the previous set as Samara isn't checking when it
receives msgs whether the set has incremented.  Need to shift the set
change check out of the SMP specific code.
- in the iViewParserThread, shifted the check of whether a new set has
started out of the SMP code as the first line of a new set could
actually be a MSG line, which was then erroneously processed as part of
the preceding set.
- added a "Fixation" option to the testtype popup, although there is no
code to analyse that sort of recording yet. 


#### Samara 51.rbp Mon 19 Mar 2007. Released as version 2.7.4, build 1,19 Mar 2007

- allows opening of both old and new format idf files (i.e. files
prior to jan 2007 had no set number in the message lines.  New ones do.)
 


#### Samara 52.rbp Mon 21 Mar 2007.

**- Incorporated Daniel's changes to allow HDF use on Windows/ OS X
Intel**

**\*\*\* - ON 27 MARCH 2007, PUT UNDER VERSION CONTROL SVN \*\*\***

**- the current version was tagged as "2.7.4a", incorporating Daniel's
changes.  That version has not yet been compiled and released to
users.**


**29 Mar 2007**

Fixed bugs in analysing anti-saccade files provided by Marcus.  Now more
tolerant of spelling of "antisaccade" or "anti-saccade" when needed, at
the level of the iViewSet or individual stimuli.  Also changed iView
importing so that if a stimulus XML message does not have a TYPE tag,
then it sets the stimulus type value to be equal to the NAME tag if it
exists.  If neither a NAME nor a TYPE is specified, then the type value
is set to a default of "target".  This allows anti-saccade analysis to
proceed correctly, where stimuli with a type of "target" or
"antisaccade" or "anti-saccade" have their gain calculated according to
the opposite sign of the displayed stimulus.  Ideally in antisaccade
tests, each stimulus should have an appropriate NAME or TYPE value so
that return-to-centre or calibration trials can be analysed as simple
prosaccades

**Compiled as version 2.7.5. for Marcus to test (under Windows).**


**11 June 2007**

- Now responds to \<overlap\> & \<delay\> tags.  Draws stimuli
correctly so that the linking line appears at the right time if there is
a delay or overlap.  The gap/overlap & delay parameters are now also
measured correctly.

- added truncateStimulusValueWithinGraphFrame to chart class  

**Compiled and released as version 2.7.6 on 15 June 2007**


**13 Aug 2007**

- Changed trace export function to also export stimulus x values
(previously just exported eye/arm data, with no stimulus info).

	**Not compiled or released.**


**05 Nov 2007**

- Minor change to report the pathname string of the file being opened
in the error dialog box  to help diagnose Windows HDF problems.


**14 Nov 2007**

- Now responds to \<OFFSET\> messages in iView data, by drawing a
black tick mark on a given stimulus to indicate the time of its
associated \<OFFSET\> message being received.

	This is to assist with assessing timing errors in the actual duration of
stimulus events via Experimenter, rather than relying on the nominal
durations sent in each \<TGT\> message re target duration, gap/overlap
duration, etc.

	**Compiled and released as version 2.7.9 on 14 Nov 2007**


**05 Dec 2007**

- Added About note to the old iView importer thread

- added ability to display a custom stimulus colour from a simple
string ('red', 'green', etc) embedded in a \<TGT\>\<COLOUR\> tag.

- Should now ignore any "TRG:" prefixes in Samara XML message lines
(TRG has special meaning for BeGaze, but we can ignore it and treat the
line like any other Samara message).

- Corrected some bugs in the iView importing in the way it applied
default values to stimuli from TGT\_DEF messages. 

- If a file consists of many sets, it can be more convenient to send
the the CONFIG test type message only once.  So if a set is added to a
session without a test type having been specified, it is now assumed
that it should be the same as the test type of the first set in the
session.

- Unchecked the MDI option for Windows executables.  Much easier to
use now, and doesn't seem to require any code changes . 

- The current background image filename is now associated with a given
target stimulus and reported with saccade measurements.

	**Compiled as a limited release to Saskia as version 2.8a on 07 Dec
2007**


**12 Dec 2007**

- Began adding vertical post hoc calibration ability

	NB these horizontal and vertical post-hoc calibration routines act as
though the two components are independent.  The routines need to be
upgraded to a true 2D recalibration, as I previously implemented in
Matlab for EMMA data.

- found that some bugs with apparent double key presses may have been
due to returning false rather than true in the chartWindow keyDown
event.  Keep monitoring this to see what the effects of the change are.


**14 Dec 2007**

- In post-hoc calibration, selecting a row of data now results in a
pink highlight ring being drawn around the corresponding data point in
the calibration stimulus vs position graph.

- internally tidied up data shifting methods (e.g. moving the data in
response to arrow keys) to use booleans ('leftward') rather than strings
('direction').


**09 Jan 2008**

- minor changes to iViewParserThread, such as logging unrecognised
messages to the UI as well as to the console.

	**In SVN, made a new tag ("release\_2.8a2") to store the latest changes
before embarking on the major revisions required for implementing 2D
display.**(NB 2.8a2 was not actually compiled and released.)

- added a plot2D method to the chart class (not yet functional), and
renamed plotData to plotLineTraces

- added a scroll bar under the chartCanvas on the chartWindow

- added twoDCanvas subclass of chartCanvas

- added simple backgroundImage class to hold a reference to a
background image, its times of onset, offset, etc.

- added radiobuttons to allow selection of 2D plotting vs line graphs.

- the iViewParser thread now extracts BeGaze image messages.  The
filenames and onset and offset times are stored in an array within each
iViewSet.   One copy of each filename is also stored in a dictionary in
the iViewSession.  This is so that when actual importing of the image
files themselves occurs, each is stored only once, and the iViewSessions
can store as many references to each as needed.

- the textual cursor data now reports the background image onscreen at
the time of the first cursor, or "Nil" if none was specified. 

- in MoVE recordings, we generally truncate the display of any data
prior to the onset of the first stimulus.  But this can cause misleading
impressions of how iView messages are sent as well as causing problems
with zooming in and then not being able to see the last part of a set. 
So this truncation is now explicitly disabled for iView data.

	**Compiled as a limited release to Saskia as version 2.8a3 on 10 Jan
2008**


**10 Jan 2008**

- the iviewSession caches a picture of each of the drawn graphs so that
they can be redrawn rapidly when needed (i.e. when don't need to be
recalculated). To cater for 2D plotting, made mGraphPics a two column
array.  The second column stores the 2D graphs.

- modified the iViewSession displaySet method extensively to select
between 2D and component graphing.

- now displays both graphs: the primary one in the main chartCanvas,
the secondary one as a thumbnail.

- currently displays stimuli in the 2D plot but not eye data, as it
can't yet convert from the stored degree coordinates back to the raw eye
data pixels.  As an interim kludge, stimuli have raw pixel values
stored.


**15 Jan 2008 Tue**

- deleted the 2DCanvas subclass as don't need any extra functionality
over the chartCanvas class as yet.

- added screenGeometry class to allow angle\>pixel conversions for
iView data both during importing and later to convert stored angular
values back to pixels when needed for 2D plotting.

- changed iViewParserThread class to use the screen Geometry class for
its importing calculations

- a screenGeometry object is passed to each chart object to use for 2D
plotting.

- 2D plotting of both stimuli and eye traces is now implemented.

	**Compiled as a limited release to Saskia as version 2.8a4 on 16 Jan
2008**


**17 Jan 2008 Thu**

- now allow calibration to be applied to all sets in a session rather
than just the one from which the calibration data was extracted (or the
currently visible one in the case of the manually entered values).

- this also implied extensive changes to general set displaying,
including a mechanism to indicate when a set is "dirty", i.e. requires
recalculation before the next drawing.

- also now responds to a simple \<RESPONSE/\> tag by storing an array
of responses and their time within each set, displayed as a pink circle.

	**Compiled as a limited release and e-mailed to Saskia as version
2.8a5 on 18 Jan 2008**


**11 Feb 2008 Mon**

- one line fix (in convertPixelsToAngle method) to attempt to correct
that vertical movements and stimulus positions were inverted. i.e.
upwards saccades were plotted as downwards, and similarly for target
positions.

- changed Butterworth filter method to invalidate points at the
beginning and end of the dataset in order to prevent discontinuities
introduced in that process.


**11 Feb 2008 Mon**

- added Butterworth filter coefficients for 500 Hz and 1250 Hz data. 
Produced using the program WinFilter, specifiying Butterworth low pass
IIR, Fsample 1250 or 500 Hz, Fcut 70 Hz, filter order 2.


**13 Feb 2008 Wed**

- Added ability to plot both stimuli and datapoints on the same 2D
plane (i.e. y vs x) in a new tab in the calibration window.

- made a variety of tweaks to the existing display of the calibration
window itself (now defaults to appear on the right hand side of the
screen, and can only be resized vertically), the list boxes, the graph
grids (the righhand-most and bottom-most lines are now drawn), and
highlighted points (de-selected points can now be highlighted).


**14 Feb 2008 Thu**

- Samara is now being compiled with REALbasic 2008 Release 1.  It was
found that the popup menus in the ChartWindow no longer responded to the
mouse, but could still change their values appropriately in response to
code (i.e. switching sets via the keyboard).  This was due to the code
in the GotFocus event of each popup which shifted the focus to the
chartCanvas (done to correct Windows-only behaviour when the popup could
suck up the keyboard focus, not allowing keypresses to be read by the
window).  Removing this code now means the popups respond to the mouse
again, but not sure what effect this will have on usability under
Windows.


**14 Feb 2008**

- implemented 2D calibration, using the Delaney matrix plugin.  This
plugin is only used in one method (the calculate2D method of the
postHocCalibration class, and so could be eliminated  if prepared to
duplicated its methods (matrix inverse and transpose) in REALbasic code
(see the pseudo code in "Numerical Recipes" 3rd ed, p.44).  The matrices
involved tend to be small (rows = number of calibration targets, columns
= 6), so speed is not much of an issue.

- the existing calibration system was changed so as to separate the
vertical and horizontal components, whereas previously both were
re-calibrated even if only 1 was desired.


**18 Feb 2008 Mon**

**Compiled under RB 2008 R1 and released as version 3.0 for Mac and
Windows.**


**20 Feb 2008 Wed**

- Added a proper selectFolderDialog with custom prompt string etc to
the iViewParserThread, in place of the uninformative selectFolder()
function when choosing a folder containing background bitmaps.

- Fixed a bug where if the dialog was cancelled, an exception occurred
when backgroundImages were added to the session object.


**21-22 Feb 2008**

- Fixed display of multiple background images where more than one
occurs within a given window of time.  Shifted from pixmapshapes which
weren't working to pictures with masks.

- Fixed the Butterworth filter, which was still producing
discontinuities in the data by incorporating some values from invalid
samples in its calculations.

	**Released as version 3.0.1**


**23 Apr 2008**

- Printing must have been broken since 2D plotting was introduced. 
Modified the DisplaySet method of the iViewSession class to restore it.


**05 Jun 2008**

- Fixed a bug seen only in Windows XP (not OS X or Win 2000) in that
the manual recalibration window would not hide when recalibration was
applied to more than one set. i.e. the window stayed visible, and being
modal, stopped use of the app. It seems that the self.hide command
didn't work in this situation. Found in testing that it would disappear
if a msgBox appeared just prior to the self.hide call. So a messy
work-around is for a msgBox to conditionally appear only on TargetWin32
and when "apply to all sets" is selected.

- changed the kWindowTitleBarHeight constant under windows from 35 to
50 (remains 22 under OS X). This means that when the ChartWindow opens,
it now correctly fills the screen in Windows XP, rather than have half
the title bar above the top edge. Conversely, on Win 2000, it now does
not quite fill the screen.

**Compiled under RB 2008 R2 and released as version 3.0.2 build 3 for
Mac and Windows (no longer as a single .exe file).**

- the calibration window bug hadn't been completely squashed: it was
fixed only for the "Recalibrate" button and not the "Restore" button.

**Re-compiled and released as version 3.0.2 build 4 for Windows **

- subsequently found to be very buggy with cursor movement: cursors
often became unresponsive to arrow and number keys, making it
practically unusable for analysis (at least on Windows, not tested
thoroughly on OS X.)


**24 Jul 2008**

**Found that the Delaney Matrix plugin is no longer compatible with
RB 2008 R3 and above (it seems to use old style constructors for
creating matrices). **

- Fixed bug in Butterworth filter where trimming end samples to remove
discontinuities would cause an out of bounds error for pathological sets
consisting of only a handful of samples.


**20 Aug 2008**

- the Delaney plugin was updated to deal with the new RB plugin
constructors.


**01 Oct 2008**

**Tried RB 2008 Release 4 but found the IDE to be very buggy so
continuing to use Release 3.1**

- Returned to examine the problems with the keyboard becoming
unresponsive on Windows. Found that:

	- The problem occurs only after RB 2008 Release 1

	- Found that the problem occurs reliably in RB 2008 Release 3.1
**IF**(1) the set is zoomed in. (2) A measurement is made and then the
window closed with the enter key. Then the chartWindow is unresponsive
to all keys except arrows, function keys, and some of the page down keys
etc. So seems to be related to the modal measurement window somehow
hogging the focus even though hidden?

- The problem seemed to go away if the measurementWindow set the focus
to its comment text field when its Activate event fired.

- Also needed to set the focus back to the ChartWindow at the end of
its keydown event (i.e. after the measurement window had closed).

- Also made some changes in the chartWindow keydown event to return
TRUE/FALSE in several conditions. May not actually make any difference
but left in there anyway.

- made a two-line change to the moveCursorsToNextMovement method of the
iViewSet class to finally implement the data scrolling forward in time
by half a screen when attempting to detect a saccade but when no more
are found in the current time interval. Previously, nothing would
happen. The cursors remain at their current time positions (but will
move in screen position) so that the user has something to anchor
themselves by when the view jumps. i.e. pushing the 'A' key shifts the
view of the data but 'A' needs to be pushed again to actually shift the
cursors forward in time to the next saccade, if it exists.

- added a displayProgressInfo to the iViewSession class so that the
iViewSet can communicate status info about slow processes, such as
filtering, re-calibrating, and calculating velocities.  Previously,
there could be a long unexplained pause in status messages between the
importing thread finishing with the last stimulus info and the final set
being imported.


**02 Oct 2008**

- Began making changes required for 2D measurement of saccades

- at the importing thread stage, stimuli now get an amplitudeX and
amplitudeY value rather than just 'amplitude' (which was just
horizontal). Both are still signed.

- also calculate unsigned Euclidean amplitude ('2Damplitude') and
orientation ('2Ddirection') in the importing thread.

- now calculate 2D Euclidean velocity for eyes as we do for the 3D arm
data. The 'v3' property of the DataPoint class has been renamed to just
'v' and represents either 2D (eye) or 3D (arm) Euclidean velocity as
required. Multiple changes required throughout iViewSession, iViewSet,
Chart, and DataPoint classes.

- added ability to display 2D Euclidean velocity for eyes, including
via a new menuitem.

- added extra radio buttons and group boxes to the chartWindow to allow
selection of 2D or horizontal-only analysis (analysis itself not yet
implemented).

- added 'analyse2D' computed property to iViewSet class (defaults to
FALSE) and also to the iViewSession (the latter called by the user
changing the radio buttons in the interface).


**03 Oct 2008**

- once a measurement has been made, the iViewSession now disables the
analysisGroupBox so the user can't change the analysis between 1D and 2D
or else we will end up with inconsistent dependent variables in
succcessive measurements.

- created a measureSaccade2D method in the iViewSet class. Not yet
fully implemented.


**06-08 Oct 2008**

- Continued working on 2D analysis

- changed the stimulus class to return a vector representing either the
location of the stimulus (it did this before from the 'vector' method,
now re-named positionVector) but now also the vector from the previous
stimulus to that location (the new method 'directionvector').

- altered the OxMVector3 class to add a method to return the angle
between a vector and the x axis, in degrees \> 180 deg when required
(for vectors with a downward component). 


**23 Oct 2008**

- Exporting traces: rather than the entire set, data is now exported
only between the first and second cursors.


**28 Oct 2008**

- added a displayOnly key to stimuli if specified when imported. A
target with this attribute is drawn on screen but ignored for analysis
purposes (1D and 2D).

- to preserve backwards compatibility and for tasks where this
attribute is not set explicitly, don't test the value of this key
directly, but instead use the new "displayOnly" accessor method of the
stimulus class.

- now get the "Value" and "Judgment" tags for a subject's response. The
first character of the response value is now drawn on screen, but not
yet recorded with a measurement.

- the stimulus "Comment" tag now responded to and recorded in the 2D
saccade measurement.

- the chartWindow analysis type radio buttons now keep in sync properly
with the analysis type of the selected set.

- sets now have their analysis type (2D or 1D) set at the importing
stage in response to a CONFIG message. Note that to keep compatible with
an older rule for test types, Samara allows a single analysis type
message to apply to all sets in a session if it is only specified for
the first one (i.e. it is treated as a default, as is the test type
config message, even though config messages were intended to be set-wide
rather than session-wide).

- cursors 4, 5, and 6 are seldom moved (currently only used in
anti-saccade measurement. So their behaviour has been changed: they now
"stick" to the next lowest cursor unless they have been explicitly
selected for individual movement. e.g. previously, cursor 3 would push
all higher cursors to the right when it moved rightwards, and then leave
them there if it then moved leftward. Now, the higher cursors will stick
with the third cursor and move backwards in time unless they have been
selected individually. When the A key is pressed to select a new
saccade, all higher cursors are "re-locked" again to the third cursor.

- the Euclidean iView velocity is now displayed in the chartwindow
along with the x and y component velocities

	**Compiled under RB 2008 R3.1 and released as version 3.1b2 for
Windows for Saskia to test**


**29 Oct 2008**

- changed getNearestStimulusNumber and
getNearestStimulusNumberinDirection methods of the iViewSet to not be
passed cursor 1 as a parameter. It is always cursor 1, so those methods
now just access that cursor themselves rather than have it passed to
them.

- added getLatencyAtFirstCursor method to the iViewSet so that the
latency to the stimulus nearest to the first cursor is now displayed in
the chartWindow window continuously as part of the cursorData, rather
than having to measure a saccade to see that value.


**28-30 Jan 2009**

- added a "disconnected" accessor method to the stimulus class, similar
to the displayOnly method, to test whether a connecting line should be
drawn between stimuli in the 1D display.

- changed the iViewParserThread to set the disconnected status of a
stimulus

- the subjectIDField seemed to have disappeared in the running
interface and needed to be recreated.

- should now import the subject name if it was specified in the iView
header

- also now imports "Session" level XML tags, such as Sex, Group, and a
session label which if present will override the one which is derived
from the file name.

- now also searches for a subject response which is explicitly linked
to a given stimulus via a \<TGT\_ID\> tag and outputs the response data
along with the saccade measurements

	**Compiled under RB 2008 R3.1 and released as version 3.1b3 for
Windows for Saskia to test**

 
**16-17 Mar 2009**

- changed the fillInBlankValuesInStimulus method of iViewParserThread
so that missing x and y stimulus values default to 0.0 deg rather than
-22.2.

- added getStimulusForCurrentTrial to iViewSet. Designed to reduce code
duplication in the stimulus selection between the 1D and 2D measure
saccade methods and to fix the memory guided target selection bug. It
returns a modified copy of a stimulus rather than the direct instance as
some properties of the stimulus need to be customised depending on the
analysis type. e.g. For MGS task, need to construct & calculate the
latency from the previous fixation target and the position and amplitude
from the next. Similarly for self-paced. 

- added highlighted boolean property to the Stimulus class and a
highlightStimulus method to iViewSet. Will allow a designated stimulus
to be visually highlighted to indicate which will be selected for
analysis. 


**20 Mar 2009**

- Fixed what must have been a longstanding bug in which the traces and
2D plot were actually drawn twice on import. Was due to the analyse2D
setter of the iViewSet class checking to see if the set had been
initialised rather than checking if the analyse2D property was actually
changing in order to mark the set as dirty.


**19 May 2009**

- many changes, primarily to integrate the new stimulus selection
method (getStimulusForCurrentTrial) with the measureSaccade2D method
(already integrated with measureSaccade1D). Also multiple bug fixes
particularly around stimulus selection.

- changed getExactStimulusNumber method of the iViewSet to not be
passed cursor 1 as a parameter. It is always cursor 1, so now just
accesses that cursor themselves rather than have it passed. Also renamed
this and several similar methods to explicitly include "AtCursor1" or 
"ToCursor1"in their names.

- previously the target selection was extracted to a separate method
(getStimulusForCurrentTrial) to be used by both the 1D and 2D saccade
measurement methods but only utilised in measureSaccade1D. Implemented
it for measureSaccade2D also, which removes more redundant code.

- deleted the getExactStimulusNumber method as it was called by only
one other method (to display the stimulus number when the cursors
moved). Now use a method which returns the stimulus itself, with the
number embedded within its "number" key.

- fixed several bugs with selecting the last stimulus in a set for
cursor data or post-hoc calibration (array bounds issue in
getExactStimulus method).

- fixed nilExceptionError when attempting to post-hoc calibrate at a
sample where there was no valid stimulus.

- fixed nilExceptionError when attempting to measure a saccade when
there was no valid stimulus (now more careful about checking when a nil
stimulus is returned).

- fixed bug with automatic calibration not being applied to all sets:
was probably just cosmetic, with re-drawing not being triggered in the
active set.

- double drawing bug found on 20 Mar didn't actually seem to have been
saved so re-fixed.

- problem with selecting displayOnly stimuli when selecting target
stimuli with the shift key down seems to have been dealt with already in
the getStimulusForCurrentTrial method. Perhaps saskia is still using an
older version?

- added session.filename property to supplement the existing
session.label. The filename now goes to the window title even when a
session label is specified. i.e. the label is used for saccade
measurements when specified, but the chart window is always titled with
the name of the file that was opened. If the label is not explicitly
specified, then the filename is used in its place.

- changed the getCursorDisplayData and both measureSaccade methods to
use the same method (getLatencyAtFirstCursor) to get the latency to
remove inconsistencies with what was being displayed in real time and
what was measured discretely. The getLatencyAtFirstCursor method also
uses the getStimulusForCurrentTrial method to get this consistency.

- partly implemented highlighting stimulus which will be measured given
the current cursor position. But it takes a redraw to see updates. Need
to be able to move it along with the cursors, otherwise things will slow
down a lot. 

	**Compiled under RB 2008 R5.1 and released as version 3.1b4 for
Windows for Saskia to test**



**20-21 May 2009**

- added new method ('getNextStimulusNumberAheadOfCursor1') specifically
to identify the target of a memory-guided saccade.

- memory-guided stimulus amplitudes were not correct as in the
importing thread, amplitudes are worked out wrt the immediately
preceding target, which, being the flash in this case, has the same
position and hence leads to a zero amplitude. So this is now worked out
properly in the getStimulusForCurrentTrial method, as for latency, by
calculating with respect to the n-2 target.

- altered cursor modifier keys so that holding down control shifts the
cursors by 1/20th of the data range (was 1/15th) and shift by 1/100th
(was 1/60).

- as a compromise solution, implemented highlighting the stimulus by
pushing the 'x' key. This triggers a full redraw, so is quite slow. It
is transient in that the highlight will disappear on the next redraw,
but doesn't update with each cursor movement.

- fixed problem with trying to manually select a preceding or
succeeding stimulus: if the neighbouring stimulus was DisplayOnly, no
stimulus would be found. Now it keeps looping up or down as required
until the next real stimulus is found. 

	**Compiled under RB 2008 R5.1 and released as version 3.1 (non beta)
for Windows & OS X**


**26 May 2009**

- fixed bug in which the modifier keys (shift to go backwards, control
forwards) were being used correctly to identify the relevant stimulus
but were not being used to measure the latency correctly. The
chooseAdjoiningStimulus parameter needed to be sent to the
getLatencyAtFirstCursor method and the getCursorDisplayData method also
needed to check the current keyboard status so its values were up to
date also.

- added modifierKeyTimer to the chartWindow to poll the keyboard every
250 ms to see if the SHIFT or CONTROL modifier keys were pressed (as
they don't generate normal keydown events that can be handled by the
window). If so, then the cursor display data is updated immediately to
reflect what would happen if the saccade was measured with that modifier
in operation. Checks are made so that we don't keep needlessly sending
update messages. i.e. the data is updated only after either key is first
pushed and again after it is first released.

	**Compiled under RB 2008 R5.1 and released as version 3.1.1 for
Windows & OS X. Filename remained at 3.1 to not break existing
shortcuts.**


**28 May 2009**

- fixed error in iViewSet.getLatencyAtFirstCursor method such that
invalid latencies were reported as -100 ms (i.e. -99.99 ms rounded). Are
now reported as -99999 ms.

	**Compiled under RB 2008 R5.1 and released as version 3.1.2 for
Windows & OS X. Filename remained at 3.1 to not break existing
shortcuts.**

- fixed major and longstanding bug in which only the first set of data
within a session had its sample rate set correctly in the iViewParser
thread by reading from the value in the iView file header. Subsequent
ones did not have a sample rate set explicitly and so used a default
value of 240 Hz regardless of the actual value. This meant that 2nd and
subsequent sets of 1250 Hz data were filtered using the 240 Hz
Butterworth coefficients. In practice, this meant minimal visible change
to the data (i.e. it was still noisy but at least didn't appear to have
been made worse). Now, the default value has been removed, and each set
gets the actual session-wide sampling rate applied explicitly. This
means that all sets of 1250 Hz data are now properly filtered. **Files
analysed prior to this date will therefore have unreliable peak
velocities for sets which were not the first in that file.**Otherwise,
the data should be reasonably OK. Saskia's experiments focussing on
trajectory measurements are just beginning now and so should be measured
reliably.

- added info so that unrecognised SESSION and RESPONSE tags now
actually output the unrecognised value itself to the Console for
debugging purposes.

	**Compiled under RB 2008 R5.1 and released as version 3.1.3 for
Windows & OS X. Filename remained at 3.1 to not break existing
shortcuts.**


**10 June 2009**

- exporting movement profiles was buggy. Fixed the
iViewSet.getMovementProfiles method in particular to remove bugs and to
make it more capable (add the trial number in a column as well as the
set number). 


**02-04 Nov 2009**

- During importing, the CPU usage was low despite the length of time
taken to complete the operation. i.e. it appeared to be disk-bound
rather than CPU-bound. Amended the Run event of the iViewParserThread to
read the entire contents of an iView filestream into a single string
rather than using readLine to read it one line at a time from disk. The
string is then split into a one-dimensional array using the split
function so that lines can still be processed individually and
sequentially. This leads to a large speed increase (e.g. from 53s down
to 9s to read in one 1250 Hz file with one set). This improves only the
importing and parsing, not the subsequent filtering and velocity
calculation and plotting.

- Amended iViewSet.display method so that if the set is \>30s in
duration, plot only the first ten seconds on first display, to improve
apparent snappiness.  Also had to set the zoom factor accordingly.

- Added calculateXaxisTicks method to Chart class to provide values for
proper x axis tick marks (rather than only having a min and max value at
each end).

- Altered Chart.plotLineTraces method to draw the tickmarks and their
associated labels. 

- Also now draws circles to indicate individual sample values when
zoomed in to show a small amount of data. The duration of data depends
both on the sample rate and the width of the plot, so as not to make a
mess by plotting too many overlapping samples.

- Added two more levels of zoom to allow viewing very small time
periods. This can actually zoom in between samples for 240 Hz data.

- Added sampling rate to the info displayed via the user interface.

- Dragged in a .png version of the application icon to the project and
added an imageWell to the AboutWindow to display it.

- Fixed a bug (noticed by Saskia) in which 2D calibration couldn't be
reset when applied to all sets. There was only one Reset button in the
calibration window, and this was hardwired to only reset horizontal
calibration. Hence, multiple reset buttons were created, one for each of
horizontal, vertical, and 2D.

	**Compiled under RB 2008 R5.1 and released as version 3.2 for Windows
& OS X.**

 

**15 Dec 2009**

- Fixed (one line) bug noted by Sarah in which the set number recorded
when measuring saccades was always zero (only happened in 1D analysis).

	**Compiled under RB 2008 R5.1 and released as version 3.2.1 for
Windows & OS X.  Filename remained at 3.2 to not break existing
shortcuts.**


**03-04 Feb 2010**

- Beginning to implement ability to automatically re-measure saccades
from a re-attached measurement file

- shifted the session-level variables (sex, date, etc) added in
session.measure to the set.measure methods.

- added measureREDO() to session and set

- added autoRemeasurement = TRUE parameter to set.storeMeasurement()

- NB re-measured saccades need to access the human-added variables
such as comments added via the measurementWindow so extract these from
the existing measurement. Also check the stimulus that was selected.
i.e. can't assume that the automatically-chosen one was what the
operator wanted.  

- Noticed that the iView data file for some reason contains a large
number (\~250) of trailing spaces after the Subject, Description, and
Number of Samples parameters in the header. Now use RTrim to remove the
white space following the subject name, which was being propagated into
the Samara measurements and hence into the analysis files, causing
unexpected results.

- added global session.dataImportCompleted property to allow finer
grained control of menu handling

	**Not yet released. Need to test with Sarah's files**


**05 Feb 2010**

- Began to work on compatibility with new PsychoPy presentation of
routine tests. In particular, want to take advantage of PsychoPy's
internal specification of stimulus locations in angles rather than
pixels. So finally need to implement responding to the \<UNITS\> config
message. Changes made to iViewParserThread.extractInfoFromTgtXML() and
iViewParserThread.extractInfoFromConfigXML().

- removed some old code from iViewParserThread.


**26 May 2010**

- Compiled changes made over past few months to allow importing of new
PsychoPy-delivered standard saccade tasks for the large PD studies and
for routine clinical use (such as defining target amplitudes in degrees,
embedding a version string of the task in the config info, and so on). 
Also note work done in February to add re-measurement from previously
stored data.

	**Compiled under RB 2008 R5.1 and released as beta version 3.3b for
testing on Windows & OS X.**


**02 Jun 2010**

- When measuring saccades, the filename is used as a session label for
each measurement, but can be overridden if an alternative \<name\> tag
is sent in the \<config\> message.  Previously, the \<name\> tag was
never actually used, however.  Now that it is, needed to insert a check
to see if it is blank.  If so, the filename remains as the the label for
the session.

	**Compiled under RB 2008 R5.1 and released as beta version 3.3.1b for
testing on Windows & OS X.**

 
**16 Jun 2010**

- In the measurementWindow, sometimes it is useful to have comments
persist from one measurement to the next so the same comment doesn't
need to be retyped each time. Often that may be annoying.  So now the
user can control that behaviour via a new checkBox, which defaults to
FALSE.

- Now correctly calculate latency in response to a stimulus in the
Delay task (previously, was measured from the visual onset of the
target, and did not take into account the delay value (i.e. the latency
produced previously was the actual latency PLUS the delay value).

- Now include the Samara version string in the set of saccade
measurements. 

- Display of discontinuities improved by not plotting connections to
data points in the 1D traces that would have values outside the plot
limits (extra check in Chart.plotLineTraces method).  Need a more
systematic way to do this by cycling forwards and backwards from invalid
data points and invalidating more neighbours.  Can't easily do this at
the import stage, as can only easily mark preceding samples as invalid.


**25 Jun 2010**

- added an explicit default red colour for a target if none is
specified.

- 21 variables in 1D analysis were incorrect using the current "Redo"
measurement feature. 

- Resolved latency and duration by dividing times by 1000 to correctly
use seconds rather than milliseconds for cursor time.

- Resolved cursor 3-6 latencies by measuring relative to stimulus
rather than first cursor

- Remaining errors were due to directly setting the .t attribute of the
cursors and not setting the required .n attribute, so cursors weren't
actually correctly associated with their corresponding data sample by
index. Needed to create new methods getNearestSampleToTime() and
matchCursorToTime() in order to work from a desired time value to the
needed sample index number.


**28 Jun 2010**

- Now allows iViewSets to have a test type of 'Delayed'.  For
measurement purposes, these should be treated in the same way as
prosaccade tests (but the delay value is taken into account on a
trial-by-trial basis).  But it can be useful at the statistical analysis
stage for these to be distinguished from prosaccade tests by a way other
than the DElay value column. 

	**Compiled under RB 2008 R5.1 and released as version 3.3.2 for
Windows & OS X (applications named simply 3.3).**

	**NB this release alters the exported saccade data format by
inserting two extra columns (the Samara version used and the test file
protocol used), before all other data columns, which remain the same.**


**29 Jul 2010**

- Changed the default, hard-coded, data components displayed for
binocular data: it isn't hooked up properly to the menu items for
displaying components like standard monocular recordings.


**04 Aug 2010**

- Begin adding ability to interpret smooth pursuit stimulus information

- added PursuitStimulus class


**04 Jan 2013**

- Added a 200 Hz filter to allow velocity calculation for data from the
new HED system being used by Eng. NB the velocity information itself
isn’t very meaningful as there is not a fixed eye/screen distance in his
study, but some sort of velocity data is necessary to allow automatic
saccade onset detection. 

	**Compiled under RB 2008 R5.1 and released as version 3.3.3 for
Windows & OS X.**



4 Feb 2010

Saskia suggested being able to enter calibration points from multiple
sets into one post-hoc calibration window. I thought at first of being
able to type in values but that would be messy. Perhaps the thing to do
is simply to shift the calibration instance from being one per set to
being one per session (that is probably how users think of it anyway.
Would still be able to choose to apply to just the current set or to all
sets in the session. 


Oct 19 2009:

- Toni pointed out that Delay trial latencies do not take into account
the Delay period. i.e. the latency is measured from current stimulus
onset rather than previous stimulus offset (the line connecting the
stimuli is drawn correctly on screen however). 

Need to make the code in getLatencyAtFirstCursor consistent with that in
chart.plotLineTraces:

        if stimuli(i).value("delay") \> 0.0 then

          t3 = stimuli(i).value("onsetTime") + stimuli(i).value("delay")
// a delay, so draw the connecting line to the end of the delay period

        else

          t3 = stimuli(i).value("onsetTime")  // connect to the time at
which the target appeared (i.e. gap, standard, or overlap target)

        end if



Saccade detection:

iLab saccade identification algorithm is based on

Fischer, B., Biscaldi, M., and Otto, P.1993. Saccadic eye movements of
dyslexic adults. Neuropsychologia, Vol. 31, No 9, pp. 887-906.I
elaborate on it a bit more in my paper: Gitelman, D.R., 2002. ILAB: a
program for postexperimental eye movement analysis. Behavior Research
Methods, Instruments & Computers 34, 605-612.

Also consider adding SMI constraint, something like the peak velocity
occurring between 20% and 80% of the saccade duration.



**- get Sarah's bug file and report from e-mail**

**MGS task for Charlotte: the end of the stimulus and the offset msg can
disagree by 20 ms or so. Need to search for an offset msg within a short
time window of a stimulus end and use that to calculate **

**- add SMI constraint to saccade detection on timing of peak velocity
relative to duration**

- need to add more info to the movement profile export, including
session label, stimulus amplitude (and direction for 2D analyses).


more stimulus info (e.g. vy, simulus y) has been added to iView trace
exports, but the routine is now very slow and inefficient, esp with 1250
Hz data.  Perhaps at least in part due to each stimulus being queried at
every sample for its x and y values, rather than more intelligently just
getting the values once and determining their duration.



to implement:

check
http://dokuwiki.vanderveer.org.nz/doku.php?id=samara\_release\_notes for
other points.


 

- should label the manual calibration window so it is clear which set
window it is associated with.

-  make the stimulus a proper class in preparation for adding SP
stimuli.  May need to add a 'getvalueforkey' type method to the class to
allow it to have dictionary-type functions which is inherent to a lot of
its functionality.  Do the later versions of RB implement some kind of
introspection that would allow this?  Fixed/Implemented in version
2008r1b1

- in the plotData method if the chart class, change the multiple,
repeated, complicated equations for plotting points to a method with
parameters, using properties for the fixed values where possible

  Then set the cursors for each set where they were applied.  Note that
this makes sense for only the first movement in each set?  Perhaps need
a way of stepping through each measured movement for when there are
multiple movements within each set.

- allow selection of left/right/both eye data via the UI

- make code robust to attempting to display binocular data from
monocular set.

- calculate velocities of both eyes from binocular data

- implement ability for user to set velocity thresholds.

- go through each class and search for calls to each method to find out
which are private and mark them accordingly.  At the moment this is done
only haphazardly.  Being more systematic would make each class' API more
apparent.  Currently done for iViewSet and iViewSession.

- the "View" menu settings (which components to show) need to apply
globally for any open and any subsequently imported sessions, rather
than just the current one.

 
**NB** the code in data.measureSaccade needs to be updated so that it
doesn't use a constant to interpret self paced stimuli but instead
properly responds to the Experimenter XML messages.


- the Save menuitem currently just works as another save as.. (i.e. it
doesn't retain a folderitem for appending to).  Note that the menu
enabling does work correctly.  i.e. Save As... is always enabled if
there is data, whereas Save is enabled only if there are unsaved
changes.

 
**BUGS:**

- The right and left arrow keys alone move the screen by half a screen.
This happens after pressing enter to take measurements of a movement,
then pressing the “cancel” button. 08/09/06

- The “post hoc calibration” window disappears if I minimize it. I have
to press the Y key twice to reopen the window. 08/09/006

- Opening the “post hoc calibration” window changes the size of the
session window. 08/09/06

 
**Would be good to add**a main sequence facility.  Build in some normal
ranges and plot the currently measured velocities and amplitudes against
that.

 
**NB by adding some functions to menus, it may be possible to remove
them from the keydown event of the window and let the menu shortcuts
handle them.**


Manual calibration: need to document the correspondence between
interface values and the actual values applied to the data in the
situation where the window is opened another time.  The behaviour is the
same as EMMA: subsequent factors are applied to the re-calibrated data,
not the raw stuff.  You can use the "restore" button to go back to the
raw data.


Previously:

The chart class draws into a picture property.  The iViewSet class
accesses that property directly (BAD DESIGN), adds objects to it (e.g.
cursors) and returns it to the iViewSession.  The iViewSession sends
that picture to the chartCanvas for display.


What should happen : 

The iViewSession displaySet method is sent two parameters, recalculate
and print = false.    When printing, recalculate must always be true. A
graphics object comes either either from a printer or a picture held by
the iViewSession (actually it now holds an array of pictures, one for
each set.  This array is initially populated with NILs each time a set
is added to the session).  The first time each set is displayed, and
each time the display for that set needs to be recalculated, a new
picture is created in the array entry corresponding to that set.  That
picture is also sent to the chartCanvas.  If recalculate is true then
the graphics is sent on to the iViewSet display method.  This method
will now need only component() and resolution parameters, as recalculate
must be true and width and height can be derived from the graphics.  The
iViewSet implements a separate method which returns vector objects
(cursors etc) rather than adding them to the currently returned
picture.  The iViewSet display method sends the graphics to the chart
plotData method in place of the width and height parameters.  It then
returns the drawn-into graphics to the iViewSession, which either sends
the graphics to the printer, or the picture to the chartCanvas.    


Do we need to also remove session property of the HDF parser, i.e. make
it a local variable as per the iView thread.


The iView code is not robust to importing only 1D data. (Is it even
possible to get only 1D data?)  


Will also need to implement filtering for 50/60 Hz eye tracking from MRI
system.


NB removing the progressWindow sheet means we no longer have a way to
stop the importing once under way.  Need to institute some checks as to
what will happen if the chartWindow is closed while the importing thread
is still running: at present this causes an exception.


**NB: HDF5 file opening will fail not only if there are spaces or other
'odd' characters in the filename, but even if they are in the
PATHNAME!**

 

**To do:**

#### See the Dokuwiki page**

- Allow just a selection of a trace to be exported rather than the
entire set.

- add a menu item for the trace export function. 







