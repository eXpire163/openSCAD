use <shapes.scad>
use <cabelcanal.scad>
//settings
{
    //enable details for final rendering
    balken_an = false;

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




module tuer2(){
    tuer_breite = eingang_breite/2 - 1;
    tuer_hoehe = eingang_hoehe-gleis_hoehe ;
    tuer_rahmen = 5;

    union(){
        grid(tuer_breite,tuer_hoehe, 1 , 2, tuer_rahmen, dicke, name="tuer");

        //deko
        translate([0,0 , +1]){

            f_breite = step_size(tuer_breite, tuer_rahmen, 1)-tuer_rahmen-1;
            f_hoehe = step_size(tuer_hoehe, tuer_rahmen, 2)-tuer_rahmen-1;
            ecken = 5;
            d_hoehe = f_hoehe/ecken;
            glue = 2;
            color(farbe_fenster){
                for(step=[0:ecken-1]){
                    translate([f_breite+tuer_rahmen,0,tuer_rahmen+(step*d_hoehe)])
                    rotate([90,0,-90])
                    triangle(d_hoehe,1,f_breite);
                }
            }
            //spacer
            translate([tuer_rahmen,0,tuer_rahmen])
            cube([f_breite, 0.6, f_hoehe]);
            // glue part back
            translate([tuer_rahmen-glue,0.6,tuer_rahmen-glue])
            cube([f_breite+glue+glue, 0.6, f_hoehe+glue+glue]);
        }

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
tuer2();
}
}
// tür rechts
translate([laenge+5,-eingang_breite/2,gleis_hoehe]){
rotate([0,0,90]){
tuer2();
}
}
// dach
translate([-2*dicke,-breite/2-2*dicke,hoehe+dicke])
dach();

// fenster_inlet(fenster_breite=20, fenster_hoehe);

// boden

boden();

//kabelkanal
color(farbe_fenster)
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
    u_kanal(kabel_kanal_breite,5,hoehe-3*dicke, cut_bottom_right=true);
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


// gleise
%gleis(3*boden_rand, -c_gleis_breite/2);

}
