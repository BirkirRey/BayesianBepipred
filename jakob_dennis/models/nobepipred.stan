data {
    int<lower=0> n_classes;
    int<lower=0> n_aa;
    int<lower=0> n_q3;
    int aa[n_aa];
    int<lower=0,upper=1> epitopes[n_aa]; // binarize to 0 or 1
    vector[n_aa] inv_length; // Inverse of length of protein
    int secondary[n_aa];
    vector[n_aa] asa;

}
parameters {
    vector[n_classes] alpha;
    real beta;
    real gamma;
    vector[n_q3] delta;

}
model {
    epitopes ~ bernoulli_logit(alpha[aa] + beta * asa + gamma * inv_length + delta[secondary]);
}
