

$fn=16;
holes = 4;
hole_size = 6;
hole_distance = 30;

thickness = 5;
depth = 15;

socket_thickness =20;
styled = "off"; // ["on", "off"]


module cylinder3d(h, d, center){
    rotate([0,0,45]){
    cylinder(h=h,d=d, center=center);
    translate([d/4, d/4,0])
        cube([d/2,d/2, h ], center=center);
    }
}

intersection(){

    difference(){

        cube([1+(holes)*hole_distance, thickness, depth]);
        //holes
        translate([hole_distance/2, 0,depth*2/3]){
            rotate([90,0,0])
            for(x=[0:holes-1]){
                translate([x*hole_distance,0,0])
                cylinder3d(h=thickness*3,d=hole_size, center=true);
            }
            
        }

    }
    if(styled=="on"){
    //style cureves
        translate([hole_distance/2, 0,depth/2]){
            rotate([90,0,0])
            for(x=[0:holes-1]){
                translate([x*hole_distance,0,0])
                scale([2,1,1])
                %cylinder(h=thickness*3,d=20, center=true);
            }
            
        }
    }
}
translate([0,(-socket_thickness+thickness)/2, 0])
cube([1+(holes)*hole_distance, socket_thickness, thickness/2 ]);
