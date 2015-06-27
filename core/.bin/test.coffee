
trace = console.log

dump = (obj)->
	trace '{'
	for key,val of obj
		if typeof val is 'function'
			trace "\t#{key} => function"
		else
			trace "\t#{key} => #{val}"
	trace '}'

is_empty = (obj)->
	if obj.length? and obj.length is 0
		true
	else
		for key,val of obj
			return false
	true

Timer = ->
	start = (new Date).getTime()
	->
		now = (new Date).getTime()
		ellapsed = now - start
		start = now
		ellapsed

T = ->
	@num_tests = 0
	@num_failed_tests = 0
	done = false

	log = trace
	
	pass = => @num_tests++

	fail = (msg)=>
		@num_tests++
		@num_failed_tests++
		log "failed: #{msg}"
		done = true

	@report = => log "tests run: #{@num_tests} passed: #{@num_tests - @num_failed_tests}"

	@is_equal = (a,b)=> if not done and a is b then pass() else fail "#{a} !== #{b}"

	@is_true = (obj)=> if not done and obj then pass() else fail "#{obj} is false"
	@is_false = (obj)=> if not done and obj then fail "#{obj} is true" else pass()

	@is_empty = (obj)=> if not done and is_empty obj then pass() else fail "#{obj} is not empty"

	@time = (call,times)->
		times = times or 1
		timer = Timer()
		for i in [1..times]
			call.apply()
		elapsed = timer()
		log "time elapsed: #{elapsed}"

	@benchmark = (call,times)->
		times = times or 1
		timer = Timer()
		for i in [1..times]
			call.apply()
		elapsed = timer()
		log "#{times} #{elapsed}"

	return this

# partial
