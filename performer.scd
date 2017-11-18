//sirens, noon to midnight, LAPhil, Nov 18th
// Casey Anderson

s.latency= 0.05;

s.waitForBoot{

	// setup busses

	~vol1 = Bus.control(s, 1).set(0.0);
	~vol2 = Bus.control(s, 1).set(0.0);
	~vol3 = Bus.control(s, 1).set(0.0);
	~fund = Bus.control(s, 1).set(400);



	// setup synths

	SynthDef(\sin, { | amp = 0.0, end = 2, freq = 300, len = 2, max = 0.7, maxdelay = 1, min = 0.2, start = 1, trig = 1 |
		var env, line, sig;

		env = EnvGen.kr( Env.perc( len * 0.25, len * 0.75 ), trig, doneAction: 2 );
		line = Line.kr( start, end, len, 0.9, doneAction: 2 );
		sig = SinOsc.ar(freq * DelayN.kr(line, maxdelay, Rand(min, max)), 0.0, amp) * env;
		Out.ar( [0,1], sig * 0.20);
	}).add;


	SynthDef(\formant, { | amp = 0.0, end = 2, freq = 300, len = 2, max = 0.7, maxdelay = 1, min = 0.2, start = 1, trig = 1 |
		var env, clean, line, sig;

		env = EnvGen.kr( Env.perc( len * 0.25, len * 0.75, 0.99 ), trig, doneAction: 2 );
		line = XLine.kr( start, end, len, doneAction: 2 );
		sig = Formant.ar(freq * DelayN.kr(line, maxdelay, Rand(min, max),0.9), freq * DelayN.kr(line, maxdelay, Rand(min, max),0.9), freq * DelayN.kr(line, maxdelay, Rand(min, max),0.9), amp) * env;
		// clean = HPF.ar(sig, 50); // should probably be a compressor
		Out.ar( [0,1], sig );
	}).add;



	// the patterns
	~sinPattern = Pbind(
		\instrument, \sin,
		\freq, ~fund.asMap,
		\start, Prand([2,3,5,7,11,13], inf),
		\end, Prand([2,3,5,7,11,13], inf),
		\len, Pwhite(20, 50, inf),
		\amp, ~vol1.asMap,
		\dur, (Pkey(\len) + 2)
	);


	~formantPattern1 = Pbind(
		\instrument, \formant,
		\freq, ~fund.asMap,
		\start, Prand([2,3,5,7,11,13,17], inf),
		\end, Prand([2,3,5,7,11,13,17], inf),
		\len, Pwhite(20, 50, inf),
		\amp, ~vol2.asMap,
		\dur, (Pkey(\len) + 2)
	);

	~formantPattern2 = Pbind(
		\instrument, \formant,
		\freq, ~fund.asMap,
		\start, Prand([2,3,5,7,11,13,17], inf),
		\end, Prand([2,3,5,7,11,13,17], inf),
		\len, Pwhite(20, 50, inf),
		\amp, ~vol3.asMap,
		\dur, (Pkey(\len) + 2)
	);


	// setup OSC connections to busses

	OSCdef(\sinResponder, { | msg |

		msg.postln;

		switch( msg[1],
			'/play', {
				"play sin".postln;
				~sinPatternPlayer = ~sinPattern.play;
			},
			'/stop', {
				"stop sin".postln;
				~sinPatternPlayer.stop;
			},
			'/vol', {
				"vol".postln;
				~vol1.set( msg[2].asFloat );
			});

		}, '/sin');


	OSCdef(\formantResponder1, { | msg |

		msg.postln;
		switch( msg[1],
			'/play', {
				"play formant1".postln;
				~formantPatternPlayer1 = ~formantPattern1.play;
			},
			'/stop', {
				"stop formant1".postln;
				~formantPatternPlayer1.stop;
			},
			'/vol', {
				"vol".postln;
				~vol2.set( msg[2].asFloat );
			});

	}, '/formant1');


	OSCdef(\formantResponder2, { | msg |

		msg.postln;
			switch( msg[1],
			'/play', {
				"play formant2".postln;
				~formantPatternPlayer2 = ~formantPattern2.play;
			},
			'/stop', {
				"stop formant2".postln;
				~formantPattern2.stop;
			},
			'/vol', {
				"vol".postln;
				~vol3.set( msg[2].asFloat );
			});


	}, '/formant2');


	OSCdef(\fundResponder, { | msg |

		msg.postln;
		~fund.set(msg[1].asFloat);

	}, '/fund');


	OSCdef(\stopsound, {

		"sound stopped!".postln;
		CmdPeriod.run;

	}, '/stopsound');

};
