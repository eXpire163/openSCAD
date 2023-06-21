
totalScale = 0.8; // 1 == 50mm height

h_width = 8;
h_move_sideways = 16;
thicknessLogo = 1.3;
thicknessStencil = 0.9;

difference(){
cube([60,thicknessStencil,70], center = true);

scale([totalScale,1,totalScale]){
translate([-h_move_sideways,0,0])
cube([h_width,thicknessLogo,50], center = true);

rotate([0,45,0])
difference(){
cube([25,thicknessLogo,25], center = true);
cube([15,3*thicknessLogo,15], center = true);
}

translate([h_move_sideways,0,0])
cube([h_width,thicknessLogo,50], center = true);

}


}
cube([2,thicknessStencil,70], center = true);