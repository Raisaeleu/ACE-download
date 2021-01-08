function [ Bx, By, Bz, dates_mag ] = calc_magf( data_storage_mag )
%%calculate properties from data_storage_mag

data_storage_mag = data_storage_mag(data_storage_mag ~= '');
%initialize
Bx = NaN*ones(length(data_storage_mag),1);
By = NaN*ones(length(data_storage_mag),1);
Bz = NaN*ones(length(data_storage_mag),1);
dates_mag = NaT(length(data_storage_mag),1, 'Format','d-MMM-y HH:mm:ss');
%data quality tag:
QBs = NaN(length(data_storage_mag),1);
%loop through data file rows and store in variables:
    for m = 1:length(data_storage_mag)
        data = str2num(char(data_storage_mag(m)));
        HH = floor(data(6)/3600);
        MM = floor(mod(data(6),3600)/60);
        SS = 0;
        Bx(m) = data(8);
        By(m) = data(9);
        Bz(m) = data(10);
        dates_mag(m) = datetime(data(1), data(2), data(3), HH, MM, SS);
        QBs(m) = data(7);
    end
%replace missing data with NaNs
Bx(Bx(:) == -999.9) = NaN;
By(By(:) == -999.9) = NaN;
Bz(Bz(:) == -999.9) = NaN;
%replace bad quality data with NaNs 
Bx(QBs ~=0) = NaN;
By(QBs ~=0) = NaN;
Bz(QBs ~=0) = NaN;

end

