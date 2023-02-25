$fn = 30;

module screw(hole = 4, height=3, head = 8){
        cylinder(30,d=hole, center=true);
    cylinder(h = height, d1 = hole, d2 = head);
    
    }


difference(){
cube([30, 70, 5], center = true);
    translate([0,-25,-0.49])
         screw();
    translate([0,25,-0.49])
         screw();
    //strap
    translate([0,0,-1.51])
         cube([32, 25,2], center = true); 
}