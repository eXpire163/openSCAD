scale = 46; // Factor for scaling H0 87
stack = 3; // amount of pallats
max_rotation = 1.5;

width = 800; // original width
length = 1200; // original
height = 144; // original

board_height = 35; // 35 is way to big but better to print
board_width = 150;
space = 63.75;

support = "off"; // ["on", "off"]



module pallat(){


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

translate([0,0,height-1.5*board_height])
cube([150, width, board_height]);
translate([length/2-75,0,height-1.5*board_height])
cube([150, width, board_height]);
translate([length-150,0,height-1.5*board_height])
cube([150, width, board_height]);

if(support == "on"){
    support_size = 30;
   translate([0,0,height-1*board_height])
cube([support_size, width, board_height]);
translate([length/2-support_size,0,height-1*board_height])
cube([support_size, width, board_height]);
translate([length-support_size,0,height-1*board_height])
cube([support_size, width, board_height]); 
    }

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

scale([1/scale,1/scale,1/scale]){

for(x=[0:stack]){
    
    rotate([0,0,rands(-max_rotation, max_rotation,1,50+x)[0]])
    translate([-length/2,-width/2,x*height])
    pallat();
}
}