%% Compute Averaged ERPs (Criterion Good)
addpath('..\Documents\eeglab2024.0');
addpath('..\Documents\eeglab2024.0\plugins\erplab10.1');

% paths
input_dir = '7_Interpolate_VoltRej_Epoched_ICALabel_ChanRemv_Triggers_Cut_Filtered_Averaged';
output_dir = 'ERP_Criterion_Good';

% list of files .set
file_list = dir(fullfile(input_dir, 'Interpolate_VoltRej_Epoched_ICALabel_ChanRemv_Triggers_Cut_Filtered_Averaged_CRB_*.set'));

for i = 1:length(file_list)
    
    % Load participant eeglab
    file_name = fullfile(input_dir, file_list(i).name);
    EEG = pop_loadset(file_name);
    subject_code = file_name(end-6:end-4);

    % Compute averaged ERPs
    try
        % When no error
        ERP = pop_averager( EEG , 'Criterion', 'good', 'DQ_custom_wins', 0, 'DQ_flag', 1, 'DQ_preavg_txt', 0, 'ExcludeBoundary', 'on', 'SEM','on' );
    catch
        % When error
        ERP = pop_averager( EEG , 'Criterion', 'all', 'DQ_custom_wins', 0, 'DQ_flag', 1, 'DQ_preavg_txt', 0, 'ExcludeBoundary', 'on', 'SEM','on' );
    end

    % Filter design (IIR 8Hz)
    Filt_ERP = pop_filterp(ERP, 1:32, 'Cutoff', [ 0.1 8], 'Design', 'butter', 'Filter', 'bandpass', 'Order',  2 );
    
    % Bin operation. (BIN3 = BIN2 - BIN1)
    Bin_ERP = pop_binoperator( Filt_ERP, { 'BIN3 = b1-b2 label First-Latter difference' } );

    % Save ERPset
    erp_name = sprintf('ERPSET_Good_CRB_%s', subject_code);
    out_file_name = strcat(erp_name, '.erp');
    ERPavg = pop_savemyerp(Bin_ERP, 'erpname', erp_name, 'filename', out_file_name, 'filepath', output_dir, 'Warning', 'on');
end

%% Compute Averaged ERPs (Criterion All)
addpath('..\Documents\eeglab2024.0');
addpath('..\Documents\eeglab2024.0\plugins\erplab10.1');

% paths
input_dir = '7_Interpolate_VoltRej_Epoched_ICALabel_ChanRemv_Triggers_Cut_Filtered_Averaged';
output_dir = 'ERP_Criterion_All';

% list of files .set
file_list = dir(fullfile(input_dir, 'Interpolate_VoltRej_Epoched_ICALabel_ChanRemv_Triggers_Cut_Filtered_Averaged_CRB_*.set'));

for i = 1:length(file_list)
    % Load participant eeglab
    file_name = fullfile(input_dir, file_list(i).name);
    EEG = pop_loadset(file_name);
    subject_code = file_name(end-6:end-4);

    % Compute averaged ERPs
    ERP = pop_averager( EEG , 'Criterion', 'all', 'DQ_custom_wins', 0, 'DQ_flag', 1, 'DQ_preavg_txt', 0, 'ExcludeBoundary', 'on', 'SEM','on' );

    % Filter design (IIR 8Hz)
    Filt_ERP = pop_filterp(ERP, 1:32, 'Cutoff', [ 0.1 8], 'Design', 'butter', 'Filter', 'bandpass', 'Order',  2 );
    
    % Bin operation. (BIN3 = BIN2 - BIN1)
    Bin_ERP = pop_binoperator( Filt_ERP, { 'BIN3 = b1-b2 label First-Latter difference' } );

    % Save ERPset
    erp_name = sprintf('ERPSET_All_CRB_%s', subject_code);
    out_file_name = strcat(erp_name, '.erp');
    ERP = pop_savemyerp(Bin_ERP, 'erpname', erp_name, 'filename', out_file_name, 'filepath', output_dir, 'Warning', 'on');
end