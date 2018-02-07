function [ D, M] = Construct_Incedence(nx,ny)
%Make incidence matrix D and link map M
%n: size of the whole region
%D: incidence matrix -> D_ij = +1 if node i begins link j, -1 if node i
%ends link j.
%M: link map, M(i,j) gives the link number between node i and j

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
end
