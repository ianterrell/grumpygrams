jQuery(function ($) {
  $(document).ready(function(){
    $('#login').fadeIn();
    FB.init({appId: 'fd577fc6f9d8d122717f0fdd6112e234', status: true, cookie: true, xfbml: false});
    FB.getLoginStatus();
    
    $('#friend').focus(function(){
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

		$("#gram_instance_form").submit(function(){
			FB.api('/' + $('#recipient_uid').val() + '/feed', 'post', 
				{ message: $('#message').val(),
				  picture: $("#" + $('#gram_id').val()).attr("src"),
					link: "http://www.grumpygrams.com/",
					caption: "This is a caption.",
					description: "This is a description.",
					name: "This is the name." 
				}, 
				function(response) {
			  	if (!response || response.error) {
				    alert('Error occured');
				  } else {
				    return true;
				  }
				}
			);
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

FB.Event.subscribe('auth.sessionChange', function(response) {
  if (response.session) {
    currentSession = response.session;
    FB.api('/me', function(response) { currentUser = response; });
    $('#login').fadeOut('slow', function() {
      $('#login').html('<img src="http://graph.facebook.com/' + currentSession.uid + '/picture" class="profile">Logged in as <span>' + currentUser.name + '</span>.<br/><a href="#" onclick="logout(); return false;">Logout of Facebook</a>').fadeIn('slow');
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
    currentSession = null;
    currentUser = null;
    currentUsersFriends = null;
    $('#login').fadeOut('slow', function() {
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
  FB.logout(function(response) {
    
  });
}
