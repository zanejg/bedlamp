
GEN_TN = 4;
GEN_WD = 15;
WALL_BASE_LN = 45;
HOOK_HT = 10;
HOOK_SPAN = 4;


// Wall base
cube([WALL_BASE_LN, GEN_TN, GEN_WD]);

// shoulder 
translate([HOOK_HT, 0, 0])
    cube([GEN_TN , HOOK_SPAN + (GEN_TN * 2),GEN_WD]);

// hook spur
translate([0, HOOK_SPAN + GEN_TN, 0])
    cube([HOOK_HT , GEN_TN,GEN_WD]);

