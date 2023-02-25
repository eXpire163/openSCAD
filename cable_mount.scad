// cable holder
//difference(){
//cube([55,15,15], center=true);
//cube([50,10,17], center=true);
//}

// cable dom

use <j-holder.scad>

$fn = 70;

diameter = 70;
distance = 50;

indent_diameter = 7;

height = 11;

holder_width = 15;
holder_distance = 300;

echo("total: ",diameter*PI+2*distance);

//base shape
module base_shape(){
linear_extrude(height, center=true){
union(){
    circle(d=diameter);
    translate([0,-distance/2,0])
        square([diameter, distance], center = true);
}
}
}


module boarder(){
union(){
//indent
rotate_extrude(angle =180, convexity = 1)
translate([diameter/2, 0, 0])
circle(d = indent_diameter, $fn = 100);

rotate([90,0,0]){
    translate([diameter/2, 0, 0])  
        cylinder(d=indent_diameter, h=distance);
    translate([-diameter/2, 0, 0])
        cylinder(d=indent_diameter, h=distance);
}
}
}
module ziptie(){
    translate([-diameter/2,-distance+15,height/2])
    cube([diameter,5,5], center=true);
}

//holder
module holder(){
    
    
    
    //j_holder(width, height, thickness, depth, drillwhole)
   
    translate([diameter/2-indent_diameter/2, -distance+holder_width, -height/2])   
    rotate([90,-90,0])
    difference(){
        j_holder(height, height, 2, holder_width, 0); 
            translate([height/2,-2*height,-1])
        cube([height,2*height,2*height])  ;
    }
}



difference(){
base_shape();
//base cutout shape
scale([0.8,0.8,1.1])
base_shape();
boarder();
ziptie();
}
holder();
    