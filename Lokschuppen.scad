use <shapes.scad>
//settings
{
    //enable details for final rendering
    balken_an = true;

    laenge = 180;
    breite = 90;
    hoehe = 80;

    gleis_breite = 43;
    gleis_hoehe = 15;

    c_gleis_breite = 40;
    c_gleis_schiene = 2.3;
    c_gleis_boden = 8;
    c_gleis_hoehe = c_gleis_boden+c_gleis_schiene;
    c_gleis_laenge = 188;
    c_gleis_spurweite = 16.5;

    dicke = 1;

    eingang_hoehe = gleis_hoehe + 50;
    eingang_breite = 60;

    fenster_rahmen = 15;
    fenster_hoehe = 40;
    fenster_boden_abstand=20;
    fenster_breite = 0;
    farbe_fenster = "blue";

    boden_rand = 10;

    gehweg_hoehe  =20;
    gehweg_breite = 12;
    
    kabel_kanal_breite = 10;
    kabel_kanal_hoehe = 5;
}
 
 
//elements
{
module wall(laenge, hoehe, dicke, fenster=0){
    fenster_breite = (laenge-((fenster+1)*fenster_rahmen))/fenster;
    difference(){
        union(){
            cube([laenge, dicke, hoehe]);
            if(balken_an){
                for(bar=[1:3*dicke:laenge]){
                    translate([bar, 1,0]){
                        cube([dicke, dicke, hoehe]);
                    }
                }
            }
        }
        //fenster
        if(fenster>0){
            
            for(count=[0:fenster-1]){
                translate([fenster_rahmen+(count*(fenster_rahmen+fenster_breite)),-1,fenster_boden_abstand]){
                    cube([fenster_breite,10,  fenster_hoehe]);
                    //fenster_innen
                    
                }
            }
            
            
        }
        
    }
    //fenster_inlet
    if(fenster > 0){
        for(count=[0:fenster-1]){
                translate([fenster_rahmen+(count*(fenster_rahmen+fenster_breite)),-1,fenster_boden_abstand]){
                    fenster_inlet(fenster_breite, fenster_hoehe);
                    //fenster_innen
                    
                }
            }
        
        
    }
    
}
module fenster_inlet(breite=20, hoehe=30, tiefe =2, rand = 3){
    breite = breite -1;//speilraum
    hoehe = hoehe -1;//speilraum
    //ausrichtung am innenfenster (nicht am kleberand)
    color(farbe_fenster)
    translate([-rand+0.5, 0, -rand+0.5]){
        //innen
        translate([rand, 0,rand])
        grid(breite, hoehe, 1, 3, 1, 3);
        //hinten
        grid(breite+2*rand, hoehe+2*rand, 1, 1, 3, 1);
        
    }
    
}



module dach(){
    
    fenster_hohe=20;
    fenster_tiefe=30;
    fenster_breite=150;
    
    pos1x=20;
    pos1y=10;
    pos2x=20;
    pos2y=60;
    
    difference(){
        
            union(){
            cube([laenge+4*dicke, breite+8*dicke, dicke]);
            translate([pos1x,pos1y,0])
                dachecke(fenster_hohe,fenster_tiefe,fenster_breite);
            translate([pos2x,pos2y,0])
                dachecke(fenster_hohe,fenster_tiefe,fenster_breite);
            }
            //dach decken löcher
            translate([pos1x+2,pos1y+2,-3])
                cube([fenster_breite-4,fenster_tiefe-8,4]);
            translate([pos2x+2,pos2y+2,-3])
                cube([fenster_breite-4,fenster_tiefe-8,4]);
           // translate([20,60,0])
          //      cube(fenster_breite,fenster_tiefe,10);
            
            
            
            
        }    
    
}

module dachecke(ecke_hohe=20, ecke_breite=30, distance=150){
    rotate([90,0,90]){
        difference(){
            hull(){
                triangle(ecke_hohe,ecke_breite,1);
                translate([0,0,distance])
                triangle(ecke_hohe,ecke_breite,1);
            }
            translate([-1,0,dicke])
            hull(){
                triangle(ecke_hohe-dicke,ecke_breite-dicke,1);
                translate([0,0,distance-2*dicke])
                triangle(ecke_hohe-dicke,ecke_breite-dicke,1);
            }
        }
        translate([0,0,distance*1/4])
                triangle(ecke_hohe,ecke_breite,1);
        translate([0,0,distance*2/4])
                triangle(ecke_hohe,ecke_breite,1);
        translate([0,0,distance*3/4])
                triangle(ecke_hohe,ecke_breite,1);
        
    }
    color(farbe_fenster){
    translate([0,-2,1])
    grid(distance+1, ecke_hohe-1, 4,1,1, 1);
    translate([0,-1,1])
    grid(distance+1, ecke_hohe-1, 0,1,1, 0.3);
    }
}



module boden(){
    
    boden_beite=breite+2*boden_rand;
    boden_laenge=laenge+ 1*boden_rand;
    
    pos1x=20;
    pos1y=10;
    pos2x=20;
    pos2y=60;
    
    difference(){
            translate([-boden_rand/2,-breite/2-boden_rand,-dicke])
            union(){
                cube([boden_laenge,boden_beite , 2*dicke]);
            
            }
            //schinen ausschnitt
            translate([-boden_rand,-breite/2-boden_rand,-dicke])
            translate([3*boden_rand,boden_beite/2-gleis_breite/2,-1])
            cube([laenge, gleis_breite, 20]);
            
            // linke wand
            translate([0,breite/2,0])
            wall(laenge, hoehe, 2.5*dicke, 4);

            // rechte wand
            translate([laenge,-breite/2,0])
            rotate([0,0,180])
            wall(laenge, hoehe, 2.5*dicke, 4);
            
            // hinten wand
            translate([2.5,-breite/2,0])
            rotate([0,0,90])
            wall(breite, hoehe, 2.5*dicke);
                
            // eingang wand
            translate([laenge-2.5,breite/2,0])
            rotate([0,0,-90])
            difference(){
                wall(breite, hoehe, 2.5*dicke);
                translate([(breite/2)-(eingang_breite/2),-dicke,0]){
                    cube([eingang_breite, 4*dicke, eingang_hoehe]);
                }
            }
        }
        
    //gehweg links
    translate([boden_rand*3,-gleis_breite/2-gehweg_breite- 5 ,0])
    gehweg();    
    //gehweg rechts
    translate([boden_rand*3,gleis_breite/2 + 5 ,0])
    gehweg(); 
    
}

module gehweg() {
    gehweg_laenge = laenge *3/6;
    translate([0,0,gehweg_hoehe])
    cube([gehweg_laenge+2*dicke, gehweg_breite, dicke]);
    
    pfosten = 6;
    abstand = gehweg_laenge/(pfosten-1);
    for(count = [0:pfosten-1]){
        translate([count*abstand,0,0])
        cube([2*dicke, gehweg_breite, gehweg_hoehe]);
    }
    //treppe hinten
    translate([-gehweg_hoehe-1, 0, 0])
    treppe();
    
    translate([gehweg_laenge+gehweg_hoehe+3, gehweg_breite, 0])
    rotate([0,0,180])
    treppe();
}

module treppe(){
    
    for(step=[1:2:gehweg_hoehe]){
            translate([step,0,0])
            cube([2, gehweg_breite, step]);
    }
}



module tuer(){
    tuer_breite = eingang_breite/2 - 1;
    tuer_hoehe = eingang_hoehe-gleis_hoehe - 2;
    
    f_rahmen = 5;
    f_hoehe = tuer_hoehe/3;
    f_breite = tuer_breite - 2*f_rahmen;
    
    difference(){
        union(){
            cube([tuer_breite, dicke, tuer_hoehe]); 
            if(balken_an){
                //deko
                d_hoehe=3;
                for(step=[0:5]){
                    translate([f_breite+f_rahmen,0,5+(step*d_hoehe)])
                    rotate([90,0,-90])                
                    triangle(d_hoehe,1,f_breite);
                }
            
            }
        }
        //fenster
        
        translate([f_rahmen,-1, tuer_hoehe-f_hoehe-f_rahmen])
        cube([f_breite,3,f_hoehe]);
        
    }
}
module gleis(x_offset, y_offset){
    translate([x_offset, y_offset,0]){
        if(balken_an){
            color("grey")
            trapez3d(c_gleis_breite, c_gleis_breite-8, c_gleis_boden, c_gleis_laenge);
            translate([0,c_gleis_breite/2-c_gleis_spurweite/2-c_gleis_schiene/2,c_gleis_boden])
            color("black")
            cube([c_gleis_laenge,c_gleis_schiene, c_gleis_schiene]);
            translate([0,c_gleis_breite/2+c_gleis_spurweite/2-c_gleis_schiene/2,c_gleis_boden])
            color("black")
            cube([c_gleis_laenge,c_gleis_schiene, c_gleis_schiene]);
        }
        else{
            cube([c_gleis_laenge, c_gleis_breite, c_gleis_hoehe]);
        }
    }
}
}
module u_kanal(u_breite=10, u_hoehe= 4, u_laenge=50, u_dicke=1, cut_top_left=false, cut_top_right=false, cut_bottom_left=false, cut_bottom_right=false){
    
    difference(){
       
       cube([ u_laenge, u_breite, u_hoehe]);
       translate([-u_dicke, u_dicke, u_dicke])
       cube([ u_laenge+2*u_dicke, u_breite-2*dicke, u_hoehe]);
        
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



//putt it together
union(){
// linke wand
translate([0,breite/2,0])
wall(laenge, hoehe, dicke, 4);

// rechte wand
translate([laenge,-breite/2,0])
rotate([0,0,180])
wall(laenge, hoehe, dicke, 4);


// hinten wand
translate([0,-breite/2,0])
rotate([0,0,90])
wall(breite, hoehe, dicke);
    
// eingang wand
translate([laenge,breite/2,0])
rotate([0,0,-90])
difference(){
    wall(breite, hoehe, dicke);
    translate([(breite/2)-(eingang_breite/2),-dicke,0]){
        cube([eingang_breite, 4*dicke, eingang_hoehe]);
    }
};
// tür lings
translate([laenge+5,0,gleis_hoehe]){
rotate([0,0,90]){
tuer();
}
}
// tür rechts
translate([laenge+5,-eingang_breite/2,gleis_hoehe]){
rotate([0,0,90]){
tuer();
}
} 
// dach
translate([-2*dicke,-breite/2-2*dicke,hoehe+dicke])
dach();

// fenster_inlet(fenster_breite=20, fenster_hoehe);

// boden

boden();

//kabelkanal
union(){
  kabel_kanal_drucken = false;
if(kabel_kanal_drucken){
    union(){
        translate([0,-3*kabel_kanal_breite,0])
        u_kanal(kabel_kanal_breite,5,hoehe, cut_bottom_right=true);
        translate([0,3*kabel_kanal_breite,0])
        u_kanal(kabel_kanal_breite,kabel_kanal_hoehe,laenge/3, cut_bottom_left=true);
        u_kanal(kabel_kanal_breite,kabel_kanal_hoehe,laenge/3);
    }
    
}else{
    union(){
    //kabel kanal wand hinten
    translate([kabel_kanal_breite,0,0])
    rotate([0,-90,0])
    u_kanal(kabel_kanal_breite,5,hoehe, cut_bottom_right=true);
    //kabel kanal oben
    translate([kabel_kanal_hoehe,0,hoehe-kabel_kanal_hoehe])
    u_kanal(kabel_kanal_breite,kabel_kanal_hoehe,laenge/3, cut_bottom_left=true);
    //led strip halter
    translate([laenge/3+kabel_kanal_hoehe,kabel_kanal_breite,hoehe])
    rotate([180,0,0])
    u_kanal(kabel_kanal_breite,kabel_kanal_hoehe,laenge/3);
}  
    }
    }




    


%gleis(3*boden_rand, -c_gleis_breite/2);

}

