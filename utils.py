import numpy as np
from sklearn import metrics
import copy

def calc_auc(pred_, real_, ten=False, one=False):
    """Calculates the AUC of predictions"""
    #Sorted identically
    pred, real = zip(*sorted(zip(pred_, real_), reverse=True))

    fprs    = [0]
    tprs    = [0]
    fprs_10 = None
    tprs_10 = None
    fprs_01 = None
    tprs_01 = None
    old_p = 0.0
    TP,FP,TN,FN = 0,0,0,0

    for p in range(len(pred)):
        if old_p == pred[p]:
            continue
        if p == 0:
            for i in range(len(pred)):
                if real[i] == 1:
                    if pred[i] >= pred[p]:
                        TP += 1
                    else:
                        FN += 1
                else:
                    if pred[i] >= pred[p]:
                        FP += 1
                    else:
                        TN += 1
        else:
            counter = p
            try:
                while pred[p] == pred[counter]:
                    if real[counter] == 1:
                        TP += 1
                        FN -= 1
                    else:
                        FP += 1
                        TN -= 1
                    counter += 1
            except IndexError:
                pass 
        
        #Calculate true/false positive ratioes
        try:
            fpr = float(FP)/(FP+TN)
        except ZeroDivisionError:
            fpr = 0.0
        try:
            tpr = float(TP)/(TP+FN)
        except ZeroDivisionError:
            tpr = 0.0
        old_p = pred[p]

        #If AUC10 is wanted do:
        if ten and fpr > 0.1 and not fprs_10:
            ratio = (0.1-fprs[-1])/(fpr-fprs[-1])
            if ratio != 0:
                tpr = ((tpr-tprs[-1])*ratio)+tprs[-1]
                fpr = 0.1
            fprs_10 = copy.copy(fprs)
            tprs_10 = copy.copy(tprs)
            fprs_10.append(fpr)
            tprs_10.append(tpr)
        if one and fpr > 0.01 and not fprs_01:
            ratio = (0.01-fprs[-1])/(fpr-fprs[-1])
            if ratio != 0:
                tpr = ((tpr-tprs[-1])*ratio)+tprs[-1]
                fpr = 0.01
            fprs_01 = copy.copy(fprs)
            tprs_01 = copy.copy(tprs)
            fprs_01.append(fpr)
            tprs_01.append(tpr)
            continue
        fprs.append(fpr)
        tprs.append(tpr)

    if ten and one:
        return metrics.auc(fprs, tprs), metrics.auc(fprs_10, tprs_10)/0.1, metrics.auc(fprs_01, tprs_01)/0.01
    elif ten:
        return metrics.auc(fprs, tprs), metrics.auc(fprs_10, tprs_10)/0.1
    elif one:
        return metrics.auc(fprs, tprs), metrics.auc(fprs_01, tprs_01)/0.01
    else:
        return metrics.auc(fprs, tprs)