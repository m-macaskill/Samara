#tag ClassClass OxMVector3	#tag Method, Flags = &h0		Sub Add(v As OxMVector3)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Adds in place		  		  X = X+v.X		  Y = Y+v.Y		  Z = Z+v.Z		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function Angle(v As OxMVector3) As Double		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Returns the angle in radians between self and 'v'		  		  Dim a As Double = ( (X*v.X) + (Y*v.Y) + (Z*v.Z) )		  Dim b As Double = ( Sqrt((X*X)+(Y*Y)+(Z*Z)) * Sqrt((v.X*v.X)+(v.Y*v.Y)+(v.Z*v.Z)) )		  		  if b = 0.0 then return 0.0		  		  return ACos(a/b)		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function AngleInDegreesFromXaxis() As Double		  // added by Michael MacAskill 07 Oct 2008 for convenience		  // initially just converted the radian value into degrees.		  // but it now also does a Samara-specific check: if the y component of self is negative,		  // then the angle is subtracted from 360. This is because the standard vector maths		  // just returns the acute angle between the vectors. It doesn't return anything larger than 180 deg		  // downwards target movements should be seen as > 180 deg from the x axis. e.g. a pure		  // downward movement should return 270 deg. The standard angle method would return 90 deg		  // and hence not distinguish between pure upward and pure downward movements.		  		  		  'return self.angle(v)*180.0/3.14159265358979323846264338327950		  		  dim theAngle as double		  const pi = 3.14159265358979323846264338327950		  dim xAxis as oXMVector3		  		  		  xAxis = new OxMVector3(1,0,0) // define the reference axis		  theAngle = self.angle(xAxis) // the acute angle between this vector and the x axis, in radians		  if self.Y < 0 then theAngle = (2*pi) - theAngle // make it a reflex angle if required		  		  return theAngle * 180.0/pi  // return the value in degrees.		  		  		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor()		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor(vx As Double, vy As Double, vz As Double)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  SetVector(vx, vy, vz)		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor(v As OxMVector3)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  Copy(v)		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Copy(v As OxMVector3)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  X = v.X		  Y = v.Y		  Z = v.Z		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Cross(v As OxMVector3)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Performs a cross product in place		  Dim tx, ty, tz As Double		  		  tx = (Y*v.Z)-(Z*v.Y)		  ty = (Z*v.X)-(X*v.Z)		  tz = (X*v.Y)-(Y*v.X)		  		  X = tx		  Y = ty		  Z = tz		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function CrossProduct(v As OxMVector3) As OxMVector3		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  return New OxMVector3( ((Y*v.Z)-(Z*v.Y)), ((Z*v.X)-(X*v.Z)), ((X*v.Y)-(Y*v.X)) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Distance(v As OxMVector3) As Double		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  return Sqrt( (v.X-X)*(v.X-X) + (v.Y-Y)*(v.Y-Y) + (v.Z-Z)*(v.Z-Z) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function DistanceSquared(v As OxMVector3) As Double		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  return ( (v.X-X)*(v.X-X) + (v.Y-Y)*(v.Y-Y) + (v.Z-Z)*(v.Z-Z) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Divide(scalar As Double)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Divides in place		  		  if scalar = 0.0 then return		  		  X = X/scalar		  Y = Y/scalar		  Z = Z/scalar		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function DotProduct(v As OxMVector3) As Double		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  return ( (X*v.X) + (Y*v.Y) + (Z*v.Z) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Equals(v As OxMVector3) As Boolean		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Checks for equality between self and 'v'		  ' Don't use Operator_Compare since < and > aren't much use here		  		  return ( (X = v.X) AND (Y = v.Y) AND (Z = v.Z) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Length() As Double		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  Return Sqrt( (X*X) + (Y*Y) + (Z*Z) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function LengthSquared() As Double		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  Return ( (X*X) + (Y*Y) + (Z*Z) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Multiply(scalar As Double)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Multiply in place		  		  X = X*scalar		  Y = Y*scalar		  Z = Z*scalar		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Normalize()		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Sets length to 1.0 (unit vector)		  		  Dim mag As Double		  		  mag = (X*X) + (Y*Y) + (Z*Z)		  if mag = 0.0 then return		  mag = Sqrt(mag)		  		  X = X/mag		  Y = Y/mag		  Z = Z/mag		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function Operator_Add(v As OxMVector3) As OxMVector3		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' vec = vec1 + vec2		  		  Return New OxMVector3( (X+v.X), (Y+v.Y), (Z+v.Z) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Operator_Divide(scalar As Double) As OxMVector3		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' vec = vec1 / n		  		  if scalar = 0.0 then Return New OxMVector3		  		  Return New OxMVector3( (X/scalar), (Y/scalar), (Z/scalar) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Operator_Multiply(scalar As Double) As OxMVector3		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' vec = vec1 * n		  		  Return New OxMVector3( (X*scalar), (Y*scalar), (Z*scalar) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Operator_MultiplyRight(scalar As Double) As OxMVector3		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' vec = n * vec1		  		  Return New OxMVector3( (X*scalar), (Y*scalar), (Z*scalar) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Operator_Subtract(v As OxMVector3) As OxMVector3		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' vec = vec1 - vec2		  		  Return New OxMVector3( (X-v.X), (Y-v.Y), (Z-v.Z) )		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Origin()		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Set to origin		  		  X = 0.0		  Y = 0.0		  Z = 0.0		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Rotate(q As OxMQuaternion)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Rotate this vector around a quaternion		  		  Dim tw, tx, ty, tz As Double		  		  ' Multiply quaternion with vector		  tx = ( (q.W*X) + (q.Y*Z) - (q.Z*Y) )		  ty = ( (q.W*Y) + (q.Z*X) - (q.X*Z) )		  tz = ( (q.W*Z) + (q.X*Y) - (q.Y*X) )		  tw = ( (q.X*X) + (q.Y*Y) + (q.Z*Z) )		  		  ' Multiply result by inverse of q		  X = ( (tw*q.X) + (tx*q.W) - ((ty*q.Z) - (tz*q.Y)) )		  Y = ( (tw*q.Y) + (ty*q.W) + ((tx*q.Z) - (tz*q.X)) )		  Z = ( (tw*q.Z) + (tz*q.W) - ((tx*q.Y) - (ty*q.X)) )		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetRotate(vX As Double, vY As Double, vZ As Double, q As OxMQuaternion)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Rotate the vector described by the v* params around q and store the result in this vector.		  		  Dim tw, tx, ty, tz As Double		  		  ' Multiply quaternion with vector		  tx = ( (q.W*vX) + (q.Y*vZ) - (q.Z*vY) )		  ty = ( (q.W*vY) + (q.Z*vX) - (q.X*vZ) )		  tz = ( (q.W*vZ) + (q.X*vY) - (q.Y*vX) )		  tw = ( (q.X*vX) + (q.Y*vY) + (q.Z*vZ) )		  		  ' Multiply result by inverse of q		  X = ( (tw*q.X) + (tx*q.W) - ((ty*q.Z) - (tz*q.Y)) )		  Y = ( (tw*q.Y) + (ty*q.W) + ((tx*q.Z) - (tz*q.X)) )		  Z = ( (tw*q.Z) + (tz*q.W) - ((tx*q.Y) - (ty*q.X)) )		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetRotate(v As OxMVector3, q As OxMQuaternion)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Rotate v around q and store the result in this vector.		  		  Dim tw, tx, ty, tz As Double		  		  ' Multiply quaternion with vector		  tx = ( (q.W*v.X) + (q.Y*v.Z) - (q.Z*v.Y) )		  ty = ( (q.W*v.Y) + (q.Z*v.X) - (q.X*v.Z) )		  tz = ( (q.W*v.Z) + (q.X*v.Y) - (q.Y*v.X) )		  tw = ( (q.X*v.X) + (q.Y*v.Y) + (q.Z*v.Z) )		  		  ' Multiply result by inverse of q		  X = ( (tw*q.X) + (tx*q.W) - ((ty*q.Z) - (tz*q.Y)) )		  Y = ( (tw*q.Y) + (ty*q.W) + ((tx*q.Z) - (tz*q.X)) )		  Z = ( (tw*q.Z) + (tz*q.W) - ((tx*q.Y) - (ty*q.X)) )		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetVector(vx As Double, vy As Double, vz As Double)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  X = vx		  Y = vy		  Z = vz		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Subtract(v As OxMVector3)		  		  #if NOT DebugBuild		    #pragma BackgroundTasks False		    #pragma BoundsChecking False		    #pragma NilObjectChecking False		    #pragma StackOverflowChecking False		  #endif		  		  ' Subtracts in place		  		  X = X-v.X		  Y = Y-v.Y		  Z = Z-v.Z		  		End Sub	#tag EndMethod	#tag Property, Flags = &h0		X As Double	#tag EndProperty	#tag Property, Flags = &h0		Y As Double	#tag EndProperty	#tag Property, Flags = &h0		Z As Double	#tag EndProperty	#tag ViewBehavior		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="2147483648"			Type="Integer"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			Type="String"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			Type="String"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="X"			Group="Behavior"			InitialValue="0"			Type="Double"		#tag EndViewProperty		#tag ViewProperty			Name="Y"			Group="Behavior"			InitialValue="0"			Type="Double"		#tag EndViewProperty		#tag ViewProperty			Name="Z"			Group="Behavior"			InitialValue="0"			Type="Double"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass