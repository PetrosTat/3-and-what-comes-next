///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Startup
(
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=2;
TempoClock.default.tempo_(160/60);
MIDIClient.init;
MIDIIn.connectAll;
)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////SynthDef

(
 SynthDef(\Signals,
	 {
	   arg
		/////////////////////////////////////////////////////////////////////////////Fundamental Argument
		    fundamental ,
	    ////////////////////////////////////////////////////////////////////////////Carrier Presence Arguments
		    pr1, pr2, pr3,
        ///////////////////////////////////////////////////////////////////////////FM, AM, Carrier Ratios and Index of Modulation Arguments
		    c1_ratio, c2_ratio, c3_ratio,
		    m1_ratio=1,
		    amp_m1_ratio=0.1,
		////////////////////////////////////////////////////////////////////////Index of Modulation Argument
		    fm_index=1,
        //////////////////////////////////////////////////////////////////////////Envelope Arguments
            attack1, attack2, attack3,
		    decay1, decay2, decay3,
		    sustain1, sustain2, sustain3,
		    release1, release2, release3,
		/////////////////////////////////////////////////////////////////////////Panning Arguments
		   azimuth, elevation;

	    var
		////////////////////////////////////////////////////////////////////////Carrier Variables
		    carrier1, carrier2, carrier3,
		    c1_freq, c2_freq, c3_freq,
		////////////////////////////////////////////////////////////////////////FM Variables
		    fm1,
		    fm1_freq,
		////////////////////////////////////////////////////////////////////////AM Variables
		    am1, am2, am3,
		    am1_freq,  am2_freq,  am3_freq,
		////////////////////////////////////////////////////////////////////////Envelope Varables
		    sig1, sig2, sig3,
		////////////////////////////////////////////////////////////////////////Signal Variables
		    env1, env2, env3,
		////////////////////////////////////////////////////////////////////////Output Variables
		   signal, audio;

		///////////////////////////////////////////////////////////////////////Frequency Modulator Ugens
		fm1_freq = (fundamental * m1_ratio);
		fm1 = SinOsc.ar(freq:fm1_freq, mul:fm1_freq * fm_index);

		////////////////////////////////////////////////////////////////////////Carrier Frequency
		c1_freq = ((fundamental * (c1_ratio/pr1)) + fm1);
		c2_freq = ((fundamental * (c2_ratio/pr2)) + fm1);
		c3_freq = ((fundamental * (c3_ratio/pr3)) + fm1);

       ////////////////////////////////////////////////////////////////////////Amplitude Modulator Ugens
		am1_freq = (c1_freq *amp_m1_ratio);
		am2_freq = (c2_freq *amp_m1_ratio);
		am3_freq = (c3_freq *amp_m1_ratio);
		am1 = SinOsc.ar(am1_freq);
		am2 = SinOsc.ar(am1_freq);
		am3 = SinOsc.ar(am1_freq);

        ////////////////////////////////////////////////////////////////////////Carrier Ugens
		 carrier1 = SinOsc.ar(freq:c1_freq, mul:am1)*AmpComp.kr((fundamental * (c1_ratio/pr1)),fundamental,0.15);
		carrier2 = SinOsc.ar(freq:c2_freq, mul:am1)*AmpComp.kr((fundamental * (c1_ratio/pr1)),fundamental,0.15);
		 carrier3 = SinOsc.ar(freq:c3_freq, mul:am1)*AmpComp.kr((fundamental * (c1_ratio/pr1)),fundamental,0.15);
		///////////////////////////////////////////////////////////////////////Envelopes
		env1 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack1, decay1, sustain1, release1],[2, 3, 0,-3]),doneAction:2);
		env2 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack2, decay2, sustain2, release2],[2, 3, 0,-3]),doneAction:2);
		env3 = EnvGen.ar(Env.new([0,1, 0.5, 0.5,0], [attack3, decay3, sustain3, release3],[2, 3, 0,-3]),doneAction:2);

		///////////////////////////////////////////////////////////////////////Signals
		sig1 = (carrier1 * env1 ); sig2 = (carrier2 * env2);  sig3 = (carrier3 * env3);

        ///////////////////////////////////////////////////////////////////////Synthesis
		signal = (  (sig1 * pr1)+ (sig2 * pr2) + (sig3 * pr3)  );
		///////////////////////////////////////////////////////////////////////Output
		audio = PanAz.ar(2,signal,azimuth);
		Out.ar(0,audio);
    }
  ).add;
)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////midi
(
(~attack1 = 1;  ~pot1 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~attack1 = vel.linlin(0,127,0.01,1)}, 20, 0));
(~decay1 = 1;  ~pot4 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~decay1 = vel.linlin(0,127,0.01,1)}, 21, 0));
(~sustain1 = 1;  ~pot7 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~sustain1 = vel.linlin(0,127,0.01,1)}, 22, 0));
(~release1 = 1;  ~pot10 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~release1 = vel.linlin(0,127,0.01,1)}, 23, 0));
(~cmod1 = 1;  ~pot16 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~cmod1 = vel.linlin(0,127,1,6)}, 24, 0));
(~presence1 = 1;  ~pot13 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~presence1 = vel.linlin(0,127,1/3,1)}, 25, 0));
(~fmmod = 1;  ~pot19 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~fmmod = vel.linlin(0,127,1,6)}, 26, 0));
(~attack2 = 1;  ~pot2 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~attack2 = vel.linlin(0,127,0.01,1)}, 27, 0));
(~decay2 = 1;  ~pot5 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~decay2 = vel.linlin(0,127,0.01,1)}, 28, 0));
(~sustain2 = 1;  ~pot8 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~sustain2 = vel.linlin(0,127,0.01,1)}, 29, 0));
(~release2 = 1;  ~pot11 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~release2 = vel.linlin(0,127,0.01,1)}, 30, 0));
(~cmod2 = 1;  ~pot17 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~cmod2 = vel.linlin(0,127,1,6)}, 31, 0));
(~presence2 = 1;  ~pot14 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~presence2 = vel.linlin(0,127,1/3,1)}, 85, 0));
(~ammod = 1;  ~pot20 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~ammod = vel.linlin(0,127,0.01,0.1)}, 86, 0));
(~attack3 = 1;  ~pot3 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~attack3 = vel.linlin(0,127,0.01,1)}, 87, 0));
(~decay3 = 1;  ~pot6 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~decay3 = vel.linlin(0,127,0.01,1)}, 88, 0));
(~sustain3 = 1;  ~pot9 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~sustain3 = vel.linlin(0,127,0.01,1)}, 89, 0));
(~release3 = 1;  ~pot12 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~release3 = vel.linlin(0,127,0.01,1)}, 90, 0));
(~cmod3 = 1;  ~pot18 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~cmod3 = vel.linlin(0,127,1,6)}, 102, 0));
(~presence3 = 1;  ~pot15 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~presence3 = vel.linlin(0,127,1/3,1)}, 103, 0));
(~azimuthio = 1;  ~pot21 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~azimuthio = vel.linlin(0,127,-0.5,0.5)}, 104, 0));
(~fundfreq = 1;  ~pot22 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~fundfreq = vel.linlin(0,127,20,110)}, 105, 0));
(~fmindex = 1;  ~pot23 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~fmindex = vel.linlin(0,127,0.1,1)}, 106, 0));
(~presence0 = 1;  ~pot24 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~presence0 = vel.linlin(0,127,0,1)}, 107, 0));
)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Task with Patterns
(
Tdef(\t_signals,
      {

			1.do(
			{
				(
			       a = Pdef(\p_signals,
                                  Pbind(
					\instrument, \Signals, \dur, Prand([0.5],inf),
						//	\azimuth, Pfunc({~azimuthio}),
							\azimuth, Pxrand([0.5,-0.5],inf),

							\c1_ratio, Pfunc({~cmod1}),   \c2_ratio, Pfunc({~cmod2}),   \c3_ratio, Pfunc({~cmod3}),

					       	 \fm_index, Pseq([1,Pfunc({~fmindex}),1],inf), 	\amp_m1_ratio, Pfunc({~ammod}),

							\m1_ratio, Pseq([1*Pfunc({~fmmod}),2*Pfunc({~fmmod}),3*Pfunc({~fmmod}),4*Pfunc({~fmmod}),5*Pfunc({~fmmod}),6*Pfunc({~fmmod})],inf),

							\fundamental, Pfunc({~fundfreq}),

							\attack1, Pfunc({~attack1}),    \attack2, Pfunc({~attack2}),    \attack3, Pfunc({~attack3}),
                        	\decay1, Pfunc({~decay1}),    \decay2, Pfunc({~decay2}),    \decay3, Pfunc({~decay3}),
							\sustain1, Pfunc({~sustain1}),    \sustain2, Pfunc({~sustain2}),    \sustain3, Pfunc({~sustain3}),
				           	\release1, Pfunc({~release1}),    \release2,Pfunc({~release2}),    \release3, Pfunc({~release3}),

							\pr1,  Pfunc({~presence1}),    \pr2,  Pfunc({~presence2}),   \pr3, Pfunc({~presence3});
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