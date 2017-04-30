function mtx=frms2mat(Dir)


%Dir=['/Users/nadavivzan/Dropbox/Mandel lab/VSDI_code/monitor_0/'];
SignalFiles=dir(fullfile(Dir, '*.mat'));

for k=1:length(SignalFiles)
    loaded{k}=(load([Dir '/' SignalFiles(k).name]));
    names{k}=fieldnames(loaded{k});
end



for k=1:length(SignalFiles)
    count_stim1=1;
    mtx{k}=zeros(85.^2,3000);    
    for i=1:length(names{k})
        if names{k}{i,1}(1:2)=='c0'
            stim1{k,count_stim1}=getfield(loaded{k},names{k}{i,1});
            mtx{k}(:, count_stim1)=reshape(  getfield(loaded{k},names{k}{i,1}),[],1);
            
            % stim1{count_stim1}=getfield(loaded,names{i});
            count_stim1=count_stim1+1; 
        end
        %waitbar(k/length(SignalFiles))      
    end
    mtx{k}=detrend(mtx{k}')';
end




