jQuery(function ($) {
  $(document).ready(function(){
		$('#friend,#message').focus(function(){
	    if ($(this).hasClass('initial')) {
	      $(this).val('');
	      $(this).removeClass('initial');
	    }
	  });
	  $('#friend').blur(function(){
	    if ($(this).val() == "") {
	      $(this).val('enter a friend\'s name');
	      $(this).addClass('initial');
	    }
	  });
	  $('#message').blur(function(){
	    if ($(this).val() == "") {
	      $(this).val('add a note if you like!');
	      $(this).addClass('initial');
	    }
	  });
    FB.init({appId: 'fd577fc6f9d8d122717f0fdd6112e234', status: true, cookie: true, xfbml: false});
    FB.getLoginStatus(function(response) {
      if (response.session) {
        // logged in and connected user, someone you know
				enableGramInstanceForm();
      } else {
        $('#login').fadeIn();
        // no user session available, someone you dont know
				disableGramInstanceForm();
      }
    });
    

		$("#gram_instance_form").submit(function(){
			$('#submit_button').attr('disabled', 'disabled');
			$('#submit_button').val('Sending...');
			
			
			FB.api('/me' /*+ $('#recipient_uid').val()*/ + '/feed', 'post', 
				{ message: $('#message').val(),
				  picture: $("#" + $('#gram_id').val()).attr("src"),
					link: "http://www.grumpygrams.com/",
					caption: "This is a caption.",
					description: "This is a description.",
					name: "This is the name." 
				}, 
				function(response) {
			  	if (!response || response.error) {
				    $('#submit_button').removeAttr('disabled');
						$('#submit_button').val('Try sending it again!');
				  } else {
						$('#submit_button').val('Send it!');
						$('#gram_instance_form')[0].reset();
						$('#friend').addClass('initial');
						$('#message').addClass('initial');
						$("#flash").html("Success!");
						$("#flash").slideDown("medium").delay(2000).slideUp("medium");
						$('#submit_button').removeAttr('disabled');
				  }
				}
			);
			return false;
		});
    
    $(".scrollable").scrollable();

    $(".items img").click(function() {

    	// see if same thumb is being clicked
    	if ($(this).hasClass("active")) { return; }

    	// calclulate large image's URL based on the thumbnail URL 
    	var url = $(this).attr("src").replace("thumb", "original");

    	// get handle to element that wraps the image and make it semi-transparent
    	var wrap = $("#image_wrap").fadeTo("medium", 0.5);

    	// the large image
    	var img = new Image();

			// grab the gram id
			var gram = $(this).attr("id");

    	// call this function after it's loaded
    	img.onload = function() {

    		// make wrapper fully visible
    		wrap.fadeTo("fast", 1);

    		// change the image
    		wrap.find("img").attr("src", url);

				// set the form with gram id
				$('#gram_id').val(gram);

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
var currentUsersFriends;

function showOrSwapLogin(method) {
  if ($('#login').is(':visible')) {
    $('#login').fadeOut('slow', method);
    console.log('visible');
  }
  else {
    console.log('invisible');
    method();
  }
}

FB.Event.subscribe('auth.sessionChange', function(response) {
  console.log('in response function subscribe');
  if (response.session) {
    currentSession = response.session;
    FB.api('/me', function(response) { 
      currentUser = response; 
      showOrSwapLogin(function() {
        $('#login').html('<img src="http://graph.facebook.com/' + currentSession.uid + '/picture" class="profile">logged in as <span>' + currentUser.name + '</span><br/><a href="#" onclick="logout(); return false;" class="logout">Logout of <img src="/images/fb-favicon.png"></a>').fadeIn('slow');
      });
    });
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
    
  } else {
    console.log('here!');
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
			enableGramInstanceForm();
    } else {
      //alert('cancelled login');// user cancelled login
    }
  }, {perms:'publish_stream'});
  return false;
}

function logout() {
  FB.logout(function(response) {
    disableGramInstanceForm();
  });
}

function enableGramInstanceForm(){
	$('#friend').val('enter a friend\'s name');
  $('#message').val('add a note if you like!');
	$('#friend,#message,#submit_button').removeAttr('disabled');
}

function disableGramInstanceForm(){
  $('#friend').val('Please login with Facebook.');
  $('#message').val('Please login with Facebook before sending a GrumpyGram.');
	$('#friend,#message,#submit_button').attr('disabled', 'disabled');
}
