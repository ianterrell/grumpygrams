// Variables
var anchor;
var currentSession;
var currentUser;
var currentUsersFriends;
var initialNameText = "enter a friend's name";
var initialMessageText = "add a note if you like!"

function initializeScrollable() {
  var url = window.location.toString();
	var anchor_index = url.indexOf('#');
  if (anchor_index != -1) {
  	anchor = url.substring(anchor_index);
  } else {
		anchor = ":first";
	}
  $(".scrollable").scrollable();
  $(".items img").click(function() {
  	if ($(this).hasClass("active")) { return; } // see if same thumb is being clicked
  	var url = $(this).attr("src").replace("thumb", "original"); // calclulate large image's URL based on the thumbnail URL 
  	var wrap = $("#image_wrap");//.fadeTo("medium", 0.5); // get handle to element that wraps the image and make it semi-transparent
  	var img = new Image(); // the large image
		var gram = $(this).attr("id");	// grab the gram id
		var phrase = $(this).attr("data-phrase");
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
  	};
  	img.src = url; // begin loading the image
  	// activate item
  	$(".items img").removeClass("active");
  	$(this).addClass("active");
  // when page loads simulate a "click" on the first image
  }).filter(anchor).click();  
}

function sendGram() {
	$('#submit_button').attr('disabled', 'disabled');
	$('#submit_button').val('Sending...');
	
	var story = {
	  picture: $("#" + $('#gram_id').val()).attr("src"),
		link: "http://www.grumpygrams.com/#" + $('#gram_id').val(),
		caption: "This is a caption.",
		description: "This is a description.",
		name: "This is the name." 
	};
	if ($('#message').val() != initialMessageText)
	  story.message = $('#message').val();
	
	//TODO: fix this so it actually posts to the friend's feed!!!
	FB.api('/me' /*+ $('#recipient_uid').val()*/ + '/feed', 'post', story, 
		function(response) {
	  	if (!response || response.error) {
		    $('#submit_button').removeAttr('disabled');
				$('#submit_button').val('Error...  Try again!');
		  } else {
		    _gaq.push(['_trackEvent', 'Grams', 'Send', $('#gram_id').val()]);
        enableForm();
				$("#flash").html("GrumpyGram delivered!  Now they'll be so happy!  Send another?").slideDown("medium").delay(3000).slideUp("medium");
				$('#submit_button').removeAttr('disabled');
		  }
		}
	);
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

function initializeForm() {
  $('#friend,#message').focus(function(){
    if ($(this).hasClass('initial')) {
      $(this).val('');
      $(this).removeClass('initial');
    }
  });
  $('#friend').blur(function(){  if ($(this).val() == "") { resetFriendField();  }});
  $('#message').blur(function(){ if ($(this).val() == "") { resetMessageField(); }});
  $("#gram_instance_form").submit(sendGram);
}

function enableForm() {
  $('#gram_instance_form img').attr('src', '/images/no-one.png');
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

function getCurrentUser() {
  FB.api('/me', function(response) { 
    currentUser = response; 
    showOrSwapLogin(function() {
      $('#login').html('<img src="http://graph.facebook.com/' + currentSession.uid + '/picture" class="profile">logged in as <span>' + currentUser.name + '</span><br/><a href="#" onclick="logout(); return false;" class="logout">Logout of <img src="/images/fb-favicon.png"></a>').fadeIn('slow');
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
              label: this.name.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(request.term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>"),
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
    showOrSwapLogin(function() {
      $('#login').html('<a href="#" onclick="login(); return false;"><img src="/images/fb-login-button.png"></a>').fadeIn('slow');
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
      FB.init({appId: 'fd577fc6f9d8d122717f0fdd6112e234', status: true, cookie: true, xfbml: false});
      FB.getLoginStatus();
      initializeForm();
      initializeScrollable();
    } 
  });
});