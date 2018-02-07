function [H]=Inkjet_Print(input)
%Simulate the Ink-jet printing process, generate height profile given droplet pattern input, 
%input: a matrix represent the droplet size at each location, each element
%should be within [0, 1]. 
%H: A matix represent the generated height profile.
nx = 5;
ny = 5;
k=1;%link index
nn=nx*ny;
nl=4*(nx-1)*(ny-1)+nx+ny-2;
D(1:nn,1:nl)=sparse(0);
M(1:nn,1:nn)=sparse(0);

for x=1:nx
   for y=1:ny
      i=(x-1)*ny+y;
      if y<ny
         D(i,k)=1;
         D(i+1,k)=-1;
         M(i,i+1)=k;
         M(i+1,i)=k;
         k=k+1;
      end
      if x<nx
         D(i,k)=1;
         D(i+ny,k)=-1;
         M(i,i+ny)=k;
         M(i+ny,i)=k;
         k=k+1;
      end
   end
end
for x=1:nx
   for y=1:ny
      i=(x-1)*ny+y;
      if y>1 && x<nx
         D(i,k)=1;
         D(i+ny-1,k)=-1;
         M(i,i+ny-1)=k;
         M(i+ny-1,i)=k;
         k=k+1;
      end
      if y<ny && x<nx
         D(i,k)=1;
         D(i+ny+1,k)=-1;
         M(i,i+ny+1)=k;
         M(i+ny+1,i)=k;
         k=k+1;
      end
   end
end
    input = rand(100,80);
    [n1, n2]=size(input);
    nx=n1+6;
    ny=n2+6;

    U=zeros(nx,ny);
    U(4:nx-3,4:ny-3)=input;

    load('drop_avg');
    ds = drop_avg;

    traj = Design_traj(U);
    u=reshape(U',[nx*ny,1]);
    num = length(traj);
    v = zeros(nx*ny,1);
    h = zeros(nx*ny,1);
    Kv= 3.1e-2;
    D = Construct_Incedence(5,5);
    for i = 1:num
        for p = -2:2
            for q = -2:2
                if traj(i)+p+q*ny>0 && traj(i)+p+q*ny<=nx*ny
                v(traj(i)+p+q*ny) = ds(3-q,3-p);
                end
            end
        end
        F=find(v);
        h(F)=(eye(25)-Kv*(D*D'))*h(F);
        h = h + v*u(traj(i));
        v = zeros(nx*ny,1);

    end  
    H = zeros(length(h)/ny);
    c = 1;
    for i=1:length(h)/ny
      for j=1:ny
        H(i,j) = h(c);
        c = c + 1
end