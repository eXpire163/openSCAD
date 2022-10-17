//helper
{
    /**
 * Standard right-angled triangle
 *
 * @param number  o_len  Length of the opposite side
 * @param number  a_len  Length of the adjacent side
 * @param number  depth  How wide/deep the triangle is in the 3rd dimension
 * @param boolean center Whether to center the triangle on the origin
 * @todo a better way ?
 */
module triangle(o_len, a_len, depth, center=false)
{
    centroid = center ? [-a_len/3, -o_len/3, -depth/2] : [0, 0, 0];
    translate(centroid) linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}

module trapez3d(bottom = 30, top = 25, height = 10, length = 172){
    hull(){
            trapez(bottom, top, height);
            translate([length,0,0])
            trapez(bottom, top, height);
    }
}

translate([0,50,0])
trapez3d();

module trapez(bottom = 30, top = 25, height = 10){
    off = (bottom-top);
    CubePoints = [
  [  0,  0,  0 ],  //0
  [ 0,  bottom,  0 ],  //1
  [ 0,  bottom-off,  height ],  //2
  [  0,  off,  height ]  //3
];
CubeFaces = [
  [0,1,2,3]  // bottom
  ]; // left

polyhedron( CubePoints, CubeFaces );
}

}

function step_size(total, bar_width, steps) = (total-bar_width)/steps;

module grid(grid_width=40, grid_height=60, steps_wide=2, steps_high=3, bar_width=1, bar_depth=3, name="grid"){


    step_width = step_size(grid_width, bar_width, steps_wide);
    step_height = step_size(grid_height, bar_width, steps_high);

    if(name != "grid2")
        echo (name, " steps ", step_width, step_height)
    if(steps_wide>0){
    for(s_wide=[0:steps_wide]){
        translate([s_wide*step_width,0,0])
        cube([bar_width, bar_depth, grid_height]);
    }}

    if(steps_high>0){
    for(s_height=[0:steps_high]){
        translate([0,0,s_height*step_height])
        cube([grid_width, bar_depth, bar_width]);
    }}

}

border = 10;
wide=3;
height=2;
translate([0,0,0])
grid(100,100, wide, height, bar_width=border);

// sample cube to fit in the hole

color("#00FFFF50")
translate([border,-2, border])
cube([step_size(100,border,wide)-border,6,step_size(100,border,height)-border]);
