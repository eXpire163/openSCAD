
//  module u_kanal(u_breite, u_hoehe, u_laenge)
//  allows to create cabel canals
//  u_breite outer width
//  u_hoehe outer hight
//  u_laenge length including cuttings
module u_kanal(u_breite=12, u_hoehe= 4, u_laenge=50, u_dicke=1, cut_top_left=false, cut_top_right=false, cut_bottom_left=false, cut_bottom_right=false){

    difference(){

       cube([ u_laenge, u_breite, u_hoehe]);
       translate([-u_dicke, u_dicke, u_dicke])
       cube([ u_laenge+2*u_dicke, u_breite-2*u_dicke, u_hoehe]);

        if(cut_top_left){
             translate([0,-u_dicke,0])
            rotate([0,-45,0])
            cube(u_breite+u_hoehe);
        }
        if(cut_top_right){
            translate([u_laenge,-u_dicke,0])
            rotate([0,-45,0])
            cube(u_breite+u_hoehe);
        }
        if(cut_bottom_left){
            translate([0,-u_dicke,u_hoehe])
            rotate([0,135,0])
            cube(u_breite+u_hoehe);
        }
        if(cut_bottom_right){
            translate([u_laenge,-u_dicke,u_hoehe])
            rotate([0,135,0])
            cube(u_breite+u_hoehe);
        }
    }

}

//preview

width = 10;
height = 5;
length = 150;

translate([0,-3*width,0])
    u_kanal(width,height,length, cut_bottom_right=true);
translate([0,3*width,0])
    u_kanal(width,height,length, cut_bottom_left=true);
translate([0,0,0])
u_kanal(width,height,length);

//sample

translate([0,5*width,0]){
    //start bottom
    color("blue")
    translate([0,width, height])
    rotate([180,0,0])
    u_kanal(width,height,length/3, cut_bottom_right=true);

    //mid part
    color("lime")
    translate([length/3,width, 0])
    rotate([0,-90,180])
    u_kanal(width,height,length/3, cut_bottom_left=true, cut_bottom_right=true);

    //top part
    color("red")
    translate([0,0, length/3- height])
    rotate([0,0,0])
    u_kanal(width,height,length/3, cut_top_left=true, cut_bottom_right=true);

    //mid part
    color("yellow")
    translate([0,width, length/3])
    rotate([0,-90,180])
    u_kanal(width,height,length/3, cut_top_left=true, cut_bottom_right=true);

}
