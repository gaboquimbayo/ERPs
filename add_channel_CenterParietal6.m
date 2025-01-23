% Load ERP data from two files ('ERP_GA_high.erp' and 'ERP_GA_low.erp') located in the specified filepath.
% Load ERP for each group (High and Low)
[ERP, ALLERP] = pop_loaderp( ...
    'filename', {'ERP_GA_high.erp', 'ERP_GA_low.erp'}, ... % Specify the names of the ERP files to load
    'filepath', 'C:\Users\gabri\OneDrive\Documents\Project_CE\ERPs\Intention_Grand_Avgs\' ... % Path to the directory where the files are stored
);

% Loop through all loaded ERPs in ALLERP (High and Low)
for i = 1:length(ALLERP)
    % Apply a channel operation to the current ERP in ALLERP
    ALLERP(i) = pop_erpchanoperator(ALLERP(i), { ... 
        % This new channel represents a region called Center Parietal 6
        % Create a new channel (nch1) as the average of channels 12(CP1), 13(Pz), 14(P3), 19(P4), and 23(CP2)
        'nch1 = (ch12+ch13+ch14+ch19+ch23)/5 label'}, ... 
        'ErrorMsg', 'popup', ... % Display error messages in a popup window if something goes wrong
        'KeepLocations', 1, ... % Preserve the spatial locations of existing channels in the ERP structure
        'Warning', 'on' ... % Enable warnings during the channel operation
    );
end
