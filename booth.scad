// winter market building

//settings
{
    //enable details for final rendering
    balken_an = true;
    balken_spacing = 1.3;
    balken_thickness = 0.3;
    balken_width = 3;

    laenge = 100;
    breite = 90;
    hoehe = 80;

}



//elements
{
    
module triangle(o_len, a_len, depth, center=false)
{
    centroid = center ? [-a_len/3, -o_len/3, -depth/2] : [0, 0, 0];
    translate(centroid) linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}
    
module top_wall(laenge, hoehe, dicke, offset_hoehe=0){
    intersection(){
        translate([laenge,0,offset_hoehe])
        rotate([0,-90,0])
        wall(hoehe,laenge,  dicke);
        union(){
            translate([laenge/2,0,offset_hoehe])
            rotate([-90,-90,0])
            triangle(laenge/2, hoehe, dicke*5);
            translate([laenge/2,dicke*5,offset_hoehe])
            rotate([90,-90,0])
            triangle(laenge/2, hoehe, dicke*5);
        }
    }
}
    
module wall(laenge, hoehe, dicke){
    difference(){
        union(){
            cube([laenge, dicke, hoehe]);
            if(balken_an){
                for(bar=[0:balken_spacing*balken_width:laenge]){
                    translate([bar, 1,0]){
                        cube([balken_width, balken_thickness, hoehe]);
                    }
                }
            }
        }
       
       

    }
  

}

wall(laenge,hoehe*2/3, ,1);
top_wall(laenge,hoehe*1/3,1,hoehe*2/3);

}