$fn=100;
// sphere(20);
// translate([10, 30, 0]){
//     sphere(30);
// }
// translate([20, -10, 0]){
//     sphere(22);
// }
// translate([20, -40, 0]){
//     sphere(12);
// }
// translate([0, -35, 0]){
//     sphere(18);
// }

spheres = [
    [20,[10, 30, 0]],
    [22,[20, -10, 0]],
    [12,[20, -40, 0]],
    [18,[0, -35, 0]],
    [20,[-10, 50, 0]],
    [20,[10, 45, 0]],
    [15,[10, 10, 0]],
    [10,[-5, -10, 0]],
    [21,[-15, 15, 0]],
    [8,[-15, -18, 0]],
    [8,[-15, -8, 0]],

];

for (this_sphere=spheres){
    translate(this_sphere[1]){
        sphere(this_sphere[0]);
    }
}

32%c2%adwroom%c2%ad32d how to put into programming mode