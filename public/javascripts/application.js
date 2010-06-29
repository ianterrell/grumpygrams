jQuery(function ($) {
  $(document).ready(function(){
    FB.init({appId: 'fd577fc6f9d8d122717f0fdd6112e234', status: true, cookie: true, xfbml: false});
    FB.getLoginStatus();
    
    
    $(".scrollable").scrollable();

    $(".items img").click(function() {

    	// see if same thumb is being clicked
    	if ($(this).hasClass("active")) { return; }

    	// calclulate large image's URL based on the thumbnail URL (flickr specific)
    	var url = $(this).attr("src").replace("thumb", "original");

    	// get handle to element that wraps the image and make it semi-transparent
    	var wrap = $("#image_wrap").fadeTo("medium", 0.5);

    	// the large image from www.flickr.com
    	var img = new Image();


    	// call this function after it's loaded
    	img.onload = function() {

    		// make wrapper fully visible
    		wrap.fadeTo("fast", 1);

    		// change the image
    		wrap.find("img").attr("src", url);

    	};

    	// begin loading the image from www.flickr.com
    	img.src = url;

    	// activate item
    	$(".items img").removeClass("active");
    	$(this).addClass("active");

    // when page loads simulate a "click" on the first image
    }).filter(":first").click();
  });  
});

var currentSession;
var currentUser;

FB.Event.subscribe('auth.sessionChange', function(response) {
  if (response.session) {
    currentSession = response.session;
    FB.api('/me', function(response) { currentUser = response; });
    $('#login-inner').fadeOut('slow', function() {
      $('#login-inner').html('<img src="http://graph.facebook.com/' + currentSession.uid + '/picture" class="profile">Logged in as <span>' + currentUser.name + '</span>.<br/><a href="#" onclick="logout(); return false;">Logout of Facebook</a>').fadeIn('slow');
    });
  } else {
    currentSession = null;
    currentUser = null;
    $('#login-inner').fadeOut('slow', function() {
      $('#login-inner').html('<a href="#" onclick="login(); return false;"><img src="/images/fb-login-button.png"></a>').fadeIn('slow');
    });
  }
});

function login() {
  FB.login(function(response) {
    if (response.session) {
      //alert('success log in');// user successfully logged in
    } else {
      //alert('cancelled login');// user cancelled login
    }
  }, {perms:'publish_stream'});
  return false;
}

function logout() {
  FB.logout(function(response) {
    
  });
}
