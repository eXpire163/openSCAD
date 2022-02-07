



ebene();

translate([0,15,0])
ebene();

translate([0,-15,0])
ebene();


module ebene(){
zweiw();

translate([15,0,0])
zweiw();

translate([-15,0,0])
zweiw();
}



module zweiw(){
cube(10);
translate([0,0,15])
cube(10);
    
translate([0,0,30])
cube(10);
}

/