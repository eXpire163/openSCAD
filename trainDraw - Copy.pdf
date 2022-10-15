
pen_diameter = 9; // stabilo 8mm
lane_width = 80; //distance between the 2 lines

cargo_train_inner_size = [80, 30];

frame(cargo_train_inner_size[0], cargo_train_inner_size[1], 15, 3);

plate(30, lane_width+2*pen_diameter, 3, pen_diameter);


module plate(len, width, height, hole){
    
    difference(){
        union(){
            translate([0,0,height/2]){
                cube([len, width, height], center = true);
                }
                    translate([0,width/2-hole,0]){
                        cylinder(h = height*2, d = hole+6);
                    }
                    translate([0,-(width/2-hole),0]){
                        cylinder(h = height*2, d = hole+6);
                    }
        }
        translate([0,width/2-hole,0]){
            #cylinder(h = height*6, d = hole,center = true);
        }
        translate([0,-(width/2-hole),0]){
            #cylinder(h = height*6, d = hole,center = true);
        }
     }
    
}

module frame(len, width, height, thickness){
    translate([0,0,height/2]){
    difference(){
        cube([len, width, height], center = true);
        cube([len-2*thickness, width-2*thickness, height+2], center = true);
        
    }
}
}
