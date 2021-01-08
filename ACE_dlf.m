function [ n, V, Bx, By, Bz, BVsquared, dates_mag, dates_swepam ] = ACE_dlf( t1, t2 )
%Imports ACE data for the most important solar wind properties between dates t1 to t2
%valid t1 and t2 format example: t1 = [2020,09,28];
% data available from 29-Jul-2015 onwards

%Solar wind properties: 
% "n" proton density
% "v" solar wind speed
% "Bx" solar wind magnetic field z component
% "By" solar wind magnetic field z component
% "Bz" solar wind magnetic field z component
% "BVsquared" (solar wind magnetic field south component) * (solar wind
% speed)^2

%define ftp server info and time frame
ftpobj = ftp('ftp.swpc.noaa.gov');
cd(ftpobj,'pub/lists/ace/');
start_date = datetime(t1(1), t1(2), t1(3), 0, 0, 0);end_date = datetime(t2(1), t2(2), t2(3), 23, 59, 59);
tdays = start_date:days(1):end_date;
tmins = (start_date:minutes(1):end_date).';

%download mag data for selected dates and store in data_storage_mag
data_storage_mag = mag_dlf(tmins, tdays, ftpobj);

%download swepam data for selected dates and store in data_storage_swepam
data_storage_swepam = swepam_dlf(tmins, tdays, ftpobj);

%calculate properties from data_storage_mag
[Bx, By, Bz, dates_mag] = calc_magf(data_storage_mag);

%calculate properties from data_storage_swepam
[V, n, dates_swepam] = calc_swepamf(data_storage_swepam);

%calculate BVsquared
    %define Bs:
    Bs = Bz;
    Bs(Bs(:) > 0) = 0;
    %calculate BV^2:
    BVsquared = (V.^2).*Bs;
    BVsquared(BVsquared(:) == 0) = NaN;
    
%cleanup:
    clearvars -except n V Bx By Bz BVsquared dates_mag dates_swepam

end

