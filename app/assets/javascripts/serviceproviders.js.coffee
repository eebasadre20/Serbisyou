# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	$('#serviceprovider_category_id').parent().hide()
	categories = $('#serviceprovider_category_id').html()
	service    = $('#serviceprovider_service_id').html()
	$('#serviceprovider_service_id').change ->
		service = $('#serviceprovider_service_id option:selected').text()
		options = $(categories).filter("optgroup[label='#{service}']").html()
		if options
			$('#serviceprovider_category_id').html(options)
			$('#serviceprovider_category_id').parent().show()
		else
			$('#serviceprovider_category_id').empty()
			$('#serviceprovider_category_id').parent().hide()