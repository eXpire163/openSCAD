//scale = 87;

width = 27;
length = 92;
height = 23;

random_seed = 1;

count_width = 4;
count_height = 15;

bar_width = width/count_width;
bar_height = height/count_height;

for(y=[0:count_width-1]){
    for(z=[0:count_height-1]){   
     translate([rands(-1,1,1,random_seed+z+y)[0],y*bar_width+rands(-0.2,0.2,1,random_seed+z)[0], z*bar_height])
     cube([length, bar_width-0.5, bar_height]);
    }
}

//innercube for printing without infill
translate([2.5,2.5,0])
    cube([length-5, width-5, height-bar_height]);


strip1 = length*1/4;
strip2 = length*3/4;

translate([strip1,-1.5,0])
    cube([2, width+3, height+1]);
translate([strip2,-1.5,0])
    cube([2, width+3, height+1]);

