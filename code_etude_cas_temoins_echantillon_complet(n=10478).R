##################################################################################
#Does dissatisfaction with physicians lead patients to alternative practitioners?#
##################################################################################

# Code used for data manipulations and analyses #
#################################################

## Chargement du répertoire de travail ----
setwd("repertoire_a_specifier")

## Lecture des fichiers de données et assignation aux objets « q1 » et « q2 » ----
q1 <- read.csv("q1_all.csv", dec = ",")
q2 <- read.csv("q2_all.csv", dec = ",")

## Préparation des deux tableaux pour leur fusion ----
# Ajout de la variable « Département de résidence » au tableau q1 (juste après la variable « sexe »)
q1$newcolumn <- NA # Création de la nouvelle variable
q1 <- q1[, c(1:191, 308, 192:307)] # Déplacement de la variable
names(q1)[192] <- c("Département.de.résidence.principale..") # Renommage de la variable

## Suppression des variables 194, 195 et 196 dans q1 (variables de code pour test-retest)
q1[194:196] <- NULL
q1[301:305] <- NULL

# Ajout à q1 de la variable de durée de remplissage relative à la variable « Département de résidence »
# Cette variable ne nous est pas utile mais comme elle est présente dans q2, nous préférons l'intégrer à q1
# avant la fusion, pour éviter tout problème.
q1$newcolumn2 <- NA # Création de la nouvelle variable
names(q1)[301] <- "Durée.pour.la.question..gene5bis" # Renommage de la variable
q1 <- q1[, c(1:299, 301, 300)] # Déplacement de la variable

# Suppression dans q2 des variables relatives aux durées de remplissage pour les variables de code pour
# test-retest
q2[302:303] <- NULL

# Identification des noms de variables distincts entre q1 et q2
setdiff(names(q1), names(q2))

# Harmonisation des noms de variables entre q1 et q2
which(colnames(q1) == "X.En.général..blablabla...") # Identification du numéro de la variable dans q1 en copiant son nom à partir du résultat de la commande « setdiff » (Ce sont en effet les noms de variables de q2 qui sont les bons, il faut donc modifier les noms de variables dans q1. Au passage, rappelons nous que cet étrange nom de variable dans q1 (blablabla…) est lié aux différents tests que j'ai dû faire avec Fanny lors du bug logiciel de noël )
names(q2)[13] # Identification du nom de la variable dans q2
names(q1)[13] <- c("En.général..je.suis.satisfait.e.de.mon.médecin.généraliste.actuel....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.d.accord.") # Renommage de la variable dans q1

which(colnames(q1) == "En.général..j.ai.été.satisfait.e.de.ces.visites.ou.consultations......Pas.du.tout.d.accord...Tout.à.fait.d.accord.") # 15
names(q2)[15]
names(q1)[15] <- c("En.général..j.ai.été.satisfait.e.de.ces.visites.ou.consultations....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.d.accord.")

which(colnames(q1) == "Avoir.une.vie.saine.est.important.pour.moi......Pas.du.tout.d.accord...Tout.à.fait.d.accord.") # 17
names(q2)[17]
names(q1)[17] <- c("Avoir.une.vie.saine.est.important.pour.moi....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.d.accord.")

which(colnames(q1) == "En.général..j.ai.été.satisfait.e.de.ce.kinésithérapeute.chiropracteur......Pas.du.tout.d.accord...Tout.à.fait.d.accord.")
names(q2)[69]
names(q1)[69] <- c("En.général..j.ai.été.satisfait.e.de.ce.kinésithérapeute.chiropracteur....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.d.accord.")

which(colnames(q1) == "En.général..j.ai.été.satisfait.e.de.cette.prise.en.charge.en.kinésithérapie.....Pas.du.tout.d.accord..Tout.à.fait.d.accord.")
names(q2)[71]
names(q1)[71] <- c("En.général..j.ai.été.satisfait.e.de.cette.prise.en.charge.en.kinésithérapie....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.d.accord.")

which(colnames(q1) == "En.ce.qui.concerne.ce.motif.principal..aviez.vous.également.consulté.un.médecin..")
names(q2)[86]
names(q2)[86] <- c("homeo.rec.comp.med1") # Cette correction est survenue durant le processus de correction de la première erreur constatée lors de la création des variables pour la publication numéro 3 (le 4 juin 2019). Elle est inutile mais je la laisse quand même.
names(q1)[86] <- c("homeo.rec.comp.med1") # Idem

which(colnames(q1) == "Le.rebouteux.que.j.ai.consulté.est.également....Aucune.autre.profession.particulière.")
names(q2)[114]
names(q1)[114] <- c("Le.rebouteux.que.j.ai.consulté.est.également.....Aucune.autre.profession.particulière.")

which(colnames(q1) == "Le.rebouteux.que.j.ai.consulté.est.également....Chirurgien.dentiste.")
names(q2)[115:123]
names(q1)[115:123] <- c("Le.rebouteux.que.j.ai.consulté.est.également.....Chirurgien.dentiste.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Infirmier.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Kinésithérapeute.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Médecin.généraliste.ou.spécialiste.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Pédicure.podologue.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Pharmacien.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Sage.femme.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Je.ne.sais.pas.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Autre.")

which(colnames(q1) == "En.général..j.ai.été.satisfait.e.de.ce.kinésithérapeute.ostéopathe......Pas.du.tout.d.accord...Tout.à.fait.d.accord.")
which(colnames(q1) == "En.général..j.ai.été.satisfait.e.de.cette.prise.en.charge.en.kinésithérapie......Pas.du.tout.d.accord...Tout.à.fait.d.accord.")
which(colnames(q1) == "Pour.ma.douleur.au.dos..j.ai.été.satisfait.e.de.ma.prise.en.charge.médicale......Pas.du.tout.d.accord...Tout.à.fait.d.accord.")
which(colnames(q1) == "Durant.les.12.derniers.mois..j.ai.été.pris.e.en.charge.en.kinésithérapie.pour.un.ou.plusieurs.des.motifs.suivants....Je.n.ai.pas.été.pris.e.en.charge.par.en.kinésithérapie.")
which(colnames(q1) == "Pour.ma.douleur.au.dos..j.ai.été.satisfait.e.de.ma.prise.en.charge.en.kinésithérapie......Pas.du.tout.d.accord...Tout.à.fait.d.accord.")
which(colnames(q1) == "Remarques.générales.sur.l.enquête..")
names(q2)[c(155, 157, 171, 173, 180, 194)]
names(q1)[c(155, 157, 171, 173, 180, 194)] <- 
  c("En.général..j.ai.été.satisfait.e.de.ce.kinésithérapeute.ostéopathe....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.d.accord.",
    "En.général..j.ai.été.satisfait.e.de.ma.prise.en.charge.en.kinésithérapie....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.d.accord.",
    "Pour.ma.douleur.au.dos..j.ai.été.satisfait.e.de.ma.prise.en.charge.médicale....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.d.accord.",
    "Durant.les.12.derniers.mois..j.ai.été.pris.e.en.charge.en.kinésithérapie.pour.un.ou.plusieurs.des.motifs.suivants....Je.n.ai.pas.été.pris.e.en.charge.en.kinésithérapie.",
    "Pour.ma.douleur.au.dos..j.ai.été.satisfait.e.de.ma.prise.en.charge.en.kinésithérapie....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.d.accord.",
    "Remarques.générales.sur.l.enquête..facultatif...")

# Identification des noms de variables distincts entre q1 et q2
setdiff(names(q2), names(q1))

# Correction du décalage
which(colnames(q1) == "En.ce.qui.concerne.ce.motif.principal..j.ai.également.consulté.un.médecin...2")
which(colnames(q1) == "En.ce.qui.concerne.ce.motif.principal..j.ai.également.consulté.un.médecin...3")
which(colnames(q1) == "En.ce.qui.concerne.ce.motif.principal..j.ai.également.consulté.un.médecin...4")
names(q1)[c(106, 126, 146)] <- c("En.ce.qui.concerne.ce.motif.principal..j.ai.également.consulté.un.médecin...3",
                                 "En.ce.qui.concerne.ce.motif.principal..j.ai.également.consulté.un.médecin...4",
                                 "En.ce.qui.concerne.ce.motif.principal..j.ai.également.consulté.un.médecin...5")

# Identification des noms de variables distincts entre q1 et q2
setdiff(names(q2), names(q1))

## Harmonisation des variables issues des échelles visuelles analogiques entre q1 et q2 ----
cut20 <- function(x) cut(x,20)
q2[,c(13,15,17,69,71,155,157,171,180)] <- lapply(
  q2[,c(13,15,17,69,71,155,157,171,180)]*10, cut20
  )
cut20 <- function(x) cut(x,20)
q1[,c(13,15,17,69,71,155,157,171,180)] <- lapply(
  q1[,c(13,15,17,69,71,155,157,171,180)]*10, cut20
  )
lev20 <- function(x) 


levels(q2[,13]) <- c(seq(1:20))
levels(q2[,15]) <- c(seq(1:20))
levels(q2[,171]) <- c(seq(1:20))
levels(q1[,13]) <- c(seq(1:20))
levels(q1[,15]) <- c(seq(1:20))
levels(q1[,171]) <- c(seq(1:20))

q2[,13] <- as.numeric(q2[,13])
q2[,15] <- as.numeric(q2[,15])
q2[,171] <- as.numeric(q2[,171])
q1[,13] <- as.numeric(q1[,13])
q1[,15] <- as.numeric(q1[,15])
q1[,171] <- as.numeric(q1[,171])

## Fusion de q1 et q2 + assignation au nouvel objet « qtnps » ----
library(plyr)
qtnps <- rbind.fill(q1, q2)

# # Harmonisation des noms de variables entre q2 et q1
# which(colnames(q2) == "En.ce.qui.concerne.ce.motif.principal..j.ai.également.consulté.un.médecin...5")
# names(q1)[146]
# names(q1)[146] <- c("osteo.rec.comp.med1") # Correction réalisée le 5 juin 2019 pour traiter l'erreur n°1 constater lors de la préparation des variables pour la publication n°3.
# names(q2)[146] <- c("osteo.rec.comp.med1") # Idem
# 
# ## Fusion de q1 et q2 + assignation au nouvel objet « qtnps » ----
# library(plyr)
# qtnps <- rbind.fill(q1, q2) # Le résultat de la fusion indique un qtnps à 300 variables au lieu des 301 de q1 et q2. L'origine du décalage s'avère résulter d'un décalage pour certaines variables (voir ci-dessous), décalage résultant lui-même d'un problème avec le nommage différentiel initial de ces variables entre q1 et q2 ainsi que dans les opérations de renommage précédentes.
# # Le résultat mentionné dans le précédent commentaire n'est plus d'actualité depuis le 5 juin 2019 suite à la correction effectuée le même jour.
# # Pour cette raison, certaines des lignes de code qui suivent ont été rendues inopérantes.
# 
# ## Correction du décalage du nombre de variable entre qtnps et q1/q2 ----
# 
# # ## Deuxième fusion de q1 et q2 + assignation au nouvel objet « qtnps » ----
# # library(plyr)
# # qtnps <- rbind.fill(q1, q2)

## Renommage des variables ----
names(qtnps)[c(3, 9:11)] <- c("dern.page", "form.non.opp", "resid.fr", 
                       "sup.18ans")
names(qtnps)[12:20] <- c("duree.mg", "sat.mg1", "fr.mg", "sat.mg2",
                        "auto.sante", "vie.saine", "san.chr", "doul.chr", "compl.san1")
names(qtnps)[21:27] <- c("acup", "chiro", "homeo", "magne", "osteo",
                         "rebout", "autre.rec")
names(qtnps)[28:47] <- c("acup.tnps", "acup.chir.d", "acup.inf",
                         "acup.kin", "acup.med", "acup.pod", "acup.pharm", "acup.sfemme", 
                         "acup.na", "acup.autre", "acup.motif", "acup.motif.autre", 
                         "acup.rec.comp.med1", "acup.rec.comp.med2", "acup.recom.med1",
                         "acup.recom.med2", "med.recom.acup", "med.depuis.acup", 
                         "talk.acup.med", "acup.comp.san")
names(qtnps)[48:73] <- c("chiro.tnps", "chiro.chir.d", "chiro.inf",
                         "chiro.kin", "chiro.med", "chiro.pod", "chiro.pharm", "chiro.sfemme", 
                         "chiro.na", "chiro.autre", "chiro.motif", "chiro.motif.autre", 
                         "chiro.rec.comp.med1", "chiro.rec.comp.med2", "chiro.recom.med1",
                         "chiro.recom.med2", "med.recom.chiro", "med.depuis.chiro", 
                         "talk.chiro.med", "chiro.rec.comp.kin1", "kin.is.chiro", 
                         "sat.kin.chiro", "chiro.rec.comp.kin2", "chiro.sat.pec.kin", 
                         "kin.recom.chiro", "chiro.comp.san")
names(qtnps)[74:93] <- c("homeo.tnps", "homeo.chir.d", "homeo.inf",
                         "homeo.kin", "homeo.med", "homeo.pod", "homeo.pharm", "homeo.sfemme", 
                         "homeo.na", "homeo.autre", "homeo.motif", "homeo.motif.autre", 
                         "homeo.rec.comp.med1", "homeo.rec.comp.med2", "homeo.recom.med1",
                         "homeo.recom.med2", "med.recom.homeo", "med.depuis.homeo", 
                         "talk.homeo.med", "homeo.comp.san")
names(qtnps)[94:113] <- c("magne.tnps", "magne.chir.d", "magne.inf",
                          "magne.kin", "magne.med", "magne.pod", "magne.pharm", "magne.sfemme", 
                          "magne.na", "magne.autre", "magne.motif", "magne.motif.autre", 
                          "magne.rec.comp.med1", "magne.rec.comp.med2", "magne.recom.med1",
                          "magne.recom.med2", "med.recom.magne", "med.depuis.magne", 
                          "talk.magne.med", "magne.comp.san")
names(qtnps)[114:133] <- c("rebout.tnps", "rebout.chir.d", "rebout.inf",
                           "rebout.kin", "rebout.med", "rebout.pod", "rebout.pharm", "rebout.sfemme", 
                           "rebout.na", "rebout.autre", "rebout.motif", "rebout.motif.autre", 
                           "rebout.rec.comp.med1", "rebout.rec.comp.med2", "rebout.recom.med1",
                           "rebout.recom.med2", "med.recom.rebout", "med.depuis.rebout", 
                           "talk.rebout.med", "rebout.comp.san")
names(qtnps)[134:158] <- c("osteo.tnps", "osteo.chir.d", "osteo.inf",
                           "osteo.kin", "osteo.med", "osteo.pod", "osteo.pharm", "osteo.sfemme", 
                           "osteo.na", "osteo.autre", "osteo.motif", "osteo.motif.autre", 
                           "osteo.rec.comp.med1", "osteo.rec.comp.med2", "osteo.recom.med1",
                           "osteo.recom.med2", "med.recom.osteo1", "med.depuis.osteo", 
                           "talk.osteo.med", "osteo.rec.comp.kin1", "kin.is.osteo", 
                           "sat.kin.osteo", "osteo.rec.comp.kin2", "osteo.sat.pec.kin", 
                           "kin.recom.osteo1")
names(qtnps)[159:172] <- c("med.non", "med.bronchite", "med.grippe", 
                           "med.gorge", "med.migraine", "med.doul.msup", "med.doul.minf", 
                           "med.doul.cou", "med.doul.dos", "med.depression", "med.stress", 
                           "med.autre", "sat.pec.med", "med.recom.osteo2")
names(qtnps)[173:182] <- c("kin.non", "kin.migraine",
                           "kin.doul.msup", "kin.doul.minf", "kin.doul.cou", "kin.doul.dos", 
                           "kin.autre", "sat.pec.kin", "kin.recom.osteo2", "osteo.comp.san")
names(qtnps)[183:195] <- c("age", "sit.matri", "emploi", "prof", 
                           "lieu.de.vie", "diplome", "diplome.autre", "revenu", "sexe",
                           "dep.resid", "support", "remarques", "temps.total")

## Remplacer toutes les valeurs "N/A" du tableau par la valeur consacrée aux données manquantes ----
qtnps[qtnps[ , ] == "N/A"] <- NA

## Remplacer toutes les valeurs vides "" du tableau par la valeur consacrée aux données manquantes ----
qtnps[qtnps[ , ] == ""] <- NA

## Nettoyage des données ----

# Suppression des données acquises le 14 décembre 2018 (jour du rétablissement par mise à jour) (n=7)
library(stringr)
which(str_detect(qtnps$Date.de.soumission, "2018-12-14") == TRUE)
# [1] 5581 5582 5583 5586 5587 5588 5589
qtnps <- qtnps[-c(5581, 5582, 5583, 5586, 5587, 5588, 5589), ]

# Suppression des remplissages d'essai (n=1)
which(str_detect(qtnps$remarques, "ALBIN GUILLAUD") == TRUE)
# [1] 5583
qtnps <- qtnps[-5583, ]

# Suppression des questionnaires incomplets (n=3833)
qtnps <- qtnps[-which((qtnps$dern.page < 5) | is.na(qtnps$dern.page)), ]

# Suppression des questionnaires au formulaire de non-opposition non approuvé (n=165)
qtnps <- qtnps[-which(qtnps$form.non.opp == "Non"), ]

# Suppression des personnes ne remplissant pas les critères d'inclusion (n=91)
qtnps <- qtnps[-which(qtnps$resid.fr == "Non"), ]
qtnps <- qtnps[-which(qtnps$sup.18ans == "Non"), ]
qtnps <- qtnps[-which(((2018-qtnps$age) < 18 ) | ((2019-qtnps$age) < 18)), ]

#### Duplicate identification and removal (n=6)
duplicated2 <- function(x){ 
  if (sum(dup <- duplicated(x))==0) 
    return(dup) 
  if (class(x) %in% c("data.frame","matrix")) 
    duplicated(rbind(x[dup,],x))[-(1:sum(dup))] 
  else duplicated(c(x[dup],x))[-(1:sum(dup))] 
} # Source: http://forums.cirad.fr/logiciel-R/viewtopic.php?p=2968
qtnps <- qtnps[-which(duplicated2(qtnps[c(11:192)])),]

## Co-variable preparation

### Creation of the variable "educational attainement"
qtnps$educ.att[qtnps$diplome %in% 
    c("2e ou 3e cycle universitaire (Master, Doctorat), Grande École")
  ] <- "Master's degree or doctorate"
qtnps$educ.att[qtnps$diplome %in% 
    c("Baccalauréat général ou DAEU", "Baccalauréat technologique ou professionnel"
      ,"BTS, DUT, DEST, DEUG, Licence")
  ] <- "Bachelor's degree or short cycle tertiary education"
qtnps$educ.att[qtnps$diplome %in%
    c("Brevet de technicien, Brevet professionnel, BEI, BEC, BEA"
  ,"CAP, BEP, BEPC, Brevet élémentaire, Brevet des collèges",
      "Certificat d'étude primaire (CEP), diplôme de fin d'études obligatoires")
  ] <- "Upper secondary education or less"

#### Level renaming of the variable "diplome.autre"
library(stringr)
infir <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "infir") == TRUE
  ))
    ]
)

Infir <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "Infir") == TRUE
  ))
    ]
)

INFIR <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "INFIR") == TRUE
  ))
    ]
)

kin <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "kin") == TRUE
  ))
    ]
)

Kin <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "Kin") == TRUE
  ))
    ]
)

KIN <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "KIN") == TRUE
  ))
    ]
)

ing <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "ing") == TRUE
  ))
    ]
)

Ing <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "Ing") == TRUE
  ))
    ]
)

agreg <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "gation") == TRUE
  ))
    ]
)

bac2 <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "\\+2") == TRUE
  ))
    ]
)

bac3 <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "\\+3") == TRUE
  ))
    ]
)

bac4 <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "\\+4") == TRUE
  ))
    ]
)

bac5 <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "\\+5") == TRUE
  ))
    ]
)

doctorat <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "doct") == TRUE
  ))
    ]
)

Doctorat <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "Doct") == TRUE
  ))
    ]
)

cadre <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "cadre") == TRUE
  ))
    ]
)

Cadre <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "Cadre") == TRUE
  ))
    ]
)

CADRE <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "CADRE") == TRUE
  ))
    ]
)

cape <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "cape") == TRUE
  ))
    ]
)

CAPE <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "CAPE") == TRUE
  ))
    ]
)

dea <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "dea") == TRUE
  ))
    ]
)

DEA <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "DEA") == TRUE
  ))
    ]
)

licence <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "licence") == TRUE
  ))
    ]
)

Licence <- as.character(
  qtnps$diplome.autre[
    (which
      (str_detect(qtnps$diplome.autre, "Licence") == TRUE
  ))
    ]
)
  
qtnps$diplome.autre.r[qtnps$diplome.autre %in%
    c("3eme de collège générale",
      "acpt transport / assistant réalisateur/diplôme de formation professionnelle port de rouen"
      ,"acupuncteur","Aide soignant + artisan savonnier","aide soignante",
      "Aide soignante","AS","Asd","aucun","Aucun diplome","aux USA",
      "auxiliaire de puericulture","Auxiliaire de puériculture",
      "Auxiliaire de Puériculture", "Brevet des collèges ","CAFAS",
      "Certificat européen d'anglais","De aide à la soignante","DE",
      "DE auxiliaire de puériculture","DEtats","dilpome d'etat d'aide soignant"
      ,"Diplôme  d état", "Diplômé  d'état ","Diplômé aide soignante",
      "Diplôme aide soignante ","diplome d état","Diplôme d État ","diplome d'etat",
      "Diplome d'etat","diplome d'état","Diplôme d'etat","diplôme d'état",
      "Diplôme d'état","Diplôme d'État","Diplôme d'état ","Diplômé d'état",
      "Diplôme d’état ","Diplôme d’état aide-soignante","Dp aide soignante /puer "
      ,"DPAP","fin d'études secondaires","obtenu, aucun","pas de diplome","sans",
      "Accident a 13 ans","Aide soignante ","aide soignate a l'etranger ","Aucun",
      "AUCUN","Aucun ","aucun diplôme","Aucun diplôme","autodidacte",
      "auxillaire de puériculture","Brevet de maîtrise. Maître artisan ","cafas"
      ,"Cap Coiffure, (pas de diplôme) formation continue","CAPAL et DEFA"
      ,"diplome aide soignante","Diplome d etat","Diplome d etat ",
      "Diplôme d’Etat d’auxiliaire de puériculture "
      ,"Diplômé de l'auxiliaire de puériculture "
      ,"diplôme enseignant Yoga","diplôme instituteur bac+1","Diplômé suisse coiffure ",
      "diplômes techniques militaires","formation intra entreprise jusqu'a 24 ans"
      ,"Le concours d'entrée à l'Ecole Nationale Supérieur des Arts Décoratifs, rue d'Ulm, Paris"
      ,"ne sais plus","niveau bac D","Niveau CAP","NIVEAU LICENCE NON VALIDE",
      "Pas de diplôme","Pas de diplôme ","Pas de papiers","patient expert","personnel",
      "titre professionnel","suivi stages et passé  examens réussis. ","rien",
      "professeur de yoga diplome fédéral","prof de yoga","cfen","Concours ATSEM",
      "conservatoire","Conservatoire de Musique Artiste Lyrique","CQP", "DEAVS ","DECEP "
      ,"En équivalence","Educatrice","moiteur éducateur","musical",
      "Responsable de centre de formation","Diplômé d'état ","DPAS"
  )] <- "Upper secondary education or less"
      
qtnps$diplome.autre.r[qtnps$diplome.autre %in%
    c("BAC + CFEN","bac tech tailleur haute couture","Baccalauréat Professionnel",
      "BEES metier de la Forme","BEESAPT et  Brevet Technicen transport international",
  "Bpjeps","Bpjeps ","Brevet d'État ","BSC",
      "Cambridge International Examinations(O Level & A Level)"
  ,"fin d'études secondaires","niveau bac g","niveau baccalaureat g3",
      "1ère année IUT","BAC","baccalauréat Mathématioques et technique"
  ,"Beesan/betriathlon/bpjepsapt","BESAPT","BM","BPJEPS","BREVET D'ETAT",
      "BREVET d'ETAT SPORTIF","Brevet Banque","Capacité en droit ","cfc","CFC",
      "diplôme architecte technicien Genève"
  )]<- "Bachelor's degree or short cycle tertiary education"
      
qtnps$diplome.autre.r[qtnps$diplome.autre %in% 
    c("Capacité en droit ", infir, kin, "1ere année iut","3ans et demi ifsi",bac2, bac3,
      "bac agricole + 2 : ENITA bordeaux","Bts",licence,"Certificat niveau II RNCP ",
      "DDiplome d'Etat travail social","DE DU","DE EJE","DE para médical ",
      "Deug et bachelor of art ","DFGSM2",
      "Diplôme CPGE","Diplôme d'état d'éducateur spécialisé","Diplome d'état d'IBODE"
      ,"Diplôme d'état puericultrice",
      "Diplome de fin de deuxieme cycle des etudes medicales",
      "Diplôme éducateur jeunes enfants ","diplome état MK","diplome IDE","Diplome ide",
      "diplome travailleur social bac Plus trois ", "diplome universitaire"
      ,"Diplôme universitaire ETP","DU","DU ","ecole paramedicale",
      "Ecole supérieure d'approvisionnement","Éducatrice spécialisée ",
      "Enseignante artistique","equivalence BAC +2","fac de pharmacie","IDE","Ifsi",
      "IFSI","MKDE","Niveau 2","pharmacie ",
      "Plusieurs années d'étude à l'étranger après le bac","Post bac","VAE",
      "2 brevets d'état, Dagess, (3 diplômes classés bac+2)s",
      "2ieme année études assistante sociale","Architecture d’intérieur ","ASS",
      "assistant de service social","assistante sociale","BEES2","bts +1 année ",
      "DE Assistant Social","DE ergothérapeute","DE psychomotricienne","DE IDE",
      "De puericulture","DE travail social","DECF (ancien = bac +4)","DEMK",
      "Diplôme d état de monitrices éducatrice ","DIPLOME D'ETAT",
      "Diplome d'Etat (Niveau Bac +3)", "diplôme d'état d'EJE ",
      "diplome d'etat de puéricultrice","diplome d'état éducateur spécialisé",
      "Diplome d'état éducateur spécialisé","Diplôme d’etat",
      "Diplôme d’etat","Diplôme d’etat ",
      "Diplôme d’état d’assistante de service social ",
      "Diplôme de manipulatrice en radiologie ","Diplôme en Droit","diplome etat EJE",
      "Diplôme état paramedical","Diploôme d'Etat ","DNAP et BTS",
      "DU DES SOINS PSYCHIATRIQUES","éducatrice spécialisée",
      "éducatrice spécialisée, psychomotricienne, musicienne intervenante"
      ,"En reconversion professionnelle \"Psychologue du travail\" au CNAM"
      ,"faculté médecine","Formation Educatrice Spécialisée en Allemagne","M.K.",
      "MK ostéo","VAE NIVEAU BAC +2","CAPAL et DEFA","DEEJE et DEES","DEES",
      "diplome d'administration publique","diplome d'état de professeur de danse",
      "diplôme de l'école d'administration de strasbourg","qtnps",
      "Ecole sup de filature et tissage",
      "ENADEP (réservée aux salariés des cabinets d'avocats)",
      "ENSAD Paris","pupitreur", "Ki ","D.E  KINÉSITHÉRAPIE"
      ,Infir,INFIR,Kin,KIN,"DE puericultrice","BAC + 2 ans École Normale",
      "JE VEUT FAIRE UN MASTER EN VAE ET J AI UNE LICENCE EN VAE JE N AI PAS LE BAC MON NIVEAU SCOLAIRE EST CAP"
      ,"DE infimière","ITB","DEISP"
      )] <- "Bachelor's degree or short cycle tertiary education"
      
qtnps$diplome.autre.r[qtnps$diplome.autre %in% 
    c("CAPA certificat d'aptitude a la profession d'avocat ",ing,
      "3 eme cycle maths appli à Grenoble",
      agreg,doctorat,bac5,bac4,cadre,cape,"CAP Professeur des écoles",dea,"CAPLP",
      "Certificat aptitude pédagogique ",
      "Certificat d’Aptitude à la Profession d’Avocat","DECS  comptabilité ","DESS",
      "Diplôme d'ostéopathe.","Diplôme d'ostéopathie",
      "diplomé école sup sécurité sociale","diplome iep bc +4",
      "diplômes professionnels obtenus après le bac (CAP d'institutrice, concours de professeurs des écoles,CAFIPEMF)"
      ,"DNAP","DNSEP beaux arts","DO","Ecole normale d'instituteurs",
      "Formation i.geniur entreprise ","HDR","maitrise","Maitrise","maîtrise",
      "maitrise ","Master 1","Master M1","Medecin Generaliste","sage femme",
      "Sage femme DE","thèse d'Etat","bac plus 5",
      "BTS puis école normale de formation des professeurs de lycées professionnels",
      "CAEI","CAFERUIS","CAP instituteur","Cap instituteur ",
      "CAPA certificat d'aptitude a la profession d'avocat ","CAPET",
      "CAPET professorat","Cer'tificat d'aptitude pédagogique","CAPSAIS",
      "certificat capacité orthophoniste",
      "certificat d'aptitude à l'enseignement élémentaire",
      "certificat d'aptitude pédagogique","certificat de capacité en orthophonie",
      "Certificat de capacité en orthophonie",
      "Certificat de fin d'études à l'écolenormale d'instituteur(trice)s de Paris Batignolles",
      "certificat fin d'études ecole normale","CFEN, CAPSAAIS",
      "concours chef d etablissement","CONCOURS DE CADRE EQUIVALENT MASTER",
      "concours professeur technique","DE de sage-femme",
      "Diplômable architecte DESA","diplome d'état de sage-femme",
      "diplome de professeur des écoles ( bac+5 )","Diplômé IUFM"
      ,"diplôme sage-femme","ecole d'officier","école de commerce",
      "Ecole EDF et formation ingénieur interne","Ecole Hôtelière de Lausanne Bac + 5"
      ,"Ecole Speciale d'Architecture","expertise comptable",
      "habilitation à diriger des recherches",
      "IAE et Certificats supétieurs 'expertise comptable)"
      ,"INSTIT","institutrice","Maîtrise","Maitrise ",
      "Maitrise + Sciences Po","Maitrise de Droit","Maîtrise de lettres modernes"
      ,"maitrise en droit","maitrise management du sport ",
      "maitrise universitaire ancien regime","maitrise, capes","Master informatique"
      ,"mastère","medecin","medecine","médecine",
      "médecine générale, capacité de gérontologie",
      "officier sapeur pompier professionnel","pharmacien"
      ,"pharmacien et naturopathe","prof d'école","Professeur des écoles ",
      "Rhumatologue.......","Sage-femme ","Sup de Co Rouen, DEA","université 4 ans USA"
      ,"Maitrise ","Certificai d'enseignante spécialisée","CRPE (ex IUFM)",
      "D.E.S.I.","DECS", "dess","PLP2","DOCTORAT"
      ,Ing,Doctorat,Cadre,CADRE,CAPE,Licence,DEA
      )] <- "Master's degree or doctorate"

#### "diplome.autre" integration in the variable "educational attainement"
qtnps$educ.att[which(
  qtnps$diplome.autre.r == "Upper secondary education or less"
  )] <- "Upper secondary education or less"
qtnps$educ.att[which(
  qtnps$diplome.autre.r == "Bachelor's degree or short cycle tertiary education"
  )] <- "Bachelor's degree or short cycle tertiary education"
qtnps$educ.att[which(
  qtnps$diplome.autre.r == "Master's degree or doctorate"
  )] <- "Master's degree or doctorate"

#### Rearrangement and factorization of the "educational attainement" variable levels
qtnps$educ.att <- factor(qtnps$educ.att, levels=c("Upper secondary education or less",
  "Bachelor's degree or short cycle tertiary education","Master's degree or doctorate"))

### English translation of the variable "presence of a chronic disease"
qtnps$chr.disease[qtnps$san.chr %in% c("Non")] <- "No"
qtnps$chr.disease[qtnps$san.chr %in% c("Oui")] <- "Yes"

### English translation of the variable "presence of a chronic pain"
qtnps$chr.pain[qtnps$doul.chr %in% c("Non")] <- "No"
qtnps$chr.pain[qtnps$doul.chr %in% c("Oui")] <- "Yes"

### English translation of the variable "self-rated health" variable
qtnps$sr.health[qtnps$auto.sante %in% c("Mauvaise")] <- "Poor"
qtnps$sr.health[qtnps$auto.sante %in% c("Passable")] <- "Fair"
qtnps$sr.health[qtnps$auto.sante %in% c("Bonne")] <- "Good"
qtnps$sr.health[qtnps$auto.sante %in% c("Très bonne")] <- "Very good"
qtnps$sr.health[qtnps$auto.sante %in% c("Excellente")] <- "Excellent"

### Rearrangement of the variable "self-rated health" variable
qtnps$sr.health <- factor(qtnps$sr.health, levels = c("Poor","Fair","Good",
  "Very good","Excellent"))

### Creation of the variable "income"
qtnps$income[qtnps$revenu %in%
    c("Moins de 1 135 euros/mois OU moins de 13600/an")] <- "<1135€"
qtnps$income[qtnps$revenu %in%
    c("De 1135 à moins de 1500 euros/mois OU de 13600 à moins de 18000/an"
      )] <- "1135-1800€"
qtnps$income[qtnps$revenu %in%
    c("De 1500 à moins de 1800 euros/mois OU de 18000 à moins de 21600/an"
      )] <- "1135-1800€"
qtnps$income[qtnps$revenu %in%
    c("De 1800 à moins de 2000 euros/mois OU de 21600 à moins de 24000/an"
      )] <- "1800-3000€"
qtnps$income[qtnps$revenu %in%
    c("De 2000 à moins de 3000 euros/mois OU de 24000 à moins de 42000/an"
      )] <- "1800-3000€"
qtnps$income[qtnps$revenu %in%
    c("De 3000 à moins de 4000 euros/mois OU de 42000 à moins de 48000/an"
      )] <- ">3000€"
qtnps$income[qtnps$revenu %in%
    c("Plus de 4000 euros/mois OU plus de 48000/an"
      )] <- ">3000€"
qtnps$income[qtnps$revenu %in%
    c("Je ne sais pas","Je ne souhaite pas répondre")] <- NA

#### Rearrangement and factorization of the variable "income"
qtnps$income <- factor(qtnps$income, levels = c("<1135€","1135-1800€","1800-3000€",
  ">3000€"))

### English translation of the variable "sex"
qtnps$ssex[qtnps$sexe %in% c("Homme")] <- "Male"
qtnps$ssex[qtnps$sexe %in% c("Femme")] <- "Female"

### Factorization of all variables
qtnps$ssex <- factor(qtnps$ssex)
qtnps$educ.att <- factor(qtnps$educ.att)
qtnps$income <- factor(qtnps$income)
qtnps$chr.disease <- factor(qtnps$chr.disease)
qtnps$chr.pain <- factor(qtnps$chr.disease)
qtnps$sr.health <- factor(qtnps$sr.health)

### Creation of the variable "age"
qtnps$age <- (2018 - qtnps$age)

# Data manipulations ----

## Co-variable preparation

### Creation of the variable "sat.gp" (satisfaction with the general practitioner)
qtnps$newcolumn <- NA
names(qtnps)[309] <- c("sat.gp")
qtnps$sat.gp <- as.numeric(qtnps$sat.gp)
qtnps$sat.gp[1:10478] <- qtnps$sat.mg1[1:10478]
qtnps$sat.gp[which((is.na(qtnps$sat.gp) == TRUE) &
    (is.na(qtnps$sat.mg2)==FALSE))] <- qtnps$sat.mg2[which(is.na(qtnps$sat.mg2) == FALSE)]

### Variable renaming for presentation of the analyses

#### Chronic disease
qtnps$chr.disease.r[qtnps$chr.disease %in% c("No")] <- "0"
qtnps$chr.disease.r[qtnps$chr.disease %in% c("Yes")] <- "1"
qtnps$chr.disease.r <- factor(qtnps$chr.disease.r)

#### Chronic pain
qtnps$chr.pain.r[qtnps$chr.pain %in% c("No")] <- "0"
qtnps$chr.pain.r[qtnps$chr.pain %in% c("Yes")] <- "1"
qtnps$chr.pain.r <- factor(qtnps$chr.pain.r)

#### Educational attainement
qtnps$educ.att.r[qtnps$educ.att %in% c("Upper secondary education or less")] <- "0"
qtnps$educ.att.r[qtnps$educ.att %in% 
    c("Bachelor's degree or short cycle tertiary education")] <- "1"
qtnps$educ.att.r[qtnps$educ.att %in% c("Master's degree or doctorate")] <- "2"
qtnps$educ.att.r <- factor(qtnps$educ.att.r)

#### Income
qtnps$income.r[qtnps$income %in% c("<1135€")] <- "0"
qtnps$income.r[qtnps$income %in% c("1135-1800€")] <- "1"
qtnps$income.r[qtnps$income %in% c("1800-3000€")] <- "2"
qtnps$income.r[qtnps$income %in% c(">3000€")] <- "3"
qtnps$income.r <- factor(qtnps$income.r)

#### Self-rated health
qtnps$sr.health.r[qtnps$sr.health %in% c("Poor")] <- "0"
qtnps$sr.health.r[qtnps$sr.health %in% c("Fair")] <- "1"
qtnps$sr.health.r[qtnps$sr.health %in% c("Good")] <- "2"
qtnps$sr.health.r[qtnps$sr.health %in% c("Very good")] <- "3"
qtnps$sr.health.r[qtnps$sr.health %in% c("Excellent")] <- "4"
qtnps$sr.health.r <- factor(qtnps$sr.health.r)

#### Sex
qtnps$ssex.r[qtnps$ssex %in% c("Male")] <- "0"
qtnps$ssex.r[qtnps$ssex %in% c("Female")] <- "1"
qtnps$ssex.r <- factor(qtnps$ssex.r)

## Dependent variable preparation

### Construction of the "complementary use" group B (all CAM practitioners)

#### Preliminary construction of a group "use of a non-physician CAM practitioner for 
#### low back pain"
dos.camp.nmed <- (
    (qtnps$acup == "Oui" & qtnps$acup.med == "Non" & (is.na(qtnps$acup.motif) == FALSE 
      & qtnps$acup.motif == "Douleur au dos")) 
  | (qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & (is.na(qtnps$chiro.motif) == FALSE 
    & qtnps$chiro.motif == "Douleur au dos"))
  | (qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & (is.na(qtnps$homeo.motif) == FALSE 
    & qtnps$homeo.motif == "Douleur au dos"))
  | (qtnps$magne == "Oui" & qtnps$magne.med == "Non" & (is.na(qtnps$magne.motif) == FALSE 
    & qtnps$magne.motif == "Douleur au dos"))
  | (qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & (is.na(qtnps$osteo.motif) == FALSE 
    & qtnps$osteo.motif == "Douleur au dos"))
  | (qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & (is.na(qtnps$rebout.motif) == FALSE 
    & qtnps$rebout.motif == "Douleur au dos"))
  )
table(dos.camp.nmed, useNA = "always")

#### Effective construction of the "complementary use" group B (all CAM practitioners)
dos.camp.nmed.comp <-(
  (qtnps$acup == "Oui" & qtnps$acup.med == "Non" & (is.na(qtnps$acup.motif) == FALSE 
    & qtnps$acup.motif == "Douleur au dos") 
    & (qtnps$acup.rec.comp.med1 == "Avant d'avoir consulté l'acupuncteur" 
      | qtnps$acup.rec.comp.med2 == "Oui") 
    & qtnps$acup.rec.comp.med1 != "Après avoir consulté l'acupuncteur")
| (qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & (is.na(qtnps$chiro.motif) == FALSE 
  & qtnps$chiro.motif == "Douleur au dos") 
  & (qtnps$chiro.rec.comp.med1 == "Avant d'avoir consulté le chiropracteur" 
    | qtnps$chiro.rec.comp.med2 == "Oui") 
  & qtnps$chiro.rec.comp.med1 != "Après avoir consulté le chiropracteur")
| (qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & (is.na(qtnps$homeo.motif) == FALSE 
  & qtnps$homeo.motif == "Douleur au dos") 
  & (qtnps$homeo.rec.comp.med1 == "Avant d'avoir consulté l'homéopathe" 
    | qtnps$homeo.rec.comp.med2 == "Oui") 
  & qtnps$homeo.rec.comp.med1 != "Après avoir consulté l'homéopathe")
| (qtnps$magne == "Oui" & qtnps$magne.med == "Non" & (is.na(qtnps$magne.motif) == FALSE 
  & qtnps$magne.motif == "Douleur au dos") 
  & (qtnps$magne.rec.comp.med1 == "Avant d'avoir consulté le magnétiseur" 
    | qtnps$magne.rec.comp.med2 == "Oui") 
  & qtnps$magne.rec.comp.med1 != "Après avoir consulté le magnétiseur")
| (qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & (is.na(qtnps$osteo.motif) == FALSE 
  & qtnps$osteo.motif == "Douleur au dos") 
  & (qtnps$osteo.rec.comp.med1 == "Avant d'avoir consulté l'ostéopathe" 
    | qtnps$osteo.rec.comp.med2 == "Oui") 
  & qtnps$osteo.rec.comp.med1 != "Après avoir consulté l'ostéopathe")
| (qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & (is.na(qtnps$rebout.motif) == FALSE 
  & qtnps$rebout.motif == "Douleur au dos") 
  & (qtnps$rebout.rec.comp.med1 == "Avant d'avoir consulté le rebouteux" 
    | qtnps$rebout.rec.comp.med2 == "Oui") 
  & qtnps$rebout.rec.comp.med1 != "Après avoir consulté le rebouteux")
  )
table(dos.camp.nmed.comp, useNA = "always")

### Construction of the reference group A (physician only)

#### Preliminary construction of a group "use of a CAM practitioner physician for 
#### low back pain"
dos.camp.med <- (qtnps$acup == "Oui" & qtnps$acup.med == "Oui" 
  & qtnps$acup.motif == "Douleur au dos"
  | qtnps$chiro == "Oui" & qtnps$chiro.med == "Oui" & qtnps$chiro.motif == "Douleur au dos"
  | qtnps$homeo == "Oui" & qtnps$homeo.med == "Oui" & qtnps$homeo.motif == "Douleur au dos"
  | qtnps$magne == "Oui" & qtnps$magne.med == "Oui" & qtnps$magne.motif == "Douleur au dos"
  | qtnps$osteo == "Oui" & qtnps$osteo.med == "Oui" & qtnps$osteo.motif == "Douleur au dos"
  | qtnps$rebout == "Oui" & qtnps$rebout.med == "Oui" 
  & qtnps$rebout.motif == "Douleur au dos")
table(dos.camp.med, useNA = "always")

#### Effective construction of the reference group A (physician only)
dos.med.seul <- ((
  qtnps$med.doul.dos == "Oui" | dos.camp.med == TRUE) & dos.camp.nmed.comp == FALSE)
table(dos.med.seul, useNA = "always")

### Construction of the "alternative use" group C (all CAM practitioners)
dos.camp.nmed.alt <- ((
  (qtnps$acup == "Oui" & qtnps$acup.med == "Non" & (is.na(qtnps$acup.motif) == FALSE 
    & qtnps$acup.motif == "Douleur au dos") 
    & (qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
      | qtnps$acup.rec.comp.med2 == "Non") 
    & qtnps$acup.rec.comp.med1 != "Après avoir consulté l'acupuncteur")
| (qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & (is.na(qtnps$chiro.motif) == FALSE 
  & qtnps$chiro.motif == "Douleur au dos") 
  & (qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | qtnps$chiro.rec.comp.med2 == "Non") 
  & qtnps$chiro.rec.comp.med1 != "Après avoir consulté le chiropracteur")
| (qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & (is.na(qtnps$homeo.motif) == FALSE 
  & qtnps$homeo.motif == "Douleur au dos") 
  & (qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | qtnps$homeo.rec.comp.med2 == "Non") 
  & qtnps$homeo.rec.comp.med1 != "Après avoir consulté l'homéopathe")
| (qtnps$magne == "Oui" & qtnps$magne.med == "Non" & (is.na(qtnps$magne.motif) == FALSE 
  & qtnps$magne.motif == "Douleur au dos") 
  & (qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | qtnps$magne.rec.comp.med2 == "Non") 
  & qtnps$magne.rec.comp.med1 != "Après avoir consulté le magnétiseur")
| (qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & (is.na(qtnps$osteo.motif) == FALSE 
  & qtnps$osteo.motif == "Douleur au dos") 
  & (qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | qtnps$osteo.rec.comp.med2 == "Non") 
  & qtnps$osteo.rec.comp.med1 != "Après avoir consulté l'ostéopathe")
| (qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & (is.na(qtnps$rebout.motif) == FALSE 
  & qtnps$rebout.motif == "Douleur au dos") 
  & (qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | qtnps$rebout.rec.comp.med2 == "Non") 
  & qtnps$rebout.rec.comp.med1 != "Après avoir consulté le rebouteux"))
  & dos.med.seul == FALSE
  & dos.camp.nmed.comp == FALSE)
table(dos.camp.nmed.alt, useNA = "always")


### Construction of the "complementary use" group D (CAM practitioners without 
### osteopaths)

#### Preliminary construction of a group "complementary use of a non-physician osteopath 
#### for low back pain"
dos.osteo.nmed.comp <- (qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" 
  & (is.na(qtnps$osteo.motif) == FALSE & qtnps$osteo.motif == "Douleur au dos") 
  & (qtnps$osteo.rec.comp.med1 == "Avant d'avoir consulté l'ostéopathe" 
    | qtnps$osteo.rec.comp.med2 == "Oui") 
  & qtnps$osteo.rec.comp.med1 != "Après avoir consulté l'ostéopathe")
table(dos.osteo.nmed.comp, useNA = "always")


#### Effective construction of the "complementary use" group D (CAM practitioners without
#### osteopaths)
dos.camp_o.nmed.comp <- (dos.camp.nmed.comp == TRUE & dos.osteo.nmed.comp == FALSE)
table(dos.camp_o.nmed.comp)


### Construction of the "alternative use" group E (CAM practitioners without osteopaths)

#### Preliminary construction of a group "alternative use of a non-physician osteopath 
#### for low back pain"
dos.osteo.nmed.alt <- (qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" 
  & (is.na(qtnps$osteo.motif) == FALSE & qtnps$osteo.motif == "Douleur au dos") 
  & (qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | qtnps$osteo.rec.comp.med2 == "Non") 
  & qtnps$osteo.rec.comp.med1 != "Après avoir consulté l'ostéopathe")
table(dos.osteo.nmed.alt, useNA = "always")


#### Effective construction of the "alternative use" group E (CAM practitioners 
#### without osteopaths)
dos.camp_o.nmed.alt <- (dos.camp.nmed.alt == TRUE & dos.osteo.nmed.alt == FALSE)
table(dos.camp_o.nmed.alt, useNA = "always")

# Data analyses ----

## Regression analyses (satisfaction variables treated as continuous) ----
library(mice)

### First hypothesis

#### Dependent variable construction
a <- (dos.med.seul == TRUE)
b <- (dos.camp.nmed.comp == TRUE)
qtnps$newcolumn <- NA
names(qtnps)[316] <- c("vd1")
names(qtnps)[316]
qtnps$vd1 <- factor(qtnps$vd1, levels = c("dos.camp.nmed.comp", "dos.med.seul"))
table(qtnps$vd1)
qtnps[(which(a == TRUE)),316] <- "dos.med.seul"
qtnps[(which(b == TRUE)),316] <- "dos.camp.nmed.comp"
table(qtnps$vd1, useNA = "always")

#### First hypothesis testing

###### Missing data imputation
a <- data.frame(
  qtnps$vd1,qtnps$sat.pec.med,qtnps$chr.disease.r,qtnps$educ.att.r,qtnps$income.r,qtnps$sr.health.r,
  qtnps$ssex.r)
a <- a[-which(is.na(a$qtnps.vd1)==TRUE),]
a$qtnps.vd1.r <- ifelse(a$qtnps.vd1=="dos.med.seul",0,1)
a$qtnps.vd1 <- NULL
impute.a <- mice(a, m=10, seed = 1)

###### Bivariate analysis
aimp <- glm.mids(qtnps.vd1.r~qtnps.sat.pec.med, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

###### Multivariate analyses

####### Variable "chronic disease" added
aimp <- glm.mids(
  qtnps.vd1.r~qtnps.sat.pec.med+qtnps.chr.disease.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

####### Variable "educational attainment" added
aimp <- glm.mids(qtnps.vd1.r~qtnps.sat.pec.med+qtnps.chr.disease.r
  +qtnps.educ.att.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

####### Variable "income" added
aimp <- glm.mids(
  qtnps.vd1.r~qtnps.sat.pec.med+qtnps.chr.disease.r+qtnps.educ.att.r+qtnps.income.r,
  data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

####### Variable "self-rated health" added
aimp <- glm.mids(qtnps.vd1.r~qtnps.sat.pec.med+qtnps.chr.disease.r
  +qtnps.educ.att.r+qtnps.income.r+qtnps.sr.health.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

####### First hypothesis, complete model ----
####### (Variable "sex" added)
aimp <- glm.mids(qtnps.vd1.r~qtnps.sat.pec.med+qtnps.chr.disease.r+qtnps.educ.att.r+
    qtnps.income.r+qtnps.sr.health.r+qtnps.ssex.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

### Second hypothesis

#### Dependent variable construction
a <- (dos.med.seul == TRUE)
b <- (dos.camp.nmed.alt == TRUE)
qtnps$newcolumn <- NA
names(qtnps)[317] <- c("vd2")
qtnps$vd2 <- factor(qtnps$vd2, levels = c("dos.camp.nmed.alt", "dos.med.seul"))
table(qtnps$vd2)
qtnps[(which(a == TRUE)),317] <- "dos.med.seul"
qtnps[(which(b == TRUE)),317] <- "dos.camp.nmed.alt"
table(qtnps$vd2, useNA = "always")

#### Second hypothesis testing

###### Missing data imputation
a <- data.frame(
  qtnps$vd2,qtnps$sat.gp,qtnps$chr.disease.r,qtnps$educ.att.r,qtnps$income.r,qtnps$sr.health.r,
  qtnps$ssex.r)
a <- a[-which(is.na(a$qtnps.vd2)==TRUE),]
a$qtnps.vd2.r <- ifelse(a$qtnps.vd2=="dos.med.seul",0,1)
a$qtnps.vd2 <- NULL
impute.a <- mice(a, m =10, seed = 1)

###### Bivariate analysis
aimp <- glm.mids(qtnps.vd2.r~qtnps.sat.gp, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

###### Multivariate analyses

####### Variable "chronic disease" added
aimp <- glm.mids(
  qtnps.vd2.r~qtnps.sat.gp+qtnps.chr.disease.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)


####### Variable "educational attainement" added
aimp <- glm.mids(qtnps.vd2.r~qtnps.sat.gp+qtnps.chr.disease.r
  +qtnps.educ.att.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

####### Variable "income" added
aimp <- glm.mids(qtnps.vd2.r~qtnps.sat.gp+qtnps.chr.disease.r
  +qtnps.educ.att.r+qtnps.income.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

####### Variable "self-rated health" added
aimp <- glm.mids(qtnps.vd2.r~qtnps.sat.gp+qtnps.chr.disease.r
  +qtnps.educ.att.r+qtnps.income.r+qtnps.sr.health.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

####### Second hypothesis, complete model ----
####### (Variable "sex" added)
aimp <- glm.mids(
  qtnps.vd2.r~qtnps.sat.gp+qtnps.chr.disease.r+qtnps.educ.att.r+qtnps.income.r+qtnps.sr.health.r+
    qtnps.ssex.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

### Third hypothesis

#### Dependent variable construction
a <- (dos.med.seul == TRUE)
b <- (dos.camp_o.nmed.comp == TRUE)
qtnps$newcolumn <- NA
names(qtnps)[318] <- c("vde1")
qtnps$vde1 <- factor(qtnps$vde1, levels = c("dos.med.seul","dos.camp_o.nmed.comp"))
table(qtnps$vde1)
qtnps[(which(a == TRUE)),318] <- "dos.med.seul"
qtnps[(which(b == TRUE)),318] <- "dos.camp_o.nmed.comp"
table(qtnps$vde1,useNA = "always")
# dos.med.seul dos.camp_o.nmed.comp                 <NA> 
#                921                   72                 4890 

#### Hypothesis testing

###### Missing data imputation
a <- data.frame(
  qtnps$vde1,qtnps$sat.pec.med,qtnps$chr.disease.r,qtnps$educ.att.r,qtnps$income.r,qtnps$sr.health.r,
  qtnps$ssex.r)
a <- a[-which(is.na(a$qtnps.vde1)==TRUE),]
a$qtnps.vde1.r <- ifelse(a$qtnps.vde1=="dos.med.seul",0,1)
a$qtnps.vde1 <- NULL
impute.a <- mice(a, m =10, seed = 1)

###### Bivariate analysis
aimp <- glm.mids(qtnps.vde1.r~qtnps.sat.pec.med, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

###### Multivariate analysis

####### Variable "chronic disease" added
aimp <- glm.mids(qtnps.vde1.r~qtnps.sat.pec.med+qtnps.chr.disease.r,
  data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

####### Variable "educational attainement" added
aimp <- glm.mids(qtnps.vde1.r~qtnps.sat.pec.med+qtnps.chr.disease.r
  +qtnps.educ.att.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

####### Variable "income" added
aimp <- glm.mids(qtnps.vde1.r~qtnps.sat.pec.med+qtnps.chr.disease.r
  +qtnps.educ.att.r+qtnps.income.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)


####### Variable "self-rated health" added
aimp <- glm.mids(qtnps.vde1.r~qtnps.sat.pec.med+qtnps.chr.disease.r
  +qtnps.educ.att.r+qtnps.income.r+qtnps.sr.health.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)


####### Third hypothesis, complete model ----
####### (Variable "sex" added)
aimp <- glm.mids(qtnps.vde1.r~qtnps.sat.pec.med+qtnps.chr.disease.r+qtnps.educ.att.r+qtnps.income.r+qtnps.sr.health.r+qtnps.ssex.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)


### Fourth hypothesis

#### Dependent variable construction
a <- (dos.med.seul == TRUE)
b <- (dos.camp_o.nmed.alt == TRUE)
qtnps$newcolumn <- NA
names(qtnps)[319] <- c("vde2")
qtnps$vde2 <- factor(qtnps$vde2, levels = c("dos.med.seul","dos.camp_o.nmed.alt"))
table(qtnps$vde2)
qtnps[(which(a == TRUE)),319] <- "dos.med.seul"
qtnps[(which(b == TRUE)),319] <- "dos.camp_o.nmed.alt"
table(qtnps$vde2,useNA = "always")


#### Fourth hypothesis testing

###### Missing data imputation
a <- data.frame(qtnps$vde2,qtnps$sat.gp,qtnps$chr.disease.r,qtnps$educ.att.r,qtnps$income.r,
  qtnps$sr.health.r,qtnps$ssex.r)
a <- a[-which(is.na(a$qtnps.vde2)==TRUE),]
a$qtnps.vde2.r <- ifelse(a$qtnps.vde2=="dos.med.seul",0,1)
a$qtnps.vde2 <- NULL
impute.a <- mice(a, m =10, seed = 1)

###### Bivariate analysis
aimp <- glm.mids(qtnps.vde2.r~qtnps.sat.gp, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

###### Multivariate analysis

####### Variable "chronic disease" added
aimp <- glm.mids(qtnps.vde2.r~qtnps.sat.gp+qtnps.chr.disease.r,
  data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

####### Variable "educational attainment" added
aimp <- glm.mids(qtnps.vde2.r~qtnps.sat.gp+qtnps.chr.disease.r
  +qtnps.educ.att.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

####### Variable "income" added
aimp <- glm.mids(qtnps.vde2.r~qtnps.sat.gp+qtnps.chr.disease.r+qtnps.educ.att.r+qtnps.income.r,
  data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)


####### Variable "self-rated health" added
aimp <- glm.mids(qtnps.vde2.r~qtnps.sat.gp+qtnps.chr.disease.r
  +qtnps.educ.att.r+qtnps.income.r+qtnps.sr.health.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)


####### Fourth hypothesis, complete model ----
####### (Variable "sex" added)
aimp <- glm.mids(qtnps.vde2.r~qtnps.sat.gp+qtnps.chr.disease.r+qtnps.educ.att.r+qtnps.income.r+
    qtnps.sr.health.r+qtnps.ssex.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)


## Regression analyses (satisfaction variables treated as categorical) ----

### Second hypothesis

#### Variable preparation
qtnps$sat.gp.r <- cut(qtnps$sat.gp, c(1,4,8,12,16,20))
qtnps$sat.gp.r <- factor(
  qtnps$sat.gp.r, levels=c("(1,4]","(4,8]","(8,12]","(12,16]","(16,20]"))
table(qtnps$sat.gp.r)
qtnps$sat.gp.r <- relevel(qtnps$sat.gp.r,ref="(16,20]")

#### Missing data imputation
qq <- data.frame(qtnps$vd2,qtnps$sat.gp.r, qtnps$chr.disease.r, qtnps$educ.att.r,
  qtnps$income.r, qtnps$sr.health.r, qtnps$ssex.r)
qq <- qq[-which(is.na(qq$qtnps.vd2)==TRUE),]
qq$qtnps.vd2.r <- ifelse(qq$qtnps.vd2=="dos.med.seul",0,1)
qq$qtnps.vd2 <- NULL
impute.qq <- mice(qq, m =10, seed = 1)

#### Second hypothesis, complete model ----
aimp <- glm.mids(qtnps.vd2.r~qtnps.sat.gp.r+qtnps.chr.disease.r+
    qtnps.educ.att.r+qtnps.income.r+qtnps.sr.health.r+qtnps.ssex.r,
  data=impute.qq,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)



### Third hypothesis

#### Variable preparation
qtnps$sat.pec.med.r <- cut(qtnps$sat.pec.med, c(1,4,8,12,16,20))
qtnps$sat.pec.med.r <- relevel(qtnps$sat.pec.med.r,ref="(16,20]")

#### Missing data imputation
qq <- data.frame(qtnps$vde1,qtnps$sat.pec.med.r, qtnps$chr.disease.r, qtnps$educ.att.r,
  qtnps$income.r, qtnps$sr.health.r, qtnps$ssex.r)
qq <- qq[-which(is.na(qq$qtnps.vde1)==TRUE),]
qq$qtnps.vde1.r <- ifelse(qq$qtnps.vde1=="dos.med.seul",0,1)
qq$qtnps.vde1 <- NULL
impute.qq <- mice(qq, m =10, seed = 1)

#### Third hypothesis, complete model ----
aimp <- glm.mids(qtnps.vde1.r~qtnps.sat.pec.med.r+qtnps.chr.disease.r+
    qtnps.educ.att.r+qtnps.income.r+qtnps.sr.health.r+qtnps.ssex.r,
  data=impute.qq,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)

