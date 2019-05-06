data {
    int<lower=0> total_aa;
    int<lower=0,upper=1> epitopes[total_aa]; // binarize to 0 or 1
    vector[total_aa] scores; // output of bepipred
}
parameters {
    vector[2] params;
}
model {
    epitopes ~ bernoulli_logit(params[1] + params[2]*scores);
}
