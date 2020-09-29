N = 4; %the total number of nodes or random variables
W = 1; %the first node called W (Winter)
I = 2;
C = 3;
F = 4; %each node is assigned a number
dag = zeros(N,N); %define a NxN matrix which specifies the graph structure
dag(W,[I C]) = 1; %W is a parent of both I and C
dag(I, F) = 1; %I is a parent to F
dag(C, F) = 1; %C is a parent to F
discrete_nodes = 1:N; %all node take discrete values.
node_sizes = [2 2 2 2]; % each node takes 2 values (e.g. True and False).

onodes = []; %Specifying which nodes are the observed ones (here none)
bnet = mk_bnet(dag,node_sizes ,'discrete',discrete_nodes ,'observed',onodes);

bnet.CPD{W} = tabular_CPD(bnet , W, [0.5 0.5]);
bnet.CPD{C} = tabular_CPD(bnet , C, [0.8 0.2 0.2 0.8]);
bnet.CPD{I} = tabular_CPD(bnet , I, [0.5 0.9 0.5 0.1]);
bnet.CPD{F} = tabular_CPD(bnet , F, [1 0.1 0.1 0.01 0 0.9 0.9 0.99]);

engine = jtree_inf_engine(bnet); % you can also use: engine = var elim inf engine (bnet);
evidence = cell(1,N); % the size of the evidence vector
evidence{F} = 2; % the evidence of Fever is True
[engine , loglik] = enter_evidence(engine , evidence);
marg = marginal_nodes(engine , I); % calculate the updated value of prob. for Influenza

%marg.T    %P(Influenza|Fever = True)
marg.T(2) %P(Influenza = True | Fever = True)
marg.T(1)

evidence{C} = 2;
[engine, loglik] = enter_evidence(engine, evidence);
marg = marginal_nodes(engine, I);

%marg.T          %P(Influenza| Cold = true ,Fever = true)
marg.T(2)       %P(Influenza = True | Cold = true , Fever = true)
marg.T(1)

evidence = cell (1, N);
[engine , ll] = enter_evidence(engine ,evidence); %no ev
m = marginal_nodes (engine , [I C F]); 
%returns m structure , its T field 3D array that contains joint probablity 

m.T(2,2,2)
m.T(1,2,2)


    %returns T(i,j,k) where i is value of I , j is value of C and k value of F
    %So T(1,1,2) will give P ( I = 1, C = 1 , F = 2 ) 
    
    %calculate joint probablitity of influenza = true when fever and cold
    %both true , then do same for false.
    
    


