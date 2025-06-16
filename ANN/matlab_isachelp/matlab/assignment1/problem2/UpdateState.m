
%asynchronous update of state N times
function newState = UpdateState(currentState,weightMatrix)

    newState = currentState;
    %N asynchronous updates in a row
    for iBit = 1:length(currentState)
        newState(iBit) = Sgn(weightMatrix(iBit,:)*currentState');
        currentState(iBit) = newState(iBit);
    end

end