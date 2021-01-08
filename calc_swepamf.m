function [ V, n, dates_swepam ] = calc_swepamf( data_storage_swepam )
%%calculate properties from data_storage_swepam

data_storage_swepam = data_storage_swepam(data_storage_swepam ~= '');
%initialize:
V = NaN(length(data_storage_swepam),1);
n = NaN(length(data_storage_swepam),1);
dates_swepam = NaT(length(data_storage_swepam),1, 'Format','d-MMM-y HH:mm:ss');
%data quality tag:
QV = NaN(length(data_storage_swepam),1);
%loop through data file rows and store in variables:
    for m = 1:length(data_storage_swepam)
        data = str2num(char(data_storage_swepam(m)));
        HH = floor(data(6)/3600);
        MM = floor(mod(data(6),3600)/60);
        SS = 0;
        QV(m) = data(7);
        n(m) = data(8);
        V(m) = data(9);
        dates_swepam(m) = datetime(data(1), data(2), data(3), HH, MM, SS);
    end
%replace missing data with NaNs
V(V(:) == -9999.9) = NaN;
n(n(:) == -9999.9) = NaN;
%replace bad quality data with NaNs 
V(QV ~=0) = NaN;
n(QV ~=0) = NaN;

end

