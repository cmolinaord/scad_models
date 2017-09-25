use <utils.scad>

$fn = 30;
$fa = 5;

module fc_arc_secc(width, height, thick)
{
	function ellipse_f(b, a, ang = 360) = concat(
		[for (x=[0:$fa:ang-$fa/2]) [a*cos(x), b*sin(x)]],
		[[a*cos(ang), b*sin(ang)]]
	);

	ellipse = concat(ellipse_f(width, height, 90), [[0, 0]]);
	mayor = (width > height)? width : height;

	translate([0, height, 0]) rotate([0, 0, -90])
	intersection() {
		square([mayor, mayor], center = false);
		difference() {
			polygon(ellipse);
			offset(r=-thick) polygon(ellipse_f(width, height));
		}
	}
}

module fc_square_secc(conn_size, thick)
{
	difference() {
		square([conn_size[0], conn_size[1]], center=true);
		square([conn_size[0]-thick*2, conn_size[1]-thick*2], center=true);
	}
}

module fc_arc(width, height, conn_size, thick)
{
	t  = thick*2;
	tm = thick;

	translate([0, conn_size[1], 0]) rotate([90, 0, 0])
	difference() {
		linear_extrude(conn_size[1])
			fc_arc_secc(width, height, conn_size[0]);
		translate([0, 0, tm])
			linear_extrude(conn_size[1] - t)
				translate([0, tm, 0])
					fc_arc_secc(
						width  - tm,
						height - tm,
						conn_size[0] - t
					);
	}

	// Move coordinate center
	translate([width - conn_size[0], 0, height])
		children();
}

module fc_top_elbow(conn_size, height, thick, angle)
{
	trans = [conn_size[0]/2, conn_size[1]/2, 0];
	translate(trans)
		linear_extrude(height = height, twist = angle, slices = $fn)
			fc_square_secc(conn_size, thick);

	translate(trans + [0, 0, height])
		rotate([0, 0, -angle])
			translate(-trans)
				children(0);
}

module fc_bot_elbow(rad, height, thick, angle)
{
	a     = abs(angle);
	neg   = angle < 0;
	rot   = [0, 0, neg? angle : 180];
	trans = [0, neg? 0 : rad];


	circle_a = concat(
		circle_perimeter(r = rad, a0 = 90, a1 = 90+a),
		[[0, 0]]
	);
	circle_b = concat(
		circle_perimeter(r = rad - thick, a0 = 90, a1 = 90+a*1.01),
		[[0, 0]]
	);
	circle_c = concat(
		circle_perimeter(r = thick, a0 = 90, a1 = 90+a*1.01),
		[[0, 0]]
	);

	translate(trans) rotate(rot)
		union() {
			linear_extrude(height) {
				difference() {
					polygon(circle_a);
					difference() {
						polygon(circle_b);
						polygon(circle_c);
					}
				}
			}
			linear_extrude(thick)
				polygon(circle_a);
			translate([0, 0, height-thick])
				linear_extrude(thick)
					polygon(circle_a);
		}

	// Moving coordinate center
	translate(neg? [0, 0, 0] : [rad*sin(a), rad - rad*cos(a), 0])
		rotate([0, 0, angle])
			children(0);
}

module fc_conn(conn_size, width, thick)
{
	w = width/2;
	cs2 = conn_size - [1, 1]*thick;

	union() {
		translate([conn_size[0]/2, conn_size[1]/2, 0]) {
			linear_extrude(w)
				fc_square_secc(conn_size, thick);
			translate([0, 0, w])
				linear_extrude(w)
					fc_square_secc(cs2, thick/2);
		}
		if ($children >= 1) rotate([0, 90, 0])         children(0);
		if ($children >= 2) translate([0, 0, width/2]) children(1);
	}
}

module fan_connector(conn_point, conn_size, conn_depth_a, conn_depth_b, thick)
{
	conn_depth = 10;

	pa        = [conn_depth, conn_size[1]];
	pb        = [conn_point[0], conn_point[1]];
	point_d   = pb - pa;
	norm_d    = norm(point_d);
	alpha     = atan2(point_d[1], point_d[0]);
	beta      = acos(conn_size[1]/norm_d);
	angle     = 90 - beta + alpha;
	arc_width = sqrt(pow(norm_d,2) - pow(conn_size[1],2)) + conn_size[0];

	echo(point_d);
	echo(angle);

	translate([10, 0, 0]) rotate([0, -90, 0])
	fc_conn(conn_size, conn_depth, thick) {
		fc_bot_elbow(conn_size[1], conn_size[0], thick, angle)
		fc_arc(arc_width, conn_point[2], conn_size, thick)
		fc_top_elbow(conn_size, conn_depth_a, thick, angle)
			fc_conn(conn_size, conn_depth, thick);

		color("red") cube([2, 1, 1]);
	}

	color("red") translate(conn_point) rotate(angle) cube([2, 2, 2]);
	//translate(pa) cube();
}

// TODO: Negative numbers
//fan_connector([30, -10, 20], [10, 15], 12, 10, 2);
fan_connector([30, 13, 20], [10, 15], 12, 10, 2);
