$(document).ready(function(){	
	$('form.button_to, form.new_auction').submit(function(){
		$('input[type=submit]', this).attr('disabled', true).css('color', 'gray');
		$.post($(this).attr('action'), $(this).serialize(), null, 'script');
		return false;
	})
})