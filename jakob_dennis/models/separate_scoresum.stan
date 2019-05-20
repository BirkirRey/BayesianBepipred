data {
    int<lower=0> n_classes;
    int<lower=0> n_aa;
    int aa[n_aa];
    int<lower=0,upper=1> epitopes[n_aa]; // binarize to 0 or 1
    vector[n_aa] scores; // output of bepipred
    vector[n_aa] inv_score_sum; // Inverse of sum of scores in protein
    
}
parameters {
    vector[n_classes] alpha;
    vector[n_classes] beta;
    real gamma;
    
}
model {
    epitopes ~ bernoulli_logit(alpha[aa] + beta[aa] .* scores + gamma * inv_score_sum);
}