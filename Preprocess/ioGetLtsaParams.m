function ioGetLtsaParams
%ioGetLtsaParams get parameters needed for generating LTSA's from user
%
% Prompt user to specify time average length (seconds) and frequency bin
% size (Herz). The parameters are typicaly data sample rate dependent. The
% default parameters given are for broad-band data, from a sampling rate of
% 200 kHz.
%
% Copyright(C) 2018 by John A. Hildebrand, UCSD, jahildebrand@ucsd.edu
%                      Kait E. Frasier, UCSD, krasier@ucsd.edu
%                      Alba Solsona Berga, UCSD, asolsonaberga@ucsd.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PARAMS 

if PARAMS.ltsa.ftype == 1    % wav file - Ishmael generated...
    prompt={'Enter Time Average Length [seconds] : ',...
        'Enter Frequency Bin Size [Hz] :'};
elseif PARAMS.ltsa.ftype == 2    % xwav file type
    prompt={'Enter Time Average Length [seconds] : ',...
        'Enter Frequency Bin Size [Hz] :'};
         %'XWAV data recorded by HARP = 1, ARP = 2, OBS = 3 : '};
end


def={num2str(PARAMS.ltsa.tave),...
    num2str(PARAMS.ltsa.dfreq)};

dlgTitle='Set Long-Term Spectrogram Parameters';
lineNo=1;
AddOpts.Resize='on';
AddOpts.WindowStyle='normal';
AddOpts.Interpreter='tex';
% display input dialog box window
in=inputdlg(prompt,dlgTitle,lineNo,def,AddOpts);
if isempty(in)	% if cancel button pushed
    PARAMS.ltsa.gen = 0;
    return
else
    PARAMS.ltsa.gen = 1;
end

PARAMS.ltsa.tave = str2double(deal(in{1}));

PARAMS.ltsa.dfreq = str2double(deal(in{2}));

if PARAMS.ltsa.ftype == 1        % wav file generated by Ishmael
    PARAMS.ltsa.dtype = 4;
else %PARAMS.ltsa.ftype == 2    % xwav file
    PARAMS.ltsa.dtype = 1;
end

% choose channel to LTSA if there is more than one channel in data file(s)
if PARAMS.ltsa.nch(1) > 1

    prompt={['Enter which channel to LTSA from 1 to ',...
        num2str(PARAMS.ltsa.nch),' : ']};

    def={num2str(1)};

    dlgTitle='Choose Channel to LTSA';
    lineNo=1;
    AddOpts.Resize='on';
    AddOpts.WindowStyle='normal';
    AddOpts.Interpreter='tex';
    % display input dialog box window
    in2=inputdlg(prompt,dlgTitle,lineNo,def,AddOpts);
    if isempty(in2)	% if cancel button pushed
        PARAMS.ltsa.ch = 1;
    else
        PARAMS.ltsa.ch = str2double(deal(in2{1}));
    end

end