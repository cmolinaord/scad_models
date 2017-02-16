// IR = inner ring
// OR = outter ring


$fs = 0.1;
$fa = 1;

/*
z_space = 20;
z_rod = 16;
z_gap = 0.5*(z_space-z_rod);
z_plate = 3;

z_belt = 10;

d_shaft = 5;
d_hole = 8;
d_rod = 40;
d_belt = 1;
*/

// Medidas en pixeles
// Hay que traducirlas a m

z_plate = 123.1;
z_rod = 224;
z_space = 402.1;
z_belt = 281;
z_gap = 0.5*(z_space-z_rod);


d_rod = 531.7;
d_hole = 307;
d_shaft = 169.4;
d_belt = 50;


//z_space=500;

// derivadas Inner ring
z_IR_A = z_gap+z_plate;
z_IR_B = z_gap;

// derivadas Outter ring
z_OR_A = 0.5*z_space - 0.1;
z_OR_B = z_gap;
z_OR_C = 0.5*(z_space - z_belt) - 0.2;
d_OR_d = 2*d_belt;


difference() {
    union(){  
        cylinder(z_IR_A,d_hole,d_hole); // central
        cylinder(z_IR_B,0.7*d_rod,0.7*d_rod); // periferico
    }
    // agujero
    translate([0,0,-0.1]) cylinder(z_IR_A+0.2,d_shaft+0.2,d_shaft+0.2);
}


difference() {
    difference() {
        union() {
            cylinder(z_OR_A,d_rod+z_gap,d_rod+z_gap);
            cylinder(z_OR_C,d_rod+z_gap+d_belt*3,d_rod+z_gap+d_belt*3);
        }
        translate([0,0,z_OR_B]) cylinder(z_OR_A,d_rod,d_rod);
        
        }
    translate([0,0,-1]) cylinder(z_OR_A,0.8*d_rod,0.8*d_rod);
}


// eje
//translate([0,0,-z_space]) cylinder(z_space*4,d_shaft,d_shaft);
