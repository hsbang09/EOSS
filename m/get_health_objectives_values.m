function [obj_HE1,obj_HE2,obj_HE3,obj_HE4,obj_HE5,obj_HE6,health_score] = get_health_objectives_values(r)
subobj_HE1_1 = r.eval('?*subobj-HE1-1*').floatValue(r.getGlobalContext());
subobj_HE1_2 = r.eval('?*subobj-HE1-2*').floatValue(r.getGlobalContext());
subobj_HE1_3 = r.eval('?*subobj-HE1-3*').floatValue(r.getGlobalContext());
subobj_HE1_4 = r.eval('?*subobj-HE1-4*').floatValue(r.getGlobalContext());
subobj_HE1_5 = r.eval('?*subobj-HE1-5*').floatValue(r.getGlobalContext());
subobj_HE1_6 = r.eval('?*subobj-HE1-6*').floatValue(r.getGlobalContext());
subobj_HE1_7 = r.eval('?*subobj-HE1-7*').floatValue(r.getGlobalContext());
subobj_HE1_8 = r.eval('?*subobj-HE1-8*').floatValue(r.getGlobalContext());
subobj_HE1_9 = r.eval('?*subobj-HE1-9*').floatValue(r.getGlobalContext());
subobj_HE1_10 = r.eval('?*subobj-HE1-10*').floatValue(r.getGlobalContext());
subobj_HE1_11 = r.eval('?*subobj-HE1-11*').floatValue(r.getGlobalContext());
subobj_HE1_12 = r.eval('?*subobj-HE1-12*').floatValue(r.getGlobalContext());
subobj_HE1_13 = r.eval('?*subobj-HE1-13*').floatValue(r.getGlobalContext());
subobj_HE1_14 = r.eval('?*subobj-HE1-14*').floatValue(r.getGlobalContext());
subobj_HE1_15 = r.eval('?*subobj-HE1-15*').floatValue(r.getGlobalContext());
subobj_HE1_16 = r.eval('?*subobj-HE1-16*').floatValue(r.getGlobalContext());
subobj_HE1_17 = r.eval('?*subobj-HE1-17*').floatValue(r.getGlobalContext());
subobj_HE1_18 = r.eval('?*subobj-HE1-18*').floatValue(r.getGlobalContext());
subobj_HE1_19 = r.eval('?*subobj-HE1-19*').floatValue(r.getGlobalContext());
subobj_HE1_20 = r.eval('?*subobj-HE1-20*').floatValue(r.getGlobalContext());
subobj_HE1_21 = r.eval('?*subobj-HE1-21*').floatValue(r.getGlobalContext());

obj_HE1 = [1/4 1/8*1/4 1/8*1/4 1/8*1/4 1/8*1/4 1/8*1/4 1/8*1/4 1/8*1/4 1/8*1/4 1/4 1/5*1/8 ...
    1/5*1/8 1/5*1/8 1/5*1/8 1/5*1/8 1/6*1/8 1/6*1/8 1/6*1/8 1/6*1/8 1/6*1/8 1/6*1/8]*[subobj_HE1_1 ...
    subobj_HE1_2 subobj_HE1_3 subobj_HE1_4 subobj_HE1_5 subobj_HE1_6...
    subobj_HE1_7 subobj_HE1_8 subobj_HE1_9 subobj_HE1_10 subobj_HE1_11 subobj_HE1_12 subobj_HE1_13 ...
    subobj_HE1_14 subobj_HE1_15 subobj_HE1_16 subobj_HE1_17 subobj_HE1_18 subobj_HE1_19 subobj_HE1_20 subobj_HE1_21]';


subobj_HE2_1 = r.eval('?*subobj-HE2-1*').floatValue(r.getGlobalContext());
subobj_HE2_2 = r.eval('?*subobj-HE2-2*').floatValue(r.getGlobalContext());
subobj_HE2_3 = r.eval('?*subobj-HE2-3*').floatValue(r.getGlobalContext());
subobj_HE2_4 = r.eval('?*subobj-HE2-4*').floatValue(r.getGlobalContext());

obj_HE2 = [1/4 1/4 1/4 1/4]*[subobj_HE2_1 subobj_HE2_2 subobj_HE2_3 subobj_HE2_4]';

subobj_HE3_1 = r.eval('?*subobj-HE3-1*').floatValue(r.getGlobalContext());
subobj_HE3_2 = r.eval('?*subobj-HE3-2*').floatValue(r.getGlobalContext());
subobj_HE3_3 = r.eval('?*subobj-HE3-3*').floatValue(r.getGlobalContext());
subobj_HE3_4 = r.eval('?*subobj-HE3-4*').floatValue(r.getGlobalContext());
obj_HE3 = [1/4 1/4 1/4 1/4]*[subobj_HE3_1 subobj_HE3_2 subobj_HE3_3 subobj_HE3_4]';

subobj_HE4_1 = r.eval('?*subobj-HE4-1*').floatValue(r.getGlobalContext());
subobj_HE4_2 = r.eval('?*subobj-HE4-2*').floatValue(r.getGlobalContext());
subobj_HE4_3 = r.eval('?*subobj-HE4-3*').floatValue(r.getGlobalContext());
subobj_HE4_4 = r.eval('?*subobj-HE4-4*').floatValue(r.getGlobalContext());
subobj_HE4_5 = r.eval('?*subobj-HE4-5*').floatValue(r.getGlobalContext());
subobj_HE4_6 = r.eval('?*subobj-HE4-6*').floatValue(r.getGlobalContext());
subobj_HE4_7 = r.eval('?*subobj-HE4-7*').floatValue(r.getGlobalContext());
subobj_HE4_8 = r.eval('?*subobj-HE4-8*').floatValue(r.getGlobalContext());
subobj_HE4_9 = r.eval('?*subobj-HE4-9*').floatValue(r.getGlobalContext());
subobj_HE4_10 = r.eval('?*subobj-HE4-10*').floatValue(r.getGlobalContext());
subobj_HE4_11 = r.eval('?*subobj-HE4-11*').floatValue(r.getGlobalContext());
subobj_HE4_12 = r.eval('?*subobj-HE4-12*').floatValue(r.getGlobalContext());
subobj_HE4_13 = r.eval('?*subobj-HE4-13*').floatValue(r.getGlobalContext());
subobj_HE4_14 = r.eval('?*subobj-HE4-14*').floatValue(r.getGlobalContext());
subobj_HE4_15 = r.eval('?*subobj-HE4-15*').floatValue(r.getGlobalContext());
subobj_HE4_16 = r.eval('?*subobj-HE4-16*').floatValue(r.getGlobalContext());
subobj_HE4_17 = r.eval('?*subobj-HE4-17*').floatValue(r.getGlobalContext());
subobj_HE4_18 = r.eval('?*subobj-HE4-18*').floatValue(r.getGlobalContext());

obj_HE4 = [1/4*1/2*1/4 1/4*1/2*1/4 1/4*1/4 1/4*1/4*1/5 1/4*1/4*1/5 1/4*1/4*1/5 1/4*1/4*1/5 1/4*1/4*1/5 1/4*1/4 ...
    3/4*1/2*1/4 3/4*1/2*1/4 3/4*1/4 3/4*1/4*1/5 3/4*1/4*1/5 3/4*1/4*1/5 3/4*1/4*1/5 3/4*1/4*1/5 3/4*1/4]*[subobj_HE4_1 ...
    subobj_HE4_2 subobj_HE4_3 subobj_HE4_4 subobj_HE4_5 subobj_HE4_6...
    subobj_HE4_7 subobj_HE4_8 subobj_HE4_9 subobj_HE4_10 subobj_HE4_11 subobj_HE4_12 subobj_HE4_13 ...
    subobj_HE4_14 subobj_HE4_15 subobj_HE4_16 subobj_HE4_17 subobj_HE4_18]';

subobj_HE5_1 = r.eval('?*subobj-HE5-1*').floatValue(r.getGlobalContext());
subobj_HE5_2 = r.eval('?*subobj-HE5-2*').floatValue(r.getGlobalContext());
subobj_HE5_3 = r.eval('?*subobj-HE5-3*').floatValue(r.getGlobalContext());
subobj_HE5_4 = r.eval('?*subobj-HE5-4*').floatValue(r.getGlobalContext());
obj_HE5 = [1/4 1/4 1/3 1/6]*[subobj_HE5_1 subobj_HE5_2 subobj_HE5_3 subobj_HE5_4]';

subobj_HE6_1 = r.eval('?*subobj-HE6-1*').floatValue(r.getGlobalContext());
subobj_HE6_2 = r.eval('?*subobj-HE6-2*').floatValue(r.getGlobalContext());
subobj_HE6_3 = r.eval('?*subobj-HE6-3*').floatValue(r.getGlobalContext());
subobj_HE6_4 = r.eval('?*subobj-HE6-4*').floatValue(r.getGlobalContext());
subobj_HE6_5 = r.eval('?*subobj-HE6-5*').floatValue(r.getGlobalContext());
subobj_HE6_6 = r.eval('?*subobj-HE6-6*').floatValue(r.getGlobalContext());

obj_HE6 = [2/3*1/3 2/3*1/3 2/3*1/3 1/3*1/3 1/3*1/3 1/3*1/3]*[subobj_HE6_1 subobj_HE6_2 subobj_HE6_3 subobj_HE6_4 subobj_HE6_5 subobj_HE6_6]';
health_score = [1/6 1/6 1/6 1/6 1/6 1/6]*[obj_HE1 obj_HE2 obj_HE3 obj_HE4 obj_HE5 obj_HE6]';
return