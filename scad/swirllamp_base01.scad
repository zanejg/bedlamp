include <swirl_common_vars.scad>
include <modelling_tests.scad>

$fn=100;
IS_RIGHT_END = false;
IS_LEFT_END = false;

IS_AN_END_PIECE = IS_RIGHT_END || IS_LEFT_END;


// Just testing the scaling
// !union(){
//     polygon(shape_pts);
    
//     translate([2.5, 0, 5]){
//         polygon(scaled_pts);
//     }
// }

module halfswirl(the_pts){
    rotate([0, 0, -straight_ang]){
        rotate_extrude(angle = SWIRL_ANG){ 
            translate([INNER_RD, 0, 0]){
                polygon(the_pts);
            }
        }
        
    }
    rotate([0, 0, 10]){
        translate([-(SHAPE_WD + INNER_RD), 0, 0]){
            rotate([90, 0, 0]){
                linear_extrude(height = STRAIGHT_LN) {
                    polygon(the_pts);    
                }
            }
        }
    }

    rotate([0, 0, -straight_ang]){
        translate([(INNER_RD), 0, 0]){
            rotate([90, 0, 0]){
                linear_extrude(height = STRAIGHT_LN) {
                    polygon(the_pts);    
                }
            }
        }
    }
}

module fullswirl(the_pts){
    halfswirl(the_pts);

    translate([SHAPE_WD + INNER_RD + (sin(straight_ang) * STRAIGHT_LN /2), 
                -(STRAIGHT_LN*2 + (sin(straight_ang) * (SHAPE_WD + INNER_RD))), 
                0]){
        rotate([0, 0, 180]){
            halfswirl(the_pts);
        }
    }
    // translate([SHAPE_WD - (INNER_RD * 3), 
    //           -(STRAIGHT_LN + INNER_RD), 
    //           BASE_HT/2]){
    //     cube([SHAPE_WD *1.5 + (INNER_RD * 2), 
    //           (STRAIGHT_LN*3) + (INNER_RD * 2), 
    //           BASE_HT], center=true);
    
    // }
}

// !fullswirl(shape_pts);

module lamp_section(){
    intersection() {
        for(xos = [0,1]){
            difference(){
                union(){
                    fullswirl(shape_pts);
                    translate([inter_swirl_offset * xos, 0, 0]){
                        fullswirl(shape_pts);
                    }
                }
                translate([0,0,-0.1]){
                    fullswirl(scaled_pts);
                    translate([inter_swirl_offset * xos, 0, 0]){
                        fullswirl(scaled_pts);
                    }
                }
            }
        }

        

        // trim ends
        translate([0, -100, 0]){
            cube([section_wd, 200, BASE_HT*3 ], center=false);
        }
    }
    
}


module LED_support(){
    rotate([40, 0, 0]){
        difference(){
            cube([8,25 ,16 ], center=true);
            translate([0, -5, 0]){
                cylinder(h = 12, r = 2/2);
            }
        }
    }
}



module glue_tab_shape(){
    cube([TAB_LN/2, BOX_TN*1.5, tab_ht *0.4], center=true);
    translate([0, 0, tab_ht * 0.6]){
        cube([TAB_LN/2, BOX_TN*1.5, tab_ht *0.4], center=true);
    }
}

module one_main_section(){
    difference(){
        union(){
            lamp_section();
            translate([0, -45, 0]){
                cube([section_wd,100 ,40 ], center=false);   
            }
            // LED Supports
            translate([32, -49, 25]){
                LED_support();
            }
            translate([84, -49, 25]){
                LED_support();
            }

            // Cylinder loop strengthening
            intersection(){
                union(){
                    // corner ends
                    translate([110, -52, 20]){
                        rotate([45, 0, 0]){
                            cube([10, 25, BOX_TN], center=true);
                        }
                    }
                    translate([6, -52, 20]){
                        rotate([45, 0, 0]){
                            cube([10, 25, BOX_TN], center=true);
                        }
                    }
                    // diag struts
                    translate([30, -86, 20]){
                        rotate([0, 0, 60]){
                            rotate([-45, 0, 0]){
                                cube([10, 45, BOX_TN], center=true);
                            }
                        }
                    }
                    translate([86, -86, 20]){
                        rotate([0, 0, -60]){
                            rotate([-45, 0, 0]){
                                cube([10, 45, BOX_TN], center=true);
                            }
                        }
                    }

                }
                // trim off anything outside the loop
                translate([58, -36, 0]){
                    cylinder(h = 50, r = 56);
                }
            }
        }
        // Main box cavity
        translate([-0.5, -40, -BOX_TN]){
            cube([section_wd + 1,cavity_wd ,CAVITY_HT ], center=false);   
        }
    
        // cable holes
        translate([25, -34, 40]){
            cube([12,8 , 10], center=true);
        }
        translate([90, -34, 40]){
            cube([12,8 , 10], center=true);
        }
        // glue tab cavities
        if(!IS_AN_END_PIECE || IS_RIGHT_END){
            translate([TAB_LN/4, -40 - (BOX_TN* 0.25), tab_ht *0.2]){
                glue_tab_shape();
            }
        }
        if(!IS_AN_END_PIECE || IS_LEFT_END){
            translate([section_wd - TAB_LN/4, 50 + (BOX_TN* 0.25), tab_ht *0.2]){
                glue_tab_shape();
            }
        }

        // swirl holding screwholes
        for(posi = SCREWHOLE_PAIR_XY){
            #translate([posi[0], posi[1], 38.5]){
                cylinder(h = 5, r = 3.5/2);
                    translate([0, 0, -1.1]){
                        cylinder(h = 2.5, r1 = 7/2, r2=2/2);
                    }
            }
        }
    
        // TEMP chop off top for dev
        #translate([50, 0, 85]){
            cube([150, 200, 90], center=true);
        }
    }
    // ###########################################################
    // glue tabs
    if(!IS_AN_END_PIECE || IS_LEFT_END){
        translate([section_wd, -(cavity_wd/2 - BOX_TN*1.5), tab_ht/2]){
            intersection(){
                cube([TAB_LN, BOX_TN, tab_ht], center=true);
                translate([TAB_LN/4, 0, -tab_ht *0.3]){
                    glue_tab_shape();
                }
            }
        }
    }
    
    if(!IS_AN_END_PIECE || IS_RIGHT_END){
        translate([0, (cavity_wd/2 + BOX_TN*2.5), tab_ht/2]){
            intersection(){
                cube([TAB_LN, BOX_TN, tab_ht], center=true);
                translate([-TAB_LN/4, 0, -tab_ht *0.3]){
                    glue_tab_shape();
                }
                
            }
        }
    }

    if (IS_LEFT_END){
        translate([BOX_TN/2, 5, (CAVITY_HT -BOX_TN)/2 + 0.5]){
            cube([BOX_TN, cavity_wd + 1, CAVITY_HT - BOX_TN +1], center=true);
        }
    }
    if (IS_RIGHT_END){
        translate([section_wd - BOX_TN/2, 5, (CAVITY_HT -BOX_TN)/2 + 0.5]){
            cube([BOX_TN, cavity_wd + 1, CAVITY_HT - BOX_TN +1], center=true);
        }
    }
    //#################################################################
    // screwhole stanchions

    translate([swirl_center_x, -swirl_center_y, 30]){
        difference(){
            cylinder(h = 10, r = SCREW_STANCHION_RD);
            #translate([0, 0, 0]){
                cylinder(h = 11, r = 2/2);
            }
        }
    }

}


one_main_section();


//###################################################################
// PCB cradle Box insert

// Mbox_wd = cavity_wd - 1;

// translate([0, BOX_TN*2, 0]){
//     difference(){
//         cube([200, Mbox_wd, tab_ht], center=true);
    
//         translate([-BOX_TN, 0, BOX_TN/2]){
//             cube([200, Mbox_wd - BOX_TN * 2, tab_ht-BOX_TN +1], center=true);
//         }
//     }
// }


