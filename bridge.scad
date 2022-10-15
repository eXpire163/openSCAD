trackwidth = 40;
border = 15;
standoffwidth = 5;

depth = 20;
plateheight =2;

heightSteps = 7;



//preview shows all
preview=true;

//change for different modules
x=11;

if(preview){
for(part=[1:10]){
    translate([0,part*(depth+5),0])
    unit(part*heightSteps);
}
}
else{
    for(part=[x:x]){
    rotate([-90,0,0])
    unit(part*heightSteps);
    }
}


module unit(unitheight){
plate(unitheight/2-plateheight/2, true);
plate(-unitheight/2+plateheight/2, (unitheight>65));

// standoff left
translate([-trackwidth/2-border-(standoffwidth/2),0, 0])
standoff(unitheight);

// standoff right
translate([+trackwidth/2+border+(standoffwidth/2),0,0])
standoff(unitheight);
}

module standoff(unitheight){
    color("blue")
    difference(){
        cube([standoffwidth, depth, unitheight], center = true);
    // cutout
  //#translate([0,0,-unitheight/2])    
    //    cube([plateheight+1, depth+5, plateheight], center=true);
    }
    
    
    color("#00FFFF")
    translate([0,0,unitheight/2])
    cube([plateheight, depth, plateheight], center=true);
    
    //label
    if(unitheight>0){
        color("pink")
        translate([0, -depth/2, 0])
        rotate([90,0,0])
        linear_extrude(0.8, false)
        text(str(unitheight/heightSteps),2, valign="center", halign = "center");
    }
    
    
}

module plate(offset, addRails){
 // offset = offset - plateheight/2;   
    // base plate
    cutoutwidth=32;
    translate([0,0,offset])
     //trackwidth+2*border
    difference(){
        cube([trackwidth+2*border, depth, plateheight], center=true);
        if(!addRails){
        translate([-17, 0,0])
        #cube([cutoutwidth, depth-plateheight*2, plateheight+2], center=true);
        translate([17, 0,0])
        #cube([cutoutwidth, depth-plateheight*2, plateheight+2], center=true);
        }
        
    }
    if(addRails){
        // rails line left
        translate([-trackwidth/2-plateheight/2,0, plateheight+ offset])
        cube([plateheight, depth, plateheight], center=true);

        // rails line right
        translate([+trackwidth/2+plateheight/2,0, plateheight+ offset])
        cube([plateheight, depth, plateheight], center=true);
    }
    
}