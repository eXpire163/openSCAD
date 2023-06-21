$fn = 30;

// not recommended but if you dont have flat screws
counterbore = "off"; //["on", "off"]
screwoffset = 25;




translate([0,0,8])
rotate([90,0,180])
%servo();
difference(){
    union(){
    hull(){
        translate([0,-20,0])
            cylinder(h=5, d=30, center=true);
        translate([0,+25,0])
            cylinder(h=5, d=30, center=true);
    }
    translate([0,-screwoffset,8]){ 
        bandFix();
        }
    translate([9,screwoffset,8]){ 
        wireFix();
        }
    }
    
    translate([0,-screwoffset,-0.49]){
         screw();         
    }
    translate([0,screwoffset,-0.49])
         screw();
    //cableInlet
    screw(hole = 8);
    
    //strap
    translate([0,0,-1.51])
         cube([32, 25,2], center = true); 
    // fusulage shape
    translate([-15,55,-2.5])
    rotate([0,0,-90])
        trapez3d();
}


module servo(){
    translate([0,0,0])
        cube([24, 12,28], center = true); 
    translate([5,8,16])
        cube([5, 20,4], center = true); 
    translate([0,0,7])
        cube([32, 12,3], center = true); 
}

module bandFix(){
    difference(){
        union(){
        translate([-7,0,0])
            cube([5,12,12], center=true);
        translate([7,0,0])
            cube([5,12,12], center=true);
        }
        rotate([0,90,0])
        #cylinder(h=50, d=4, center=true);
    }
}
module wireFix(){
    difference(){
        union(){
        translate([-3,0,0])
            cube([3,12,20], center=true);
        translate([3,0,0])
            cube([4,12,20], center=true);
        translate([0,0,-3])
            cube([4,12,6], center=true);
        }
        
        translate([0,0,7])
        rotate([0,90,0])
        #cylinder(h=50, d=2, center=true);
    }
}


module screw(hole = 4.5, height=3, head = 8){
    cylinder(30,d=hole, center=true);
    if(counterbore != "off"){
        cylinder(h = height, d1 = hole, d2 = head);
    }
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



module trapez3d(bottom = 30, top = 14.8, height = 3, length = 120){
    hull(){
            trapez(bottom, top, height);
            translate([length,0,0])
            trapez(bottom, top, height);
    }
}

