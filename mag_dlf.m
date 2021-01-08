function [ data_storage_mag ] = mag_dlf( tmins, tdays, ftpobj )
%download ACE mag data files for dates defined in tdays and store data in
%data_storage_mag

%initialize
data_storage_mag = strings([length(tmins),1]);
row = 1;
%loop through requested dates
    for ti = 1:length(tdays)
        YY = year(tdays(ti));
        MM = datestr(tdays(ti),5);
        DD = datestr(tdays(ti),7);
        %define filename based on date
        filename = [num2str(YY) num2str(MM) num2str(DD) '_ace_mag_1m.txt'];
        %get datafile
        mget(ftpobj,filename);
        data = splitlines(fileread(filename));
        %find first line after header
        r = find(char(data(:,1)) == '2');
        data = data(r(1):end-1);
        %store data in data_storage_mag
        data_storage_mag(row:(row+length(data)-1)) = data;
        row = row+length(data);
        %delete local file
        delete(filename);
    end

end

