#tag ModuleModule MM_HDF5_methods	#tag Method, Flags = &h0		Function MMGetDimensionsOfDataSpace(dataSpaceID as integer, numDimensions as integer = 3) As integer()		  dim dimensions(), status, i, j as integer		  dim dimensionsMB, maxDimensionsMB, tempMB as memoryBlock		  		  // This function simplifies things for the calling code by returning the dimensions of a dataspace		  // directly in an array rather than in a memoryblock.  Instead the memoryBlock is constructed,		  // passed and parsed here.		  // to use this method, you must pass in the handle of a dataSpace.  This is achieved by doing		  // something like the following before calling this method:		  // dataSetID = H5Dopen(fileID, "/trial_0001/data")		  // dataSpaceID = H5Dget_space(dataSetID)		  // You also need to pass in the number of dimensions.  This seems to be 3 even for single values		  // (i.e. 1x1x1), so we can probably just go with the default value of 3.  If not, you can obtain the		  // number of dimensions from the H5Sget_simple_extent_ndims function.		  		  #if TargetPowerPC then		    // this is the memoryBlock which will be returned containing the dataSpace dimensions:		    dimensionsMB = newMemoryBlock(numDimensions*8)		    // this will also be returned but can be ignored:		    maxDimensionsMB = newMemoryBlock(numDimensions*8)		    		    // get the dimensions:		    status = H5Sget_simple_extent_dims(dataSpaceID, dimensionsMB, maxDimensionsMB)		    // dimensionsMB is returned containing 8 bytes per dimension.  Ignore the first four bytes		    // (seem to be empty) and get a long integer from the remaining four bytes:		    		    redim dimensions(numDimensions)		    for i = 0 to numDimensions-1		      dimensions(i) = dimensionsMB.long(i*8 + 4)  // ie a long starting at bytes 4, 12, 20, ...		      'system.debugLog "MM_HDF5_methods module MMGetDimensionsOfDataSpace: " + str(dimensions(i))		    next		    		  #else		    		    // this is the memoryBlock which will be returned containing the dataSpace dimensions:		    dimensionsMB = newMemoryBlock(numDimensions*8)		    dimensionsMB.littleEndian = false		    // this will also be returned but can be ignored:		    maxDimensionsMB = newMemoryBlock(numDimensions*8)		    maxDimensionsMB.littleEndian = false		    tempMB = newMemoryBlock(8)		    tempMB.littleEndian = false		    // get the dimensions:		    status = H5Sget_simple_extent_dims(dataSpaceID, dimensionsMB, maxDimensionsMB)		    // dimensionsMB is returned containing 8 bytes per dimension.  Ignore the first four bytes		    // (seem to be empty) and get a long integer from the remaining four bytes:		    redim dimensions(numDimensions)		    for i = 0 to numDimensions-1		      for j = 0 to 7		        tempMB.byte(j)= dimensionsMB.byte(i*8+7-j)		      next		      dimensions(i) = tempMB.UInt32Value(4)  // ie a long starting at bytes 4, 12, 20, ...		      gLog "MM_HDF5_methods module MMGetDimensionsOfDataSpace: " + str(dimensions(i))		    next		    //gLog "MMGetDimensions:" + str(dimensions)		    		  #endif		  		  return dimensions		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function MMGetSolitaryDouble(file_ID as integer, dataSetName as string) As single		  dim status, i as integer		  dim tempMem as memoryBlock		  		  // this function is used as a short cut for calling the H5LTread_dataset_float to get a value from a dataset consisting		  // of a solitary float value.  This saves the calling code the hassle of creating a memory block and then reading from it		  // to get the desired value.  Instead, it is returned directly from this function.		  // When the dataset is a different size, you need to create an appropriate sized memory block and call H5LTread_dataset_float		  // and read the values from the returned memoryblock.		  		  tempMem = newMemoryBlock(8)		  status = H5LTread_dataset_double(file_ID, dataSetName, tempMem)		  return tempMem.doubleValue(0)		  		  		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function MMGetSolitaryFloat(file_ID as integer, dataSetName as string) As single		  dim status, i as integer		  dim tempMem as memoryBlock		  		  // this function is used as a short cut for calling the H5LTread_dataset_float to get a value from a dataset consisting		  // of a solitary float value.  This saves the calling code the hassle of creating a memory block and then reading from it		  // to get the desired value.  Instead, it is returned directly from this function.		  // When the dataset is a different size, you need to create an appropriate sized memory block and call H5LTread_dataset_float		  // and read the values from the returned memoryblock.		  		  tempMem = newMemoryBlock(4)		  status = H5LTread_dataset_float(file_ID, dataSetName, tempMem)		  return tempMem.singleValue(0)		  		  		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function MMGetStringAttribute(loc_id as integer, objectName as string, attributeName as string) As string		  dim status, i as integer		  dim memoryBlockSize as integer = 96		  dim tempMem as memoryBlock		  dim tempStr as string		  		  // this function is used as a short cut for calling H5LTget_attribute_string to get a a string attribute from a dataset		  // This saves the calling code the hassle of creating a memory block and then reading from it		  // to get the desired value.  Instead, it is returned directly from this function.		  		  		  tempMem = newMemoryBlock(memoryBlockSize)		  status = H5LTget_attribute_string(loc_id, objectName, attributeName, tempMem)		  		  if status < 0 then		    tempStr = ""		  else		    // OK, here I am lazy.  Instead of calling an HDF Lite function to get the length of the string attribute in advance,		    // I just send a large memoryBlock and then search through it to find the first zero value, which marks the end of the string:		    for i = 0 to memoryBlockSize - 1		      if tempMem.byte(i) = 0 then exit		    next		    		    tempStr = tempMem.stringValue(0, i)		  end if		  		  gLog "MMGetStringAttibute:" + tempStr		  		  return tempStr		  		  		  		End Function	#tag EndMethod	#tag Note, Name = About		This module contains globally acessible methods which provide certain functions such as getting the size of a given dataset.  It requires the 		HDF5_declare_wrappers module to provide access to the HDF libraries.	#tag EndNote	#tag ViewBehavior		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="2147483648"			Type="Integer"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			Type="String"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			Type="String"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Module#tag EndModule