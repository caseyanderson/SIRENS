//sirens, noon to midnight, LAPhil, Nov 18th
// Casey Anderson

s.boot;

// setup the network ( TODO: replace with Scott's utility)

~ip1 = "10.0.1.4";
~ip2 = "10.0.1.6";
~ip3 = "10.0.1.3";


~pi1 = NetAddr(~ip1, 57120);
~pi2 = NetAddr(~ip2, 57120);
~pi3 = NetAddr(~ip3, 57120);


// the GUI

(
~window = Window.new("SIRENS", Rect(0,0,600,640));

// pi 1
// instrument 1

~b1 = Button(~window, Rect( 10, 10, 50, 50))
		.states_([
			["OFF", Color.white, Color.black],
			["ON", Color.white, Color.red]
		])

.action_({ arg butt;
	if( butt.value == 1,
		{
			"SIN PLAYING".postln;
			~pi1.sendMsg('/sin', '/play');
		},
		{
			"SIN STOPPED".postln;
			~pi1.sendMsg('/sin', '/stop');
		}
	);
});

~h1 = NumberBox(~window, Rect(10, 10 + 60, 50, 50));
~h1.align = \center;
~h1.value = 1.1;

~s1 = Slider.new(~window, Rect(65, 10, 50, 200))
.action_({ |slider|
	~pi1.sendMsg('/sin', '/vol', slider.value.asFloat);
});


// instrument 2

~b2 = Button(~window, Rect( 10, 220, 50, 50))
		.states_([
			["OFF", Color.white, Color.black],
			["ON", Color.white, Color.red]
		])

.action_({ arg butt;
	if( butt.value == 1,
		{
			"formant PLAYING".postln;
			~pi1.sendMsg('/formant1', '/play');
		},
		{
			"SIN STOPPED".postln;
			~pi1.sendMsg('/formant1', '/stop');
		}
	);
});

~h2 = NumberBox(~window, Rect(10, 220 + 60, 50, 50));
~h2.align = \center;
~h2.value = 1.2;

~s2 = Slider.new(~window, Rect(65, 220, 50, 200))
.action_({ |slider|
	~pi1.sendMsg('/formant1', '/vol', slider.value.asFloat);
});


// instrument 3

~b3 = Button(~window, Rect( 10, 430, 50, 50))
		.states_([
			["OFF", Color.white, Color.black],
			["ON", Color.white, Color.red]
		])

.action_({ arg butt;
	if( butt.value == 1,
		{
			"formant2 PLAYING".postln;
			~pi1.sendMsg('/formant2', '/play');
		},
		{
			"formant2 STOPPED".postln;
			~pi1.sendMsg('/formant2', '/stop');

		}
	);
});

~h3 = NumberBox(~window, Rect(10, 430 + 60, 50, 50));
~h3.align = \center;
~h3.value = 1.3;

~s3 = Slider.new(~window, Rect(65, 430, 50, 200))
.action_({ |slider|
	~pi1.sendMsg('/formant2', '/vol', slider.value.asFloat);
});


//pi2
//instrument 1
~b4 = Button(~window, Rect( 125, 10, 50, 50))
		.states_([
			["OFF", Color.white, Color.black],
			["ON", Color.white, Color.red]
		])

.action_({ arg butt;
	if( butt.value == 1,
		{
			"SIN PLAYING".postln;
			~pi2.sendMsg('/sin', '/play');
		},
		{
			"SIN STOPPED".postln;
			~pi2.sendMsg('/sin', '/stop');
		}
	);
});

~h4 = NumberBox(~window, Rect(125, 10 + 60, 50, 50));
~h4.align = \center;
~h4.value = 2.1;

~s4 = Slider.new(~window, Rect(190, 10, 50, 200))
.action_({ |slider|
	~pi2.sendMsg('/sin', '/vol', slider.value.asFloat);
});


// instrument 2

~b5 = Button(~window, Rect( 125, 220, 50, 50))
		.states_([
			["OFF", Color.white, Color.black],
			["ON", Color.white, Color.red]
		])

.action_({ arg butt;
	if( butt.value == 1,
		{
			"formant1 PLAYING".postln;
			~pi2.sendMsg('/formant1', '/play');
		},
		{
			"formant1 STOPPED".postln;
			~pi2.sendMsg('/formant1', '/stop');
		}
	);
});

~h5 = NumberBox(~window, Rect(125, 220 + 60, 50, 50));
~h5.align = \center;
~h5.value = 2.2;

~s5 = Slider.new(~window, Rect(190, 220, 50, 200))
.action_({ |slider|
	~pi2.sendMsg('/formant1', '/vol', slider.value.asFloat);
});


// instrument 3

~b6 = Button(~window, Rect( 125, 430, 50, 50))
		.states_([
			["OFF", Color.white, Color.black],
			["ON", Color.white, Color.red]
		])

.action_({ arg butt;
	if( butt.value == 1,
		{
			"formant2 PLAYING".postln;
			~pi2.sendMsg('/formant2', '/play');
		},
		{
			"formant2 STOPPED".postln;
			~pi2.sendMsg('/formant2', '/stop');

		}
	);
});

~h6 = NumberBox(~window, Rect(125, 430 + 60, 50, 50));
~h6.align = \center;
~h6.value = 2.3;

~s6 = Slider.new(~window, Rect(190, 430, 50, 200))
.action_({ |slider|
	~pi2.sendMsg('/formant2', '/vol', slider.value.asFloat);
});


//pi3
// instrument 1

~b7 = Button(~window, Rect( 250, 10, 50, 50))
		.states_([
			["OFF", Color.white, Color.black],
			["ON", Color.white, Color.red]
		])

.action_({ arg butt;
	if( butt.value == 1,
		{
			"SIN PLAYING".postln;
			~pi3.sendMsg('/sin', '/play');
		},
		{
			"SIN STOPPED".postln;
			~pi3.sendMsg('/sin', '/stop');
		}
	);
});

~h7 = NumberBox(~window, Rect( 250, 10 + 60, 50, 50));
~h7.align = \center;
~h7.value = 3.1;

~s7 = Slider.new(~window, Rect(315, 10, 50, 200))
.action_({ |slider|
	~pi3.sendMsg('/sin', '/vol', slider.value.asFloat);
});

// instrument 2

~b8 = Button(~window, Rect( 250, 220, 50, 50))
		.states_([
			["OFF", Color.white, Color.black],
			["ON", Color.white, Color.red]
		])

.action_({ arg butt;
	if( butt.value == 1,
		{
			"formant1 PLAYING".postln;
			~pi3.sendMsg('/formant1', '/play');
		},
		{
			"formant1 STOPPED".postln;
			~pi3.sendMsg('/formant1', '/stop');
		}
	);
});

~h8 = NumberBox(~window, Rect(250, 220 + 60, 50, 50));
~h8.align = \center;
~h8.value = 3.2;

~s8 = Slider.new(~window, Rect(315, 220, 50, 200))
.action_({ |slider|
	~pi3.sendMsg('/formant1', '/vol', slider.value.asFloat);
});

// instrument 3

~b9 = Button(~window, Rect( 250, 430, 50, 50))
		.states_([
			["OFF", Color.white, Color.black],
			["ON", Color.white, Color.red]
		])

.action_({ arg butt;
	if( butt.value == 1,
		{
			"formant2 PLAYING".postln;
			~pi3.sendMsg('/formant2', '/play');
		},
		{
			"formant2 STOPPED".postln;
			~pi3.sendMsg('/formant2', '/stop');

		}
	);
});

~h9 = NumberBox(~window, Rect(250, 430 + 60, 50, 50));
~h9.align = \center;
~h9.value = 3.3;

~s9 = Slider.new(~window, Rect(315, 430, 50, 200))
.action_({ |slider|
	~pi3.sendMsg('/formant2', '/vol', slider.value.asFloat);
});


// sets fundamental for all tones

~sfund = Slider.new(~window, Rect(500, 10, 50, 200))
.action_({ |slider|
	var map;

	map = (slider.value.linlin(0.0, 1.0, 50.0, 200.0));
	map.postln;
	~pi1.sendMsg('/fund', map.asFloat);
	~pi2.sendMsg('/fund', map.asFloat);
	~pi3.sendMsg('/fund', map.asFloat);
});

~window.front;

);