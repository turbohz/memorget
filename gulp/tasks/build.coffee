gulp  =require 'gulp'
coffee=require 'gulp-coffee'
rename=require 'gulp-rename'
error =require '../util/error'

gulp.task 'build',->
	
	gulp
		.src ['src/*']
		.pipe coffee(bare:true)
		.on 'error',error
		.pipe rename('memorget.js')
		.pipe gulp.dest('lib/')