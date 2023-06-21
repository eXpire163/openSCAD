rohr_durchmesser = 35;
rohr_hoehe = 20;
dicke=2;
duese_durchmesser = 10;
duese_hoehe=10;

hoehe_trichter=15;

//rohr
pipe(rohr_durchmesser, rohr_durchmesser+dicke, rohr_hoehe);

//trichter
translate([0,0,rohr_hoehe])
trichter(rohr_durchmesser,duese_durchmesser, dicke, hoehe_trichter);
// duese
translate([0,0,rohr_hoehe+hoehe_trichter])
pipe(duese_durchmesser, duese_durchmesser+dicke, duese_hoehe);

module pipe(in, out, height){
    
    difference(){
        cylinder(h=height,d=out );
        cylinder(h=height,d=in );
        }
    }
    
    
module trichter(in1,in2, thickness, height){
    
    difference(){
        cylinder(h=height,d1=in1+thickness, d2=in2+thickness);
        cylinder(h=height,d1=in1, d2=in2);
    }
}