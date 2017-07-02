$fn = 50;
pi = 3.14;

H = 3; // Heigth of torus
S_max = 8; // Maximum width of torus
S_min = 1.5; // Minumum width of torus
D_outer = 20;
D_inner = D_outer - S_max - S_min;
x = 0.5*(S_max - S_min); // Separation of centers
B = 3; // Bebel edge length for the 45 degree angle
h = 1; // Diameter of holes
N = 20; // Number of holes
s = 0.2; // Thickness of walls

echo("Area entrada:",(S_max-2*s)*(H+B-2*s));
echo("Area salida:",N*pi*h*h);


difference(){

union(){
difference(){
    difference(){
        cylinder(H,D_outer,D_outer);
        translate([x,0,-s]) cylinder(H+s,D_inner,D_inner);
    }
    translate([0,0,s])
    difference(){
        cylinder(H,D_outer - 2*s,D_outer - 2*s);
        translate([x,0,0]) cylinder(H,D_inner + 2*s,D_inner + 2*s);
    }
}
translate([0,0,H])
difference(){
    difference(){
        cylinder(B,D_outer,D_outer);
        translate([x,0,0]) cylinder(2*B,D_inner,D_inner + 2*B);
    }
    translate([0,0,0])
    difference(){
        cylinder(B - 2*s,D_outer - 2*s,D_outer - 2*s);
        translate([x,0,-0.1*s]) cylinder(2*B,D_inner + 2*s,D_inner + 2*B + 2*s);
    }
}

}

translate([x,0,H])
for (i = [0:N-1]){
    ang = i * 360 / N;
    rotate([0,0,ang])
    translate([D_inner+B,0,0])
    rotate([0,-45,0])
    cylinder(2*sqrt(B),h,h);
}

}
