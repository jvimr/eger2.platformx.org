// Batmosphere Embedded Media Player, version 2006-05-31 
// Written by David Battino, www.batmosphere.com
// OK to use if this notice is included
// This function reads an MP3 URL and title from the referring page and generates embedding code to play back the audio file.
// Windows browsers (except for Internet Explorer) will play back the file with the Windows Media Player *plugin.* Internet Explorer will use Windows Media Player.
// Non-Windows browsers will play back the file with their standard audio handler for the MIME type audio/mpeg. On Macs, that handler will usually be QuickTime.

var audioFolder = ""; // If you have a default audio directory, e.g., http://www.your-media-hosting-site.com/sounds/, you can put it here to make links on the referring page shorter.

function embedPlayer(MP3title,MP3URL) { 
   // Get Operating System 
   var isWin = navigator.userAgent.toLowerCase().indexOf("windows") != -1;
   if (isWin) { // Use MIME type application/x-mplayer2
      visitorOS="Windows";
   } else { // Use MIME type audio/mpeg, audio/x-wav, etc.
      visitorOS="Other";
   }

   var audioURL = audioFolder + MP3URL;
   var objTypeTag = "application/x-mplayer2"; // The MIME type to load the WMP plugin in non-IE browsers on Windows
   if (visitorOS != "Windows") { objTypeTag = "audio/mpeg"}; // The MIME type for Macs and Linux 
  
   document.writeln("<div>");
 //  document.writeln("<strong style='font-size:18px; position:relative; top:-28px'>" + MP3title + "&nbsp;</strong>");  // Adjust font style to taste
   document.writeln("<object width='280' height='69'>"); // Width is the WMP minimum. Height = 45 (WMP controls) + 24 (WMP status bar) 
   document.writeln("<param name='type' value='" + objTypeTag + "'>");
   document.writeln("<param name='src' value='" + audioURL + "'>");
   document.writeln("<param name='autostart' value='0'>");
   document.writeln("<param name='showcontrols' value='1'>");
   document.writeln("<param name='showstatusbar' value='1'>");
   document.writeln("<embed src ='" + audioURL + "' type='" + objTypeTag + "' autoplay='false' autostart='0' width='280' height='69' controller='0' showstatusbar='1' bgcolor='#ffffff'></embed>"); 
   
   // Firefox and Opera Win require both autostart and autoplay
   document.writeln("</object>");
   document.writeln("</div>");
   document.close(); // Finalizes the document
}
