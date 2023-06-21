
diameter = 20;
space = 5;
cut_thickness = 3;
stencil_thickness = 0.8;

//off = (1.3*diameter)+space;
side = sqrt(3)/2*diameter;
module row(blocks = 9){
    
    for(x = [0:blocks]){
        translate([x*side,diameter/2*x,-1])
        cylinder(h=cut_thickness, d=diameter, $fn=6);
    }
}
module grid(blocks = 9){
    for(x = [0:blocks]){
        translate([0,x*diameter,0])
            row(blocks);
    }
}

difference(){
    translate([0,100,0])
   cube([90,110,stencil_thickness]);
    
    grid(20); 
}

