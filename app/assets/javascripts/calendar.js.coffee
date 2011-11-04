# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

shift_classes = ["se_empty","se_hasone","se_hastwo","se_full"]
	
fix_shift = (shift) ->
	emt1 = $('#' + shift + '_emt1').find(':selected').val()
	emt2 = $('#' + shift + '_emt2').find(':selected').val()
	driver = $('#' + shift + '_d').find(':selected').val()
	count = 0
	count += 1 if emt1.length > 0
	count += 1 if emt2.length > 0
	count += 1 if driver.length > 0
	newclass = shift_classes[count]
	$('.se_'+shift).removeClass(shift_classes.join(' ')).addClass(newclass)

$ ->
	fix_shift(shift) for shift in ['s1','s2','s3','s4']
	
	$('.choose_member').change ->
		fix_shift(this.id[0..1])
	