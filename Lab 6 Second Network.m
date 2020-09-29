N = 5; %the total number of nodes or random variables
SEASON = 1; 
FLIGHT = 2;
SARS = 3;
FEVER = 4;
COUGH = 5;
 %each node is assigned a number
 
dag = zeros(N,N); %define a NxN matrix which specifies the graph structure
dag(SEASON,SARS) = 1; %SEASON is a parent of SARS
dag(FLIGHT,SARS) = 1; %FLIGHT is a parent of SARS
dag(SARS, [FEVER COUGH]) = 1; %SARS is a parent to FEVER and COUGH.
discrete_nodes = 1:N; %all node take discrete values.
node_sizes = [2 2 2 2 2]; % each node takes 2 values (e.g. True and False).

onodes = []; %Specifying which nodes are the observed ones (here none)
bnet = mk_bnet(dag,node_sizes ,'discrete',discrete_nodes ,'observed',onodes);

bnet.CPD{SEASON} = tabular_CPD(bnet , SEASON, [0.9 0.1]);  % Low, high
bnet.CPD{FLIGHT} = tabular_CPD(bnet , FLIGHT, [0.7 0.3]);  % false, true
%                                         F:F,L F,H  T,L  T,H  T:F,L F,H  T,L  T,H
bnet.CPD{SARS} = tabular_CPD(bnet , SARS, [0.98 0.98 0.97 0.95 0.02 0.02 0.03 0.05]);
%                                           F: F F:T  T:F T:T
bnet.CPD{FEVER} = tabular_CPD(bnet , FEVER, [0.8 0.1 0.2 0.9]);
%                                            F:F  F:T  T:F  T:T
bnet.CPD{COUGH} = tabular_CPD(bnet , COUGH, [0.70 0.35 0.30 0.65]);


engine = var_elim_inf_engine(bnet); % you can also use: engine = var elim inf engine (bnet)
evidence = cell(1,N); % the size of the evidence vector
[engine , loglik] = enter_evidence(engine , evidence);
marg = marginal_nodes(engine , [SEASON FLIGHT SARS FEVER COUGH]);

%Season = Low(1), Flight = False(1), SARS = True(2), Fever = True(2), and Cough = True(2),
marg.T(1,1,2,2,2) 
%compare to result on paper

% Season: Low=1, High =2 
% Flight: False=1, True=2
% SARS: False=1, True=2
% Fever: False=1, True=2
% Cough: False=1, True=2


%SEASON = 1; FLIGHT = 2; SARS = 3; FEVER = 4; COUGH = 5;
evidence{5} = 2;
[engine, loglik]= enter_evidence(engine, evidence);
marg = marginal_nodes(engine, 3);
format short e 
marg.T



