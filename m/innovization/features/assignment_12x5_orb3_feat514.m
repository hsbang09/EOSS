function bool =assignment_12x5_orb3_feat514(soln)
bool = false;
if( not( logical( abs( soln(25:36) -[0,0,1,0,0,0,0,0,0,0,0,1]))))
bool = true;
end