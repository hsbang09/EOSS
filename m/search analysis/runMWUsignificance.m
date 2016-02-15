function [p,sig] = runMWUsignificance(path,mResPath,selector1,creditDef1,benchmark)
%Given a path, the heuristic selector name, credit definition name, and
%problem name this function will run a Mann Whitney U test (aka Wilcoxon
%rank sum test) to compare a method to the benchmark

origin = cd(mResPath);
file1 = dir(strcat(selector1,'*',creditDef1,'.mat'));
res1 = load(file1.name,'res');

cd(strcat(path,filesep,'Benchmarks'))
file2 = dir(strcat(benchmark,'*.mat'));
res2 = load(file2.name,'res');
cd(origin)

f_names = fieldnames(res1.res);
p = struct;
sig = struct;
for i=1:length(f_names)
    f_name = f_names{i};
    if strcmp(f_name,'allfHV')||strcmp(f_name,'allET')||strcmp(f_name,'ET')
        continue
    end
    data1 = getfield(res1.res,f_name);
    data2 = getfield(res2.res,f_name);
    [metric_p,h] = ranksum(data1,data2);
    if h==1 %then significant difference and medians are different
        med_diff = median(data1)-median(data2);
        if med_diff < 0
            metric_sig = -1;
        else
            metric_sig = 1;
        end
    else
        metric_sig = 0;
    end
    p = setfield(p,f_name,metric_p);
    sig = setfield(sig,f_name,metric_sig);
end