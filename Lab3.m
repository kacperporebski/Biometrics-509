sigA = load('sigAllGenuine.mat'); 
auth = struct2array(sigA);
sigF = load('sigAllImposter.mat');
forg = struct2array(sigF);
N_a = 20;

a = zeros(N_a ,2); 
f = zeros(N_a , 2);


for i = 1: N_a
    auth_i = (auth{i}).';
    forg_i = (forg{i}).';
    %load signature and transpose
    
    x = auth_i (1 ,:);
    y = auth_i (2 ,:);
    prs = auth_i (3 ,:);
    time = auth_i (4 ,:);
    velx = zeros(1,max(length(x)));
    vely = zeros(1,max(length(y)));
    %calculate auth
    
    xf = forg_i (1 ,:);
    yf = forg_i (2 ,:);
    prsf = forg_i (3 ,:);
    timef = forg_i (4 ,:);
    velxf = zeros(1,max(length(xf)));
    velyf = zeros(1,max(length(yf)));
    %calculate forg
    
  for j = 2:max(length(velx ))
     velx(j) = abs((x(j)-x(j-1)) / (time(j)-time(j-1)));
     vely(j) = abs((y(j)-y(j-1)) / (time(j)-time(j-1)));
  end  
  %calculate auth
  
  for j = 2:max(length(velxf ))
     velxf(j) = abs((xf(j)-xf(j-1)) / (timef(j)-timef(j-1)));
     velyf(j) = abs((yf(j)-yf(j-1)) / (timef(j)-timef(j-1)));
  end  
  %calculate forg
  
  
auth_i (1 ,:) = x;
auth_i (2 ,:) = y;
auth_i (3 ,:) = prs;
auth_i (4 ,:) = sqrt(velx .^2 + vely .^2);
%calculate auth


forg_i (1 ,:) = xf;
forg_i (2 ,:) = yf;
forg_i (3 ,:) = prsf;
forg_i (4 ,:) = sqrt(velxf .^2 + velyf .^2);
%calculate forg


a(i ,1) = mean( auth_i (3 ,:)); % mean pressure as the first column of "a"
a(i ,2) = mean( auth_i (4 ,:)); % mean velocity as the second column of "a"
f(i,1) = mean( forg_i (3,:));
f(i,2) = mean (forg_i (4,:));

end 

mu_a = mean(a);
sigma_a = cov(a);
plotgaus( mu_a , sigma_a , [0 1 1]);
mu_f = mean(f);
sigma_f = cov(f);
plotgaus( mu_f , sigma_f , [0 1 0]);

%disp(mu_a);
%disp(sigma_a);
%disp(mu_f);
%disp(sigma_f);

%2.2
Na = size(a ,1);
Nf = size(f ,1);
N = Na + Nf;
Pa = Na/N;
Pf = Nf/N;

for i = 1:length(a(: ,1))
aglog(i) = gloglike(a(i), mu_a , sigma_a ) + log(Pa);
end
for i = 1:length(f(: ,1))
fglog(i) = gloglike(f(i), mu_f , sigma_f ) + log(Pf);
end

%disp(aglog)
%disp(fglog)

gausplot(a,mu_a,sigma_a,'Authentic');
gausplot(f,mu_f,sigma_f,'Imposter');


%3

Mydata= [a;f];
means = {mu_a, mu_f}; 
vars = {sigma_a , sigma_f};
emalgo(Mydata,means,vars);

