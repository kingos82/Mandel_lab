clear all
close all
clc
% convert frames in cell/structure format to 2D matrix
     Dir=['/Users/nadavivzan/Dropbox/Mandel lab/VSDI_code/monitor_0/'];  
%     Dir=['/Users/nadavivzan/Dropbox/Mandel lab/VSDI_code/E3/'];
     mtx=frms2mat(Dir);
%   
[t_trig0, t_photod0]=find_trg([Dir 'Timing_FileMonitor.bin']);

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

figure
n=2500 %% pixel vector I choose to show



for k0=1:5 %%move across conditions

    

    
    ints1=[];
    mnmx=0;
    for k3=1:5 %%move across blocks
        
        
        for k1=1:2
            indx{k0}(k1,:)=round(t_stim{k3}(k0,k1).*250)+[1:125];
            ints0{k0}(k1,:)=mtx{k3}(n,indx{k0}(k1,:));
        end
        ints0{k0}=ints0{k0}-mean(ints0{k0}(:));
        
        ints1=[ints1; ints0{k0}-mnmx];
         mnmx=(max(ints0{k0}(:))-min(ints0{k0}(:)))+mnmx;
    end
    ints2{k0}=ints1;    
end

ints_pre=[];


for k0=1:5
    indx_pre=round(t0(k0).*250)+[1:125];     
    ints_pre=[ints_pre; mtx{k0}(n,indx_pre)];
end

subplot(3,2,1)
plot([0:124]./250,ints2{1});
axis([0 0.5 min(ints2{1}(:)) max(ints2{1}(:))])
title('Condition 1 - Top left')


subplot(3,2,2)
plot([0:124]./250,ints2{2});
axis([0 0.5 min(ints2{2}(:)) max(ints2{2}(:))])
title('Condition 2 - Top right')


subplot(3,2,3)
plot([0:124]./250,ints2{3});
axis([0 0.5 min(ints2{3}(:)) max(ints2{3}(:))])
ylabel('Flurecence')
title('Condition 3 - Bottom left')

subplot(3,2,4)
plot([0:124]./250,ints2{4});
axis([0 0.5 min(ints2{4}(:)) max(ints2{4}(:))])
title('Condition 4 - Bottom right')

subplot(3,2,5)
plot([0:124]./250,ints2{5});
axis([0 0.5 min(ints2{5}(:)) max(ints2{5}(:))])
xlabel('Time (ms)')

title('Condition 5 - Blank')

subplot(3,2,6)
indx=round(t0(k0).*250)+[1:125]; 
plot([0:124]./250,ints_pre);
xlabel('Time (ms)')
title('Pre-stim')
