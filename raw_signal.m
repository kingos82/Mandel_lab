%clear all
close all
clc
% convert frames in cell/structure format to 2D matrix
     %Dir=['/Users/nadavivzan/Dropbox/Mandel lab/VSDI_code/monitor_0/'];  
     Dir=['C:\Users\User\Dropbox\Mandel lab\VSDI data\2017.04.19\E3'];
     %Dir=['C:\Users\User\Dropbox\Mandel lab\VSDI data\2017.04.24\E3'];
     %mtx=frms2mat(Dir); 
     %load E3.mat 
%   
[t_trig0, t_photod0]=find_trg([Dir '\E3.bin']);
t_photod1=reshape(t_photod0,[],length(mtx))';

%%setting up the timings!!!
for k0=1:length(mtx)
    t0(k0)=t_photod1(k0,1)-t_trig0(k0);
    
    t_stim{k0}=...
       [t_photod1(k0,2) t_photod1(k0,7);
        t_photod1(k0,3) t_photod1(k0,8);
        t_photod1(k0,4) t_photod1(k0,9);
        t_photod1(k0,5) t_photod1(k0,10);
        t_photod1(k0,6) t_photod1(k0,11)]-t_trig0(k0);
end

ints_pre=[];
figure


n=5208; %% pixel vector I choose to show
nf=200; %number of frames to show

sub_ind=get_area(mtx{1}); %get area under rectangle

for k0=1:10
    sub_set{k0}=mtx{k0}(sub_ind(:),:);
    indx_pre=round(t0(k0).*250)+[1:nf];   
    
    ints_pre=[ints_pre; mean(sub_set{k0}(:,indx_pre))];
end

base_line=mean(ints_pre,2);


figure
for k0=1:length(mtx)
    
   v0= (mean(sub_set{k0})-base_line(k0))./base_line(k0);
   v1=2.*(v0-min(v0))./(max(v0)-min(v0))-2.*k0+1;
   %figure 
   %subplot(10,1,k0)
   hold on
   plot([0:2999]./250, v1) 
   %title(['Block ' num2str(k0)])
    hold on
    line([t0(k0) t0(k0); reshape(t_stim{k0},[],1) reshape(t_stim{k0},[],1)]',...
        [repmat(min(v1),11,1) repmat(max(v1),11,1)]','color','k')
end

axis([0 12 -19 1])



