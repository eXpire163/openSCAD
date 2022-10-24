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

module insert(tx=0,ty=0,tz=0) {
    translate([tx,ty,tz])
        color("blue",0.2)
        cube([inner_width, depth_slot, height_slot]);
    
    echo("endedge", tz+height_slot);
    
    x = (tx+inner_width);
    y = (ty+depth_slot);
    z = (tz+height_slot);
    translate([x,y,z])
    rotate([90,0,0])
    text(str(x," ",y," ",z)); 
    
}

for(i=[0:layers-1]){
    
    startpoint = i*(layer_height);
    
    insertStart = startpoint+board;
    
    translate([0,0,startpoint])
    color("brown")
        cube([inner_width, depth, board]);

    
    insert(1,0,insertStart);
    
      echo("startpoint", startpoint);  
    echo("insertStart", insertStart);  
}
 