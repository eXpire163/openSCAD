// barrel
$fn=100;
scale = 46; // 46 for toy, 87 for H0 scale

diameter = 571;
height = 875;


scale([1/scale,1/scale,1/scale]){
    //body    
    cylinder(h=height, d=diameter);
    //rings
    for(x=[0:3]){
        translate([0,0,x*((height-10)/3)])
        difference(){
            cylinder(h=20, d=diameter+20);
            cylinder(h=30, d=diameter-20);
        }
    }
    //inlet
    translate([diameter/3,0,height])
    cylinder(h=20, d=60);
    
}