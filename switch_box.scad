





width= 50;
depth= 30;
height = 20;
wall = 3;
diameter_button=7;
turnout_count=3;
single_double=true;


rotate([180,0,0])
difference(){
cube([width, depth, height], center = true);

translate([0,0,-wall])
cube([width-wall*2, depth-wall*2, height], center = true);
   translate([0,0,height/3-7])
   # buttons();
    
    translate([0,-depth/3,-10])
    rotate([90,0,0])
    hole();

}

module buttons(){
    
    gap = width/(turnout_count+1);
    all_gaps = gap*(turnout_count-1);
    
for(part=[0:turnout_count-1]){
    translate([gap*part - all_gaps/2,0, 0])
    turnhout();
}
}


module turnhout(){
    
    if(single_double){
        color("red")
        translate([0,depth/4, 0])
        hole();
        color("lime")
        translate([0,-depth/4, 0])
        hole();
    }
    else{
        hole();
    }
}

module hole(){
    cylinder(h=10, d = 7, $fn=20);
}