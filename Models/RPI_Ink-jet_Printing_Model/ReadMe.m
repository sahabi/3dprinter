%This file shows how to use the Inkjet_Print funciton. Design_traj and
%Construct_Incedence are called in Inkjet_Print. drop_avg constains the
%droplet shape information.

%First define your input. It is a matrix represent the droplet size at each location, each element
%should be within [0, 1]. It is recommened to choose the size smaller than 100*100. 
input = rand(100,80);

%Call fucntion Inkjet_Print to generate the height profile
H=Inkjet_Print(input);

%Display the generated height profile

