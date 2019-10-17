time = [8.638 0.219 4.047 4.147 0.342];
length = [177269 27816 122671 120411 42687];
size = [12642 1880 8727 8556 3052];

% figure
% plot(size,time,'o')

% fileattrib rc_0.log

s=dir('rc_0.log');
the_size=s.bytes;

user = memory;
user.MemAvailableAllArrays
