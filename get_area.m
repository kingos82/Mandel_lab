function sub_ind=get_area(data)
%data0=repmat([1:85.^2]',1,3000 );
%data0=reshape([1:3000.*(85.^2)]',85.^2,3000);
%data0=data0./max(data0(:));
%data=data0; %mtx{1};
close all; 
imshow(reshape(mean(data'), 85, 85),[]); 
%imshow(data); 
colormap(jet);
rect=round(getrect);
rectangle('Position',rect);
ind_mat=reshape([1:85.^2],85,85);
sub_ind=ind_mat(rect(1)+[0:rect(3)-1], rect(2)+[0:rect(4)-1]);
% sub_set=data(sub_ind(:),:);
%figure
%imshow(reshape(mean(sub_set'),rect(4),rect(3)),[])


