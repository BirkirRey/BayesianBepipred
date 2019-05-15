data {
    int<lower=0> n_aa;
    int<lower=0,upper=1> epitopes[n_aa]; // binarize to 0 or 1
    vector[n_aa] scores; // output of bepipred
}
parameters {
    real alpha;
    real beta;
}
model {
    epitopes ~ bernoulli_logit(alpha + beta * scores);
}
