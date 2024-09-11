%% Start ImageJ
addpath '/Applications/Fiji.app/scripts'
javaaddpath /Applications/MATLAB_R2023a.app/java/jar/mij.jar
javaaddpath /Applications/MATLAB_R2023a.app/java/jar/ij.jar
ImageJ;

% Define a sheet to save to here
output_file = "/Users/allisonlam/Downloads/nut_test.xls";

trogo_table = table('Size',[0 2],'VariableTypes',{'string','double'});
trogo_table.Properties.VariableNames = ["Filename", "% Trogo"];

%%
[listOfFolderNames, dapi_files, ~] = find_files("DAPI*.tif");
[~, cy5_files, ~] = find_files("CY*.tif", listOfFolderNames{1});
[~, fitc_files, ~] = find_files("FITC*.tif", listOfFolderNames{1});
analyze_me_later = [];

for i = 1:size(dapi_files, 2)
save = 0;
settings = 0;
filename = erase(dapi_files{i}, "_DAPI");
dapi = imread(strcat(listOfFolderNames{1}, "/", dapi_files{i}));
cy5 = imread(strcat(listOfFolderNames{1}, "/", cy5_files{i}));
fitc = imread(strcat(listOfFolderNames{1}, "/", fitc_files{i}));

while (save == 0)
IJM.show('dapi');
MIJ.run("16-bit");
MIJ.run("Nuclear Voronoi [o]");

if (settings == 1)
    MIJ.run("Enhance CLACHE [e]");
end

if (settings == 2)
    MIJ.run("Invert");
end

IJM.show('cy5');
MIJ.run("16-bit");
MIJ.run("Cell Huang Thresholding [l]");

IJM.show('fitc');
MIJ.run("immune [Q]");
save = input("Enter 1 to save data, 0 otherwise.");

if (save == 0)
    settings = input("Enter 0 to mark for manual analysis, 1 to brighten + rerun, 2 to invert + rerun.");
    MIJ.closeAllWindows;
    if (settings == 0)
        save = 2;
        analyze_me_later = [analyze_me_later filename];
    end
end
end

if (save == 1)
results = MIJ.getResultsTable;
idx = any(results(:,5)>50 & results(:,5)<50);
percent_trogo = (max(size(idx)) / size(results,1)) * 100;
results = array2table(results);
results.Properties.VariableNames = ["Area", "Mean", "Min", "Max", "%Area"];
writetable(results, output_file, 'Sheet', i+1);

trogo = table(string(filename), percent_trogo);
trogo.Properties.VariableNames = ["Filename", "% Trogo"];
trogo_table = [trogo_table; trogo];
writetable(trogo_table, output_file, 'Sheet', 1);
MIJ.closeAllWindows;
end
end
