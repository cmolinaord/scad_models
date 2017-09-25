$fa = 2;
//Units in mm

//Fijas
D_ext_rodZ = 35;
H_rodZ = 10;
D_ext_rodX = 10;
D_ext_rodY = 10;
h_rod_peq = 4;

//Variables
esp_brazos = 7;
L_tornillo = 15.8;
D_tornillo = 2.8;

//Calculadas
sep_anillos = L_tornillo - h_rod_peq - esp_brazos;

D_in_grande = D_ext_rodZ + 2*esp_brazos + 2*sep_anillos;
D_out_grande= D_in_grande + 2*esp_brazos;

D_in_exterior = D_out_grande + 2*sep_anillos;
D_out_exterior= D_in_exterior + 2*esp_brazos;


difference() {
    translate([0,0,-0.5*(H_rodZ+4)])
    difference() {
        cylinder(h=H_rodZ+4,d=D_ext_rodZ+2*esp_brazos,center=false);
        translate([0,0,-1]) cylinder(h=H_rodZ+6,d=D_ext_rodZ,center=false);
        };
    union(){
    translate([0,-0.5*D_ext_rodZ-esp_brazos+h_rod_peq,0]) rotate([90,0,0])
    cylinder(h = 2*h_rod_peq, d = D_ext_rodY);
    translate([0,0.5*D_ext_rodZ+esp_brazos-h_rod_peq,0]) rotate([-90,0,0])
    cylinder(h = 2*h_rod_peq, d = D_ext_rodY);
    }
    };


difference() {
    translate([0,0,-0.5*(H_rodZ+4)])
    difference() {
        cylinder(h=H_rodZ+4,d=D_out_grande,center=false);
        translate([0,0,-1]) cylinder(h=H_rodZ+6,d=D_in_grande,center=false);
        };
    union(){
    union(){
    translate([h_rod_peq-0.5*D_out_grande,0,0]) rotate([0,-90,0])
    cylinder(h = 2*esp_brazos, d = D_ext_rodY);
    translate([h_rod_peq+0.5*D_in_grande,0,0]) rotate([0,90,0])
    cylinder(h = 2*esp_brazos, d = D_ext_rodY);
    }
    translate([0,0.5*(D_out_grande + sep_anillos),0]) rotate([90,0,0])
    cylinder(h = D_out_grande + sep_anillos, d = D_tornillo, center=false, $fn=20);
    }
    };

difference() {
    translate([0,0,-0.5*(H_rodZ+4)])
    difference() {
        cylinder(h=H_rodZ+4,d=D_out_exterior,center=false);
        translate([0,0,-1]) cylinder(h=H_rodZ+6,d=D_in_exterior,center=false);
        };
    translate([-0.5*(D_out_exterior + sep_anillos),0,0]) rotate([0,90,0])
    cylinder(h = D_out_exterior + sep_anillos, d = D_tornillo, center=false, $fn=20);
    };
