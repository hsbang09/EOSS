function bool =assignment_12x5_orb1_feat3228(soln)
bool = false;
if( not( logical( abs( soln(1:12) -[1,1,0,0,1,0,0,1,1,0,1,1]))))
bool = true;
end