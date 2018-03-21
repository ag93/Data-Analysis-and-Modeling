Max_days = 100000;
No_of_Sims = 100000;

p = 0.10;
No_comps = 20;
Tech_Fix = 5;
TTC = zeros(No_of_Sims,1);
All_infected = zeros(No_of_Sims,1);
No_infected = zeros(No_of_Sims,1);

for k=1:No_of_Sims
    T = 0;
    Infected_computers = [1
        zeros(No_comps-1,1)];
    Infected_at_least_once_comp = Infected_computers;
    Ninfected = sum(Infected_computers);
    
    while Ninfected > 0 && T<Max_days
        T = T+1;
        P_infection = 1-(1-p)^Ninfected
        
        Infected_computers = max(Infected_computers, (rand(No_comps,1) < P_infection));
        Infected_at_least_once_comp = max(Infected_at_least_once_comp, Infected_computers);
        
        Compfix = 1;
        No_compsompfix = 0;
        
        while (Compfix <= No_comps) && (No_compsompfix < Tech_Fix)
            if Infected_computers(Compfix) == 1
                Infected_computers(Compfix)=0;
                No_compsompfix = No_compsompfix+1;
            end
            Compfix = Compfix+1;
        end
        Ninfected = sum(Infected_computers);
    end
    
    TTC(k) = T;
    All_infected(k) = (sum(Infected_at_least_once_comp) == No_comps);
    No_infected(k) = (sum(Infected_at_least_once_comp));
end

disp(['The expected time unitl all computers are fixed is approximately ', num2str(mean(TTC)), 'days']);
disp(['The probability that each computers gets infected atleast oNo_compse is ', num2str(mean(All_infected))]);
disp(['The expected number of computers that get infected is approximately ', num2str(mean(No_infected))]);

