function [ traj ] = Design_traj( Hd )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[nx, ny]= size(Hd);

%% Load dropletshape and make a trajectory vector
hd=reshape(Hd',[nx*ny,1]);
traj = find(hd);

%% Determine direction of printernozzle (Preset trajectory)
for i = 1:length(traj)
    if mod(((traj(i)-1)-mod(traj(i)-1,ny))/ny,2) == 1;
        even(i) = 1;
    else
        even(i) = 0;
    end
end
z = 1;
zz = 1;
start = 1;
ending = 0;
i_end=[];
for i = 1:length(even)
    if even(i) ==1 && start == 1
        i_start(z) = i;
        start = 0;
        ending = 1;
        z = z+1;
    end
    if even(i)==0 && ending == 1;
        i_end(zz) = i-1;
        start = 1;
        ending = 0;
        zz = zz+1;
    end
end
if isempty(i_end)==0
    if length(i_end) < length(i_start)
        i_end = [i_end length(even)];
    end
    for i = 1:length(i_end)
        traj(i_start(i):i_end(i)) = flip(traj(i_start(i):i_end(i)));
    end
end
end