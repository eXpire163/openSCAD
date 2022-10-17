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
translate([0,0,0])
trapez3d();

module trapez(bottom = 30, top = 25, height = 10){
    echo("haha");
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

module grid(g_breite=40, g_hoehe=60, felder_lenks=2, felder_hoch=3, achsen_breite=1, achsen_tiefe=3){

   //assert(felder_lenks>0, "felder_lenks must be greater 0");
   // assert(felder_hoch>0, "felder_hoch must be greater 0");

    schritt_breite = (g_breite-achsen_breite)/felder_lenks;
    schritt_hoehe = (g_hoehe-achsen_breite)/felder_hoch;

    if(felder_lenks>0){
    for(lenks=[0:felder_lenks]){
        translate([lenks*schritt_breite,0,0])
        cube([achsen_breite, achsen_tiefe, g_hoehe]);
    }}

    if(felder_hoch>0){
    for(hoch=[0:felder_hoch]){
        translate([0,0,hoch*schritt_hoehe])
        cube([g_breite, achsen_tiefe, achsen_breite]);
    }}
}

translate([0,50,0])
grid(felder_lenks=4, felder_hoch=8);
