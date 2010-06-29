jQuery(function ($) {
  $(document).ready(function(){
    FB.init({appId: 'fd577fc6f9d8d122717f0fdd6112e234', status: true, cookie: true, xfbml: false});
    FB.getLoginStatus();
  });  
});

FB.Event.subscribe('auth.sessionChange', function(response) {
  if (response.session) {
    alert("logged in");// A user has logged in, and a new cookie has been saved
  } else {
    alert("logged out");// The user has logged out, and the cookie has been cleared
  }
});

function login() {
  FB.login(function(response) {
    if (response.session) {
      alert('success log in');// user successfully logged in
    } else {
      alert('cancelled login');// user cancelled login
    }
  });
  return false;
}