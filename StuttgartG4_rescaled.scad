// todo: curve top at start end not printable (!)
// todo: window gegeüber von tür (/)
// todo: kupplung
// bug: räder vorne und hinten nicht gleicher abstand (/)


// config
{

$fn = 60;
ration = 1/87;

original_length = 18000;
original_width = 2200;
original_height = 3160;

original_wheelbase_1 = 1700;
original_wheelbase_2 = 10000;

length = original_length*ration;
width = 27;// original_width*ration; //fake scale
height = 44;//  original_height*ration*1; //fake scale
    
top_height = 0.2 * height;
bottom_heigt = 0.1 * height;
wheel_height = 0.2 * height;
body_height = height-top_height-bottom_heigt-wheel_height;


echo(length, width, height);

wheelbase_1 = original_wheelbase_1*ration;
wheelbase_2 = original_wheelbase_2*ration;
  
window_height = body_height/2;
window_width = window_height * 1.3;  

border = 1.2;
}


// modeling box
//%color("#00CCCC10")
//cube( [length, width, height]);

module oval(o_x, o_y){
     scale([o_x, o_y,1]){
         circle(d=1);
     }
}


module base(b_length, b_width, fill=true){
    difference(){
        hull(){
            translate([b_length - (b_width*0.75),0,0])
            oval(b_width*1.5, b_width);
            translate([b_width*0.75,0,0])
            oval(b_width*1.5, b_width);
        }
        if(fill==false){
            translate([1*border,0,0])
            scale([1, 1,1.02])
            base(length-2*border, width-2*border);         
        }
       
    }
    translate([b_length/2 ,-b_width/2,0])
    square([1, b_width]); 
}

module body(){
    difference(){
        linear_extrude(body_height)
        base(length, width, fill=false); 
        
               
        distance_start_end = 12;
        spaces = 3;
        windows = 5;
        window_start_height = body_height/2-spaces;
        windowtotal = window_width*windows+spaces*(windows-1);
        
        //left block
        translate([distance_start_end,0,window_start_height]){
            //windows
            for(i=[0:windows-1]){
                translate([i*(window_width+spaces),0,0])
                window();
            }
            
        } 
        //right block
        translate([length-distance_start_end-windowtotal,0,window_start_height]){
            //windows
            for(i=[0:windows-1]){
                translate([i*(window_width+spaces),0,0])
                window();
            }
            
        }
       //front back
        front_window_width = width/1.5;
        front_window_part = front_window_width/10;
        translate([-2, -(width/1.5)/2,window_start_height]){
            translate([0,0,0])
            #cube([length*1.1,front_window_part*2, window_height]) ;
            translate([0,3*front_window_part,0])
            #cube([length*1.1,front_window_part*4, window_height]) ;
            translate([0,8*front_window_part,0])
            #cube([length*1.1,front_window_part*2, window_height]) ;
                       
        }
        
        distance_door_start_end=12;
        door_width = 15;
        //left door
        translate([distance_door_start_end,-width,2])
        cube([door_width, 20,body_height-4]);
        //right door
        translate([length-distance_door_start_end-door_width,-width,2])
        cube([door_width, 20,body_height-4]);
    }    
    
}


module window(){
    
    //translate([0,-width,0])
    //%cube([window_width, width*2, window_height]);
      x = 2;
    hull(){
    rotate([90,0,0]){ 
        translate([x, x,0]){
        // 4-3
        // | | 
        // 1-2
            cylinder(h=width*2, r=x, center=true);
        translate([window_width-2*x, 0,0])
            cylinder(h=width*2, r=x, center=true);
        translate([window_width-2*x, window_height-2*x,0])
            cylinder(h=width*2, r=x, center=true);
        translate([0, window_height-2*x,0])
            cylinder(h=width*2, r=x, center=true);
    
        
        
    }
}  }
}

module top(){
    # echo("top_height", top_height);
    ratio =  top_height/width;
    # echo("ratio", ratio);
    oval_scale = 1.5;
    difference(){
        union(){
            hull(){
                translate([length - (width*oval_scale/2),0,0]){
                    scale([oval_scale,1,ratio])
                    sphere(d=width);
                    
                }
            
                translate([width*oval_scale/2,0,0]){
                    scale([oval_scale,1,ratio])
                    sphere(d=width);
                }
            }
            difference(){
            translate([length*0.1,-width/3,-top_height/2])
                cube([length*0.8, width*2/3,top_height]);
            translate([length*0.11,-width*1/4,-top_height/2])
                cube([length*0.78, width*1/2,top_height]);
            }
        }
    translate([0,-width,-100])
    cube([length,2*width, 100]);
    
   
}

//numbers
numbers_size = 8;
    translate([1,numbers_size/2,0])
    number(numbers_size);
    translate([length-1,-numbers_size/2,0])
    rotate([0,0,180])
    number(numbers_size);

    
}

module number(size=5){
    rotate([90,0,0])
    intersection(){
        cylinder(h=size,r=size);
        cube(size);
    }
    
}

module bottom(){
    
    echo("top_height", top_height);
    ratio =  top_height/width;
    echo("ratio", ratio);
    oval_scale = 1.5;
            abstand = 34;
    difference() {
        hull(){
            translate([length - (width*oval_scale/2),0,0]){
                scale([oval_scale,1,ratio])
                sphere(d=width);
                
            }
        
            translate([width*oval_scale/2,0,0]){
                scale([oval_scale,1,ratio])
                sphere(d=width);
            }
        }
        
        //oben abschneiden
        translate([0,-width,0])
        cube([length,2*width, 100]);
        
        //platz für räder

    translate([abstand,0 ,0 ])
        cube([20,width-2*border,20], center=true);
    translate([length - abstand,0 ,0 ])
        cube([20,width-2*border,20], center=true);
    } 
       //halter räder befestigung
    
    translate([abstand,0 ,0 ])
        wheel_holder();
    translate([length - abstand ,0 ,0 ])
        wheel_holder();
    
}


module wheel_holder(top_plate = 20, wh_height=7){
    thickness = 2;
    translate([0,0,-thickness/2])
    cube([top_plate,13,thickness], center=true);
    
    translate([0,-5.5,-wh_height/2])
    wheel_holder_single(wh_height = wh_height);
    translate([0,5.5,-wh_height /2])
    wheel_holder_single(wh_height = wh_height);
}

module wheel_holder_single(wh_width=7,wh_height=10,wh_hole=3,wh_thickness=2){
    
    hole_distance = 3;
    
    difference(){
        cube([wh_width,wh_thickness, wh_height ], center=true);
        
        translate([0,0,-wh_height/2+hole_distance])
        rotate([90,0,0])
            #cylinder(h=2*wh_thickness, d=wh_hole, center=true);
        
        translate([0,0,-wh_height/2 +hole_distance/2 ])
            #cube([1.9,wh_thickness*2, hole_distance ], center=true);
    }
}



module bank(){
    b_width = 8;
    b_height = 10;
    b_lenghs_for_2=6;
    
    translate([b_lenghs_for_2/2-0.4,0,0])
    cube([0.8, b_width, b_height]);
    cube([b_lenghs_for_2, b_width, b_height/2]);
    
}

//bank();

main();
module main(){
    {
        
        //top
        color("black")
        translate([0,0,body_height])
        top();

        //body
        body();              
 
        //bottom
        color("grey")
        translate([0,0,0])
        bottom();                 

    }
}
