// Variables
var currentSession;
var currentUser;
var currentUsersFriends;
var initialNameText = "enter a friend's name";
var initialMessageText = "add a note if you like!"

function initializeScrollable() {
  var url = window.location.toString();
	var anchor_index = url.indexOf('#');
  var anchor = (anchor_index != -1) ? url.substring(anchor_index+1).replace("send-", "") : false;
  $(".scrollable").scrollable();
  $(".items img").click(function() {
  	if ($(this).hasClass("active")) { return; } // see if same thumb is being clicked
  	var url = $(this).attr("src").replace("thumb", "original"); // calclulate large image's URL based on the thumbnail URL 
  	var wrap = $("#image_wrap");//.fadeTo("medium", 0.5); // get handle to element that wraps the image and make it semi-transparent
  	var img = new Image(); // the large image
		var gram = $(this).attr("data-hash");	// grab the gram id
		var name = $(this).attr("data-name");
		var phrase = $(this).attr("data-phrase");
		var recipient_phrase = $(this).attr("recipient-phrase");
		var facebook_tagline = $(this).attr("facebook-tagline");
		var facebook_caption = $(this).attr("facebook-caption");
  	// call this function after it's loaded
  	img.onload = function() {
  		wrap.fadeTo("fast", 0.4, function(){
  		  wrap.find("img").attr("src", url);
  		  wrap.fadeTo("fast", 1);
  		}); // make wrapper fully visible
      //       wrap.find("img").attr("src", url); // change the image
      // wrap.fadeTo("fast", 1); // make wrapper fully visible
			$('#gram_id').val(gram); // set the form with gram id
			$('#phrase').html(phrase);
			$('#recipient_phrase').html(recipient_phrase);
			$('#facebook_tagline').val(facebook_tagline);
			$('#facebook_caption').val(facebook_caption);
  	};
  	img.src = url; // begin loading the image
  	// activate item
  	$(".items img").removeClass("active");
  	$(this).addClass("active");
  // when page loads simulate a "click" on the first image
  }).filter(anchor ? function(index){return $(this).attr('data-hash') == anchor} : ":first").click();  
}

function displayMessage(div, message) {
  $("#" + div).html(message).slideDown("medium").delay(3000).slideUp("medium");
}

function flash(message) {
  displayMessage("flash", message);
}

function oops(message) {
  displayMessage("oops", message);
}

function sendGram() {
	if ($('#recipient_uid').val() == '')
	  oops("Oops!  You gotta pick a friend first!");
	else {
  	$('#submit_button').attr('disabled', 'disabled');
  	$('#submit_button').val('Sending...');
	
  	var story = {
  	  picture: $(".items img").filter(function(index){return $(this).attr('data-hash') == $('#gram_id').val()}).attr("src"),
  		link: "http://www.grumpygrams.com/#" + $('#gram_id').val(),
			name: $('#facebook_tagline').val(),
  		caption: $('#facebook_caption').val(),
  		description: " "
  	};
  	if ($('#message').val() != initialMessageText)
  	  story.message = $('#message').val();
	
  	FB.api('/' + $('#recipient_uid').val() + '/feed', 'post', story, 
  		function(response) {
  	  	if (!response || response.error) {
      	  oops("Oh noes, there was an error sending your gram! Try not to fly off the handle.");
  		    $('#submit_button').removeAttr('disabled');
  				$('#submit_button').val('Try sending again!');
  		  } else {
  		    //_gaq.push(['_trackEvent', 'Grams', 'Send', $('#gram_id').val()]);
          enableForm();
  				flash("GrumpyGram delivered!  Now they'll be so happy!  Send another?");
  				$('#submit_button').removeAttr('disabled');
  		  }
  		}
  	);
	}
	return false;
}

function resetFriendField() {
  $('#friend').val(initialNameText);
  $('#friend').addClass('initial');
	$('#friend').removeAttr('disabled');
}

function resetMessageField() {
  $('#message').val(initialMessageText);
  $('#message').addClass('initial');
	$('#message').removeAttr('disabled');
}

function resetMailingListField() {
  $('#mce-EMAIL').val('Email Address');
  $('#mce-EMAIL').addClass('initial');
}

function initializeForms() {
  $('#friend,#message,#mce-EMAIL').focus(function(){
    if ($(this).hasClass('initial')) {
      $(this).val('');
      $(this).removeClass('initial');
    }
  });
  $('#friend').blur(function(){  if ($(this).val() == "") { resetFriendField();  }});
  $('#message').blur(function(){ if ($(this).val() == "") { resetMessageField(); }});
  $('#mce-EMAIL').blur(function(){ if ($(this).val() == "") { resetMailingListField(); }});
  $("#gram_instance_form").submit(sendGram);
}

function enableForm() {
  $('#gram_instance_form img').attr('src', '/images/no-one.png');
  $('#recipient_uid').val('');
  resetFriendField();
  resetMessageField();
  $('#submit_button').val('Send it!').removeAttr('disabled');
}

function disableForm(){
  $('#friend').val('Please login with Facebook.');
  $('#message').val('Please login with Facebook before sending a GrumpyGram.');
	$('#friend,#message,#submit_button').attr('disabled', 'disabled');
}

function showOrSwapLogin(method) {
  if ($('#login').is(':visible'))
    $('#login').fadeOut('slow', method);
	else 
    method();
}

function showLogin() {
  showOrSwapLogin(function() {
    $('#login').html('<a href="#" onclick="login(); return false;"><img src="/images/fb-login-button.png"></a>').fadeIn('slow');
  });
}

function getCurrentUser() {
  FB.api('/me', function(response) { 
    currentUser = response; 
    showOrSwapLogin(function() {
      $('#login').html('<img src="http://graph.facebook.com/' + currentSession.uid + '/picture" class="profile">Logged in as <span>' + currentUser.name + '</span><br/><a href="#" onclick="logout(); return false;" class="logout">Logout of <img src="/images/fb-favicon.png"></a>').fadeIn('slow');
    });
  });
}

function populateFriends() {
  FB.api('/me/friends', function(response) { 
    currentUsersFriends = response;
    $('#friend').autocomplete({
			minLength: 0,
			delay: 0,
			source: function(request, response) {
        var matcher = new RegExp(request.term, "i");
        var matches = [];
        $(currentUsersFriends.data).each(function() {
          if (this.name && (!request.term || matcher.test(this.name)))
            matches.push({
              id: this.id,
              name: this.name,
              label: this.name.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(request.term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>")
            });
        });
        response(matches);
      },
			focus: function(event, ui) {
				$('#project').val(ui.item.label);
				return false;
			},
			select: function(event, ui) {
				$('#friend').val(ui.item.name);
				$('#recipient_uid').val(ui.item.id);
        // $('#friend-description').html(ui.item.name);
				$('#friend-avatar').attr('src', 'http://graph.facebook.com/' + ui.item.id + '/picture');

				return false;
			}
		})
		.data( "autocomplete" )._renderItem = function( ul, item ) {
			return $( "<li></li>" )
				.data( "item.autocomplete", item )
				.append( '<a><img src="http://graph.facebook.com/' + item.id + '/picture">' + item.label + "</a>" )
				.appendTo( ul );
		};
  });
}

// Everything pertaining to logging in and logging out happens here
FB.Event.subscribe('auth.sessionChange', function(response) {
  if (response.session) { // logged in
	  enableForm();
    currentSession = response.session;
    getCurrentUser();
    populateFriends();
  } else { // logged out
    disableForm();
    currentSession = null;
    currentUser = null;
    currentUsersFriends = null;
    showLogin();
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
  FB.logout();
}

function initializeSortableAdmin() {
  $('#admin #grams').sortable({
    dropOnEmpty: false,
    cursor: 'crosshair',
    items: '.gram',
    opacity: 0.4,
    scroll: true,
    update: function(){
      $.ajax({
        type: 'post',
        data: $('#admin #grams').sortable('serialize'),
        dataType: 'script',
        url: '/admin/grams/reorder'
      })
    }
  });
}

jQuery(function ($) {
  $(document).ready(function(){
    if ($('#admin').size() == 1)
      initializeSortableAdmin();
    else {
      FB.init({appId: '137471566265661', status: true, cookie: true, xfbml: false});
			initializeForms();
      FB.getLoginStatus(function(response){if (!response.session) { showLogin(); disableForm(); }});
      initializeScrollable();
			if (window.location.toString().indexOf('#') != -1 && window.location.toString().indexOf('#send-') == -1){
				$('#receive-it').attr('style', 'display:block;');
				$('#send_your_own_button').click(function() {
					$('#receive-it').fadeOut('slow', function() {
						$('#send-it').fadeIn('slow');
						$('#gram-image-flow').slideDown('slow');
					});
				});
			} else {
				$('#send-it').attr('style', 'display:block;');
				$('#gram-image-flow').slideDown('slow');
			}
    } 
  });
});