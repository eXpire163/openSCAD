$fn = 30;

module screw(hole = 4.5, height=3, head = 8){
        cylinder(30,d=hole, center=true);
    // cylinder(h = height, d1 = hole, d2 = head);
    
    }



difference(){
    hull(){
        translate([0,-20,0])
            cylinder(h=5, d=30, center=true);
        translate([0,+20,0])
            cylinder(h=5, d=30, center=true);
    }
    translate([0,-25,-0.49])
         screw();
    translate([0,25,-0.49])
         screw();
    //strap
    translate([0,0,-1.51])
         cube([32, 25,2], center = true); 
    // fusulage shape
    translate([-15,35,-2.5])
    rotate([0,0,-90])
        trapez3d();
}




module trapez(bottom = 30, top = 25, height = 10){
    off = (bottom-top);
    CubePoints = [
  [  0,  0,  0 ],  //0
  [ 0,  bottom,  0 ],  //1
  [ 0,  bottom-off,  height ],  //2
  [  0,  off,  height ]  //3
];
CubeFaces = [
  [0,1,2,3]  // bottom
  ]; // left

polyhedron( CubePoints, CubeFaces );
}



module trapez3d(bottom = 30, top = 14.8, height = 3, length = 70){
    hull(){
            trapez(bottom, top, height);
            translate([length,0,0])
            trapez(bottom, top, height);
    }
}

