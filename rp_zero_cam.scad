outterSize = [65,30,1.2];
drill = [58, 23, 1];
drilloffset = drill/2;
holesize = 2.75;
$fn = 60;

difference(){
    cube(outterSize*1.22, center = true);
    
    translate([drilloffset.x, drilloffset.y,0])
        cylinder(20, d = holesize, center = true);
    translate([drilloffset.x, -drilloffset.y,0])
        cylinder(20, d = holesize, center = true);
    translate([-drilloffset.x, drilloffset.y,0])
        cylinder(20, d = holesize, center = true);
    translate([-drilloffset.x, -drilloffset.y,0])
        cylinder(20, d = holesize, center = true);
    
   //cam cable
    translate([-1.5,0,0])
        cube([8,10,5],center = true);
}

 // cam mount
 translate([10,0,15/2])
intersection(){
   
        cube([15,15,15],center = true);
    translate([-15/2,0,-15/2])
         sphere(r = 15);
    
    
}