// Hola mundo openSCAD

/*
comentarios
*/

$fs = 0.1; // tamaño minimo
$fa = 1; // angulo minimo

difference() {
    union() {
        cylinder(1,9,9);
        cylinder(3,3,3,$fn=6);
    }
    translate([0,0,-1]) cylinder(5,2,2,$fn=6);
}
