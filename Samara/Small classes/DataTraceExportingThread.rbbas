#tag ClassClass DataTraceExportingThreadInherits Thread	#tag Event		Sub Run()		  // this thread exists so that movement traces can be exported in the background		  		  dim dataToString as string		  dim row, column, numberOfRows, numberOfColumns as integer		  dim tab, EOLChar as string		  dim fileStream as textOutputStream		  		  'gLog " dataTraceExportingThread beginning"		  		  		  tab = chr(9)  // a tab character to separate fields		  EOLChar = endOfLine  // the end of line sequence for the platform being compiled for, to separate rows.		  numberOfRows = uBound(mDataTraceArray, 1)		  numberOfColumns = uBound(mDataTraceArray, 2)		  		  if mFile.exists then		    fileStream = mFile.appendToTextFile		  else		    fileStream = mFile.createTextFile  // create file		    // create a single string which contains the data values, beginning with a row of string values labelling each column		    for column = 0 to numberOfColumns		      dataToString = dataToString + mColumnTitles(column) + tab  // create a row of data		    next		    dataToString = dataToString + EOLChar  // terminate the row		  end if		  		  		  // write each row of data.		  // NB the method of writing each row to disk is immensely faster than continually appending rows to a string and then writing that single		  // huge string in one write call.  Presumably this is due to the immutable nature of strings: a new one has to be created each time rather		  // than just appending to the existing one.  This begins to take a long time with large string sizes, growing non-linearly with increasing number		  // of rows.		  		  for row = 0 to numberOfRows		    for column = 0 to numberOfColumns		      dataToString = dataToString + str(mDataTraceArray(row, column)) + tab  // create a row of data		    next		    fileStream.write(dataToString + EOLChar)  //write this row		    dataToString = ""		  next		  		  fileStream.close		  		  'gLog " dataTraceExportingThread ending"		  		  // clean up circluar references		  mCallingInstance = nil		  mFile = nil		  mDataTraceArray = nil		  mColumnTitles = nil		  		exception err		  gHandleException err, "run event of dataTraceExportingThread class."		End Sub	#tag EndEvent	#tag Method, Flags = &h0		Sub Constructor(callingInstance as dataTraceForExport, file as folderItem, byref dataTraceArray(,) as variant, byref columnTitles() as string)		  // get refernces to some properties of the calling dataTraceForExport object		  mCallingInstance = callingInstance		  mFile = file		  mDataTraceArray = dataTraceArray		  mColumnTitles = columnTitles		End Sub	#tag EndMethod	#tag Note, Name = About		This thread is instantiated by a DataTraceForExport instance when that instance wants to export its data to a file.		THat instance passes a reference to itself and to the destination file in the thread constructor	#tag EndNote	#tag Property, Flags = &h1		#tag Note			Gives a reference back to the calling object (a DataTraceForExport instance), set in the constructor.  Set to nil at the end of the run event		#tag EndNote		Protected mCallingInstance As dataTraceForExport	#tag EndProperty	#tag Property, Flags = &h1		#tag Note			a reference to the columnTitles of mCallingInstance		#tag EndNote		Protected mColumnTitles() As string	#tag EndProperty	#tag Property, Flags = &h1		#tag Note			a reference to the dataTraceArray property of mCallingInstance		#tag EndNote		Protected mDataTraceArray(0,0) As variant	#tag EndProperty	#tag Property, Flags = &h1		#tag Note			The file to which the data will be written.  Set by the calling code in the constructor.  Set to nil at the end of the run event		#tag EndNote		Protected mFile As folderItem	#tag EndPropertyEnd Class#tag EndClass