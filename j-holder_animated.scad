
width=70;
height = 120;
thickness = 15;
depth = 15;
drillwhole = 7;

linear_extrude(depth){
    difference(){//upper bar
        translate([0,-thickness])
        square([width, 2*thickness]);  //double thickness to create soft edge left bar
        if($t>0.1){
            hull(){ //merge both holes to cut them off
                translate([2*thickness,-thickness])
                circle(d=2*thickness); 
                translate([2*width,-thickness])
                circle(d=2*thickness); 
            }
        }
        if($t>0.2){
            //mounting
            translate([thickness/2,thickness/2,0])
            circle(d=drillwhole); // whole left
            translate([width-thickness,thickness/2,0])
            circle(d=drillwhole); // whole right
        }
    }
    if($t>0.3){
        translate([0,-height/2,0])
        square([thickness, height/2]); // left bar
    }
    translate([width/2,-height/2,0])
    difference(){ //lower part
        if($t>0.4){
            circle(d=width); // outer circle
        }
        if($t>0.5){
            circle(d=width-2*thickness); //cutout circle
        }
        if($t>0.6){
            translate([-(width-2*thickness)/2, 0,0])
            square([width-2*thickness, width/2]); // cut circle top
        }
        if($t>0.7){
            translate([-(width-2*thickness)/2, thickness,0])
            square([width, width/2]); // cut circle right
        }
    }
}