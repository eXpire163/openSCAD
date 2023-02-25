
width=70;
height = 120;
thickness = 15;
depth = 15;
drillwhole = 7;

module j_holder(width, height, thickness, depth, drillwhole){

linear_extrude(depth){
    difference(){//upper bar
        translate([0,-thickness])
        square([width, 2*thickness]);  //double thickness to create soft edge left bar
        hull(){ //merge both holes to cut them off
            translate([2*thickness,-thickness])
            circle(d=2*thickness); 
            translate([2*width,-thickness])
            circle(d=2*thickness); 
        }
        //mounting
        translate([thickness/2,thickness/2,0])
        circle(d=drillwhole); // whole left
        translate([width-thickness,thickness/2,0])
        circle(d=drillwhole); // whole right
        
    }
    translate([0,-height/2,0])
    square([thickness, height/2]); // left bar
    translate([width/2,-height/2,0])
    difference(){ //lower part
        circle(d=width); // outer circle
        circle(d=width-2*thickness); //cutout circle
        translate([-(width-2*thickness)/2, 0,0])
        square([width-2*thickness, width/2]); // cut circle top
        translate([-(width-2*thickness)/2, thickness,0])
        square([width, width/2]); // cut circle right
    }
}
}
j_holder(width, height, thickness, depth, drillwhole);