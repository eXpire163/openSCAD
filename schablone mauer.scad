
stencil_thickness = 1;
stencil_width = 120;
stencil_rows = 10;

brick_height = 5;
brick_width=10;


for(i=[0:stencil_rows]){
    translate([0,i*brick_height, 0])
    line(stencil_width+1, 1);
    daneben =  i%2==0 ? 0 : brick_width/2;
    if(i<stencil_rows){
    for(x=[daneben:brick_width:stencil_width]){
        translate([x,i*brick_height,0])
        line(1, brick_height);
        }
    }
}
// first

module line(len,  thickness) {
        cube([len, thickness, stencil_thickness]);
    
}