data {
    int<lower=0> classes;
    int<lower=0> total_aa;
    int aa[total_aa];
    int<lower=0,upper=1> epitopes[total_aa]; // binarize to 0 or 1
    vector[total_aa] scores; // output of bepipred
    vector[total_aa] inv_scores; // Inverse of sum of scores in protein
    
}
parameters {
    vector[classes] alpha;
    vector[classes] beta;
    real<lower=0,upper=1> gamma;
    real delta;
    
}
model {
    epitopes ~ uniform(gamma + (1 - gamma) * delta * inv_scores .* expit(beta[aa] + alpha[aa] .* scores));
}