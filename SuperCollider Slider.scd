//run local server
(
s.boot;
s.meter;
)

//define synthdef
(
x= SynthDef(\twodslider, {
	|freq=400, pan=0|
	var sig = SinOsc.ar(freq,0,0.2);
	Out.ar(0, Pan2.ar(sig, pan));
}).add;
)

//instantiate synthdef
(
x=Synth(\twodslider, [\freq, 440]);
)

(
x.free;
)

//join p2psc
(
fork{
	p = P2PSC();
	p.sync;
	p.setName("Shirin");
	p.sync;
}
)

(
var columns, win, slider, temp, temp2, fixedx, userView, visColumns;


columns = [0.25, 0.5, 0.75, 1];
win = Window("2D Slider", Rect(200, 200, 300, 300)).front;
slider = Slider2D(win, Rect(20, 20, 260, 260)).background_(Color.gray).action_({|sld|
	temp = sld.y.linexp(0,1,200,1000);
	temp2 = sld.x.linexp(0,1,1,5);



	if (sld.x<= 0.25, {temp2 = 0.5;},
		{if (sld.x<= 0.5, {temp2 = 1;},
			{if (sld.x<= 0.75, {temp2 = 1.5;},
				{if (sld.x<= 1, {temp2 = 2;}) }
			)}
		)}
	);

	[temp, temp2].postln;
	});

fixedx = 0.2;

userView = UserView(win, slider.bounds)
.background_(Color.clear)
.canFocus_(false)
.acceptsMouse_(false)
.drawFunc_({
	var lineX;
	 columns.do { |col|
            lineX = slider.bounds.width * col;
	Pen.color = Color.black;
	Pen.line(Point(lineX, 0), Point(lineX, slider.bounds.height));
};
	Pen.stroke;
});


//p.sendMsg("/" ++ "laura" ++ "/ping", temp, temp2);
)







//reciever func
(
fork {
})	