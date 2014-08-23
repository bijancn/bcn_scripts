//!javascript
//<adblock_subscriptions___SCRIPT
extensions.load("adblock_subscriptions", {
//<adblock_subscriptions___CONFIG

// Shortcut to subscribe to a filterlist
scSubscribe : null, 
// Command to subscribe to a filterlist
cmdSubscribe : "adblock_subscribe", 

// Shortcut to unsubscribe from a filterlist
scUnsubscribe : null, 

// Command to unsubscribe from a filterlist
cmdUnsubscribe : "adblock_unsubscribe",

// Shortcut to update subscriptions and reload filter rules
// Note that dwb will also update all subscriptions on startup
scUpdate : null, 

// Command to update subscriptions and reload filter rules
// Note that dwb will also update all subscriptions on startup
cmdUpdate : "adblock_update", 

// Path to the filterlist directory, will be created if it doesn't exist. 
filterListDir : data.configDir + "/adblock_lists"
//>adblock_subscriptions___CONFIG
});
//>adblock_subscriptions___SCRIPT
//<googlebookmarks___SCRIPT
extensions.load("googlebookmarks", {
//<googlebookmarks___CONFIG
  // Shortcut to save a bookmark
  shortcut : "egb",

  // Whether to open the submitted bookmark in a new tab, if set to
  // true backToOriginal is ignored
  newTab : false,

  // Whether to navigate back to the original after the bookmark
  // is saved, if newTab is enabled or autoSubmit is disabled
  // this option is ignored
  backToOriginal : true,

  // Whether to autosubmit the bookmark form
  autoSubmit : true
//>googlebookmarks___CONFIG
});
//>googlebookmarks___SCRIPT
//<contenthandler___SCRIPT
extensions.load("contenthandler", {
//<contenthandler___CONFIG
  // The handler can either be a string or a function, if it is a string
  // %u will be replaced with the uri of the request, if the handler is a
  // function the first parameter of the function will be the uri and the
  // function must return the command to execute.
  
  // Handle requests based on filename extension
  extension : {
    // "torrent" : "xterm -e 'aria2 %u'", 
    // "pdf" : "xterm -e 'wget %u --directory-prefix=~/mypdfs'"
  },

  // Handle requests based on URI scheme
  uriScheme : {
      //ftp : function(uri) { 
      //    if (uri[uri.length-1] == "/") 
      //        return "xterm -e 'ncftp " + uri + "'"; 
      //    else 
      //        return "xterm -e 'ncftpget " + uri + "'"; 
      //}
  },

uriScheme: {
    mailto: "sylpheed --compose \"%u\""
},

  // Handle requests based on MIME type
  mimeType : {
    // "application/pdf" : "xterm -e 'wget %u --directory-prefix=~/mypdfs'"
  }
//>contenthandler___CONFIG
});
//>contenthandler___SCRIPT
