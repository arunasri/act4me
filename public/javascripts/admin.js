$(document).ready(function() {
	$("#destroy_all").live("click", function() {
		if ($(this).is(":checked")) {
			$("input[id$='_destroy']").attr('checked', 'checked')
		} else {

			$("input[id$='_destroy']").removeAttr('checked')
		}
	});

	$(".category_all").live('click', function() {
		$("input[name$='[category]'][value='" + $(this).val() + "']").each(function() {
			$(this).attr('checked', 'checked');
		});
	});
});

