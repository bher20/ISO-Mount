' Author: Brad Herring 
' Email: brad@bherville.com
' Website: www.bherville.com
' Organization: Bherville
' Copyright 2010 Brad Herring

' This program is free software: you can redistribute it and/or modify
'    it under the terms of the GNU General Public License as published by
'    the Free Software Foundation, either version 3 of the License, or
'    (at your option) any later version.

'    This program is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'    GNU General Public License for more details.

'    You should have received a copy of the GNU General Public License
'    along with this program.  If not, see <http://www.gnu.org/licenses/>.


' This script parses the argument 
' 	that is passed to it, using a 
'	regualer expression to pull out
'	the frame rate.


' Declare the variables to be used.
Dim Match


' Set up the objects to be used.
Set objRegExp = New RegExp
Set args = WScript.Arguments
strTest = args.Item(0)
objRegExp.Global = False
objRegExp.IgnoreCase = False
objRegExp.Multiline = False

' This regular expression will that a 
' 	the string that is passed to this 
'	script like d:\Batman Begins.bluray.24fps.iso
'	and extract the 24fps from it.
objRegExp.Pattern = "[^\.]([0-9]+)fps"

' Execurte the regular expression 
'	on the string that was passed.
Set myMatches = objRegExp.Execute(strTest)

' Loop thru the strings that were 
'	captured based on the regex
'	for each one (should only 
' 	be one tho) it will remove 
'	the trailing fps from it
' 	and echo them to the command
'	prompt.
For Each myMatch in myMatches
  WScript.Echo Left(myMatch, (Len(myMatch)-3))

Next

