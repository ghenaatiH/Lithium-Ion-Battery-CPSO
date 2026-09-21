clear;clc;close all;
success = false; 
while ~success
    try
        pso
        success = true;
        disp('file1 با موفقیت اجرا شد!');
        
    catch
        disp('خطایی در file1 رخ داد. دوباره تلاش می‌شود...');success = false;
    end
end


clear;clc;close all;
success = false; % یک متغیر برای کنترل موفقیت آمیز بودن اجرا
while ~success
    try
        pso
        success = true;
        disp('file1 با موفقیت اجرا شد!');
        
    catch
        disp('خطایی در file1 رخ داد. دوباره تلاش می‌شود...');success = false;
    end
end

clear;clc;close all;
success = false; % یک متغیر برای کنترل موفقیت آمیز بودن اجرا
while ~success
    try
        pso
        success = true;
        disp('file1 با موفقیت اجرا شد!');
        
    catch
        disp('خطایی در file1 رخ داد. دوباره تلاش می‌شود...');success = false;
    end
end

clear;clc;close all;
success = false; % یک متغیر برای کنترل موفقیت آمیز بودن اجرا
while ~success
    try
        cpso
        success = true;
        disp('file1 با موفقیت اجرا شد!');
        
    catch
        disp('خطایی در file1 رخ داد. دوباره تلاش می‌شود...');success = false;
    end
end

clear;clc;close all;
success = false; % یک متغیر برای کنترل موفقیت آمیز بودن اجرا
while ~success
    try
        cpso
        success = true;
        disp('file1 با موفقیت اجرا شد!');
        
    catch
        disp('خطایی در file1 رخ داد. دوباره تلاش می‌شود...');success = false;
    end
end

!shutdown -h now