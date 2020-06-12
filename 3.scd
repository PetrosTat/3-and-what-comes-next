///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Startup
(
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=2;
TempoClock.default.tempo_(120/60);
MIDIClient.init;
MIDIIn.connectAll;
)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////SynthDef

(
 SynthDef(\Signals,
	 {
	   arg
	    ////////////////////////////////////////////////////////////////////////////Carrier Presence Arguments
		    pr1, pr2, pr3, pr4, pr5, pr6, pr7, pr8, pr9, pr10, pr11, pr12,
        ///////////////////////////////////////////////////////////////////////////FM, AM, Carrier Ratios and Index of Modulation Arguments
		    c1_ratio, c2_ratio, c3_ratio, c4_ratio, c5_ratio, c6_ratio,
		    c7_ratio, c8_ratio, c9_ratio, c10_ratio, c11_ratio, c12_ratio,
		    m1_ratio=1,
		    amp_m1_ratio=1,
        //////////////////////////////////////////////////////////////////////////Envelope Arguments
            attack1, attack2, attack3, attack4, attack5, attack6, attack7, attack8, attack9, attack10, attack11, attack12,
		    decay1, decay2, decay3, decay4, decay5, decay6, decay7, decay8, decay9, decay10, decay11, decay12,
		    sustain1, sustain2, sustain3, sustain4, sustain5, sustain6, sustain7, sustain8, sustain9, sustain10, sustain11, sustain12,
		    release1, release2, release3, release4, release5, release6, release7, release8, release9, release10, release11, release12,
		/////////////////////////////////////////////////////////////////////////Panning Arguments
		   azimuth, elevation;


	    var
		////////////////////////////////////////////////////////////////////////Carrier Variables
		    carrier1, carrier2, carrier3, carrier4, carrier5, carrier6,
	        carrier7, carrier8, carrier9, carrier10, carrier11, carrier12,
		    c1_freq, c2_freq, c3_freq, c4_freq, c5_freq, c6_freq,
		    c7_freq, c8_freq, c9_freq, c10_freq, c11_freq, c12_freq,
		////////////////////////////////////////////////////////////////////////FM Variables
		    modulator1,
		    m1_freq,
		////////////////////////////////////////////////////////////////////////AM Variables
		    amp1,
		    amp_mod1_freq=1,
		////////////////////////////////////////////////////////////////////////Fundamental and Index
		    frequency = 220,
		    modulation_index=1,
		////////////////////////////////////////////////////////////////////////Envelope Varables
		    sig1, sig2, sig3, sig4, sig5, sig6, sig7, sig8, sig9, sig10, sig11, sig12,
		////////////////////////////////////////////////////////////////////////Signal Variables
		    env1, env2, env3, env4, env5, env6, env7, env8, env9, env10, env11, env12,
		////////////////////////////////////////////////////////////////////////Output Variables
		   signal, audio;

		////////////////////////////////////////////////////////////////////////Amplitude Modulator Ugens
		amp_mod1_freq = (frequency *amp_m1_ratio);
		amp1 = SinOsc.ar(amp_mod1_freq);

		///////////////////////////////////////////////////////////////////////Frequency Modulator Ugens
		m1_freq = (frequency * m1_ratio);
		modulator1 = SinOsc.ar(freq:m1_freq, mul:m1_freq * modulation_index);

		////////////////////////////////////////////////////////////////////////Carrier Ugens
		c1_freq = ((frequency * c1_ratio) + modulator1); carrier1 = SinOsc.ar(freq:c1_freq, mul:amp1);
		c2_freq = ((frequency * c2_ratio) + modulator1); carrier2 = SinOsc.ar(freq:c2_freq, mul:amp1);
		c3_freq = ((frequency * c3_ratio) + modulator1); carrier3 = SinOsc.ar(freq:c3_freq, mul:amp1);
		c4_freq = ((frequency * c4_ratio) + modulator1); carrier4 = SinOsc.ar(freq:c4_freq, mul:amp1);
		c5_freq = ((frequency * c5_ratio) + modulator1); carrier5 = SinOsc.ar(freq:c5_freq, mul:amp1);
		c6_freq = ((frequency * c6_ratio) + modulator1); carrier6 = SinOsc.ar(freq:c6_freq, mul:amp1);
		c7_freq = ((frequency * c7_ratio) + modulator1); carrier7 = SinOsc.ar(freq:c7_freq, mul:amp1);
		c8_freq = ((frequency * c8_ratio) + modulator1); carrier8 = SinOsc.ar(freq:c8_freq, mul:amp1);
		c9_freq = ((frequency * c9_ratio) + modulator1); carrier9 = SinOsc.ar(freq:c9_freq, mul:amp1);
		c10_freq = ((frequency * c10_ratio) + modulator1); carrier10 = SinOsc.ar(freq:c10_freq, mul:amp1);
		c11_freq = ((frequency * c11_ratio) + modulator1); carrier11 = SinOsc.ar(freq:c11_freq, mul:amp1);
		c12_freq = ((frequency * c12_ratio) + modulator1); carrier12 = SinOsc.ar(freq:c12_freq, mul:amp1);

		///////////////////////////////////////////////////////////////////////Envelopes
		env1 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack1, decay1, sustain1, release1],[2, 3, 0,-3]),doneAction:2);
		env2 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack2, decay2, sustain2, release2],[2, 3, 0,-3]),doneAction:2);
		env3 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack3, decay3, sustain3, release3],[2, 3, 0,-3]),doneAction:2);
		env4 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack4, decay4, sustain4, release4],[2, 3, 0,-3]),doneAction:2);
		env5 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack5, decay5, sustain5, release5],[2, 3, 0,-3]),doneAction:2);
		env6 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack6, decay6, sustain6, release6],[2, 3, 0,-3]),doneAction:2);
		env7 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack7, decay7, sustain7, release7],[2, 3, 0,-3]),doneAction:2);
		env8 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack8, decay8, sustain8, release8],[2, 3, 0,-3]),doneAction:2);
		env9 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack9, decay9, sustain9, release9],[2, 3, 0,-3]),doneAction:2);
		env10 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack10, decay10, sustain10, release10],[2, 3, 0,-3]),doneAction:2);
		env11 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack11, decay11, sustain11, release11],[2, 3, 0,-3]),doneAction:2);
		env12 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack12, decay12, sustain12, release12],[2, 3, 0,-3]),doneAction:2);

		///////////////////////////////////////////////////////////////////////Signals
		sig1 = (carrier1 * env1); sig2 = (carrier2 * env2);  sig3 = (carrier3 * env3);
		sig4 = (carrier4 * env4); sig5 = (carrier5 * env5); sig6 = (carrier6 * env6);
		sig7 = (carrier7 * env7); sig8 = (carrier8 * env8);  sig9 = (carrier9 * env9);
		sig10 = (carrier10 * env10); sig11 = (carrier11 * env11); sig12 = (carrier12 * env12);

        ///////////////////////////////////////////////////////////////////////Synthesis
		signal = (
			     (sig1 * pr1) + (sig2 * pr2) + (sig3 * pr3) + (sig4 * pr4) + (sig5 * pr5) + (sig6 * pr6) +
		         (sig7 * pr7) + (sig8 * pr8) + (sig9 * pr9) + (sig10 * pr10) + (sig11 * pr11) + (sig12 * pr12)
		        );

		///////////////////////////////////////////////////////////////////////Output
		audio = PanAz.ar(2,signal,azimuth);
        Out.ar(0,audio);
    }
  ).add;
)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////midi
(
~azimuthio = 0;
 ~pot1 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;
                                    	~azimuthio = vel.linlin(0,127,-0.5,0.5);
}, 75, 0);
);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Task with Patterns
(
Tdef(\t_signals,
      {

			1.do(
			{
				(
			       a = Pdef(\p_signals,
                                  Pbind(
					\instrument, \Signals, \dur,2,
							\azimuth, Pfunc({~azimuthio}),

							\c1_ratio, Pxrand([1,2,3,4],inf), \c2_ratio, Pxrand([1,2,3,4],inf), \c3_ratio, Pxrand([1,2,3,4],inf),
							\c4_ratio, Pxrand([1,2,3,4],inf), \c5_ratio, Pxrand([1,2,3,4],inf), \c6_ratio, Pxrand([1,2,3,4],inf),
							\c7_ratio, Pxrand([1,2,3,4],inf), \c8_ratio, Pxrand([1,2,3,4],inf), \c9_ratio, Pxrand([1,2,3,4],inf),
							\c10_ratio, Pxrand([1,2,3,4],inf), \c11_ratio, Pxrand([1,2,3,4],inf), \c12_ratio, Pxrand([1,2,3,4],inf),

							\attack1, Pxrand([0.01,0.03,0.06],inf), \attack2, Pxrand([0.01,0.03,0.06],inf), \attack3, Pxrand([0.01,0.03,0.06],inf),
							\attack4, Pxrand([0.01,0.03,0.06],inf), \attack5, Pxrand([0.01,0.03,0.06],inf), \attack6, Pxrand([0.01,0.03,0.06],inf),
							\attack7, Pxrand([0.01,0.03,0.06],inf), \attack8, Pxrand([0.01,0.03,0.06],inf), \attack9, Pxrand([0.01,0.03,0.06],inf),
							\attack10, Pxrand([0.01,0.03,0.06],inf), \attack11, Pxrand([0.01,0.03,0.06],inf), \attack12, Pxrand([0.01,0.03,0.06],inf),

							\decay1, Pxrand([0.6,0.9,1.2],inf), \decay2, Pxrand([0.6,0.9,1.2],inf), \decay3, Pxrand([0.6,0.9,1.2],inf),
							\decay4, Pxrand([0.6,0.9,1.2],inf), \decay5, Pxrand([0.6,0.9,1.2],inf), \decay6, Pxrand([0.6,0.9,1.2],inf),
							\decay7, Pxrand([0.6,0.9,1.2],inf), \decay8, Pxrand([0.6,0.9,1.2],inf), \decay9, Pxrand([0.6,0.9,1.2],inf),
							\decay10, Pxrand([0.6,0.9,1.2],inf), \decay11, Pxrand([0.6,0.9,1.2],inf), \decay12, Pxrand([0.6,0.9,1.2],inf),

							\sustain1, Pxrand([0.1,0.3,0.6],inf), \sustain2, Pxrand([0.1,0.3,0.6],inf), \sustain3, Pxrand([0.1,0.3,0.6],inf),
							\sustain4, Pxrand([0.1,0.3,0.6],inf), \sustain5, Pxrand([0.1,0.3,0.6],inf), \sustain6, Pxrand([0.1,0.3,0.6],inf),
							\sustain7, Pxrand([0.1,0.3,0.6],inf), \sustain8, Pxrand([0.1,0.3,0.6],inf), \sustain9, Pxrand([0.1,0.3,0.6],inf),
							\sustain10, Pxrand([0.1,0.3,0.6],inf), \sustain11, Pxrand([0.1,0.3,0.6],inf), \sustain12, Pxrand([0.1,0.3,0.6],inf),

							\release1, Pxrand([0.6,0.9,1.2],inf), \release2, Pxrand([0.6,0.9,1.2],inf), \release3, Pxrand([0.6,0.9,1.2],inf),
							\release4, Pxrand([0.6,0.9,1.2],inf), \release5, Pxrand([0.6,0.9,1.2],inf), \release6, Pxrand([0.6,0.9,1.2],inf),
							\release7, Pxrand([0.6,0.9,1.2],inf), \release8, Pxrand([0.6,0.9,1.2],inf), \release9, Pxrand([0.6,0.9,1.2],inf),
							\release10, Pxrand([0.6,0.9,1.2],inf), \release11, Pxrand([0.6,0.9,1.2],inf), \release12, Pxrand([0.6,0.9,1.2],inf),

							\pr1, Pseq([1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1],inf), \pr2, Pseq([1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1,1/12],inf),
							\pr3, Pseq([1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1,1/12,1/12],inf), \pr4, Pseq([1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1,1/12,1/12,1/12],inf),
							\pr5, Pseq([1/12,1/12,1/12,1/12,1/12,1/12,1/12,1,1/12,1/12,1/12,1/12],inf), \pr6, Pseq([1/12,1/12,1/12,1/12,1/12,1/12,1,1/12,1/12,1/12,1/12,1/12],inf),
							\pr7, Pseq([1/12,1/12,1/12,1/12,1/12,1,1/12,1/12,1/12,1/12,1/12,1/12],inf), \pr8, Pseq([1/12,1/12,1/12,1/12,1,1/12,1/12,1/12,1/12,1/12,1/12,1/12],inf),
							\pr9, Pseq([1/12,1/12,1/12,1,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12],inf), \pr10, Pseq([1/12,1/12,1,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12],inf),
							\pr11, Pseq([1/12,1,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12],inf), \pr12, Pseq([1,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12,1/12],inf);

						)
                          ).play(quant:1)
	            ); 0.yield
		    }
	    );
     })
)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////play and MIDI
(
Tdef(\t_signals).play;
//s.record(numChannels:2);

)