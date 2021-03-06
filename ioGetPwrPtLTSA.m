function [pwr,pt] = ioGetPwrPtLTSA(p,fnames,L,K,rfTime,k,hdr)

% grab the ltsa pwr matrix to plot
nbin = sum(hdr.ltsa.nave(L)); % # of time bins to get 
fid = fopen(fullfile(hdr.ltsa.inpath,hdr.ltsa.infile),'r');
% samples to skip over in ltsa file
skip = hdr.ltsa.byteloc(L(1));
fseek(fid,skip,-1);    % skip over header + other data

if ~isempty(k)
    pwr = fread(fid,[hdr.ltsa.nf,nbin],'int8');   % read data
    fclose(fid);
    [ pt, pwr] = padLTSAGaps(hdr, L,pwr);
else
    pwr = fread(fid,[hdr.ltsa.nf,nbin],'int8');   % read data
    fclose(fid);
    % make time vector
    t = rfTime{K}(L(1));
    dt = datenum([0 0 0 0 0 5]);
    pt = t:dt:t + (nbin-1)*dt;
end