// Version v_2
// Disminuido grosor de la placa fina de la arandela exterior
// para que sea menor (la midad) que la de la arandela interior y
// no roze con el soporte metalico


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

//d_rod = 13mm
/*
factor=13/531.7;

z_plate = 123.1*factor;
z_rod = 224*factor;
z_space = 402.1*factor;
z_belt = 281*factor;
z_gap = 0.5*(z_space-z_rod)*factor;

//d_rod = 531.7*factor; //13mm
d_rod=13;
d_hole = 307*factor;
d_shaft = 169.4*factor;
d_belt = 40*factor;
*/

z_plate = 3;
z_rod = 5;
z_space = 9;
z_belt = 6;
z_gap = 0.5*(z_space-z_rod);

d_rod = 13/2; //13mm
d_hole = 7/2;
d_shaft = 4/2;
d_belt = 1;




//z_space=500;

// derivadas Inner ring
z_IR_A = z_gap+z_plate;
z_IR_B = z_gap;

// derivadas Outter ring
z_OR_A = 0.5*z_space - 0.5*z_gap;
z_OR_B = 0.5*z_gap;
z_OR_C = 0.5*(z_space - z_belt) - 0.5*z_gap;
d_OR_d = 2*d_belt-0.5*z_gap;


difference() {
    union(){  
        cylinder(z_IR_A,d_hole,d_hole); // central
        cylinder(z_IR_B,0.7*d_rod,0.7*d_rod); // periferico
    }
    // agujero
    translate([0,0,-0.1]) cylinder(z_IR_A+0.2,d_shaft+0.2,d_shaft+0.1);
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





translate([4*d_rod,0,0])

difference() {
    union(){  
        cylinder(z_IR_A,d_hole,d_hole); // central
        cylinder(z_IR_B,0.7*d_rod,0.7*d_rod); // periferico
    }
    // agujero
    translate([0,0,-0.1]) cylinder(z_IR_A+0.2,d_shaft+0.2,d_shaft+0.2);
}

translate([4*d_rod,0,0])
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
