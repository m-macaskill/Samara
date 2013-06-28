#tag ClassClass DataTraceForExport	#tag Method, Flags = &h0		Sub addDataColumn(columnLabel as string, data() as variant)		  dim i, numberOfRows, numberOfColumns as integer		  		  mColumnTitles.append columnLabel  // store the description of this column of data (eg 'Time (s)')		  		  numberOfColumns = uBound(mColumnTitles)		  numberOfRows = uBound(data)		  redim mDataTraceArray(numberOfRows, numberOfColumns)  // assumes that each passed column will have the same number of rows.		  		  for i = 0 to numberOfRows  // cycle through the passed values, adding them to the stored array		    mDataTraceArray(i, numberOfColumns) = data(i)		  next		  		  'gLog "adding column " + columnLabel + str(columnNumber)		  		exception err		  gHandleException err, "addDataColumn method of dataTraceForExport class."		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function saveToTextFile(askUserForFilename as boolean, autoFilename as string = "", autoSaveLocation as folderItem = nil) As boolean		  // Exports the data traces to a text file as an array with column headings		  // returns true if succesful, false if failed or cancelled.		  		  // This method may be used to automatically save traces to files, in which case askUserForFilename is false.		  // In that case, a filename and a folder location for saving must also be passed in.		  		  // If the user has asked to save the file, then present a save dialog box to get that information manually.		  		  		  dim dlg as saveAsDialog		  dim file as folderItem		  dim exportThread as dataTraceExportingThread		  		  		  select case askUserForFilename		    		  case true  // ask the user where to put the file		    dlg = new saveAsDialog		    dlg.promptText="Choose where to save this movement trace text file."		    dlg.suggestedFileName= "Movement traces.txt"		    dlg.title = "Save movement trace data"		    dlg.filter = "application/text"		    file = dlg.ShowModal		    if file = nil then		      return false		    end if		    		  case false  // the calling method knows where to put the file and what to call it.		    if autoSaveLocation.child(autoFilename).exists then // hopefully this means that if there is an existing file with this name, append to it.		      file = autoSaveLocation.child(autoFilename)		    else  // if it doesn't exist, create it.		      file = new folderItem(autoSaveLocation.child(autoFilename))		      file.name = autoFilename		    end if		    		  end		  		  exportThread = new dataTraceExportingThread(self, file, mDataTraceArray, mColumnTitles)		  exportThread.run		  		exception err		  gHandleException err, "saveToTextFile method of dataTraceForExport class."		End Function	#tag EndMethod	#tag Note, Name = About		This class provides an object whereby the iViewSet class can provide a simple array of position and time values and stimulus positions		for purposes such as exporting to a text file for graphing or analysis by other software.				The iViewSet object exports either its entire contents (ie the traces of an entire iViewSet) or just a selection.		It does this by successive calls to the addDataColumn method, sending the label for a given column (eg 'Time (s)')		and 1D array containing the corresponding values.	#tag EndNote	#tag Property, Flags = &h1		#tag Note			Holds the label for each column of data represented in the mDataTraceArray property		#tag EndNote		Protected mColumnTitles() As string	#tag EndProperty	#tag Property, Flags = &h1		#tag Note			Holds the data.  Each row represents a sample.  Each column represents a particular variable			(eg t,x, y, z, ...).  A label containing a description of each column's contents is held in the			corresponding entry in the mColumnTitles array.		#tag EndNote		Protected mDataTraceArray(0,0) As variant	#tag EndPropertyEnd Class#tag EndClass