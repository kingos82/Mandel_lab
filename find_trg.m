function [t_trig, t_photod]=find_trg(Dir);

%     fid2 = fopen([Dir 'Timing_FileMonitor.bin'],'r');

    fid2 = fopen(Dir,'r');
    [data,count] = fread(fid2,[3,inf],'double');
    fclose(fid2);
    t = data(1,:);
    ch = data(2:3,:);
    fs=2.75*1000;
    w=[20/(fs/2) 30/(fs/2)];
    b=fir1(100,w,'bandpass');
    ch0=filtfilt(b,1,((ch(1,:)/max(ch(1,:)))-min((ch(1,:)/max(ch(1,:)))))...
        -mean(((ch(1,:)/max(ch(1,:)))-min((ch(1,:)/max(ch(1,:)))))));
    plot(t,[ch0; ch(2,:)])
    trsh=input('What is the threshold?');
    %trsh=0.3;
    ch1=ch0>trsh;
    ch2=diff(ch1);
    ch2(ch2==-1)=0;
    t_photod= find(ch2==1)./5000;    
    
    ch3=ch(2,:);
    ch4=ch3>trsh;
    ch5=diff(ch4);
    ch5(ch5==-1)=0;  
    t_trig= find(ch5==1)./5000;
    hold on
    plot(t,trsh.*[0 ch2; 0 ch5], '*');