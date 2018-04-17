function cc=get_kmeans(k1,k2,threshold)
%load train file
member = csvread('members_id.csv', 1, 0);
clusterUser= kmeans(member(:,2:5),k1);
song = csvread('songs_id.csv', 1, 0);
clusterSong= kmeans(song(:,2:14),k2);
input = load('input_train1.mat');
result = input.result;
output = load('output_train1.mat');
target = output.target;
cc = zeros(k1,k2);
for i = 1:k1
    for j = 1:k2
        users = find(clusterUser(:)==i);
        songs = find(clusterSong(:)==j);
        A = member(users,1);
        B = result(:,1);
        isusers = ismember(B,A);
        C = song(songs,1);
        D = result(isusers(:)==1,4);
        issongs = ismember(D, C);
        if (issongs == 0)
            cc(i,j)=0;
        else 
            cc(i,j)=sum(target(issongs))/sum(issongs);
        end
       
        
    end
end
save('cc.mat','cc');
get_accuracy(cc,clusterUser,clusterSong, threshold);
end
