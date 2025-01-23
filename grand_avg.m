% This code was written by Gabriel Quimbayo Polo & Reviewed by Dr. Leidy Cubillos-Pinilla 

%% Calculate grand average for each group (High & Low)
addpath('..\..\eeglab2024.0');
addpath('..\..\eeglab2024.0\plugins\erplab10.1\');

% Define lists of subject IDs for each group based on their arithmetic averages
high_intention = [3, 4, 15, 17, 24, 26, 27, 34, 35, 37, 40, 45, 49, 50, 58, 65, 66, 70, 75, 76];
low_intention = [1, 5, 8, 12, 18, 28, 29, 32, 42, 43, 54, 56, 59, 60, 61, 62, 67, 68, 69, 72, 74];

% Generate the filenames for the ERP files of the "high intention" group
% Each filename follows the format 'ERPSET_Good_CRB_XXX.erp', where XXX is the subject ID (zero-padded to 3 digits)
files_high_intention = arrayfun(@(x) sprintf('ERPSET_Good_CRB_%03d.erp', x), high_intention, 'UniformOutput', false);

% Generate the filenames for the ERP files of the "low intention" group
files_low_intention = arrayfun(@(x) sprintf('ERPSET_Good_CRB_%03d.erp', x), low_intention, 'UniformOutput', false);

% Load ERP data for the "high intention" group
% `pop_loaderp` loads the list of ERP files into `ALLERP_high` and the most recently loaded ERP into `ERP_high`
[ERP_high, ALLERP_high] = pop_loaderp( ...
    'filename', files_high_intention, ... % List of filenames for the "high intention" group
    'filepath', 'C:\Users\gabri\OneDrive\Documents\Project_CE\ERPs\ERP_Criterion_Good\' ... % Directory path where ERP files are stored
);

% Load ERP data for the "low intention" group
[ERP_low, ALLERP_low] = pop_loaderp( ...
    'filename', files_low_intention, ... % List of filenames for the "low intention" group
    'filepath', 'C:\Users\gabri\OneDrive\Documents\Project_CE\ERPs\ERP_Criterion_Good\' ... % Directory path where ERP files are stored
);

% Create a grand average ERP for the "high intention" group
% `pop_gaverager` computes a grand average across all ERP files in `ALLERP_high`
ERP_GA_high = pop_gaverager( ...
    ALLERP_high, ... % The set of ERPs to average
    'DQ_flag', 1, ... % Enable data quality (DQ) flagging
    'DQ_spec', 'DQ_spec_structure', ... % Specify the DQ structure for reporting
    'Erpsets', 1:length(ALLERP_high), ... % Include all ERPs in `ALLERP_high`
    'ExcludeNullBin', 'on', ... % Exclude bins with no data
    'SEM', 'on' ... % Compute the standard error of the mean (SEM)
);

% Create a grand average ERP for the "low intention" group
ERP_GA_low = pop_gaverager( ...
    ALLERP_low, ... % The set of ERPs to average
    'DQ_flag', 1, ... % Enable data quality flagging
    'DQ_spec', 'DQ_spec_structure', ... % Specify the DQ structure for reporting
    'Erpsets', 1:length(ALLERP_low), ... % Include all ERPs in `ALLERP_low`
    'ExcludeNullBin', 'on', ... % Exclude bins with no data
    'SEM', 'on' ... % Compute the standard error of the mean (SEM)
);

% Save the grand average ERP for the "high intention" group to a file
pop_savemyerp( ...
    ERP_GA_high, ... % ERP structure to save
    'erpname', 'ERP_GA_high', ... % Name to give to the ERP in the saved file
    'filename', 'ERP_GA_high.erp', ... % Name of the output ERP file
    'filepath', 'C:\Users\gabri\OneDrive\Documents\Project_CE\ERPs\Intention_Grand_Avgs', ... % Directory where the file will be saved
    'Warning', 'on' ... % Enable warnings during the saving process
);

% Save the grand average ERP for the "low intention" group to a file
pop_savemyerp( ...
    ERP_GA_low, ... % ERP structure to save
    'erpname', 'ERP_GA_low', ... % Name to give to the ERP in the saved file
    'filename', 'ERP_GA_low.erp', ... % Name of the output ERP file
    'filepath', 'C:\Users\gabri\OneDrive\Documents\Project_CE\ERPs\Intention_Grand_Avgs', ... % Directory where the file will be saved
    'Warning', 'on' ... % Enable warnings during the saving process
);
