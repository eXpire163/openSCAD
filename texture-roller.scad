// texture roller



diameter = 50;
height = 60;
height_layers = 6;
min_structure = 0.5;
max_structure = 1;


//main role
// cylinder(h= height, r=diameter/2);

//polar to cartisien coordiantes
function pc(r,deg, z) = [r*sin(deg),r*cos(deg),z];
//random for structure
function rs(s1, s2,seed) = rands(s1,s2,seed)[0];



module slice_vert(r=10, degStart=0, degWidth=10, z =  0,o1,o2,o3,o4, maxHeight){

    degHalf=degWidth/2;
    polyhedron(
      points=[ pc(r+0,degStart-degWidth, z-o1),
               pc(r+0,degStart+degWidth, z-o2),
               pc(r+0,degStart+degWidth, z+o3),
               pc(r+0,degStart-degWidth, z+o4), // the four points at base
               [0,0,0], [0,0,maxHeight]  ],                                 // the apex point 
      faces=[ [0,1,4], //bottom
                [1,2,4], //left
                [2,3,4], //top
                [3,0,4], //right              // each triangle side
                 [1,0,3],[2,1,3]    ]                         // two triangles for square base
     );

}

module slice_vert_new(r=10, degStart=0, degWidth=10, z =  0,o1,o2,o3,o4, maxHeight){

    degHalf=degWidth/2;
    polyhedron(
      points=[ pc(r+0,degStart-degWidth, z-o1),
               pc(r+0,degStart+degWidth, z-o2),
               pc(r+0,degStart+degWidth, z+o3),
               pc(r+0,degStart-degWidth, z+o4), // the four points at base
               [0,0,-maxHeight], [0,0,maxHeight]  ],                                 // the apex point 
      faces=[ [0,1,4], //bottom
                [1,2,4],[2,4,5], //left
                [2,3,5], //top
                [3,0,4],[3,4,5], //right              // each triangle side
                 [1,0,3]   ,[2,1,3] ]                         // two triangles for square base
     );

}

module slice(r=10, degStart=0, degWidth=10, z =  0,o1,o2,o3,o4, layer, x, lastLayer=false){
    slice_vert(r, degStart, degWidth, z, o1,o2,o3,o4, 2);

    sb = 0.5 ; //shorten by
    if((layer%2+ x)%2 ==0 && !lastLayer)
        slice_vert(r, degStart, 0.8, z, o1-sb,o2-sb,o3+height_layers-sb,o4+height_layers-sb, height_layers);

    
}

module row(layer, lastLayer=false){
    


    stepper = 10;
    totalSteps = 360/stepper;


    offsets = rands(min_structure,max_structure,150,1);
    //echo(offsets);
union(){
    for(x=[0:totalSteps-2]){
        xstart = offsets[x];
        xend = offsets[x+1];
        slice(diameter/2,x*stepper,stepper/2,0,
        xstart,
        xend,
        xend,
        xstart,layer, x, lastLayer);
        
    }
        xstart = offsets[totalSteps-1];
        xend = offsets[0];
        slice(diameter/2,(totalSteps-1)*stepper,stepper/2,0,
        xstart,
        xend,
        xend,
        xstart,layer, totalSteps-1, lastLayer);
}



}
difference(){
    union(){
        
        for(layer = [0:height_layers:height-1]){
            translate([0,0,layer])
            row(layer/height_layers, false);
        }
        translate([0,0,height])
            row(0, true);
        cylinder(h=height*1, d=0.7*diameter, center=false);
    }
    cylinder(h=height*3, d=0.6*diameter, center=true);

}



