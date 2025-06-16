%% SIR model for disinformation spreading

%Each individual is either Susceptible (S) to the disinformation, Infected (I) (someone who believe the disinformation),
% or has Recovered (R)(believing truth again) and is immune(a part of them no longer believe the disinformation).
% Infected individuals infect the susceptible they meet at a rate of β andrecover at a rate of γ.


% 1. initialize N agents at random locations and make a small fraction of the agents infected.

% 2.Model the movements of the agents as random walks on the arena: at every
% time step, each agent either remains still with some probability,
% or moves to a random neighboring tile (e.g., their von Neumann
% neighborhood), with a probability of d, where d denotes the diffusion rate.

% 3.For every infected agent, check if there are any susceptible agents in the same
% lattice site. At every time step, each infected agent should have a probability
% β of infecting all susceptible individuals at its current site.

% 4.At every time step, each infected agent has a probability of recovery of γ.

% 5.The disease dynamics evolves until the number of infected agents reaches
% zero. This condition will be used as a stopping criterion for the simulation.

% 6.The probability α means that recovered agents become susceptible again.

% Simulate the agent-based SIR model with d = 0.8 and N = 1000 (1000 agents on a 100 × 100 lattice).
% Use a 1% initial infection rate.

clear all

L = 100; % Length of the lattice.
N = 1000; % Number of agents.
initialInfectionRate = 0.01;
d = 0.8; % Probability of moving.

gamma = 0.01; % Probability of recovery.
beta = 0.2; % Probability of infection.
alpha = 0.005; % Probability of losing immunity when infected.
t=0;
SIR = [];



% Initialization of the grid.
lattice = cell(L);
for n = 1:(N - N*initialInfectionRate)
    x = randi(L);
    y = randi(L);
    lattice{x, y} = [lattice{x, y}, 1];
    if (n > (N - 2*N*initialInfectionRate))
        lattice{x, y} = [lattice{x, y}, 2];
    end
end

% Main loop.
while (~CheckForInfected(lattice) && (t < 5000))
    lattice = Diffusion(lattice, d);
    lattice = Infection(lattice, beta);
    lattice = Recovery(lattice, gamma);
    lattice = ImmunityLoss(lattice, alpha);
    SIR(t + 1, :) = GetData(lattice);
    if (rem(t, 10) == 0)
        Plots(lattice, SIR, beta, gamma, t);
        pause(0.001)
    end
    t = t + 1;
end



