angle= 36;

pipe_diameter = 15;


width = 80;
height = 30;
depth = pipe_diameter*3/2;

nut_depth = 5;
nut_diameter = 7;
srew_diameter = 5;
difference(){
    cube([width,depth/2, height], center=true);


    //piples
    #translate([0,-pipe_diameter/2,-pipe_diameter*4]){
        rotate([0,angle/2, 0])
        cylinder(h=200, d = pipe_diameter);
        rotate([0,-angle/2, 0])
        cylinder(h=200, d = pipe_diameter);
    }
    
    //srew
    translate([0,depth/4,0])
    rotate([90,0,0])
    #cylinder(h=nut_depth,d=nut_diameter,   $fn = 6);
}