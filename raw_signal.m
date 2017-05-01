%clear all
close all
clc
% convert frames in cell/structure format to 2D matrix
     %Dir=['/Users/nadavivzan/Dropbox/Mandel lab/VSDI_code/monitor_0/'];  
     Dir=['C:\Users\User\Dropbox\Mandel lab\VSDI data\2017.04.19\E3'];
     mtx=frms2mat(Dir); 
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
nf=400; %number of frames to show
for k0=1:10
    indx_pre=round(t0(k0).*250)+[1:nf];     
    ints_pre=[ints_pre; mtx{k0}(n,indx_pre)];
end

base_line=mean(ints_pre,2);



for k0=1:length(mtx)
    
   v0= (mtx{k0}(n,:)-base_line(k0))./base_line(k0);
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






% ints_pre=[];
% for k0=1:10
%     indx_pre=round(t0(k0).*250)+[1:nf];     
%     ints_pre=[ints_pre; mtx{k0}(n,indx_pre)];
% end
% 
% base_line=mean(ints_pre,2);
% 
% 
% for k0=1:5 %%move across conditions
% %for k0=5:1 %%move across conditions    
%     ints1=[];
%     mnmx=0;
%     for k3=1:10 %%move across blocks
%         
% %         for k1=1:2
% %             indx{k0}(k1,:)=round(t_stim{k3}(k0,k1).*250)+[1:nf];
% %             if k0==5
% %                 ints0{k0}(k1,:)=mtx{k3}(n,indx{k0}(k1,:));
% %                 
% %             else
% %                 base_line1=mean(mtx{k3}(n,indx{5}(k1,:)));
% %                   ints0{k0}(k1,:)=(mtx{k3}(n,indx{k0}(k1,:))-base_line1)./base_line1;
% %             end
% %            
% %         end
%         
%         
%         
%         for k1=1:2
%             indx{k0}(k1,:)=round(t_stim{k3}(k0,k1).*250)+[1:nf];
%             ints0{k0}(k1,:)=(mtx{k3}(n,indx{k0}(k1,:))-base_line(k3))./base_line(k3);
%             %        ints0{k0}(k1,:)=mtx{k3}(n,indx{k0}(k1,:));
% 
%         end
%         %ints0{k0}=ints0{k0}-mean(ints0{k0}(:));
%         ints1=[ints1; ints0{k0}];
%         %ints1=[ints1; ints0{k0}-mnmx];
%          %mnmx=(max(ints0{k0}(:))-min(ints0{k0}(:)))+mnmx;
%     end
%     ints2{k0}=ints1;    
% end
% 
% 
% %subplot(3,2,1)
% figure
% plot([0:nf-1]./250,ints2{1});
% axis([0 nf./250 min(ints2{1}(:)) max(ints2{1}(:))])
% title('Condition 1 - Top left')
% 
% 
% %subplot(3,2,2)
% figure
% plot([0:nf-1]./250,ints2{2});
% axis([0 nf./250 min(ints2{2}(:)) max(ints2{2}(:))])
% title('Condition 2 - Top right')
% 
% 
% %subplot(3,2,3)
% figure
% plot([0:nf-1]./250,ints2{3});
% axis([0 nf./250 min(ints2{3}(:)) max(ints2{3}(:))])
% ylabel('Flurecence')
% title('Condition 3 - Bottom left')
% 
% %subplot(3,2,4)
% figure
% plot([0:nf-1]./250,ints2{4});
% axis([0 nf./250 min(ints2{4}(:)) max(ints2{4}(:))])
% title('Condition 4 - Bottom right')
% 
% %subplot(3,2,5)
% figure
% plot([0:nf-1]./250,ints2{5});
% axis([0 nf./250 min(ints2{5}(:)) max(ints2{5}(:))])
% xlabel('Time (ms)')
% 
% title('Condition 5 - Blank')
% 
% %subplot(3,2,6)
% figure
% indx=round(t0(k0).*250)+[1:125]; 
% plot([0:nf-1]./250,ints_pre);
% axis([0 nf./250 min(ints_pre(:)) max(ints_pre(:))])
% 
% xlabel('Time (ms)')
% title('Pre-stim')
