data {
    int<lower=0> n_classes;                    // No. of unique amino acids in the sequence
    int<lower=0> n_aa;                         // Total number of amino acids
    int aa[n_aa];                              //
    int<lower=0,upper=1> epitopes[n_aa];       // Binarize to 0 or 1
    vector[n_aa] scores;                       // Output of bepipred
}

parameters {
    vector[n_classes] alpha;
    vector[n_classes] beta;
}

model {
    epitopes ~ bernoulli_logit(alpha[aa] + beta[aa] .* scores);
}
