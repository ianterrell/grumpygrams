// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  $('.gram-template-preview').click(function(){
    $('#gram_gram_template_id').val($(this).attr('gram_template_id'));
  });
});