function [fHV,ET] = getAllResults(path,selector,creditDef)
%Given a path, the heuristic selector name, credit definition name, and
%problem name this function will get all the results from the given path 
%with files that include the selector name and the credit definition name. 
%
%This function returns the epsilon indicator EI, generational distance GD,
%hyper volume HV, and inverted generational distance as a n x m matrix where n is the number files
%containing the selector name and credit definition name and m is the
%number of values collected per file.

origin = cd(path);
files = dir(strcat(selector,'*',creditDef,'*.res'));
cd(origin)
nfiles = length(files);
npts = 820;
fHV  = zeros(nfiles,npts);
ET = zeros(nfiles,npts);

for i=1:nfiles
    [tfHV,tET] = getMOEAIndicators(strcat(path,filesep,files(i).name),npts);
    try
        fHV(i,:) = tfHV;
    catch
        fprintf('meh');
    end
    ET(i,:) = tET;
end
end
