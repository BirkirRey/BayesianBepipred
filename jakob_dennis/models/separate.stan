data {
    int<lower=0> classes;                    // Number of unique amino acids in the sequence
    int<lower=0> total_aa;                   // Total number of amino acids
    int aa[total_aa];                        // ?
    int<lower=0,upper=1> epitopes[total_aa]; // Binarize to 0 or 1
    vector[total_aa] scores;                 // Output of bepipred
}

parameters {
    vector[classes] alpha;
    vector[classes] beta;
}

model {
    epitopes ~ bernoulli_logit(alpha[aa] + beta[aa] .* scores);
}