use<shapes.scad>

inner_width = 950;
height_slot = 80;
depth_slot = 47;

depth = 60;

board = 10;
layers = 5;

target_height=460;

calc_slot_height = (target_height/layers);

startpoint=0;
insertStart=0;
layer_height =calc_slot_height;// height_slot+board+1;
echo("layer_height",layer_height);





for(i=[0:layers-1]){
    
    startpoint = i*(layer_height);
    
    insertStart = startpoint+board;
    
    translate([0,0,startpoint])
    color("brown")
        cube([inner_width, depth, board]);

    color("blue",0.2)
    ccube(inner_width, depth_slot, height_slot,1,0,insertStart);
    
    //echo("startpoint", startpoint);  
    //echo("insertStart", insertStart);  
}
