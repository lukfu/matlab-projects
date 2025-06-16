
%prints answer in a openTA friendly way
function k = PrintStateAsMatrix(state,width)
    k = '[';
    for i = 1:length(state)/width
        s = state(i*width-width+1:i*width);
        s = string(regexprep( mat2str(s), {' '}, {','}));%to string
        if i ~= length(state)/width
            k = k+s + ',';
        else
            k = k+s;
        end
    end
    k = k+']';

end