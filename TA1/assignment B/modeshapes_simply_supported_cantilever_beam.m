function [phi, omega] = modeshapes_simply_supported_cantilever_beam(x, order, length, EI, rhoA)
% Calculates the eigenfrequency and the normalized mode shape of a beam
% with a fixed support on one side and a simple support on the other side
% EI - bending moment (Young's modulus * Area moment of ineria)
% rhoA - mass per unit length (density * cross-section)
% length - total length of the beam
% x - coordinate, should be between 0 and length
% order - 1, 2, 3, ...

% approximation for the wavenumber
kn = ((order + 0.25) * pi ) / length;  

% mode shape
phi = sinh(kn*(length-x)) - sinh(length * kn) / sin(length * kn) * sin(kn*(length-x));

% normalising the mode shape to 1
phi = phi / max(phi);

% eigenfrequency in circular frequency
omega = sqrt(EI/(rhoA)) * kn^2;