

function answer = DecodeOperators(operatorString,value1,value2,constants)
    switch operatorString
        case '+'
            answer = value1 + value2;
        case '-'
            answer = value1 - value2;
        case '*'
            answer = value1 .* value2;
        otherwise
            if value2 == 0
               answer = max(constants);
            else
                answer = value1./value2;
            end
    end
    
end