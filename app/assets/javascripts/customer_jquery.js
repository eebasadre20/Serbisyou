$(document).ready(function () {
	$('#search').submit( function (evt) {
		var brgy_val = $('#barangay option:selected').text();
		if(!$('#barangay option:selected').val()) {
			//swal("Choose your desire Barangay", "", "warning", {timer: 2000});
			swal({   title: "Ooop!",   text: "Choose desire Barangay.", timer: 3000 });
		} else {
			return true;
		}
		evt.preventDefault();
	});

	$('#serviceprovider_category_id').parent().hide();
	categories = $('#serviceprovider_category_id').html();
	service    = $('#serviceprovider_service_id').change( function () {
		service = $('#serviceprovider_service_id option:selected').text();
		options = $(categories).filter("optgroup[label='#{service}']").html()
		if(options) {
			$('#serviceprovider_category_id').html(options);
			$('#serviceprovider_category_id').parent().show();
		} else {
			$('#serviceprovider_category_id').empty();
			$('#serviceprovider_category_id').parent().hide();
		}



	})

	$("#input-id").rating();
	$("#input-id").rating(['min'=>1, 'max'=>10, 'step'=>2, 'size'=>'sm']);
});