%song_id song_length artist_name composer lyricist language first_genre_id second_genre_id 
song = csvread('songs_id.csv', 1, 0);
%msno city bd gender regsiter_via register_init_time expiration_date
member = csvread('members_id.csv', 1, 0);
fileID = fopen('r1.test');
trainItems = textscan(fileID, '%f %f %f %f %f %f','Delimiter', ',');
%msno,song_id,source_system_tab,source_screen_name,source_type

msno = trainItems{1};
song_id = trainItems{2};
source_system_tab= trainItems{3};
source_screen_name= trainItems{4};
source_type=trainItems{5};
target = trainItems{6};
[itemNum,v]=size(target);
gender = zeros(itemNum,1);
bd= zeros(itemNum,1);
song_length = zeros(itemNum,1);
artist_name = zeros(itemNum,1);
composer = zeros(itemNum,1);
lyricist = zeros(itemNum,1);
language = zeros(itemNum,1);
first_genre_id = zeros(itemNum,1);
second_genre_id  = zeros(itemNum,1);
for i = 1:size(member)
    row = find(msno(:)==member(i,1));
    gender(row) = member(i,4);
    bd(row) = member(i,3);
   
    
end
%song_length artist_name composer lyricist language first_genre_id second_genre_id 
for j = 1:size(song)
    row = find(song_id(:)==song(j,1));
    song_length(row) = song(j,2);
    artist_name(row) = song(j,3);
    composer(row) = song(j,4);
    lyricist(row) = song(j,5);
    language(row) = song(j,6);
    first_genre_id(row) = song(j,7);
    second_genre_id(row) = song(j,8);
          
end
result = [msno gender bd song_id song_length artist_name composer lyricist language first_genre_id second_genre_id source_system_tab source_screen_name source_type];
save('input_test1.mat','result');
save('output_test1.mat','target');
