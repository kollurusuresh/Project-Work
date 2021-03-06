% Initiliazation
    clear         % clear all workspace variables
    clc           % clear command window
    close all     % close all open figures
    mFileName     = mfilename;                              % Get mfile name
    mFileNameFull = mfilename('fullpath');                  % Get mfile full name
    mFileDirMain  = mFileNameFull(1:end-length(mFileName)); % Extract the dir of the mfile directory
    if ~isempty(mFileDirMain)
        cd(mFileDirMain)    % change matlab current folder to mfile directory
    end
    clear mFileName mFileNameFull mFileDirMain              % clear variables
    rng(0)                                                  % set the random seed to 0
    if exist('OFDM_Class','class') == 8                     % Check if OFDM_Class exits
        OFDM_Class.checkForUpdatedVersion();                % Check if the class is updated
    else
        fprintf('The OFDM_Class does not exist or its path is not added. You can download the class from this %s \n',...
                '<a href = "http://www.mathworks.com/matlabcentral/fileexchange/54070">Link</a>')
        return
    end

% Parameters
    Para.NB                  = 1000;    % Number of ofdm symbols per run
    Para.M                   =  4;      % Modulation order
    Para.N                   = 64;      % Number of sybcarriers
    Para.NFFT                = 64*4;    % Upsampling rate is 4, and FFT based interpolation is used
    Para.ifDoRaylieghChannel = 1;       % No rayliegh channel
    Para.ifDoAWGNChannel     = 1;       % Only AWGN Channel
    Para.channSNRdB          = 25;
% Building class
    Obj = OFDM_Class(Para);
    
% Update parameters
% Transmitter
    Obj.ofdmTransmitter();
    Obj.ofdmChannel();
    Obj.ofdmReceiver();
    Obj.ofdmBER();
    
% Display
    fprintf('-------------------------------------\n')
    fprintf('  Simulation DER over AWGN chann is %f \n',Obj.DER)
    fprintf('  Simulation BER over AWGN chann is %f \n',Obj.BER)
    fprintf('  Theory     BER over AWGN chann is %f \n',Obj.BERTheoryRayliegh)
    fprintf('-------------------------------------\n')    
    
% Single Plots    
    Obj.plotTime();
    Obj.plotTxSpectrum();
    Obj.plotScatter();
