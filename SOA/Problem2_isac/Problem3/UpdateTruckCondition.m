
%perhaps have a time parameter 
function [x, v, temperatureBrake, deltaTb] = UpdateTruckCondition(temperatureBrake, x...
    , v, gear, pressurePedal, deltaTb, alpha, timestep)

     [temperatureMax,mass,tao,cH,temperatureAmbient,...
    cB,~,~,~,~,~] = InitiateTruckSlopeVariables();

    %calculate Fb, Feb, Fg
    switch gear
        case 1
            Feb = 7.0*cB;
        case 2
            Feb = 5.0*cB;
        case 3
            Feb = 4.0*cB;
        case 4
            Feb = 3.0*cB;
        case 5
            Feb = 2.5*cB;
        case 6
            Feb = 2.0*cB;
        case 7
            Feb = 1.6*cB;
        case 8
            Feb = 1.4*cB;
        case 9
            Feb = 1.2*cB;
        case 10
            Feb = cB;
    end

    g = 9.82;%m/s^2
    Fg = mass*g*sin(alpha*pi/180);%N

    if temperatureBrake < temperatureMax -100
        Fb = (mass*g/20)*pressurePedal;%N
    else
        expTerm = -(temperatureBrake-(temperatureMax-100))/100;
        Fb = (mass*g/20)*pressurePedal*exp(expTerm);%N
    end

    %update x
    x = x + v*timestep;

    %update v
    vPrime = (Fg-Fb-Feb)/mass;
    v = v + vPrime*timestep;

    %update Tb and deltaTb
    if pressurePedal < 0.01
        deltaTb = deltaTb - deltaTb/tao*timestep;
        temperatureBrake = temperatureAmbient + deltaTb;
    else
        deltaTb =  deltaTb + cH*pressurePedal*timestep;
        temperatureBrake = temperatureAmbient + deltaTb;
    end
    

end