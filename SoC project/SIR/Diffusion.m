function lattice = Diffusion(lattice, d)
    L = length(lattice);
    for i = 1:L
        for j = 1:L
            numberOfAgents = size(lattice{i,j}, 2);
            for n = 1:numberOfAgents
                r = rand();
                if (d > r)
                    savedAgent = lattice{i,j}(1);
                    lattice{i,j}(1) = [];
                    direction = randi(4);
                    if (direction == 1)
                        x = i;
                        if (j == 1)
                            y = L;
                        else
                            y = j - 1;
                        end
                    elseif (direction == 2)
                        x = i;
                        if (j == L)
                            y = 1;
                        else
                            y = j + 1;
                        end
                    elseif (direction == 3)
                        y = j;
                        if (i == 1)
                            x = L;
                        else
                            x = i - 1;
                        end
                    elseif (direction == 4)
                        y = j;
                        if (i == L)
                            x = 1;
                        else
                            x = i + 1;
                        end
                    end
                    lattice{x, y} = [lattice{x, y}, savedAgent];
                end
            end
        end
    end
end

