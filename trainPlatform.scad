use<shapes.scad>


module platform(width=45, height=11, splits = 5, thickness=1.5, overhang = 1, bar_width=0.5){
    
    difference(){
        ccube(width, thickness, height);
        grid(width+bar_width, height,splits, 0,bar_width=bar_width, bar_depth=thickness*0.33);
    }
    if(overhang > 0){
    
        difference(){
          ccube(width, thickness+overhang, thickness,0,-overhang,height-thickness);
          translate([0,-overhang,height-thickness])
        grid(width+bar_width, height,splits, 0,bar_width=bar_width, bar_depth=thickness*0.33);
        }
        
        
    }
}

module ramp(width=45, height=11, splits = 5, thickness=1.5, overhang = 0, bar_width=0.5, left=true, degree = 10){
    difference(){
        if(left){
            platform(width, height, splits, thickness, overhang, bar_width);
            
        }
        else{
            translate([width,0,0])
            rotate([0,0,180])
            platform(width, height, splits, thickness, overhang, bar_width);
        
        }
        translate([0,-(thickness+overhang)*2,height])
        rotate([0,degree,0])
        cube([width*2,(thickness+overhang)*4,height*2]);
    }
}
$preview = false;

translate([0,20,0])
color("grey")
platform();

color("lightgrey")
ramp(left=false);

translate([0,-20,0])
color("lightgrey")
ramp();

