scale = 87;

width = 800;
length = 1200;
height = 144;

board_height = 35;
board_width = 150;
space = 63.75;
scale([1/scale,1/scale,1/scale]){
//length top
translate([0,0,height-board_height])
cube([length, 100, board_height]);
translate([0,100+(1*space),height-board_height])
cube([length, 100, board_height]);
translate([0,200+(2*space),height-board_height])
cube([length, 145, board_height]);
translate([0,345+(3*space),height-board_height])
cube([length, 100, board_height]);
translate([0,445+(4*space),height-board_height])
cube([length, 100, board_height]);

//length bot
translate([0,0,0])
cube([length, 100, board_height]);
//translate([0,100+(1*space),0])
//cube([length, 100, board_height]);
translate([0,200+(2*space),0])
cube([length, 145, board_height]);
//translate([0,345+(3*space),0])
//cube([length, 100, board_height]);
translate([0,445+(4*space),0])
cube([length, 100, board_height]);

//cross

translate([0,0,height-2*board_height])
cube([150, width, board_height]);
translate([length/2-75,0,height-2*board_height])
cube([150, width, board_height]);
translate([length-150,0,height-2*board_height])
cube([150, width, board_height]);

//cubes
//front
translate([0,0,0])
cube([150, 100, height]);
translate([length/2-75,0,0])
cube([150, 100, height]);
translate([length-150,0,0])
cube([150, 100, height]);
//mid
translate([0,200+(2*space),0])
cube([150, 145, height]);
translate([length/2-75,200+(2*space),0])
cube([150, 145, height]);
translate([length-150,200+(2*space),0])
cube([150, 145, height]);
//back
translate([0,445+(4*space),0])
cube([150, 100, height]);
translate([length/2-75,445+(4*space),0])
cube([150, 100, height]);
translate([length-150,445+(4*space),0])
cube([150, 100, height]);

}