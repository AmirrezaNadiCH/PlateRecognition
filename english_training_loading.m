files=dir('English Map Set');
len=length(files)-2;

TRAIN=cell(2,len);

for i=1:len
   TRAIN{1,i}=imread(['English Map Set','\',files(i+2).name]);
   TRAIN{2,i}=files(i+2).name(1);
end

save('TRAININGSET.mat','TRAIN');