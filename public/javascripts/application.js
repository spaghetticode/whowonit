$(document).ready(function(){	
	$('form.button_to').submit(function(){
		$('input[type=submit]', this).attr('disabled', true);
		$.post($(this).attr('action'), $(this).serialize(), null, 'script');
		return false;
	})
})