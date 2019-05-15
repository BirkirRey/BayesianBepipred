data {
    int<lower=0> n_classes;
    int<lower=0> n_aa;
    int aa[n_aa];
    int<lower=0,upper=1> epitopes[n_aa]; // binarize to 0 or 1
    vector[n_aa] scores; // output of bepipred
    vector[n_aa] inv_score_sum; // Inverse of sum of scores in protein
    
}
parameters {
    real beta_mu;
    real<lower=0> beta_sigma;
    vector[n_classes] beta;
    real alpha;
    real gamma;
    
}
model {
    beta ~ normal(beta_mu, beta_sigma);
    epitopes ~ bernoulli_logit(alpha + beta[aa] .* scores + gamma * inv_score_sum);
}