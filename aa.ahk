#Persistent
CoordMode Pixel, Screen 
CoordMode Mouse, Screen 
SetTimer, WatchCursor, 100
return

WatchCursor:
MouseGetPos X, Y 
PixelGetColor Color, %X%, %Y%, RGB
ToolTip, %Color%