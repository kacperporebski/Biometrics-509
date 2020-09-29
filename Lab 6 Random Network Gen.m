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

nsamples=5000;
samples = cell(N, nsamples);
for i=1:nsamples
samples(:,i) = sample_bnet(bnet);
end

N2 = 4;
W2 = 1;
I2 = 2;
C2 = 3;
F2 = 4;

node_sizes = ones(1,N);
node_sizes (1,1) = 2;
node_sizes (1,2)=  3;
node_sizes (1,3) = 2;
node_sizes (1,4) = 3;

data = cell2num(samples);
order = [W2 I2 C2 F2];
max_fan_in = 2;
dag2 = learn_struct_K2(data , node_sizes , order , 'max_fan_in', max_fan_in);

bnet2 = mk_bnet(dag2 , node_sizes );
seed = 4;
rand('state', seed);
bnet2.CPD{W2} = tabular_CPD(bnet2 , W2);
bnet2.CPD{C2} = tabular_CPD(bnet2 , C2);
bnet2.CPD{I2} = tabular_CPD(bnet2 , I2);
bnet2.CPD{F2} = tabular_CPD(bnet2 , F2);

bnet2 = learn_params(bnet2 , data);
CPT3 = cell(1,N2);
for i = 1:N2
S = struct(bnet2.CPD{i});
CPT3fig = S.CPT;
end

%Compare
bnet.dag
bnet2.dag

bnet.CPD
bnet2.CPD
