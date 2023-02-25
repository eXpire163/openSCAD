// wall mount
$fn = 50;
width = 13;
depth= 80;
height = 50;

top_tickness = 5;
cut_scale = 1.1;
drill_hole = 4.5;
drill_hole_top = 9; 

drilldiff = drill_hole_top-drill_hole;



module hole(){
    cylinder(h= top_tickness+1, d=drill_hole);
    cylinder(h=drilldiff/2, d1 = drill_hole_top, d2=drill_hole);
}
//lay flat printing
rotate([0,-90,0]){

    //top
    translate([0,0,height])
    cube([width, depth, top_tickness]);


    //wall
    difference(){
        cube([width, top_tickness, height]);
        translate([width*2/3,top_tickness,  height*1/5])
        rotate([90,0,0])    
        hole();
        translate([width*2/3,top_tickness,  height*4/5])
        rotate([90,0,0])    
        hole();
    }
    //rim
    intersection(){
    difference(){
        
        cube([top_tickness, depth, height]);
        translate([0,depth,0])
        scale([1,(depth-top_tickness)/height,1])
        rotate([0,90,0])
        cylinder(h=width, r=height);
    }
        translate([0,depth,0])
        scale(cut_scale)
        scale([1,(depth-top_tickness)/height,1])
        rotate([0,90,0])
        cylinder(h=width, r=height);
    }

}