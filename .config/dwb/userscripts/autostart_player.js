//!javascript 
// opens YouTube videos with mplayer.
var regexa = new RegExp("http(.*)://www.youtube.com/watch\\?(.*&)*v=.*");
var regexb = new RegExp("http(.*)://www.twitch.tv/.*");

Signal.connect("navigation", function (wv, frame, request) {
  if (wv.mainFrame == frame && (regexa.test(request.uri) || regexb.test(request.uri))) 
    //system.spawn("sh -c 'mplayer \"$(youtube-dl -g " + request.uri + ")\"'");
    system.spawn("livestreamer " + request.uri + " best ");
  return false;
});
