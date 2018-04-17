function acc=get_accuracy(cc,clusterUser,clusterSong, threshold)
%load train file
fileID = fopen('r1.test');
usersItems = textscan(fileID, '%f %f %f %f %f %f','Delimiter', ',');
uid = usersItems{1};
mid = usersItems{2};
rate = usersItems{6};
[itemNum,v]=size(rate);
TP = 0;
TN = 0;
FP = 0;
FN = 0;
sizeuser = size(clusterUser);
sizesong = size(clusterSong);
for i=1:itemNum
    userId = uid(i);
    musicId = mid(i);
    if musicId > sizesong | musicId < 1 
        continue
    elseif userId > sizeuser| userId < 1
        continue
    else
        predict = cc(clusterUser(userId),clusterSong(musicId));
        rating = rate(i);
        if rating < threshold && predict < threshold
            TN = TN+1;
        elseif rating < threshold && predict >= threshold
            FP = FP+1;
        elseif  rating >= threshold && predict >= threshold
            TP = TP+1;  
        elseif  rating >= threshold && predict < threshold
            FN = FN+1;
        else
        
        
        end
    end
end

acc = (TP+TN)/(TP+TN+FP+FN);
disp(TP+TN);
disp(TP+TN+FP+FN);
disp(acc);
end
