%% HRSV Assignment 1 - Matlab intruduction
% This script is meant to give you a short overview about data handling in
% Matlab required for your first HRSV assignment. Feel free to contact me
% if you have any questions!


% Author: Leon Müller - Chalmers University of Technology
% email: leon.mueller@chalmers.se
% February 2022



%% Overview of Different Data Structures
close all
clear
clc

%% Single scalar - A scalar is a two-dimensional array that has a size of 1-by-1.

a = 1;


%% Vectors
a2 = [1; 2; 3; 4];
a3 = (1:0.5:20)';

%% 2D Arrays
% Commas separate columns, semicolons seperate rows
b = [1, 2, 3; 4, 5, 6];
% We can get the size of a matrix (also called array) by using
size_b = size(b);
% Remember that the first dimension is the number of rows and the second is
% the number of columns!

% If we are only interested in the size of one dimension we can use 
size_b_1 = size(b, 1); % (see doc size)

% We can combine ("concatenate") different arrays with the same comma and semicolon
% operators that we used before. Therefore, we have to ensure that the
% dimensions of the different arrays match!
b2 = [b, 2*b; b/2, -b];

% We can transpose an array, i.e. changing its orientation, by using '
b3 = b2';

% If you are using complex numbers you have to be careful with ', as this
% will give you the complex conjugate! If you want to transpose an array of
% complex numbers, use .' !

b4 = [1 + 2i, 3 + 4i, 5 + 6i];
b5 = b4';
b6 = b4.';

%% Multidimensional Arrays
% This matlab page gives a good overview about the fundamentals of
% multidimensional arrays: https://www.mathworks.com/help/matlab/math/multidimensional-arrays.html

% When we use multidimensional arrays, we have more indexes available than
% just rows and columns. We can create a 3D array by just concatenating two
% 2D arrays as
c(:,:,1) = b;
c(:,:,2) = 2*b;

% Or alternatively, by using the cat function (see doc cat)
c2 = cat(3, b, 2*b);

% In the same way, we can create even higher order arrays. In some cases, this 
% may actually make sense, e.g. often you can avoid using loops by using 3D
% arrays. We will come to that later.
c3(1,2,3,4,5) = 1; % This for example creates a 5D array.
c4 = rand(20,20,20,20); % here we use the rand function to generate a 20x20x20x20 random array



%% Structure Arrays
% We can organize or data by arranging them in structs. Structure arrays 
% contain data in fields that you access by name. This helps to clean
% up our workspace and keep a good overview. 

% We can create a struct by using the dot operator as
data_struct.a = a;
data_struct.b = b;
data_struct.c = b;
data_struct.d = "Important Data";

% In the same way, we can read variables from structs
my_result = mean(data_struct.b, 2);

% We can also create structs in structs
data_struct.subdata.a = a;

% An alternative way to index structs is by additionaly numbering the individual fields
other_struct(1).a = a;
other_struct(2).a = 2*a;
other_struct(1).b = b;
other_struct(2).b = 2*b;
other_struct(1).c = b;
other_struct(2).c = 2*b;
other_struct(1).d = data_struct.d;
other_struct(2).d = data_struct.d;

% You can access the data in the same way:
my_other_result = mean(other_struct(1).b, 2);


%% Cell arrays
% Cell arrays contain data in cells that you access by numeric indexing.
% This is a good aternative to structs when you want to be able to index
% different dataset e.g. to loop through them.

% We can create cell arrays by using curly brackets
data_cell = {a, b, "a string"; 2*a, 2*b, "an other string"};

% And again, we access the data with the same operator
my_cell_result = mean(data_cell{1,2}, 2);

% We can also create cell arrays in cell arrays. This may seem confousing
% right now but actually makes sense sometimes
confusing_cell = {data_cell; data_cell};

% If we want to extract the data from one of those cells we again use the
% curly brackets
extracted_data = confusing_cell{1,1}{1,2};

% In the above case, we get the data in its original format, a 2D array in
% this case. If we want to extract a whole cell array out of an other cell
% we use normal parentheses.
extracted_cell = confusing_cell(1,1);

% Here is an explanation from the internet which might clarify this a bit 
% "Think of cell array as a regular homogenic array, whose elements are all cells. 
% Parentheses () simply access the cell wrapper object, while accessing elements 
% using curly brackets {} gives the actual object contained within the cell.
% (https://stackoverflow.com/questions/9055015/difference-between-accessing-cell-elements-using-curly-braces-and-parentheses)


%% The HRSV Assignment 1 Data Structure

% Now lets take a look at the actual data structure of our soundwalk
% results.

% First clear up all the mess from before
clear

% The data comes in .mat files, we can load them by using
load('sw_2017_group_1A.mat')
% Note that the .mat file needs to be in your matlab path for this.
% Alternatively, you can also specify the whole file path as follows
% load('/Users/leon/Library/Mobile Documents/com~apple~CloudDocs/02_Uni/Teaching/HRSV/Assignment 1/sw_2017_group_1A.mat')

% If we now take a look at our workspace, we see that we got a 1x5 struct
% called 'sw_2017_group_1A'. Doubleclicking on the struct in our workspace
% reveals that this struct contains fields called 'interview',
% 'Questions_1234' and 'Questions_56', each of them numberes for the 5
% participants of this group.

%% 
% Lets start with a few basic things: we can determine the number of
% participants in this group by taking the size of this struct in 2nd
% Dimension.

sw17.grp1A.nParticipants = size(sw_2017_group_1A, 2);

%% 
% If we want to get the answers from an individual participant we index the
% struct like this
tmp = sw_2017_group_1A(1).Questions_1234;

% thereby the number in the parentheses is the participant number and we
% specify the field that we want for this participant by using the dot
% operator.

% we can also directly process this data, e.g.
sw17.grp1A.meanPart1 = mean(sw_2017_group_1A(1).Questions_1234, 1);

%%
% If we do the same for the interview answers, we get a cell array.
tmp = sw_2017_group_1A(1).interview;

% This means that, if we want to extract a single value from the interview
% questions, e.g. the age, we have to use curly brackets here
sw17.grp1A.agePart1 = sw_2017_group_1A(1).interview{3};


%%
% So far so good. But how do we efficiently calculate things like the mean
% result for a single location of an entire group?

% If we look again at our input data, we see that the answers for questions
% 1-4 are given in a 2D matrix with the orientation (location x question)
% for each participant

% The most straightforward but cumbersome way would be something like this:

% We could manually extract the answers for a single location of a
% participant
sw17.grp1A.loc1Part1 = sw_2017_group_1A(1).Questions_1234(1,:);
sw17.grp1A.loc1Part2 = sw_2017_group_1A(2).Questions_1234(1,:);
sw17.grp1A.loc1Part3 = sw_2017_group_1A(3).Questions_1234(1,:);
sw17.grp1A.loc1Part4 = sw_2017_group_1A(4).Questions_1234(1,:);
sw17.grp1A.loc1Part5 = sw_2017_group_1A(5).Questions_1234(1,:);


% Then combine those to a single 2D Array
sw17.grp1A.loc1 = [sw17.grp1A.loc1Part1; sw17.grp1A.loc1Part2; sw17.grp1A.loc1Part3; ...
    sw17.grp1A.loc1Part4; sw17.grp1A.loc1Part5];

% And finally take the mean for this array in the first dimension
sw17.grp1A.loc1Mean = mean(sw17.grp1A.loc1, 1);

% While this gives us the right result, we would have to repeat this for
% each location and each group. Of course we could maybe write a function
% or use some loops to automate this procedure, but there are better ways
% to do this!


%% 
% Lets think again about our problem here. Wouldn't it be nice if we could
% have all data for all participants, all questions and all locations in a
% single matrix so that we can directly perform all our calculations on
% that? Well, this is a case where 3D Arrays are useful:

% remember that we can get the results from a single participant by using
% 'sw_2017_group_1A(1).Questions_1234'. This means that we can store the
% results from all participants in a 3D array, e.g. by doing

sw17.grp1A.q1234(:,:,1) = sw_2017_group_1A(1).Questions_1234;
sw17.grp1A.q1234(:,:,2) = sw_2017_group_1A(2).Questions_1234;
sw17.grp1A.q1234(:,:,3) = sw_2017_group_1A(3).Questions_1234;
sw17.grp1A.q1234(:,:,4) = sw_2017_group_1A(4).Questions_1234;
sw17.grp1A.q1234(:,:,5) = sw_2017_group_1A(5).Questions_1234;

% Or alternatively by using the cat function and inserting all participant
% results at once by using (:) as struct field index
sw17.grp1A.q1234 = cat(3, sw_2017_group_1A(:).Questions_1234);
% There are propably more ways to do this but in my opinion, this is the most
% elegant one!

% Now we have a 3D matrix which is arranged as (Location x Question x
% Participant). If we want to calculate the mean answers for all questions and all locations of all
% participants, we can now just take the mean over the 3rd dimension
sw17.grp1A.q1234mean = mean(sw17.grp1A.q1234, 3);

%% 
% Lets say we want to also calculate the mean over different group
% combinations. Therefore, we just load the other groups data

load('sw_2017_group_1B.mat')

% Convert our results for questions 1-4 to a 3D matrix
sw17.grp1B.q1234 = cat(3, sw_2017_group_1B(:).Questions_1234);

% Combinig our two 3D arrays
sw17.grp1A1B.q1234 = cat(3, sw17.grp1A.q1234, sw17.grp1B.q1234);

% And finally take the mean of the 3rd dimension of this combined matrix
sw17.grp1A1B.q1234mean = mean(sw17.grp1A1B.q1234, 3);

%% Saving our results

% As you might have seen in the assignment pdf, we want you to save your
% results in specific matalb files for each task. This helps us to
% automatically evaluate if your results are correct. Please make sure that
% you read the saving instructions for each task pdf carefully!

% Lets say we want to save our results for the arithmetic mean of question
% 1 for both group 1A and the combination of group 1A & 1B.
% We do this by creating an array which contains the values we want to save
part_1_arithmetic_mean_Q_1 = [sw17.grp1A.q1234mean(:,1)'; sw17.grp1A1B.q1234mean(:,1)']; 

% And then use the save command (see doc save)
save('part_1_arithmetic_mean_Q_1.mat', 'part_1_arithmetic_mean_Q_1')
% Please be aware that this will overwrite existing files with the same
% name!

% We can make our life a bit easier by creating a "results" struct, which contains all
% the things that we want to save later. Then we can loop through all the
% struct fields and save everything at once. However, this is a little bit more
% advanced. In general, it is the best to solve things in a way that you
% understand what you are doing rather than using fancier ways that
% you don't really understand! 

results.part_1_arithmetic_mean_Q_1 = [sw17.grp1A.q1234mean(:,1)'; sw17.grp1A1B.q1234mean(:,1)']; 
results.part_1_arithmetic_mean_Q_2 = [sw17.grp1A.q1234mean(:,2)'; sw17.grp1A1B.q1234mean(:,2)']; 
results.part_1_arithmetic_mean_Q_3 = [sw17.grp1A.q1234mean(:,3)'; sw17.grp1A1B.q1234mean(:,3)']; 

resultnames = fieldnames(results); 
for nr = 1 : size(resultnames,1)
  tempresult.(resultnames{nr}) = results.(resultnames{nr});
  savename = string(resultnames(nr)) + '.mat';
  save(savename,'-struct', 'tempresult');
  clear tempresult savename
end

%% Use functions

%% General Advices

% - Be consistent in the way you name variables!
%   there are different styles that you can use, e.g.
%   my_great_variable_1 or myGreatVariable1, its good practice to use the same
%   naming format in the entire script
% - Find a good balance between too short and too long variable names
%   you could name something 'soundwalk_2021_group1A_mean_q1234' or
%   '21g1AMq14'. While the first variable name is very long and makes your
%   code quite extensive, it is impossible to understand what the second name
%   means if some of your colleagues reads your code. A good compromise
%   could be 'sw21_grp1A_mean_q1234'. Or, IMO even better, you use a struct: 
%   'sw21.grp1A.mean_q1234'
% - If you can, use matrix operations instead of looping through data.
%   E.g. if you, for some reason, want to calculate the sum of all
%   participant answers in a group it is faster and more elegant to do

tic 
mysum = sum(cat(3, sw_2017_group_1B(:).Questions_1234), 3);
t1 = toc;

% instead of looping through all the participants like this 
tic
mysum2 = 0;
for n = 1 : size(sw_2017_group_1B, 2)
    mysum2 = mysum2 +  sw_2017_group_1B(n).Questions_1234;
end
t2 = toc;

timeDifference = t2 - t1;

% the tic and toc functions are just used to demonstrate the difference in 
% computation time between both methods.

