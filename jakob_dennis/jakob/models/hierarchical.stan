data {
    int<lower=0> n_classes;
    int<lower=0> n_aa;
    int aa[n_aa];
    int<lower=0,upper=1> epitopes[n_aa]; // binarize to 0 or 1
    vector[n_aa] scores; // output of bepipred
    
}
parameters {
    real alpha_mu;
    real<lower=0> alpha_sigma;
    real beta;
    vector[n_classes] alpha;
    
}
model {
    alpha ~ normal(alpha_mu, alpha_sigma);
    epitopes ~ bernoulli_logit(alpha[aa] + beta * scores);
}
