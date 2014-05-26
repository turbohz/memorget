fs=require 'fs'
scripts=require './util/filter'
tasks=fs
	.readdirSync './gulp/tasks/'
	.filter scripts

require("./tasks/#{t}") for t in tasks