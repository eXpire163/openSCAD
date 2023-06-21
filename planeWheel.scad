$fn= 50;

wheel_size = 100;
wheel_width = 15;
wheel_hole = 5;
arms = 3;
arm_thickness = 4;
hud_ratio = 1.2;



rotate_extrude(convexity = 10)
translate([wheel_size/2, 0, 0])
difference(){
    
    //circle(wheel_width/2);
    scale([0.5,1,1])
    square(wheel_width, center=true);
    translate([-wheel_width-2,-wheel_width/2,0])
    square(wheel_width);
    
}


difference(){
   union() {
       arms();
       cylinder(h=wheel_width,r=hud_ratio*wheel_hole, center=true );
   }
    cylinder(h=2*wheel_width,d=wheel_hole, center=true );
}




module arms(){
    step = 360/arms;
    for(s = [0: step: 360]){
        echo(s)
        rotate([0,0,s])
        translate([wheel_size/4,0,0])
        arm();
    }
}


module arm(){
rotate_extrude(angle=180, convexity = 10)
translate([wheel_size/4, 0, 0])
square([arm_thickness,wheel_width],center = true);
}

