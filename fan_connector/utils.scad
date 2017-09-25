
function translate2d(v, list) = [for (p = list) [p[0] + v[0], p[1] + v[1]]];

function _circle_perimeter(r = 1, a0 = 0, a1 = 360) =
	concat([for (i = [0:1:$fn-1])
			let(a = a0 + (a1-a0)/$fn*i) r*[cos(a), sin(a)]],
		[r*[cos(a1), sin(a1)]]);

function circle_perimeter(r = 1, a0 = 0, a1 = 360) =
	(a0 < a1) ?
		_circle_perimeter(r=r, a0=a0, a1=a1) :
		reverse(_circle_perimeter(r=r, a0=a1, a1=a0));

module show_pnt(p, txt="")
{
	#translate(p) {
		sphere(0.1, $fn=20);
		rotate([45, 0, 0])
		linear_extrude(1)
		text(
			//text = str(txt, " - (", p[0], ", ", p[1], ", ", p[2], ")"),
			text = txt,
			size = 1,
			halign="right"
		);
	}
}

function _animate(start, end) =
	end - abs(2*(end-start)*($t-0.5));
function animate(start, end, bounce = true) =
	(!bounce) ? start + (end-start)*$t :
		(start < end)? _animate(start, end) :
		-_animate(start, end) + start + end;
