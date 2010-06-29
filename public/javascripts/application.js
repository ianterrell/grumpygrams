jQuery(function ($) {
  $(document).ready(function(){
    FB.init({appId: 'fd577fc6f9d8d122717f0fdd6112e234', status: true, cookie: true, xfbml: false});
    FB.getLoginStatus();
  });  
});

var currentSession;
var currentUser;

FB.Event.subscribe('auth.sessionChange', function(response) {
  if (response.session) {
    currentSession = response.session;
    FB.api('/me', function(response) { currentUser = response; });
    $('#login-inner').fadeOut('slow', function() {
      $('#login-inner').html('<img src="http://graph.facebook.com/' + currentSession.uid + '/picture" class="profile">Logged in as <span>' + currentUser.name + '</span>.<br/><a href="#" onclick="logout();">Logout of Facebook</a>').fadeIn('slow');
    });
  } else {
    currentSession = null;
    currentUser = null;
    $('#login-inner').fadeOut('slow', function() {
      $('#login-inner').html('<a href="#" onclick="login();"><img src="/images/fb-login-button.png"></a>').fadeIn('slow');
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