use <Hardman.ttf>

width= 100; // [20:250]
depth= 80;  // [20:250]
height = 100; // [20:250]
border = 5; // [2:15]


// Name used for the front side
name = "your-name ;)";
// Size of the name must fit the front
font_size = 10;
// download and install hardman for better results Hardman:style=Regular
font_style = "";


//customize the decoration on the sides
triangles = [[10,13,20], [-20,-15,17], [25,-22,12],[-30,20,15]];

box();

module box(){
    
    difference(){
        cube([width, depth, height], center = true);
        
        translate([0,0,border]){
         cube([width-2*border, depth-2*border, height], center = true);
            }
            translate([0,0,0]){
                rotate([90,20,0]){
                    linear_extrude()
                    text(name,font_size,font_style,halign="center", valign="center");
                }
            }
            for( t = triangles){
                hole(t[0], t[1], t[2]);
            }
            
    }
    
}


module hole(hoch, seite, radius){
    translate([0,seite, hoch]){
        $fn=3;
    rotate([0,-90,0]){
                cylinder(h = 2*width, r = radius, center=true);
            }
    
    }
}