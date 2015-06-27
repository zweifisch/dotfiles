var T, Timer, dump, is_empty, trace;

trace = console.log;

dump = function(obj) {
  var key, val;
  trace('{');
  for (key in obj) {
    val = obj[key];
    if (typeof val === 'function') {
      trace("\t" + key + " => function");
    } else {
      trace("\t" + key + " => " + val);
    }
  }
  return trace('}');
};

is_empty = function(obj) {
  var key, val;
  if ((obj.length != null) && obj.length === 0) {
    true;
  } else {
    for (key in obj) {
      val = obj[key];
      return false;
    }
  }
  return true;
};

Timer = function() {
  var start;
  start = (new Date).getTime();
  return function() {
    var ellapsed, now;
    now = (new Date).getTime();
    ellapsed = now - start;
    start = now;
    return ellapsed;
  };
};

T = function() {
  var done, fail, log, pass,
    _this = this;
  this.num_tests = 0;
  this.num_failed_tests = 0;
  done = false;
  log = trace;
  pass = function() {
    return _this.num_tests++;
  };
  fail = function(msg) {
    _this.num_tests++;
    _this.num_failed_tests++;
    log("failed: " + msg);
    return done = true;
  };
  this.report = function() {
    return log("tests run: " + _this.num_tests + " passed: " + (_this.num_tests - _this.num_failed_tests));
  };
  this.is_equal = function(a, b) {
    if (!done && a === b) {
      return pass();
    } else {
      return fail("" + a + " !== " + b);
    }
  };
  this.is_true = function(obj) {
    if (!done && obj) {
      return pass();
    } else {
      return fail("" + obj + " is false");
    }
  };
  this.is_false = function(obj) {
    if (!done && obj) {
      return fail("" + obj + " is true");
    } else {
      return pass();
    }
  };
  this.is_empty = function(obj) {
    if (!done && is_empty(obj)) {
      return pass();
    } else {
      return fail("" + obj + " is not empty");
    }
  };
  this.time = function(call, times) {
    var elapsed, i, timer;
    times = times || 1;
    timer = Timer();
    for (i = 1; 1 <= times ? i <= times : i >= times; 1 <= times ? i++ : i--) {
      call.apply();
    }
    elapsed = timer();
    return log("time elapsed: " + elapsed);
  };
  this.benchmark = function(call, times) {
    var elapsed, i, timer;
    times = times || 1;
    timer = Timer();
    for (i = 1; 1 <= times ? i <= times : i >= times; 1 <= times ? i++ : i--) {
      call.apply();
    }
    elapsed = timer();
    return log("" + times + " " + elapsed);
  };
  return this;
};
