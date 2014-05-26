notify=require 'gulp-notify'

module.exports=(args...)->

	format=
		title: 'Compile Error'
		message: '<%= error.message %>'

	# Send error to notification center with gulp-notify

	notify
		.onError format
		.apply @,args

	# Keep gulp from hanging on this task

	@emit 'end'

	return
