function [R,buffer_count] = updateReplayBuffer(experience,buffer_size,R)
[row,col] = size(R);
if row < buffer_size
    R = [R;experience];
    buffer_count = row+1;
else
    R = [R(2:row,:);experience];
    buffer_count = row;
end

 