#tag ClassClass GraphCanvasInherits canvas	#tag Event		Sub Open()		  mPicture = newPicture(me.width, me.height, 32)		End Sub	#tag EndEvent	#tag Event		Sub Paint(g As Graphics, areas() As REALbasic.Rect)		  g.drawPicture(mPicture, 0, 0, self.width, self.height)		End Sub	#tag EndEvent	#tag Method, Flags = &h1		Protected Function hPixel(x as double) As double		  // convert an x coordinate into a pixel value for plotting		  return x * mScaleFactorX + mOriginPixelX		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub plotPoints(enabledPoints() as boolean, data() as dataPoint, stimuli() as stimulus, parameters() as dictionary, component as integer, highlightedPoints() as boolean)		  // NB the data passed in is 1-based		  		  dim width, height, upperBound, currrentPoint, i as integer		  dim x, y, x1, y1, slope, intercept, negAxisLimit, gridIncrement as double		  dim symbolWidth as double = 9		  dim g as graphics		  		  		  g = mPicture.graphics		  width = g.width-1  // subtract 1 so that the final grid line is drawn		  height = g.height-1		  mOriginPixelX = width/2		  mOriginPixelY = height/2		  mScaleFactorX = mOriginPixelX/mAxisLimit		  mScaleFactorY = mOriginPixelY/mAxisLimit		  		  if component <> 2 then		    slope = parameters(component).value("Slope")		    intercept = parameters(component).value("Intercept")		  end if		  		  // clear the previous drawing		  g.ClearRect 0, 0, width, height		  		  // draw grid		  g.foreColor = &cAAAAAA		  negAxisLimit = -1 * mAxisLimit		  gridIncrement = mAxisLimit / 4		  		  for i = negAxisLimit to mAxisLimit step gridIncrement		    g.drawLine(hPixel(i), vPixel(mAxisLimit), hPixel(i), vPixel(negAxisLimit))		    g.drawLine(hPixel(mAxisLimit), vPixel(i), hPixel(negAxisLimit), vPixel(i))		  next		  		  		  		  // draw x and y axes		  g.foreColor = &c000000		  g.drawLine(mOriginPixelX, vPixel(mAxisLimit), mOriginPixelX, vPixel(negAxisLimit))		  g.drawLine(hPixel(mAxisLimit), mOriginPixelY, hPixel(negAxisLimit), mOriginPixelY)		  		  if component <> 2 then		    // draw line y = x (make pen width smaller as drawing obliquely).		    g.drawLine(hPixel(mAxisLimit), vPixel(mAxisLimit), hPixel(negAxisLimit), vPixel(negAxisLimit))		    		    // draw regression line		    g.foreColor = &cFF0000		    g.drawLine(hPixel(mAxisLimit), vPixel(mAxisLimit * slope + intercept), hPixel(negAxisLimit), vPixel(negAxisLimit  * slope + intercept))		    		  end if		  		  upperBound = uBound(data)		  		  for currrentPoint = 1 to upperBound		    		    select case component		      		    case 0 // horizontal		      x = hPixel(stimuli(currrentPoint).value("x"))		      y = vPixel(data(currrentPoint).x)		      		    case 1  // vertical		      x = hPixel(stimuli(currrentPoint).value("y"))		      y = vPixel(data(currrentPoint).y)		      		    case 2 // 2D		      x = hPixel(stimuli(currrentPoint).value("x")) // stimulus coordinates		      y = vPixel(stimuli(currrentPoint).value("y"))		      x1 = hPixel(data(currrentPoint).x)  // datapoint coordinates		      y1 = vPixel(data(currrentPoint).y)		      		    end select		    		    // draw points in blue to indicate that they are being used in the calculation:		    if enabledPoints(currrentPoint) then		      g.foreColor = &c0000AA		    else		      g.foreColor = &cAAAA00		    end if		    		    // draw a circle		    g.drawOval(x-symbolWidth/2, y-symbolWidth/2, symbolWidth, symbolWidth)		    		    // for 2D data only, draw a line indicating the deviation of the data point from its associated stimulus position		    if component = 2 then		      g.drawLine(x, y, x1, y1)		    end if		    		    // draw a highlight ring around any selected points		    if highlightedPoints(currrentPoint) then		      g.foreColor = &cAA00AA		      g.drawOval(x-(symbolWidth+6)/2, y-(symbolWidth+6)/2, symbolWidth+6, symbolWidth+6)		    end if		    		    		  next		  		  		  me.refresh(false)		  		exception err		  gHandleException err, "plotPoints method of GraphCanvas class."		  		  		  		  		  		  		  		End Sub	#tag EndMethod	#tag Method, Flags = &h1		Protected Function vPixel(y as double) As double		  // convert a y coordinate into a pixel value for plotting		  return mOriginPixelY - (y * mScaleFactorY)		End Function	#tag EndMethod	#tag Property, Flags = &h0		mAxisLimit As double = 20.0	#tag EndProperty	#tag Property, Flags = &h1		Protected mOriginPixelX As double	#tag EndProperty	#tag Property, Flags = &h1		Protected mOriginPixelY As double	#tag EndProperty	#tag Property, Flags = &h1		Protected mPicture As picture	#tag EndProperty	#tag Property, Flags = &h1		Protected mScaleFactorX As double	#tag EndProperty	#tag Property, Flags = &h1		Protected mScaleFactorY As double	#tag EndProperty	#tag ViewBehavior		#tag ViewProperty			Name="AcceptFocus"			Visible=true			Group="Behavior"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="AcceptTabs"			Visible=true			Group="Behavior"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="AutoDeactivate"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Backdrop"			Visible=true			Group="Appearance"			Type="Picture"			EditorType="Picture"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="DoubleBuffer"			Visible=true			Group="Behavior"			InitialValue="False"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Enabled"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="EraseBackground"			Visible=true			Group="Behavior"			InitialValue="True"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Height"			Visible=true			Group="Position"			InitialValue="100"			Type="Integer"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="HelpTag"			Visible=true			Group="Appearance"			Type="String"			EditorType="MultiLineEditor"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			Type="Integer"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="InitialParent"			Type="String"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			Type="Integer"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockBottom"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockLeft"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockRight"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockTop"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="mAxisLimit"			Group="Behavior"			InitialValue="20.0"			Type="double"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			Type="String"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			Type="String"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabIndex"			Visible=true			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabPanelIndex"			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabStop"			Visible=true			Group="Position"			InitialValue="True"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			Type="Integer"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Transparent"			Visible=true			Group="Behavior"			InitialValue="True"			Type="Boolean"			EditorType="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="UseFocusRing"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Visible"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Width"			Visible=true			Group="Position"			InitialValue="100"			Type="Integer"			InheritedFrom="canvas"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass