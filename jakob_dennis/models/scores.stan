data {
    int<lower=0> classes;
    int<lower=0> total_aa;
    int aa[total_aa];
    int<lower=0,upper=1> epitopes[total_aa]; // binarize to 0 or 1
    vector[total_aa] scores; // output of bepipred
    vector[total_aa] inv_scores; // Inverse of sum of scores in protein
    
}
parameters {
    real beta_mu;
    real<lower=0> beta_sigma;
    real alpha;
    vector[classes] beta;
    real gamma;
    
}
model {
    beta ~ normal(beta_mu, beta_sigma);
    epitopes ~ bernoulli_logit(beta[aa] + alpha*scores + gamma * inv_scores);
}