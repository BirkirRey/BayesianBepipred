data {
    int<lower=0> n_classes;
    int<lower=0> n_aa;
    int aa[n_aa];
    int<lower=0,upper=1> epitopes[n_aa]; // binarize to 0 or 1
    vector[n_aa] inv_length; // Inverse of protein length
    
}
parameters {
    vector[n_classes] alpha;
    real gamma;
    
}
model {
    epitopes ~ bernoulli_logit(alpha[aa] + gamma * inv_length);
}