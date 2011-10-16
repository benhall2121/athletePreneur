// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})


$(document).ready(function() {
  
  $(".pop").fancybox({
	'autoScale'		: false,
	'transitionIn'		: 'elastic',
	'transitionOut'		: 'elastic',
	'type'			: 'iframe',
	'centerOnScroll'	: 'true'
  });
  
  $('#company_launch_page_submit_email').click(function(){
      var email_address = $('#company_launch_page_email_textfield_id').val();
      var company_id = $('#company_launch_page_company_id').val();
      
      $('.company_launch_page_warning_message_div').html('');
        
      if(email_address.indexOf("@") == -1){ 
        $('.company_launch_page_warning_message_div').html('Please enter a valid email address');
        return false;
      }
      
      $.post('/users/launch_page_email_address', {"email_address": email_address, "company_id": company_id }, function(response) { 
        $('.company_launch_page_warning_message_div').html("Thanks for signing up! You'll hear from us soon");
        $('#company_launch_page_email_textfield_id').val('');
      });
       	    
  });
  
  $("#main_search input").keyup(function() {
    $.get($("#main_search").attr("action"), $("#main_search").serialize(), null, "script");
    $('.company_wrapper').html('');
    return false;
  });
  
  $(".user_type_main_search").click(function() {
    $('.nav_links a').removeClass('header_selected');
    $(this).addClass('header_selected');		  
    $.get($(this).attr('href'), null, null, "script");
    return false;
  });
  
  $('.account_type').change(function(){
    id = $(this).attr('id').replace('account_type_id_', '');
    account_type = $(this).val();
    
    if(account_type == ''){
      return false;	    
    }
    
    $.post('/admin_update_verify_user', {'id': id, 'account_type': account_type}, function(response) { 
      $('#verify_user_' + id).hide('fast');
    });
  });
  
  $('.verify_user_nav div').click(function(){
    id=$(this).attr('id')
    $('.verify_user_nav div').removeClass('verify_user_div_selected');
    $('#'+id).addClass('verify_user_div_selected')
    just_id = id.replace('_nav_div','');
    $('.verify_user_type_div').hide();
    $('#' + just_id + '_div').show();
    $('#user_type_apply').val(just_id);
  });
  
});


