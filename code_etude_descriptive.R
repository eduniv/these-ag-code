# Code utilisé pour la préparation des données et les analyses descriptives #
#############################################################################

# Manipulation des données ----

# Chargement du répertoire de travail ----
setwd("repertoire_de_travail_a_specifier")

# Lecture des fichiers de données et assignation aux objets « q1 » et « q2 » ----
q1 <- read.csv("q1_all.csv", dec = ",")
q2 <- read.csv("q2_all.csv", dec = ",")

# Préparation des données ----

## Préparation des deux tableaux pour leur fusion ----
# Ajout de la variable « Département de résidence » au tableau q1 
# (juste après la variable « sexe »)
q1$newcolumn <- NA # Création de la nouvelle variable
q1 <- q1[, c(1:191, 308, 192:307)] # Déplacement de la variable
names(q1)[192] <- c("Département.de.résidence.principale..") # Renommage de la variable

## Suppression des variables 194, 195 et 196 dans q1 
# (variables de code pour test-retest)
q1[194:196] <- NULL
q1[301:305] <- NULL

# Ajout à q1 de la variable de durée de remplissage relative à la variable 
# « Département de résidence ».
# Cette variable ne nous est pas utile mais comme elle est présente dans q2, 
# nous préférons l'intégrer à q1 avant la fusion, pour éviter tout problème.
q1$newcolumn2 <- NA # Création de la nouvelle variable
names(q1)[301] <- "Durée.pour.la.question..gene5bis" # Renommage de la variable
q1 <- q1[, c(1:299, 301, 300)] # Déplacement de la variable

# Suppression dans q2 des variables relatives aux 
#durées de remplissage pour les variables de code pour test-retest
q2[302:303] <- NULL

# Identification des noms de variables distincts entre q1 et q2
# setdiff(names(q1), names(q2))

# Harmonisation des noms de variables entre q1 et q2
# which(colnames(q1) == "X.En.général..blablabla...") # Identification du numéro de la
#variable dans q1 en copiant son nom à partir du résultat de la commande « setdiff » 
# (Ce sont en effet les noms de variables de q2 qui sont les bons, il faut donc 
# modifier les noms de variables dans q1. Au passage, précisons que
# le nom de variable dans q1 (blablabla…) est lié aux différents tests que
# nous avons dû faire lors du bug logiciel fin décembre 2018.)
# names(q2)[13] # Identification du nom de la variable dans q2
# Renommage de la variable dans q1
names(q1)[13] <- c("En.général..je.suis.satisfait.e.de.mon.médecin.généraliste.actuel....
Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.
  Tout.à.fait.d.accord.") 

# names(q2)[15]
names(q1)[15] <- c("En.général..j.ai.été.satisfait.e.de.ces.visites.ou.consultations....
Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.
  Tout.à.fait.d.accord.")

# names(q2)[17]
names(q1)[17] <- c("Avoir.une.vie.saine.est.important.pour.moi....Veuillez.faire.glisser
.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.d.accord.")

# names(q2)[69]
names(q1)[69] <- c("En.général..j.ai.été.satisfait.e.de.ce.kinésithérapeute.
chiropracteur....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.
  tout.d.accord.Tout.à.fait.d.accord.")

# names(q2)[71]
names(q1)[71] <- c("En.général..j.ai.été.satisfait.e.de.cette.prise.en.charge.en.
kinésithérapie....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du
.tout.d.accord.Tout.à.fait.d.accord.")

# names(q2)[114]
names(q1)[114] <- c("Le.rebouteux.que.j.ai.consulté.est.également.....Aucune.autre.
profession.particulière.")

# names(q2)[115:123]
names(q1)[115:123] <- c("Le.rebouteux.que.j.ai.consulté.est.également.....Chirurgien.
  dentiste.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Infirmier.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....
  Kinésithérapeute.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....
Médecin.généraliste.ou.spécialiste.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....
  Pédicure.podologue.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Pharmacien.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Sage.femme.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....
  Je.ne.sais.pas.",
                        "Le.rebouteux.que.j.ai.consulté.est.également.....Autre.")

# names(q2)[c(155, 157, 171, 173, 180, 194)]
names(q1)[c(155, 157, 171, 173, 180, 194)] <- 
  c("En.général..j.ai.été.satisfait.e.de.ce.kinésithérapeute.ostéopathe....Veuillez.
faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.
    d.accord.","En.général..j.ai.été.satisfait.e.de.ma.prise.en.charge.en.kinésithérapie
....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.du.tout.d.accord
    .Tout.à.fait.d.accord.","Pour.ma.douleur.au.dos..j.ai.été.satisfait.e.de.ma.prise.en
.charge.médicale....Veuillez.faire.glisser.le.curseur.pour.donner.votre.réponse.....Pas.
    du.tout.d.accord.Tout.à.fait.d.accord.","Durant.les.12.derniers.mois..j.ai.été.pris.
e.en.charge.en.kinésithérapie.pour.un.ou.plusieurs.des.motifs.suivants....Je.n.ai.pas.
    été.pris.e.en.charge.en.kinésithérapie.","Pour.ma.douleur.au.dos..j.ai.été.satisfait.
e.de.ma.prise.en.charge.en.kinésithérapie....Veuillez.faire.glisser.le.curseur.pour.
donner.votre.réponse.....Pas.du.tout.d.accord.Tout.à.fait.d.accord.",
    "Remarques.générales.sur.l.enquête..facultatif...")

# Identification des noms de variables distincts entre q1 et q2 ----
# setdiff(names(q2), names(q1))

# Correction du décalage
# which(colnames(q1) == "En.ce.qui.concerne.ce.motif.principal..j.ai.également.consulté.
#un.médecin...2")
# which(colnames(q1) == "En.ce.qui.concerne.ce.motif.principal..j.ai.également.consulté.
#un.médecin...3")
# which(colnames(q1) == "En.ce.qui.concerne.ce.motif.principal..j.ai.également.consulté.
#un.médecin...4")
names(q1)[c(106, 126, 146)] <- c("En.ce.qui.concerne.ce.motif.principal..j.ai.également.
consulté.un.médecin...3",
                                 "En.ce.qui.concerne.ce.motif.principal..j.ai.également.
consulté.un.médecin...4",
                                 "En.ce.qui.concerne.ce.motif.principal..j.ai.également.
consulté.un.médecin...5")

# Identification des noms de variables distincts entre q1 et q2 ----
# setdiff(names(q2), names(q1))

## Harmonisation des variables issues des échelles visuelles analogiques entre q1 et q2
cut5 <- function(x) cut(x,5)
q1[,c(13,15,17,69,71,155,157,171,180)] <- lapply(
  q1[,c(13,15,17,69,71,155,157,171,180)], cut5
  )
q2[,c(13,15,17,69,71,155,157,171,180)] <- lapply(
  q2[,c(13,15,17,69,71,155,157,171,180)]*10, cut5
  )

## Fusion de q1 et q2 + assignation au nouvel objet « qtnps » ----
library(plyr)
qtnps <- rbind.fill(q1, q2)

## Suppression des colonnes inutiles ----
qtnps[c(196:210, 212:301)] <- NULL

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
                         "chiro.kin", "chiro.med", "chiro.pod", "chiro.pharm",
  "chiro.sfemme", 
                         "chiro.na", "chiro.autre", "chiro.motif", "chiro.motif.autre", 
                         "chiro.rec.comp.med1", "chiro.rec.comp.med2", 
  "chiro.recom.med1",
                         "chiro.recom.med2", "med.recom.chiro", "med.depuis.chiro", 
                         "talk.chiro.med", "chiro.rec.comp.kin1", "kin.is.chiro", 
                         "sat.kin.chiro", "chiro.rec.comp.kin2", "chiro.sat.pec.kin", 
                         "kin.recom.chiro", "chiro.comp.san")
names(qtnps)[74:93] <- c("homeo.tnps", "homeo.chir.d", "homeo.inf",
                         "homeo.kin", "homeo.med", "homeo.pod", "homeo.pharm",
  "homeo.sfemme", 
                         "homeo.na", "homeo.autre", "homeo.motif", "homeo.motif.autre", 
                         "homeo.rec.comp.med1", "homeo.rec.comp.med2","homeo.recom.med1",
                         "homeo.recom.med2", "med.recom.homeo", "med.depuis.homeo", 
                         "talk.homeo.med", "homeo.comp.san")
names(qtnps)[94:113] <- c("magne.tnps", "magne.chir.d", "magne.inf",
                          "magne.kin", "magne.med", "magne.pod", "magne.pharm",
  "magne.sfemme", 
                          "magne.na", "magne.autre", "magne.motif", "magne.motif.autre", 
                          "magne.rec.comp.med1", "magne.rec.comp.med2",
  "magne.recom.med1",
                          "magne.recom.med2", "med.recom.magne", "med.depuis.magne", 
                          "talk.magne.med", "magne.comp.san")
names(qtnps)[114:133] <- c("rebout.tnps", "rebout.chir.d", "rebout.inf",
                           "rebout.kin", "rebout.med", "rebout.pod", "rebout.pharm",
  "rebout.sfemme", 
                           "rebout.na", "rebout.autre", "rebout.motif",
  "rebout.motif.autre", 
                           "rebout.rec.comp.med1", "rebout.rec.comp.med2",
  "rebout.recom.med1",
                           "rebout.recom.med2", "med.recom.rebout", "med.depuis.rebout", 
                           "talk.rebout.med", "rebout.comp.san")
names(qtnps)[134:158] <- c("osteo.tnps", "osteo.chir.d", "osteo.inf",
                           "osteo.kin", "osteo.med", "osteo.pod", "osteo.pharm",
  "osteo.sfemme", 
                           "osteo.na", "osteo.autre", "osteo.motif", "osteo.motif.autre", 
                           "osteo.rec.comp.med1", "osteo.rec.comp.med2",
  "osteo.recom.med1",
                           "osteo.recom.med2", "med.recom.osteo1", "med.depuis.osteo", 
                           "talk.osteo.med", "osteo.rec.comp.kin1", "kin.is.osteo", 
                           "sat.kin.osteo", "osteo.rec.comp.kin2", "osteo.sat.pec.kin", 
                           "kin.recom.osteo1")
names(qtnps)[159:172] <- c("med.non", "med.bronchite", "med.grippe", 
                           "med.gorge", "med.migraine", "med.doul.msup", "med.doul.minf", 
                           "med.doul.cou", "med.doul.dos", "med.depression","med.stress", 
                           "med.autre", "sat.pec.med", "med.recom.osteo2")
names(qtnps)[173:182] <- c("kin.non", "kin.migraine",
                           "kin.doul.msup", "kin.doul.minf", "kin.doul.cou",
  "kin.doul.dos", 
                           "kin.autre", "sat.pec.kin", "kin.recom.osteo2",
  "osteo.comp.san")
names(qtnps)[183:195] <- c("age", "sit.matri", "emploi", "prof", 
                           "lieu.de.vie", "diplome", "diplome.autre", "revenu", "sexe",
                           "dep.resid", "support", "remarques", "temps.total")

## Remplacer toutes les valeurs "N/A" du tableau par la valeur 
## consacrée aux données manquantes
qtnps[qtnps[ , ] == "N/A"] <- NA

## Remplacer toutes les valeurs vides "" du tableau par la valeur 
## consacrée aux données manquantes
qtnps[qtnps[ , ] == ""] <- NA

## Nettoyage des données ----

# Suppression des données acquises le 14 décembre 2018 
# (jour du rétablissement par mise à jour) (n=7)
library(stringr)
# which(str_detect(qtnps$Date.de.soumission, "2018-12-14") == TRUE)
# [1] 5581 5582 5583 5586 5587 5588 5589
qtnps <- qtnps[-c(5581, 5582, 5583, 5586, 5587, 5588, 5589), ]

# Suppression des remplissages d'essai (n=1)
# which(str_detect(qtnps$remarques, "ALBIN GUILLAUD") == TRUE)
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
      "acpt transport / assistant réalisateur/diplôme de formation professionnelle port
      de rouen"
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
      ,"Le concours d'entrée à l'Ecole Nationale Supérieur des Arts Décoratifs, 
      rue d'Ulm, Paris"
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
      "JE VEUT FAIRE UN MASTER EN VAE ET J AI UNE LICENCE EN VAE JE N AI PAS LE BAC MON
NIVEAU SCOLAIRE EST CAP"
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
      "diplômes professionnels obtenus après le bac (CAP d'institutrice,
concours de professeurs des
      écoles,CAFIPEMF)"
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
      "Certificat de fin d'études à l'écolenormale d'instituteur(trice)s de Paris 
      Batignolles",
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

## Préparation pour les statistiques descriptives ----

qtnps$sit.matri.r <- factor(qtnps$sit.matri, levels = c("Divorced/separated",
  "Married/cohabiting", "Single", "Widowed", "Other (=NA)"))
qtnps$sit.matri.r[qtnps$sit.matri %in% c("Célibataire")] <- "Single"
qtnps$sit.matri.r[qtnps$sit.matri %in% c("En couple (PACS, concubinage…)",
  "Marié(e)")] <- "Married/cohabiting"
qtnps$sit.matri.r[qtnps$sit.matri %in% c("Veuf(ve)")] <- "Widowed"
qtnps$sit.matri.r[qtnps$sit.matri %in% 
    c("Divorcé(e) ou séparé(e)")] <- "Divorced/separated"
qtnps$sit.matri.r[qtnps$sit.matri %in% c("Autre")] <- "Other (=NA)"

qtnps$lieu.de.vie.r <- factor(qtnps$lieu.de.vie, levels = c("Rural", "Intermediate",
  "Urban"))
qtnps$lieu.de.vie.r[qtnps$lieu.de.vie %in% c("Un village","Une ferme ou une maison à
  la campagne")] <- "Rural"
qtnps$lieu.de.vie.r[qtnps$lieu.de.vie %in% 
    c("Une ville moyenne ou petite")] <- "Intermediate"
qtnps$lieu.de.vie.r[qtnps$lieu.de.vie %in% 
c("Une grande ville","La banlieue ou les environs d'une 
  grande ville")] <- "Urban"

## Regroupement de modalités pour les variables « qtnps$[thérapeute].autre.r » ----
# Acupuncteurs
qtnps$acup.autre.r[qtnps$acup.autre %in% c("Acupuncture médecine chinoise",
  "Diplômé de médecine chinoise","docteur en sciences du vivant - CFMTC",
"heilpraktiker","Homeopathe","Homéopathe","m2DECINE CHINOISE","medecin chinois",
  "médecin chinois","médecin chinois, holistique","medecine chinoise",
  "Médecine traditionnelle chinoise ","Micro nutritionniste ","MTC","osteopathe",
  "ostéopathe","Ostéopathe","ostéopathe ","Ostéopathe ","ostépathe",
  "praticien en médecine traditionnelle chinoise","spécialisé en médecine chinoise",
"Therapeute","acupuncteur","Apiculteur","bioénergéticienne","chimiste","Diététicienne",
  "divers","Energeticien chinois. ","Énergeticienne","Formateur ","homeopathe",
  "homéopathe","Homéopathe ","homéopathe acupuncteur","magnétiseur","masseur",
  "mécdecine chinoise","Médecin chinois","Medecin chinois ",
  "Medecin traditionnel chinois","Médecin traditionnel chinois",
  "Médecin Traditionnel Chinois","Médecin traditionnel chinois ",
  "Medecine chinoise","médecine chinoise","Médecine chinoise",
  "Medecine energetique chinoise","medecine traditionnelle chinoise",
  "MEDECINE TRADITIONNELLE CHINOISE","médecine traditionnelle chinoise",
  "Médecine Traditionnelle Chinoise","mésothérapeute","Naturopathe","NATUROPATHE","NO",
  "Osteopathe","ostéopathe, bionutritionniste","osthéopathe","Praticien de MTC",
"praticien en medecine chinoise","praticien en médecine chinoise",
  "praticien en Medecine Traditionnelle Chinoise","PRATICIEN EN SANTE NATURELLE",
  "praticien medecine chinoise","PRATICIEN MEDECINE CHINOISE",
"Praticien médecine chinoise","Praticien MTC","professeur d(arts martiaux",
  "professeur de qi gong","professeur de QI Qong","professeur de yoga","Psychiatre",
  "réflexologue","rien d'autre","soigne aussi avec pharmacopée chinoise",
  "Spécialiste en médecine chinoise ",
  "thérapeute hypnose","Ancien kinésithérapeute ")] <- "nps"
qtnps$acup.autre.r[qtnps$acup.autre %in% c("Anesthésiste ","chirurgien","Gynecologue",
  "Médecin de la douleur ","Médecin urgentiste ","generaliste","Médecin anesthésiste",
  "médecin homéopathe","Medecin naturopathe","Médecine")] <- "medecin"
qtnps$acup.autre.r[qtnps$acup.autre %in% c("Ambulancier",
  "assistant radiologie")] <- "ps.nmed"

qtnps$acup.autre.r <- factor(qtnps$acup.autre.r)
levels(qtnps$acup.autre.r)
# [1] "medecin" "nps"     "ps.nmed"
table(qtnps$acup.autre.r, useNA = "always")
# medecin     nps ps.nmed    <NA> 
#      11     111       2   10354 

# Chiropracteurs
qtnps$chiro.autre.r[qtnps$chiro.autre %in% 
    c("biokinergie","Energeticien","KINESIOLOGUE","thérapeute")] <- "nps"

qtnps$chiro.autre.r <- factor(qtnps$chiro.autre.r)
levels(qtnps$chiro.autre.r)
# [1] "nps"
table(qtnps$chiro.autre.r, useNA = "always")
 # nps  <NA> 
 #    3 10475 

# Homéopathes
qtnps$homeo.autre.r[qtnps$homeo.autre %in% 
    c("accupuncteur","acupuncteur","Acupuncteur","Acupuncteur donc","Acupuncture ",
      "acupunteur","auriculothérapeute","Iridologue","micronutritionniste ",
      "naturophate ",
      "Ostéopathe","Psychologue "
,"seulement homéopathe","ostéopathe","acuponcteur","Acuponcteur","Acupuncteur ",
"auto médicamentation","Auto medication ","Homéopathe ","naturopathe","Naturopathe",
"Nturopathe","ostéo","Osthéopate","phytothérapeute","Praticien en médecine chinoise",
"Uniciste","voir ci dessus")] <- "nps"
qtnps$homeo.autre.r[qtnps$homeo.autre %in% 
    c("medecin TTT","ORL","c 'est mon médecin traitant aussi ",
      "c'est donc la même médecin-acupunctrice-homéopathe","chirurgien","endocrinologue",
      "Gynécologue","Gynécologue ","Gynécologue / Sage-femme",
      "JE SUIS MOI MEME  MEDECIN HOMEOPATHE","Le naturepathe est anesthesiste","médecin",
"médecin acupuncteur","médecin de cure thermale","Médecin de la douleur ",
      "nutritionniste",
"Oncologue","Psychiatre")] <- "medecin"

qtnps$homeo.autre.r <- factor(qtnps$homeo.autre.r)
levels(qtnps$homeo.autre.r)
# [1] "medecin" "nps" 
table(qtnps$homeo.autre.r, useNA = "always")
# medecin     nps    <NA> 
#      22      60   10396 

# Magnétiseurs
qtnps$magne.autre.r[qtnps$magne.autre %in% c("A la retraite ",
  "Accompagnant personne dépendante","agriculteur retraité","CAISSIERE",
"Charpentier","documentaliste","éthiopathe","géobiologue","géobioloque",
"Hypnothérapeute","hypnotiseur","Hypnotiseur","naturopathe ","Osteo","Osteopathe",
"ostéopathe","osthéopathe","policier","psychologue","psychomotricien","Reflexologue ",
"Reiki","Relaxologue Hypnose Sophrologue","sophrologue","Agriculteur","Agriculteurs ",
  "aucune","autre","aucune","autre","cultivateur","DANSEUSE ","énergéticien",
  "Enseignant ","Épicier",
"homéopathe accupuncteur non conventionné","Hypnotherapeute ","ingenieur","Ingénieur"
,"Magnétiseur uniquement","masseur","mécanicien","medium","naturopathe","Naturopathe",
"non","osteopathe","Ostéopathe","OstheopaThe","Parapsychologue","particulier",
"Particulier qui passe les brûlures des zonas","Personne à la retraite",
"Plusieurs méthode en médecine alternative ","pompier","Pompier",
  "PRATICIEN EN SANTE NATURELLE","profession non médicale","rebouteux","reflexologue",
  "reflexologue plantaire","retaité","retraité","Retraité",
  "Retraité d'un emploi administratif","Retraité de la police","Retraité du batiment",
  "Retraitée lingère ","Rettraite enseignement","rien d'autre","Sophrologue",
  "Sophrologue ","sophrologue, hypnothérapeuthe","therapeute","vétérinaire ",
  "Vigneron")] <- "nps"
qtnps$magne.autre.r[qtnps$magne.autre %in% c("Aide-soignant",
  "technicien radio")] <- "ps.nmed"
qtnps$magne.autre.r[qtnps$magne.autre %in% c("Médecin réanimateur ")] <- "medecin"

qtnps$magne.autre.r <- factor(qtnps$magne.autre.r)
levels(qtnps$magne.autre.r)
# [1] "medecin" "nps"     "ps.nmed"
table(qtnps$magne.autre.r, useNA = "always")
# medecin     nps ps.nmed    <NA> 
#       1      85       2   10390

# Ostéopathes
qtnps$osteo.autre.r[qtnps$osteo.autre %in% 
    c(
      "Acuponcteur, hypnotiseur","acupuncteur","Acupunctteur","aucune autre",
      "Bioenergicien","biokinergie","biokinergiste","Diplômé en médecine chinoise",
      "Energéticien","Esthiopathe","ethiopathe","Ethiopathe","etiopathe","Etiopathe",
      "etiothérapie","ex kinésithérapeute (a rendu sa plaque)","Ex  kiné",
      "ancien infirmier - enseignant en osteopathie","hypnose ericksonnienne",
      "hypnothérapeute","hypnothiseur ",
      "Il était psychomotricité avant de se former à l'ostéopathie.  Pendant un temps il
a exercé les 2 activités. Mais maintenant il n'exerce qu'en tant qu'osteopathe. ",
      "Juste ostéopathe ","Kinesio","kinesiologue","Kinesiologue","kinésiologue",
      "Kinesiologue ","Kinesiologue / énergies chinoises","Magnetiseur","Magnétiseur ",
      "masseur","masseur, technique chinoise","Médecin chinois traditionnel",
      "Médecin traditionnel chinois","Médecine Chinoise","Médecine Quantique",
      "Micro-kiné","microkiné","moniteur de ski","naturopathe",
      "naturopathe, médecine chinoise","ostéo","Ostéopathe agréer",
      "ostéopathie fonctionnelle","Posturologue",
      "Praticien en médecine traditionelle chinoise","pratique uniquement ostéo",
      "psychanaliste","Psycotherapeute","Réflexologue","uniquement ostéopathe",
      "accuponcteur","acuponcteur","Acuponcture ","Acupuncteur","ACUPUNCTEUR",
      "Acupuncteur ","Acupuncteur médecine chinoise","acupuncteur, Homeopathe",
      "Acupuncture ","aucune","Ė","Energeticien","enseignant",
      "Enseignant ","Enseignant EPS à l'université","Enseignant Tai chi/ Qi Gong",
      "Enseignante en école d'ostéo","ergotherapeuthe","éthopathe","Etiomédeccin",
      "étiopathe","étiopathe, ","étudiant","Étudiants ","FACIOTHERAPEUTE",
      "Fibromyalgie ","il n'est qu'osteopathe","Kinésiologue ","magnétiseur",
      "Magnétiseur","Massage sportif","Médecin traditionnel chinois ",
      "médecine chinoise","médecine chinoise, chaman","Naturopathe",
      "OSTEO DANS UN CLUB SPORT PROFESSIONNEL","osteopathe","Ostéopathe",
      "Osteopathe equin","ostéopathe exclusif",
      "Ostéopathe formée en école d'ostéopathie à Lyon.","Osthéopathe seulement",
      "Phytothérapeute","posturologue","Praticien en MTC",
      "pratiquant de médecine chinoise","psychologue","puericultrice","Rien d'autre",
      "Somatopathie et soins indiens","Specialiste du sport",
      "Surveillant dans un collège","Synthonipathie ",
      "Travail avec les points d'énergie "
      )] <- "nps"
qtnps$osteo.autre.r[qtnps$osteo.autre %in% 
    c("Kinésithérapeute ","manipulateur radio","Manipulateur radio",
      "kiné en cure thermale","Kiné et hypnothérapeute","Kinésithérapeute",
      "micro kiné","Microkinésithérapeute","Pédicure et Diétiéticiennet ",
      "podologue")] <- "ps.nmed"
qtnps$osteo.autre.r[qtnps$osteo.autre %in% 
    c("neuro...","Ophtalmo","radiologue","Rhumato","rhumatologue","gastro-enterologue",
"médecin","medecin en traumatologie","Neurchir","nutritionniste","Oncolgue"
,"rhumatologue ","Rhumatologue centre antidouleur","Urgentistes")] <- "medecin"

qtnps$osteo.autre.r <- factor(qtnps$osteo.autre.r)
levels(qtnps$osteo.autre.r)
# [1] "medecin" "nps"     "ps.nmed"
table(qtnps$osteo.autre.r, useNA = "always")
# medecin     nps ps.nmed    <NA> 
#      16     118       9   10335  

# Rebouteux
qtnps$rebout.autre.r[qtnps$rebout.autre %in% c("Agriculteur","Énergéticien",
  "osteopathe","Retraite","retraité","Retraité","agent de banque","bio-énergeticien",
  "Etiopathie","informaticien","magnétiseur","Magnétiseur hypnotherapeute ",
"Utilise le physioscan")] <- "nps"
qtnps$rebout.autre.r[qtnps$rebout.autre %in% c("Ambulanciers")] <- "ps.nmed"

qtnps$rebout.autre.r <- factor(qtnps$rebout.autre.r)
levels(qtnps$rebout.autre.r)
# [1] "nps"     "ps.nmed"
table(qtnps$rebout.autre.r, useNA = "always")
# nps ps.nmed    <NA> 
#  16       1   10461

# Analyse descriptive ----

## Description de l'échantillon (Tableau X) ----
## Sex
table(qtnps$ssex, useNA = "always")
# Female   Male   <NA> 
#   6690   3788      0
round(prop.table(table(qtnps$ssex, useNA = "always")),3)*100
# Female   Male   <NA> 
#   63.8   36.2    0.0
sum(table(qtnps$ssex, useNA = "always"))
# [1] 10478

## Marital status
table(qtnps$sit.matri.r, useNA = "always")
# Divorced/separated Married/cohabiting             Single            Widowed 
#               1115               7396               1572                356 
#        Other (=NA)               <NA> 
#                 39                  0 
round(prop.table(table(qtnps$sit.matri.r, useNA = "always")),2)*100
# Divorced/separated Married/cohabiting             Single            Widowed 
#                 11                 71                 15                  3 
#        Other (=NA)               <NA> 
#                  0                  0
sum(table(qtnps$sit.matri.r, useNA = "always"))
# [1] 10478

## Lieu de vie
table(qtnps$lieu.de.vie.r, useNA = "always")
# Rural Intermediate        Urban         <NA> 
#   2837         3398         4243            0 
round(prop.table(table(qtnps$lieu.de.vie.r, useNA = "always")),2)*100
# Rural Intermediate        Urban         <NA> 
#    27           32           40            0
sum(table(qtnps$sit.matri.r, useNA = "always"))
# [1] 10478

## Monthly income
table(qtnps$income, useNA = "always")
# <1135€ 1135-1800€ 1800-3000€     >3000€       <NA> 
#   1452       2542       3660       1787       1037 
round(prop.table(table(qtnps$income, useNA = "always")),2)*100
# <1135€ 1135-1800€ 1800-3000€     >3000€       <NA> 
#     14         24         35         17         10
sum(table(qtnps$income, useNA = "always"))
# [1] 10478

## Educational attainement
table(qtnps$educ.att, useNA = "always")
#                   Upper secondary education or less 
#                                                1607 
# Bachelor's degree or short cycle tertiary education 
#                                                4804 
#                        Master's degree or doctorate 
#                                                4058 
#                                                <NA> 
#                                                   9 
round(prop.table(table(qtnps$educ.att, useNA = "always")),2)*100
#                   Upper secondary education or less 
#                                                  15 
# Bachelor's degree or short cycle tertiary education 
#                                                  46 
#                        Master's degree or doctorate 
#                                                  39 
#                                                <NA> 
#                                                   0 
sum(table(qtnps$educ.att, useNA = "always"))
# [1] 10478

## Age
mean(qtnps$age)
# [1] 51.1903
sd(qtnps$age)
# [1] [1] 16.03766
sum(table(qtnps$age))
# [1] 10478
table(is.na(qtnps$age))
# FALSE 
# 10478

## Emploi
# Manipulations préliminaires
qtnps$emploi.r <- as.character(qtnps$emploi)
qtnps$emploi.r[qtnps$emploi.r %in% c("Chômeur(se)")] <- "En recherche d'emploi"
qtnps$emploi.r[qtnps$emploi.r %in% c("Étudiant(e)")] <- "Étudiant"
qtnps$emploi.r[qtnps$emploi.r %in% c("Préretraité(e)")] <- "Retraité"
qtnps$emploi.r[qtnps$emploi.r %in% c("Retraité(e)")] <- "Retraité"
qtnps$emploi.r[qtnps$emploi.r %in% c("Allocataire du RSA")] <- "En recherche d'emploi"
qtnps$emploi.r[qtnps$emploi.r %in% c("Occupe un emploi")] <- "En activité"
qtnps$emploi.r[qtnps$emploi.r %in% 
c("En invalidité / en longue maladie")] <- "Invalidité ou longue
maladie"
# Données
table(qtnps$emploi.r, useNA = "always")
#    Au foyer                        Autre 
#         176                          290 
# En activité        En recherche d'emploi 
#        5410                          355 
#    Étudiant Invalidité ou longue maladie 
#         553                          476 
#    Retraité                         <NA> 
#        3218                            0 
round(prop.table(table(qtnps$emploi.r, useNA = "always")),2)*100
#    Au foyer                        Autre 
#           2                            3 
# En activité        En recherche d'emploi 
#          52                            3 
#    Étudiant Invalidité ou longue maladie 
#           5                            5 
#    Retraité                         <NA> 
#          31                            0 
sum(table(qtnps$educ.att, useNA = "always"))
# [1] 10478

## Taux de recours aux TA (Figure A1) ----
acup = qtnps$acup == "Oui"
chiro = qtnps$chiro == "Oui" 
homeo = qtnps$homeo == "Oui" 
magne = qtnps$magne == "Oui"
osteo = qtnps$osteo == "Oui"
rebout <- qtnps$rebout == "Oui"
camp <- (acup|chiro|homeo|magne|osteo|rebout)
ta <- table(camp, useNA = "always")
# FALSE  TRUE  <NA> 
#  4989  5489     0
round(prop.table(ta),3)*100
# FALSE  TRUE  <NA> 
#  47.6  52.4   0.0

### Taux de recours à un acupuncteur
table(acup,useNA = "always")
# FALSE  TRUE  <NA> 
#  9496   982     0
round(prop.table(table(acup,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  90.6   9.4   0.0

### Taux de recours à un chiropracteur
table(chiro,useNA = "always")
# FALSE  TRUE  <NA> 
# 10254   224     0
round(prop.table(table(chiro,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  97.9   2.1   0.0

### Taux de recours à un homéopathe
table(homeo,useNA = "always")
# FALSE  TRUE  <NA> 
#  9396  1082     0
round(prop.table(table(homeo,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  89.7  10.3   0.0

### Taux de recours à un magnétiseur
table(magne,useNA = "always")
# FALSE  TRUE  <NA> 
#  9852   626     0
round(prop.table(table(magne,useNA = "always")),4)*100
# FALSE  TRUE  <NA> 
#    94     6     0

### Taux de recours à un ostéopathe
table(osteo,useNA = "always")
# FALSE  TRUE  <NA> 
#  5796  4682     0
round(prop.table(table(osteo,useNA = "always")),4)*100
# FALSE  TRUE  <NA> 
# 55.32 44.68  0.00

### Taux de recours à un rebouteux
table(rebout,useNA = "always")
# FALSE  TRUE  <NA> 
# 10360   118     0
round(prop.table(table(rebout,useNA = "always")),4)*100
# FALSE  TRUE  <NA> 
# 98.87  1.13  0.00

## Taux de recours à un TA médecin (Figure A2) ----
camp.med <- (qtnps$acup == "Oui" & (qtnps$acup.med == "Oui" | 
    (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))) |
  (qtnps$chiro == "Oui" & (qtnps$chiro.med == "Oui" |
      (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))) |
  (qtnps$homeo == "Oui" & (qtnps$homeo.med == "Oui" |
     (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))) |
  (qtnps$magne == "Oui" & (qtnps$magne.med == "Oui" |
      (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))) |
  (qtnps$osteo == "Oui" & (qtnps$osteo.med == "Oui" |
      (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))) |
  (qtnps$rebout == "Oui" & (qtnps$rebout.med == "Oui" |
      (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin")))
table(camp.med, useNA = "always")
# FALSE  TRUE  <NA> 
#  9072  1406     0
round(prop.table(table(camp.med, useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  86.6  13.4   0.0

### Médecin-acupuncteur
acup.med <- (qtnps$acup == "Oui" & (qtnps$acup.med == "Oui" | 
    (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin")))
table(acup.med,useNA = "always")
# FALSE  TRUE  <NA> 
#  9993   485     0
round(prop.table(table(acup.med,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  95.4   4.6   0.0

### Médecin-chiropracteur
chiro.med <- (qtnps$chiro == "Oui" & (qtnps$chiro.med == "Oui" | 
    (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin")))
table(chiro.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10474     4     0
round(prop.table(table(chiro.med,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#   100     0     0

### Médecin-homéopathe
homeo.med <- (qtnps$homeo == "Oui" & (qtnps$homeo.med == "Oui" | 
    (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin")))
table(homeo.med,useNA = "always")
# FALSE  TRUE  <NA> 
#  9569   909     0
round(prop.table(table(homeo.med,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  91.3   8.7   0.0

### Médecin-magnétiseur
magne.med <- (qtnps$magne == "Oui" & (qtnps$magne.med == "Oui" | 
    (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin")))
table(magne.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10466    12     0
round(prop.table(table(magne.med,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  99.9   0.1   0.0

### Médecin-ostéopathe
osteo.med <- (qtnps$osteo == "Oui" & (qtnps$osteo.med == "Oui" | 
    (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin")))
table(osteo.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10171   307     0 
round(prop.table(table(osteo.med,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  97.1   2.9   0.0 

### Médecin-rebouteux
rebout.med <- (qtnps$rebout == "Oui" & (qtnps$rebout.med == "Oui" | 
    (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin")))
table(rebout.med,useNA = "always")
# FALSE  <NA> 
# 10478     0
round(prop.table(table(rebout.med,useNA = "always")),3)*100
# FALSE  <NA> 
#   100     0

## Taux de recours à un TA non médecin (Figure A3) ----
camp.nmed <- (qtnps$acup == "Oui" & qtnps$acup.med == "Non" &
    (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE)) |
  (qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & (qtnps$chiro.autre.r != "medecin" |
      is.na(qtnps$chiro.autre.r) == TRUE)) |
  (qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & (qtnps$homeo.autre.r != "medecin" |
      is.na(qtnps$homeo.autre.r) == TRUE)) |
  (qtnps$magne == "Oui" & qtnps$magne.med == "Non" & (qtnps$magne.autre.r != "medecin" |
      is.na(qtnps$magne.autre.r) == TRUE)) |
  (qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & (qtnps$osteo.autre.r != "medecin" |
      is.na(qtnps$osteo.autre.r) == TRUE)) |
  (qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" &
      (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE))
table(camp.nmed, useNA = "always")
# FALSE  TRUE  <NA> 
#  5582  4896     0
round(prop.table(table(camp.nmed, useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  53.3  46.7   0.0

### Chiropracteur non médecin
chiro.nmed <- (qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" &
    (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE))
table(chiro.nmed,useNA = "always")
# FALSE  TRUE  <NA> 
# 10258   220     0
round(prop.table(table(chiro.nmed,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  97.9   2.1   0.0

### Homéopathe non médecin
homeo.nmed <- (qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" &
    (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE))
table(homeo.nmed,useNA = "always")
# FALSE  TRUE  <NA> 
# 10305   173     0
round(prop.table(table(homeo.nmed,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  98.3   1.7   0.0

### Magnétiseur non médecin
magne.nmed <- (qtnps$magne == "Oui" & qtnps$magne.med == "Non" &
    (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE))
table(magne.nmed,useNA = "always")
# FALSE  TRUE  <NA> 
#  9864   614     0
round(prop.table(table(magne.nmed,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  94.1   5.9   0.0

### Ostéopathe non médecin
osteo.nmed <- (qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" &
    (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE))
table(osteo.nmed,useNA = "always")
# FALSE  TRUE  <NA> 
#  6103  4375     0
round(prop.table(table(osteo.nmed,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  58.2  41.8   0.0

### Rebouteux non médecin
rebout.nmed <- (qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" &
    (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE))
table(rebout.nmed,useNA = "always")
# FALSE  TRUE  <NA> 
# 10360   118     0
round(prop.table(table(rebout.nmed,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  98.9   1.1   0.0

## Taux de recours aux différents TA-PS et non médecins (ps non med) ----
### Acupuncteur ps non med
acup.ps.nmed <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.chir.d == "Oui" | qtnps$acup.inf == "Oui" | qtnps$acup.kin == "Oui" 
      | qtnps$acup.pharm == "Oui" | qtnps$acup.pod == "Oui" |
      qtnps$acup.sfemme == "Oui" | 
      (is.na(qtnps$acup.autre.r)==FALSE & qtnps$acup.autre.r == "ps.nmed"))
table(acup.ps.nmed,useNA = "always")
# FALSE  TRUE  <NA> 
# 10398    80     0
round(prop.table(table(acup.ps.nmed,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  99.2   0.8   0.0

### Chiropracteur ps non med
chiro.ps.nmed <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.chir.d == "Oui" | qtnps$chiro.inf == "Oui" | qtnps$chiro.kin == "Oui" 
      | qtnps$chiro.pharm == "Oui" | qtnps$chiro.pod == "Oui" |
      qtnps$chiro.sfemme == "Oui" | 
      (is.na(qtnps$chiro.autre.r)==FALSE & qtnps$chiro.autre.r == "ps.nmed"))
table(chiro.ps.nmed,useNA = "always")
# FALSE  TRUE  <NA> 
# 10457    21     0 
round(prop.table(table(chiro.ps.nmed,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  99.8   0.2   0.0

### Homéopathe ps non med
homeo.ps.nmed <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.chir.d == "Oui" | qtnps$homeo.inf == "Oui" | qtnps$homeo.kin == "Oui" 
      | qtnps$homeo.pharm == "Oui" | qtnps$homeo.pod == "Oui" |
      qtnps$homeo.sfemme == "Oui" | 
      (is.na(qtnps$homeo.autre.r)==FALSE & qtnps$homeo.autre.r == "ps.nmed"))
table(homeo.ps.nmed,useNA = "always")
# FALSE  TRUE  <NA> 
# 10441    37     0
round(prop.table(table(homeo.ps.nmed,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  99.6   0.4   0.0

### Magnétiseur ps non med
magne.ps.nmed <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.chir.d == "Oui" | qtnps$magne.inf == "Oui" | qtnps$magne.kin == "Oui" 
      | qtnps$magne.pharm == "Oui" | qtnps$magne.pod == "Oui" |
      qtnps$magne.sfemme == "Oui" | 
      (is.na(qtnps$magne.autre.r)==FALSE & qtnps$magne.autre.r == "ps.nmed"))
table(magne.ps.nmed,useNA = "always")
# FALSE  TRUE  <NA> 
# 10433    45     0
round(prop.table(table(magne.ps.nmed,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  99.6   0.4   0.0 

### Ostéopathe ps non med
osteo.ps.nmed <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.chir.d == "Oui" | qtnps$osteo.inf == "Oui" | qtnps$osteo.kin == "Oui" 
      | qtnps$osteo.pharm == "Oui" | qtnps$osteo.pod == "Oui" | 
      qtnps$osteo.sfemme == "Oui" | 
      (is.na(qtnps$osteo.autre.r)==FALSE & qtnps$osteo.autre.r == "ps.nmed"))
table(osteo.ps.nmed,useNA = "always")
round(prop.table(table(osteo.ps.nmed,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  9208  1270     0

### Rebouteux ps non med
rebout.ps.nmed <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.chir.d == "Oui" | qtnps$rebout.inf == "Oui" | qtnps$rebout.kin == "Oui" 
      | qtnps$rebout.pharm == "Oui" | qtnps$rebout.pod == "Oui" |
      qtnps$rebout.sfemme == "Oui" | 
      (is.na(qtnps$rebout.autre.r)==FALSE & qtnps$rebout.autre.r == "ps.nmed"))
table(rebout.ps.nmed,useNA = "always")
# FALSE  TRUE  <NA> 
# 10468    10     0
round(prop.table(table(rebout.ps.nmed,useNA = "always")),3)*100
# FALSE  TRUE  <NA> 
#  99.9   0.1   0.0 

### Taux général de recours TA ps non med (Figure A4) ----
camp.ps.nmed <- acup.ps.nmed|chiro.ps.nmed|homeo.ps.nmed|magne.ps.nmed|osteo.ps.nmed|
  rebout.ps.nmed
table(camp.ps.nmed, useNA = "always")
# FALSE  TRUE  <NA> 
#  9077  1401     0 
round(prop.table(table(camp.ps.nmed)),3)*100
# FALSE  TRUE 
#  86.6  13.4

## Taux de recours aux différents TA non professionnels de santé ----

### Acupuncteur NPS
acup.tnps <- qtnps$acup == "Oui" &
  (qtnps$acup.med == "Non" 
    & qtnps$acup.chir.d == "Non" 
    & qtnps$acup.inf == "Non" 
    & qtnps$acup.kin == "Non" 
    & qtnps$acup.pharm == "Non" 
    & qtnps$acup.pod == "Non" 
    & qtnps$acup.sfemme == "Non") &
  (qtnps$acup.tnps == "Oui" |
      qtnps$acup.na == "Oui" |
      (is.na(qtnps$acup.autre) == FALSE &
          qtnps$acup.autre.r == "nps"))
table(acup.tnps, useNA = "always")
# FALSE  TRUE  <NA> 
# 10060   418     0 
round(prop.table(table(acup.tnps)),3)*100
# FALSE  TRUE 
#    96     4

### Chiropracteur non professionnel de santé
chiro.tnps <- qtnps$chiro == "Oui" &
  (qtnps$chiro.med == "Non" 
    & qtnps$chiro.chir.d == "Non" 
    & qtnps$chiro.inf == "Non" 
    & qtnps$chiro.kin == "Non" 
    & qtnps$chiro.pharm == "Non" 
    & qtnps$chiro.pod == "Non" 
    & qtnps$chiro.sfemme == "Non") &
  (qtnps$chiro.tnps == "Oui" |
      qtnps$chiro.na == "Oui" |
      (is.na(qtnps$chiro.autre) == FALSE &
          qtnps$chiro.autre.r == "nps"))                          
table(chiro.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10279   199     0 
round(prop.table(table(chiro.tnps)),3)*100
# FALSE  TRUE 
#  98.1   1.9 

### Homéopathe non professionnel de santé
homeo.tnps <- qtnps$homeo == "Oui" &
  (qtnps$homeo.med == "Non" 
    & qtnps$homeo.chir.d == "Non" 
    & qtnps$homeo.inf == "Non" 
    & qtnps$homeo.kin == "Non" 
    & qtnps$homeo.pharm == "Non" 
    & qtnps$homeo.pod == "Non" 
    & qtnps$homeo.sfemme == "Non") &
  (qtnps$homeo.tnps == "Oui" |
      qtnps$homeo.na == "Oui" |
      (is.na(qtnps$homeo.autre) == FALSE &
          qtnps$homeo.autre.r == "nps"))
table(homeo.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10342   136     0
round(prop.table(table(homeo.tnps)),3)*100
# FALSE  TRUE 
#  98.7   1.3 

### Magnétiseur NPS
magne.tnps <- qtnps$magne == "Oui" &
  (qtnps$magne.med == "Non" 
    & qtnps$magne.chir.d == "Non" 
    & qtnps$magne.inf == "Non" 
    & qtnps$magne.kin == "Non" 
    & qtnps$magne.pharm == "Non" 
    & qtnps$magne.pod == "Non" 
    & qtnps$magne.sfemme == "Non") &
  (qtnps$magne.tnps == "Oui" |
      qtnps$magne.na == "Oui" |
      (is.na(qtnps$magne.autre) == FALSE &
          qtnps$magne.autre.r == "nps"))
table(magne.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
#  9909   569     0
round(prop.table(table(magne.tnps)),3)*100
# FALSE  TRUE 
#  94.6   5.4 

### Ostéopathe NPS
osteo.tnps <- qtnps$osteo == "Oui" &
  (qtnps$osteo.med == "Non" 
    & qtnps$osteo.chir.d == "Non" 
    & qtnps$osteo.inf == "Non" 
    & qtnps$osteo.kin == "Non" 
    & qtnps$osteo.pharm == "Non" 
    & qtnps$osteo.pod == "Non" 
    & qtnps$osteo.sfemme == "Non") &
  (qtnps$osteo.tnps == "Oui" |
      qtnps$osteo.na == "Oui" |
      (is.na(qtnps$osteo.autre) == FALSE &
          qtnps$osteo.autre.r == "nps"))
table(osteo.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
#  7369  3109     0
round(prop.table(table(osteo.tnps)),3)*100
# FALSE  TRUE 
#  70.3  29.7 

### Rebouteux NPS
rebout.tnps <- qtnps$rebout == "Oui" &
  (qtnps$rebout.med == "Non" 
    & qtnps$rebout.chir.d == "Non" 
    & qtnps$rebout.inf == "Non" 
    & qtnps$rebout.kin == "Non" 
    & qtnps$rebout.pharm == "Non" 
    & qtnps$rebout.pod == "Non" 
    & qtnps$rebout.sfemme == "Non") &
  (qtnps$rebout.tnps == "Oui" |
      qtnps$rebout.na == "Oui" |
      (is.na(qtnps$rebout.autre) == FALSE &
          qtnps$rebout.autre.r == "nps"))
table(rebout.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10370   108     0
round(prop.table(table(rebout.tnps)),3)*100
# FALSE  TRUE 
#    99     1

## Taux général de recours aux TA-NPS (Figure A5) ----
tnps <- acup.tnps|chiro.tnps|homeo.tnps|magne.tnps|osteo.tnps|rebout.tnps
table(tnps,useNA = "always")
# FALSE  TRUE  <NA> 
#  6703  3775     0
round(prop.table(table(tnps)),3)*100
# FALSE  TRUE 
#    64    36

# Motifs de consultation (manipulations préalables) ----

## Harmonisation des niveaux
qtnps$acup.motif <- factor(qtnps$acup.motif, levels = c(
  levels(qtnps$homeo.motif)
))
qtnps$chiro.motif <- factor(qtnps$chiro.motif, levels = c(
  levels(qtnps$homeo.motif)
))
qtnps$magne.motif <- factor(qtnps$magne.motif, levels = c(
  levels(qtnps$homeo.motif)
))
qtnps$osteo.motif <- factor(qtnps$osteo.motif, levels = c(
  levels(qtnps$homeo.motif)
))
qtnps$rebout.motif <- factor(qtnps$rebout.motif, levels = c(
  levels(qtnps$homeo.motif)
))

## Correction de divers bugs liés au logiciel
qtnps$magne.motif.autre <- as.character(qtnps$magne.motif.autre)
qtnps$magne.motif.autre[6163] <- c(
  "Douleurs au ventre : adenomyose et effets secondaires pose Essures")
qtnps$magne.motif.autre <- as.factor(qtnps$magne.motif.autre)
qtnps$rebout.motif.autre <- as.character(qtnps$rebout.motif.autre)
qtnps$rebout.motif.autre[6163] <- c(
  "Douleurs au ventre : adenomyose et effets secondaires pose Essures")
qtnps$rebout.motif.autre <- as.factor(qtnps$rebout.motif.autre)
qtnps$osteo.motif.autre <- as.character(qtnps$osteo.motif.autre)
qtnps$osteo.motif.autre[3058] <- c("CYstites recidivantes")
qtnps$osteo.motif.autre <- as.factor(qtnps$osteo.motif.autre)
qtnps$magne.motif.autre <- as.character(qtnps$magne.motif.autre)
qtnps$magne.motif.autre[9287] <- c("Douleurs diffuses partout dans lecorps")
qtnps$magne.motif.autre <- as.factor(qtnps$magne.motif.autre)

qtnps[which(qtnps$osteo == "Oui" & 
    is.na(qtnps$osteo.motif)),"osteo.motif"] <- "Autre"
qtnps[which(qtnps$homeo == "Oui" & 
    is.na(qtnps$homeo.motif)),"homeo.motif"] <- "Autre"
qtnps[which(qtnps$magne == "Oui" & 
    is.na(qtnps$magne.motif)),"magne.motif"] <- "Autre"
qtnps[which(qtnps$rebout == "Oui" & 
    is.na(qtnps$rebout.motif)),"rebout.motif"] <- "Autre"
qtnps[which(qtnps$chiro == "Oui" & 
    is.na(qtnps$chiro.motif)),"chiro.motif"] <- "Autre"
qtnps[which(qtnps$acup == "Oui" & 
    is.na(qtnps$acup.motif)),"acup.motif"] <- "Autre"

qtnps[which(is.na(qtnps$osteo.motif.autre)==FALSE
  &qtnps$osteo.motif != "Autre"),"osteo.motif.autre"] <- NA
qtnps[which(is.na(qtnps$acup.motif.autre)==FALSE
  &qtnps$acup.motif != "Autre"),"acup.motif.autre"] <- NA
qtnps[which(is.na(qtnps$chiro.motif.autre)==FALSE
  &qtnps$chiro.motif != "Autre"),"chiro.motif.autre"] <- NA
qtnps[which(is.na(qtnps$homeo.motif.autre)==FALSE
  &qtnps$homeo.motif != "Autre"),"homeo.motif.autre"] <- NA
qtnps[which(is.na(qtnps$magne.motif.autre)==FALSE
  &qtnps$magne.motif != "Autre"),"magne.motif.autre"] <- NA
qtnps[which(is.na(qtnps$rebout.motif.autre)==FALSE
  &qtnps$rebout.motif != "Autre"),"rebout.motif.autre"] <- NA

qtnps$acup.motif.autre <- as.character(qtnps$acup.motif.autre)
qtnps$chiro.motif.autre <- as.character(qtnps$chiro.motif.autre)
qtnps$homeo.motif.autre <- as.character(qtnps$homeo.motif.autre)
qtnps$magne.motif.autre <- as.character(qtnps$magne.motif.autre)
qtnps$osteo.motif.autre <- as.character(qtnps$osteo.motif.autre)
qtnps$rebout.motif.autre <- as.character(qtnps$rebout.motif.autre)

qtnps[which(qtnps$acup.motif == "Autre" &
    is.na(qtnps$acup.motif.autre) == TRUE),"acup.motif.autre"] <- "Non renseigné"
qtnps[which(qtnps$chiro.motif == "Autre" &
    is.na(qtnps$chiro.motif.autre) == TRUE),"chiro.motif.autre"] <- "Non renseigné"
qtnps[which(qtnps$homeo.motif == "Autre" &
    is.na(qtnps$homeo.motif.autre) == TRUE),"homeo.motif.autre"] <- "Non renseigné"
qtnps[which(qtnps$magne.motif == "Autre" &
    is.na(qtnps$magne.motif.autre) == TRUE),"magne.motif.autre"] <- "Non renseigné"
qtnps[which(qtnps$osteo.motif == "Autre" &
    is.na(qtnps$osteo.motif.autre) == TRUE),"osteo.motif.autre"] <- "Non renseigné"
qtnps[which(qtnps$rebout.motif == "Autre" &
    is.na(qtnps$rebout.motif.autre) == TRUE),"rebout.motif.autre"] <- "Non renseigné"

## Prévalence de chaque motif de consultation (Figure X) ----
camp.motif <- table(qtnps$acup.motif)+
  table(qtnps$chiro.motif)+
  table(qtnps$homeo.motif)+
  table(qtnps$magne.motif)+
  table(qtnps$osteo.motif)+
  table(qtnps$rebout.motif)

camp.motif
#                                                      0 
#                                                   Autre 
#                                                    2018 
#                                               Bronchite 
#                                                      53 
#                                              Dépression 
#                                                      87 
#   Douleur à l'épaule, au coude, au poignet ou à la main 
#                                                     790 
# Douleur à la hanche, au genou, à la cheville ou au pied 
#                                                    1049 
#                                          Douleur au cou 
#                                                     498 
#                                          Douleur au dos 
#                                                    2514 
#                              Grippe ou syndrome grippal 
#                                                      51 
#                                            Mal de gorge 
#                                                      27 
#                                Maux de tête ou migraine 
#                                                     160 
#                                       Stress ou anxiété 
#                                                     467 
round(prop.table(camp.motif),3)*100
#                                                     0.0 
#                                                   Autre 
#                                                    26.2 
#                                               Bronchite 
#                                                     0.7 
#                                              Dépression 
#                                                     1.1 
#   Douleur à l'épaule, au coude, au poignet ou à la main 
#                                                    10.2 
# Douleur à la hanche, au genou, à la cheville ou au pied 
#                                                    13.6 
#                                          Douleur au cou 
#                                                     6.5 
#                                          Douleur au dos 
#                                                    32.6 
#                              Grippe ou syndrome grippal 
#                                                     0.7 
#                                            Mal de gorge 
#                                                     0.4 
#                                Maux de tête ou migraine 
#                                                     2.1 
#                                       Stress ou anxiété 
#                                                     6.1 

## Fouille de texte pour la catégorie « Autre, pouvez-vous préciser ? » ----
# Analyse basée sur le code et les manipulations présentées ici :
# http://www.sthda.com/french/wiki/text-mining-et-nuage-de-mots-avec-le-logiciel-r-5-
#etapes-simples-a-savoir (Attention, lien en deux morceaux).
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
filePath <- "chemin_a_specifier"
text <- readLines(filePath)
docs <- Corpus(VectorSource(text))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, c("NA","non","renseigné","sur","après","dans",
  "par","des","pour","mon","traitement","problèmes","depuis","avec","les","une",
  "pas","est","mes","aux","plus","fois","que","cest","chute","ans","plusieurs",
  "diverses","mois","faire"))
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 100)
# fibromyalgie     fibromyalgie  181
# douleurs             douleurs  176
# fatigue               fatigue  113
# chronique           chronique  101
# douleur               douleur   94
# général               général   61
# maladie               maladie   57
# dos                       dos   48
# suite                   suite   47
# suivi                   suivi   46
# prévention         prévention   41
# cancer                 cancer   36
# ventre                 ventre   35
# visite                 visite   35
# entretien           entretien   35
# sommeil               sommeil   33
# diffuses             diffuses   32
# médecin               médecin   32
# lyme                     lyme   30
# problème             problème   29
# accouchement     accouchement   25
# corps                   corps   24
# état                     état   24
# grossesse           grossesse   23
# post                     post   23
# allergie             allergie   22
# tout                     tout   22
# zona                     zona   21
# bilan                   bilan   20
# traitant             traitant   19
# cou                       cou   19
# syndrome             syndrome   19
# maux                     maux   18
# vertiges             vertiges   18
# stress                 stress   17
# chroniques         chroniques   17
# etat                     etat   17
# general               general   16
# musculaires       musculaires   16
# annuel                 annuel   16
# troubles             troubles   15
# mal                       mal   15
# générale             générale   15
# sciatique           sciatique   15
# ménopause           ménopause   14
# infection           infection   14
# santé                   santé   14
# partout               partout   14
# effets                 effets   14
# tendinite           tendinite   13
# chaleur               chaleur   13
# urinaire             urinaire   13
# contrôle             contrôle   13
# annuelle             annuelle   13
# généralisées     généralisées   13
# secondaires       secondaires   13
# digestion           digestion   12
# asthme                 asthme   12
# régulier             régulier   12
# sinusite             sinusite   12
# multiples           multiples   12
# allergies           allergies   11
# médecine             médecine   11
# digestifs           digestifs   11
# eczéma                 eczéma   11
# besoin                 besoin   10
# bouffées             bouffées   10
# prevention         prevention   10
# genou                   genou   10
# bassin                 bassin   10
# articulaires     articulaires   10
# généraliste       généraliste   10
# psoriasis           psoriasis   10
# fond                     fond   10
# chimiothérapie chimiothérapie    9
# globale               globale    9
# divers                 divers    9
# sein                     sein    9
# hanche                 hanche    9
# médical               médical    9
# accident             accident    9
# préventif           préventif    8
# énergétique       énergétique    8
# tabac                   tabac    8
# dépression         dépression    8
# cruralgie           cruralgie    8
# eczema                 eczema    8
# physique             physique    8
# remise                 remise    8
# rééquilibrage   rééquilibrage    8
# peau                     peau    8
# check                   check    8
# accompagnement accompagnement    7
# jambes                 jambes    7
# insomnie             insomnie    7
# hypertension     hypertension    7
# faire                   faire    7
# chimio                 chimio    7
# niveau                 niveau    7
# énergie               énergie    7

## Création de la catégorie « Polyalgies » ----
camp.motif.autre <- c(as.character(qtnps$acup.motif.autre),
  as.character(qtnps$chiro.motif.autre),
  as.character(qtnps$homeo.motif.autre),
  as.character(qtnps$magne.motif.autre),
  as.character(qtnps$osteo.motif.autre),
  as.character(qtnps$rebout.motif.autre))
camp.motif.autre[camp.motif.autre %in% 
    c("arthrose, cervicalgies, lombalgies, cruralgie, sciatique, migraines"
,"arthrose, rhizarthrose, cervicagies, fibromyalgie sciatalgie, cruralgie ....."
,"Aucune solution proposée par la médecine conventionnelle pour mes états d'épuisement 
et mes 
      couleurs ayant un effet "
,"diverses douleurs en lien avec la fibromyalgie"
,"Douleur chronique avec inflammation partout dans le corps "
,"douleur dans tout le corp","Douleur dans tout le corps "
,"Douleur doigts poignets coudes épaules cervicales colonne vertébrale genoux doigts 
      de pieds"
,"Douleur dos + douleur cervicales + maux de tete"
,"Douleur dos épaules bras mains cou","Douleur général ","douleur generale"
,"douleur generale et fatigue","douleur généralisée aïgue"
,"douleur partout","Douleur partout "
,"DOULEURS  GENERALISEES RESISTANTES  AUX ANTIDOULEURS"
,"Douleurs à toutes les articulations"
,"douleurs au dos, épaule, coude poignet, hanche, genou, cheville"
,"Douleurs chroniques de la fibromyalgie et dépression"
,"douleurs chroniques fibromyalgie","Douleurs chroniques fibromyalgie"
,"Douleurs chroniques globale","Douleurs cou, dos,  épaules et coudes "
,"Douleurs dans tout le corps","douleurs de partout - blocage cervicales, dos....."
,"Douleurs des muscles (jambes, chevilles, pieds, dos, bras etc etc)"
,"DOULEURS DIFFFUSES","Douleurs diffuse partout dans corp + la migraine "
,"douleurs diffuses","Douleurs diffuses","Douleurs Diffuses"
,"DOULEURS DIFFUSES","douleurs diffuses ","Douleurs diffuses "
,"douleurs diffuses - stress - fatigue - insomnies - "
,"douleurs diffuses chroniques (fibromyalgie)"
,"Douleurs diffuses chroniques de la fibromyalgie et dépression"
,"Douleurs diffuses chroniques insomniantes et épuisante simulant une fibromyalgie 
malheureusement ça
      a aggravé ma douleur"
,"douleurs diffuses dans tout le corps","douleurs diffuses de fibromyalgie"
,"Douleurs diffuses liées à une maladie chronique, anxiété et dépression "
,"Douleurs diffuses musculaires","Douleurs diffuses partout dans lecorps"
,"douleurs diffuses sur l'ensemble du corps","douleurs diffuses sur tout le corps"
,"douleurs diffuses- problèmes digestifs - insomnies - stress","douleurs digestives"
,"Douleurs digestives et basithoraciques et migraines"
,"Douleurs diverses dos jambes cou","douleurs dos, cheville, dépression"
,"douleurs du corp entier","Douleurs en général "
,"douleurs épaules, bras, hanches, cou, etc. tout à égalité","Douleurs fibromyalgie "
,"douleurs generales","douleurs generalisées","douleurs généralisées"
,"Douleurs génèralisées","douleurs généralisées ","Douleurs généralisées "
,"Douleurs généralisées ,os et muscles.","Douleurs généralisées à tout le corps "
,"Douleurs generalisees,osteoporose"
,"douleurs multilocalisées, fibromyalgie","Douleurs multiples liées à uné fibromyalgie"
,"Douleurs multiples liées au déplacement de nombreux os (10  points traités de la 
tête aux pieds).
      La maladie dont je souffre affaiblit les muscles qui ont du mal à maintenir le 
squelette en 
      place au moindre mouvement.","Douleurs musculaires intense et généralisées ",
      "Douleurs musculaires intense et généralisées (dos, mains, pieds, jambes, 
chevilles etc
      etc...) ","douleurs nomades généralisées",
      "douleurs ostéo-articulaire multiples en particulier cou et extrémités_À SIGNALER:
IL EST
      IMPOSSIBLE DE REMPLIR la ligne \"\"si plusieurs motifs...\"\" ","douleurs partout"
,"Douleurs partout","Douleurs partout "
,"Douleurs partout  tête dos bras pieds cuisses..."
,"Douleurs partout et fatigue chronique "
,"Douleurs sur l'ensemble des articulations (épaule,poignet, main,genou, cheville, pied)
+ douleur
      au cou et au dos"
,"douleurs sur tout le  corps: muscles, tendons, nerfs, os..."
,"Douleurs sur tout le corps","Douleurs tendineuses ds ts le corps"
,"Ego si fibromyalgie","Fatigue et douleurs diffusent"
,"fatigue générale et petites douleurs diffuses","fbromyalgie","FIBROMALGIE"
,"fibromialgie","Fibromialgie ","fibromyalgie","Fibromyalgie","FIBROMYALGIE"
,"fibromyalgie ","Fibromyalgie ","FIBROMYALGIE ","Fibromyalgie fond douleurs multiples"
,"Fibromyalgie, des douleurs dans tout le corps."
,"Fibromyalgie, sur conseil de la posturologue","Fibromylgie","fybromialgie"
,"Fybromialgie","FYBROMIALGIR","Fybromyalgie "
,"Migraine, douleur dos, épaules et cou")] <- "polyalgie"
a <- camp.motif.autre[which(is.na(camp.motif.autre) == FALSE 
  & camp.motif.autre != "polyalgie")]
camp.motif.autre[camp.motif.autre %in% a] <- "Autre"
table(camp.motif.autre,useNA = "always")
# camp.motif.autre
#     Autre polyalgie      <NA> 
#      1744       274     60850  
# Calcul du volume total de consultations
sum(camp.motif)
# [1] 7714 
# Taux de polyalgies comme motif de consultation ----
(274/7714)*100
# [1] 3.552

## Prévalence de chaque motif de consultation sans les ostéopathes ----
camp.motif.mo <- table(qtnps$acup.motif)+table(qtnps$chiro.motif)+
  table(qtnps$homeo.motif)+table(qtnps$magne.motif)+table(qtnps$rebout.motif)
camp.motif.mo
#                                                       0 
#                                                   Autre 
#                                                    1352 
#                                               Bronchite 
#                                                      48 
#                                              Dépression 
#                                                      72 
#   Douleur à l'épaule, au coude, au poignet ou à la main 
#                                                     254 
# Douleur à la hanche, au genou, à la cheville ou au pied 
#                                                     277 
#                                          Douleur au cou 
#                                                      91 
#                                          Douleur au dos 
#                                                     398 
#                              Grippe ou syndrome grippal 
#                                                      47 
#                                            Mal de gorge 
#                                                      26 
#                                Maux de tête ou migraine 
#                                                      78 
#                                       Stress ou anxiété 
#                                                     389 
round(prop.table(camp.motif.mo),3)*100
#                                                     0.0 
#                                                   Autre 
#                                                    44.6 
#                                               Bronchite 
#                                                     1.6 
#                                              Dépression 
#                                                     2.4 
#   Douleur à l'épaule, au coude, au poignet ou à la main 
#                                                     8.4 
# Douleur à la hanche, au genou, à la cheville ou au pied 
#                                                     9.1 
#                                          Douleur au cou 
#                                                     3.0 
#                                          Douleur au dos 
#                                                    13.1 
#                              Grippe ou syndrome grippal 
#                                                     1.6 
#                                            Mal de gorge 
#                                                     0.9 
#                                Maux de tête ou migraine 
#                                                     2.6 
#                                       Stress ou anxiété 
#                                                    12.8 

## Création de la catégorie « Polyalgies » (sans les ostéopathes) ----
camp.motif.autre.mo <- c(as.character(qtnps$acup.motif.autre),
  as.character(qtnps$chiro.motif.autre),
  as.character(qtnps$homeo.motif.autre),
  as.character(qtnps$magne.motif.autre),
  as.character(qtnps$rebout.motif.autre))
camp.motif.autre.mo[camp.motif.autre.mo %in% 
        c("arthrose, cervicalgies, lombalgies, cruralgie, sciatique, migraines"
,"arthrose, rhizarthrose, cervicagies, fibromyalgie sciatalgie, cruralgie ....."
,"Aucune solution proposée par la médecine conventionnelle pour mes états d'épuisement
et mes 
          couleurs ayant un effet "
,"diverses douleurs en lien avec la fibromyalgie"
,"Douleur chronique avec inflammation partout dans le corps "
,"douleur dans tout le corp","Douleur dans tout le corps "
,"Douleur doigts poignets coudes épaules cervicales colonne vertébrale genoux doigts de 
          pieds"
,"Douleur dos + douleur cervicales + maux de tete"
,"Douleur dos épaules bras mains cou","Douleur général ","douleur generale"
,"douleur generale et fatigue","douleur généralisée aïgue"
,"douleur partout","Douleur partout "
,"DOULEURS  GENERALISEES RESISTANTES  AUX ANTIDOULEURS"
,"Douleurs à toutes les articulations"
,"douleurs au dos, épaule, coude poignet, hanche, genou, cheville"
,"Douleurs chroniques de la fibromyalgie et dépression"
,"douleurs chroniques fibromyalgie","Douleurs chroniques fibromyalgie"
,"Douleurs chroniques globale","Douleurs cou, dos,  épaules et coudes "
,"Douleurs dans tout le corps","douleurs de partout - blocage cervicales, dos....."
,"Douleurs des muscles (jambes, chevilles, pieds, dos, bras etc etc)"
,"DOULEURS DIFFFUSES","Douleurs diffuse partout dans corp + la migraine "
,"douleurs diffuses","Douleurs diffuses","Douleurs Diffuses"
,"DOULEURS DIFFUSES","douleurs diffuses ","Douleurs diffuses "
,"douleurs diffuses - stress - fatigue - insomnies - "
,"douleurs diffuses chroniques (fibromyalgie)"
,"Douleurs diffuses chroniques de la fibromyalgie et dépression"
,"Douleurs diffuses chroniques insomniantes et épuisante simulant une fibromyalgie
malheureusement ça
          a aggravé ma douleur"
,"douleurs diffuses dans tout le corps","douleurs diffuses de fibromyalgie"
,"Douleurs diffuses liées à une maladie chronique, anxiété et dépression "
,"Douleurs diffuses musculaires","Douleurs diffuses partout dans lecorps"
,"douleurs diffuses sur l'ensemble du corps","douleurs diffuses sur tout le corps"
,"douleurs diffuses- problèmes digestifs - insomnies - stress","douleurs digestives"
,"Douleurs digestives et basithoraciques et migraines"
,"Douleurs diverses dos jambes cou","douleurs dos, cheville, dépression"
,"douleurs du corp entier","Douleurs en général "
,"douleurs épaules, bras, hanches, cou, etc. tout à égalité","Douleurs fibromyalgie "
,"douleurs generales","douleurs generalisées","douleurs généralisées"
,"Douleurs génèralisées","douleurs généralisées ","Douleurs généralisées "
,"Douleurs généralisées ,os et muscles.","Douleurs généralisées à tout le corps "
,"Douleurs generalisees,osteoporose"
,"douleurs multilocalisées, fibromyalgie","Douleurs multiples liées à uné fibromyalgie"
,"Douleurs multiples liées au déplacement de nombreux os (10  points traités de la tête
aux pieds). 
          La maladie dont je souffre affaiblit les muscles qui ont du mal à maintenir le
squelette 
          en place au moindre mouvement.","Douleurs musculaires intense et 
          généralisées ",
          "Douleurs musculaires intense et généralisées (dos, mains, pieds, jambes, 
chevilles etc 
          etc...) ","douleurs nomades généralisées","douleurs ostéo-articulaire 
multiples en 
          particulier cou et extrémités_À SIGNALER: IL EST IMPOSSIBLE DE REMPLIR la 
ligne \"\"si 
          plusieurs motifs...\"\" ","douleurs partout"
,"Douleurs partout","Douleurs partout "
,"Douleurs partout  tête dos bras pieds cuisses..."
,"Douleurs partout et fatigue chronique "
,"Douleurs sur l'ensemble des articulations (épaule,poignet, main,genou, cheville, 
pied) + 
          douleur au cou et au dos"
,"douleurs sur tout le  corps: muscles, tendons, nerfs, os..."
,"Douleurs sur tout le corps","Douleurs tendineuses ds ts le corps"
,"Ego si fibromyalgie","Fatigue et douleurs diffusent"
,"fatigue générale et petites douleurs diffuses","fbromyalgie","FIBROMALGIE"
,"fibromialgie","Fibromialgie ","fibromyalgie","Fibromyalgie","FIBROMYALGIE"
,"fibromyalgie ","Fibromyalgie ","FIBROMYALGIE ","Fibromyalgie fond douleurs multiples"
,"Fibromyalgie, des douleurs dans tout le corps."
,"Fibromyalgie, sur conseil de la posturologue","Fibromylgie","fybromialgie"
,"Fybromialgie","FYBROMIALGIR","Fybromyalgie "
,"Migraine, douleur dos, épaules et cou")] <- "polyalgie"

a <- camp.motif.autre.mo[which(is.na(camp.motif.autre.mo) == FALSE &
    camp.motif.autre.mo != "polyalgie")]
camp.motif.autre.mo[camp.motif.autre.mo %in% a] <- "Autre"
table(camp.motif.autre.mo,useNA = "always")
    # Autre polyalgie      <NA> 
    #  1180       172     51038    
# Calcul du volume total de consultations (sans les ostéopathes)
sum(camp.motif.mo)
# [1] 3032
# Taux de polyalgies comme motif de consultation (sans les ostéopathes)
(172/3032)*100
# [1] 5.672823

# Place du recours aux TA dans le parcours de soin des patients ----

## Manipulations préliminaires ----

### Recours à un TA pour un mal de dos

#### Acupuncteur pour un mal de dos
acup.dos <- qtnps$acup == "Oui" & qtnps$acup.motif == "Douleur au dos" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.dos,useNA = "always")

#### Médecin-acupuncteur pour un mal de dos
acup.med.dos <- (qtnps$acup == "Oui" & qtnps$acup.motif == "Douleur au dos") & 
  (qtnps$acup.med == "Oui" |
  (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))
table(acup.med.dos,useNA = "always")

#### Acupuncteur non médecin pour un mal de dos
acup.nmed.dos <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE) &
  qtnps$acup.motif == "Douleur au dos"
table(acup.nmed.dos,useNA = "always")

#### Acupuncteur PS non médecin pour un mal de dos
acup.ps.nmed.dos <- acup.ps.nmed == TRUE & qtnps$acup.motif == "Douleur au dos"
table(acup.ps.nmed.dos,useNA = "always")

#### Chiropracteur pour un mal de dos
chiro.dos <- qtnps$chiro == "Oui" & qtnps$chiro.motif == "Douleur au dos"
table(chiro.dos,useNA = "always")

#### Chiropracteur médecin pour un mal de dos
chiro.med.dos <- (qtnps$chiro == "Oui" & qtnps$chiro.motif == "Douleur au dos") & 
  (qtnps$chiro.med == "Oui" |
  (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))
table(chiro.med.dos,useNA = "always")

#### Chiropracteur non médecin pour un mal de dos
chiro.nmed.dos <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE) &
  qtnps$chiro.motif == "Douleur au dos"
table(chiro.nmed.dos,useNA = "always")

#### Chiropracteur PS non médecin pour un mal de dos
chiro.ps.nmed.dos <- chiro.ps.nmed == TRUE & qtnps$chiro.motif == "Douleur au dos"
table(chiro.ps.nmed.dos,useNA = "always")

#### Homéopathe pour un mal de dos
homeo.dos <- qtnps$homeo == "Oui" & qtnps$homeo.motif == "Douleur au dos" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.dos,useNA = "always")

#### Homéopathe médecin pour un mal de dos
homeo.med.dos <- (qtnps$homeo == "Oui" & qtnps$homeo.motif == "Douleur au dos") & 
  (qtnps$homeo.med == "Oui" |
  (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))
table(homeo.med.dos,useNA = "always")

#### Homéopathe non médecin pour un mal de dos
homeo.nmed.dos <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE) &
  qtnps$homeo.motif == "Douleur au dos" & is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.nmed.dos,useNA = "always")

#### Homéopathe PS non médecin pour un mal de dos
homeo.ps.nmed.dos <- homeo.ps.nmed == TRUE & qtnps$homeo.motif == "Douleur au dos"
table(homeo.ps.nmed.dos,useNA = "always")

##### Magnétiseur pour un mal de dos
magne.dos <- qtnps$magne == "Oui" & qtnps$magne.motif == "Douleur au dos" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.dos,useNA = "always")

#### Magnétiseur médecin pour un mal de dos
magne.med.dos <- (qtnps$magne == "Oui" & qtnps$magne.motif == "Douleur au dos") & 
  (qtnps$magne.med == "Oui" |
  (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))
table(magne.med.dos,useNA = "always")

#### Magnétiseur non médecin pour un mal de dos
magne.nmed.dos <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE) &
  qtnps$magne.motif == "Douleur au dos" & is.na(qtnps$magne.motif.autre) == TRUE
table(magne.nmed.dos,useNA = "always")

#### Magnétiseur PS non médecin pour un mal de dos
magne.ps.nmed.dos <- magne.ps.nmed == TRUE & qtnps$magne.motif == "Douleur au dos"
table(magne.ps.nmed.dos,useNA = "always")

#### Ostéopathe pour un mal de dos
osteo.dos <- qtnps$osteo == "Oui" & qtnps$osteo.motif == "Douleur au dos" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.dos,useNA = "always")

#### Ostéopathe médecin pour un mal de dos
osteo.med.dos <- (qtnps$osteo == "Oui" & qtnps$osteo.motif == "Douleur au dos") & 
  (qtnps$osteo.med == "Oui" |
  (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))
table(osteo.med.dos,useNA = "always")

#### Ostéopathe non médecin pour un mal de dos
osteo.nmed.dos <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE) &
  qtnps$osteo.motif == "Douleur au dos" & is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.nmed.dos,useNA = "always")

#### Ostéopathe PS non médecin pour un mal de dos
osteo.ps.nmed.dos <- osteo.ps.nmed == TRUE & qtnps$osteo.motif == "Douleur au dos" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.ps.nmed.dos,useNA = "always")

#### Rebouteux pour un mal de dos
rebout.dos <- qtnps$rebout == "Oui" & qtnps$rebout.motif == "Douleur au dos" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.dos,useNA = "always")

#### Rebouteux médecin pour un mal de dos
rebout.med.dos <- (qtnps$rebout == "Oui" & qtnps$rebout.motif == "Douleur au dos") & 
  (qtnps$rebout.med == "Oui" |
  (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin"))
table(rebout.med.dos,useNA = "always")

#### Rebouteux non médecin pour un mal de dos
rebout.nmed.dos <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE) &
  qtnps$rebout.motif == "Douleur au dos" & is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.nmed.dos,useNA = "always")

#### Rebouteux PS non médecin pour un mal de dos
rebout.ps.nmed.dos <- rebout.ps.nmed == TRUE & qtnps$rebout.motif == "Douleur au dos" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.ps.nmed.dos,useNA = "always")

#### TA pour un mal de dos ----
camp.dos <- acup.dos|chiro.dos|homeo.dos|magne.dos|osteo.dos|rebout.dos
table(camp.dos,useNA = "always")

#### TA médecin pour un mal de dos ----
camp.med.dos <- acup.med.dos|chiro.med.dos|homeo.med.dos|magne.med.dos|
  osteo.med.dos|rebout.med.dos
table(camp.med.dos,useNA = "always")

#### TA non médecin pour un mal de dos ----
camp.nmed.dos <- acup.nmed.dos|chiro.nmed.dos|homeo.nmed.dos|
  magne.nmed.dos|osteo.nmed.dos|rebout.nmed.dos
table(camp.nmed.dos,useNA = "always")

#### TA-PS non médecin pour un mal de dos ----
camp.ps.nmed.dos <- acup.ps.nmed.dos|chiro.ps.nmed.dos|
  homeo.ps.nmed.dos|magne.ps.nmed.dos|rebout.ps.nmed.dos
table(camp.ps.nmed.dos, useNA = "always")

### Recours à un TA pour une bronchite

#### Acupuncteur pour une bronchite
acup.bronchite <- qtnps$acup == "Oui" & qtnps$acup.motif == "Bronchite" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.bronchite,useNA = "always")

#### Médecin-acupuncteur pour une bronchite
acup.med.bronchite <- (qtnps$acup == "Oui" & qtnps$acup.motif == "Bronchite") & 
  (qtnps$acup.med == "Oui" |
  (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))
table(acup.med.bronchite,useNA = "always")

#### Acupuncteur non médecin pour une bronchite
acup.nmed.bronchite <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE) &
  qtnps$acup.motif == "Bronchite"
table(acup.nmed.bronchite,useNA = "always")

#### Acupuncteur PS non médecin pour une bronchite
acup.ps.nmed.bronchite <- acup.ps.nmed == TRUE & qtnps$acup.motif == "Bronchite"
table(acup.ps.nmed.bronchite,useNA = "always")

#### Chiropracteur pour une bronchite
chiro.bronchite <- qtnps$chiro == "Oui" & qtnps$chiro.motif == "Bronchite"
table(chiro.bronchite,useNA = "always")

#### Chiropracteur médecin pour une bronchite
chiro.med.bronchite <- (qtnps$chiro == "Oui" & qtnps$chiro.motif == "Bronchite") & 
  (qtnps$chiro.med == "Oui" |
  (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))
table(chiro.med.bronchite,useNA = "always")

#### Chiropracteur non médecin pour une bronchite
chiro.nmed.bronchite <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE) &
  qtnps$chiro.motif == "Bronchite"
table(chiro.nmed.bronchite,useNA = "always")

#### Chiropracteur PS non médecin pour une bronchite
chiro.ps.nmed.bronchite <- chiro.ps.nmed == TRUE & qtnps$chiro.motif == "Bronchite"
table(chiro.ps.nmed.bronchite,useNA = "always")

#### Homéopathe pour une bronchite
homeo.bronchite <- qtnps$homeo == "Oui" & qtnps$homeo.motif == "Bronchite" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.bronchite,useNA = "always")

#### Homéopathe médecin pour une bronchite
homeo.med.bronchite <- (qtnps$homeo == "Oui" & qtnps$homeo.motif == "Bronchite") & 
  (qtnps$homeo.med == "Oui" |
  (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))
table(homeo.med.bronchite,useNA = "always")

#### Homéopathe non médecin pour une bronchite
homeo.nmed.bronchite <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE) &
  qtnps$homeo.motif == "Bronchite" & is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.nmed.bronchite,useNA = "always")

#### Homéopathe PS non médecin pour une bronchite
homeo.ps.nmed.bronchite <- homeo.ps.nmed == TRUE & qtnps$homeo.motif == "Bronchite"
table(homeo.ps.nmed.bronchite,useNA = "always")

##### Magnétiseur pour une bronchite
magne.bronchite <- qtnps$magne == "Oui" & qtnps$magne.motif == "Bronchite" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.bronchite,useNA = "always")

#### Magnétiseur médecin pour une bronchite
magne.med.bronchite <- (qtnps$magne == "Oui" & qtnps$magne.motif == "Bronchite") & 
  (qtnps$magne.med == "Oui" |
  (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))
table(magne.med.bronchite,useNA = "always")

#### Magnétiseur non médecin pour une bronchite
magne.nmed.bronchite <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE) &
  qtnps$magne.motif == "Bronchite" & is.na(qtnps$magne.motif.autre) == TRUE
table(magne.nmed.bronchite,useNA = "always")

#### Magnétiseur PS non médecin pour une bronchite
magne.ps.nmed.bronchite <- magne.ps.nmed == TRUE & qtnps$magne.motif == "Bronchite"
table(magne.ps.nmed.bronchite,useNA = "always")

#### Ostéopathe pour une bronchite
osteo.bronchite <- qtnps$osteo == "Oui" & qtnps$osteo.motif == "Bronchite" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.bronchite,useNA = "always")

#### Ostéopathe médecin pour une bronchite
osteo.med.bronchite <- (qtnps$osteo == "Oui" & qtnps$osteo.motif == "Bronchite") & 
  (qtnps$osteo.med == "Oui" |
  (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))
table(osteo.med.bronchite,useNA = "always")

#### Ostéopathe non médecin pour une bronchite
osteo.nmed.bronchite <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE) &
  qtnps$osteo.motif == "Bronchite" & is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.nmed.bronchite,useNA = "always")

#### Ostéopathe PS non médecin pour une bronchite
osteo.ps.nmed.bronchite <- osteo.ps.nmed == TRUE & qtnps$osteo.motif == "Bronchite" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.ps.nmed.bronchite,useNA = "always")

#### Rebouteux pour une bronchite
rebout.bronchite <- qtnps$rebout == "Oui" & qtnps$rebout.motif == "Bronchite" & 
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.bronchite,useNA = "always")

#### Rebouteux médecin pour une bronchite
rebout.med.bronchite <- (qtnps$rebout == "Oui" & qtnps$rebout.motif == "Bronchite") & 
  (qtnps$rebout.med == "Oui" |
  (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin"))
table(rebout.med.bronchite,useNA = "always")

#### Rebouteux non médecin pour une bronchite
rebout.nmed.bronchite <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE) &
  qtnps$rebout.motif == "Bronchite" & is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.nmed.bronchite,useNA = "always")

#### Rebouteux PS non médecin pour une bronchite
rebout.ps.nmed.bronchite <- rebout.ps.nmed == TRUE &
  qtnps$rebout.motif == "Bronchite" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.ps.nmed.bronchite,useNA = "always")

#### TA pour une bronchite ----
camp.bronchite <- acup.bronchite|chiro.bronchite|homeo.bronchite|magne.bronchite|
  osteo.bronchite|rebout.bronchite
table(camp.bronchite,useNA = "always")

#### TA médecin pour une bronchite ----
camp.med.bronchite <- acup.med.bronchite|chiro.med.bronchite|homeo.med.bronchite|
  magne.med.bronchite|
  osteo.med.bronchite|rebout.med.bronchite
table(camp.med.bronchite,useNA = "always")

#### TA non médecin pour une bronchite ----
camp.nmed.bronchite <- acup.nmed.bronchite|chiro.nmed.bronchite|homeo.nmed.bronchite|
  magne.nmed.bronchite|osteo.nmed.bronchite|rebout.nmed.bronchite
table(camp.nmed.bronchite,useNA = "always")

#### TA-PS non médecin pour une bronchite ----
camp.ps.nmed.bronchite <- acup.ps.nmed.bronchite|chiro.ps.nmed.bronchite|
  homeo.ps.nmed.bronchite|magne.ps.nmed.bronchite|rebout.ps.nmed.bronchite
table(camp.ps.nmed.bronchite, useNA = "always")

### Recours à un TA pour une dépression

#### Acupuncteur pour une dépression
acup.depression <- qtnps$acup == "Oui" & qtnps$acup.motif == "Dépression" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.depression,useNA = "always")

#### Médecin-acupuncteur pour une dépression
acup.med.depression <- (qtnps$acup == "Oui" & qtnps$acup.motif == "Dépression") & 
  (qtnps$acup.med == "Oui" |
  (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))
table(acup.med.depression,useNA = "always")

#### Acupuncteur non médecin pour une dépression
acup.nmed.depression <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE) &
  qtnps$acup.motif == "Dépression"
table(acup.nmed.depression,useNA = "always")

#### Acupuncteur PS non médecin pour une dépression
acup.ps.nmed.depression <- acup.ps.nmed == TRUE & qtnps$acup.motif == "Dépression"
table(acup.ps.nmed.depression,useNA = "always")

#### Chiropracteur pour une dépression
chiro.depression <- qtnps$chiro == "Oui" & qtnps$chiro.motif == "Dépression"
table(chiro.depression,useNA = "always")

#### Chiropracteur médecin pour une dépression
chiro.med.depression <- (qtnps$chiro == "Oui" & qtnps$chiro.motif == "Dépression") & 
  (qtnps$chiro.med == "Oui" |
  (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))
table(chiro.med.depression,useNA = "always")

#### Chiropracteur non médecin pour une dépression
chiro.nmed.depression <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE) &
  qtnps$chiro.motif == "Dépression"
table(chiro.nmed.depression,useNA = "always")

#### Chiropracteur PS non médecin pour une dépression
chiro.ps.nmed.depression <- chiro.ps.nmed == TRUE & qtnps$chiro.motif == "Dépression"
table(chiro.ps.nmed.depression,useNA = "always")

#### Homéopathe pour une dépression
homeo.depression <- qtnps$homeo == "Oui" & qtnps$homeo.motif == "Dépression" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.depression,useNA = "always")

#### Homéopathe médecin pour une dépression
homeo.med.depression <- (qtnps$homeo == "Oui" & qtnps$homeo.motif == "Dépression") & 
  (qtnps$homeo.med == "Oui" |
  (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))
table(homeo.med.depression,useNA = "always")

#### Homéopathe non médecin pour une dépression
homeo.nmed.depression <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE) &
  qtnps$homeo.motif == "Dépression" & is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.nmed.depression,useNA = "always")

#### Homéopathe PS non médecin pour une dépression
homeo.ps.nmed.depression <- homeo.ps.nmed == TRUE & qtnps$homeo.motif == "Dépression"
table(homeo.ps.nmed.depression,useNA = "always")

##### Magnétiseur pour une dépression
magne.depression <- qtnps$magne == "Oui" & qtnps$magne.motif == "Dépression" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.depression,useNA = "always")

#### Magnétiseur médecin pour une dépression
magne.med.depression <- (qtnps$magne == "Oui" & qtnps$magne.motif == "Dépression") & 
  (qtnps$magne.med == "Oui" |
  (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))
table(magne.med.depression,useNA = "always")

#### Magnétiseur non médecin pour une dépression
magne.nmed.depression <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE) &
  qtnps$magne.motif == "Dépression" & is.na(qtnps$magne.motif.autre) == TRUE
table(magne.nmed.depression,useNA = "always")

#### Magnétiseur PS non médecin pour une dépression
magne.ps.nmed.depression <- magne.ps.nmed == TRUE & qtnps$magne.motif == "Dépression"
table(magne.ps.nmed.depression,useNA = "always")

#### Ostéopathe pour une dépression
osteo.depression <- qtnps$osteo == "Oui" & qtnps$osteo.motif == "Dépression" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.depression,useNA = "always")

#### Ostéopathe médecin pour une dépression
osteo.med.depression <- (qtnps$osteo == "Oui" & qtnps$osteo.motif == "Dépression") & 
  (qtnps$osteo.med == "Oui" |
  (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))
table(osteo.med.depression,useNA = "always")

#### Ostéopathe non médecin pour une dépression
osteo.nmed.depression <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE) &
  qtnps$osteo.motif == "Dépression" & is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.nmed.depression,useNA = "always")

#### Ostéopathe PS non médecin pour une dépression
osteo.ps.nmed.depression <- osteo.ps.nmed == TRUE & qtnps$osteo.motif == "Dépression" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.ps.nmed.depression,useNA = "always")

#### Rebouteux pour une dépression
rebout.depression <- qtnps$rebout == "Oui" & qtnps$rebout.motif == "Dépression" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.depression,useNA = "always")

#### Rebouteux médecin pour une dépression
rebout.med.depression <- (qtnps$rebout == "Oui" & qtnps$rebout.motif == "Dépression") & 
  (qtnps$rebout.med == "Oui" |
  (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin"))
table(rebout.med.depression,useNA = "always")

#### Rebouteux non médecin pour une dépression
rebout.nmed.depression <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE) &
  qtnps$rebout.motif == "Dépression" & is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.nmed.depression,useNA = "always")

#### Rebouteux PS non médecin pour une dépression
rebout.ps.nmed.depression <- rebout.ps.nmed == TRUE &
  qtnps$rebout.motif == "Dépression" & is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.ps.nmed.depression,useNA = "always")

#### TA pour une dépression ----
camp.depression <- acup.depression|chiro.depression|homeo.depression|magne.depression|
  osteo.depression|rebout.depression
table(camp.depression,useNA = "always")

#### TA médecin pour une dépression ----
camp.med.depression <- acup.med.depression|chiro.med.depression|homeo.med.depression|
  magne.med.depression|
  osteo.med.depression|rebout.med.depression
table(camp.med.depression,useNA = "always")

#### TA non médecin pour une dépression ----
camp.nmed.depression <- acup.nmed.depression|chiro.nmed.depression|
  homeo.nmed.depression|
  magne.nmed.depression|osteo.nmed.depression|rebout.nmed.depression
table(camp.nmed.depression,useNA = "always")

#### TA-PS non médecin pour une dépression ----
camp.ps.nmed.depression <- acup.ps.nmed.depression|chiro.ps.nmed.depression|
  homeo.ps.nmed.depression|magne.ps.nmed.depression|rebout.ps.nmed.depression
table(camp.ps.nmed.depression, useNA = "always")

### Recours à un TA pour une grippe ou un syndrome grippal

#### Acupuncteur pour une grippe ou un syndrome grippal
acup.grippe <- qtnps$acup == "Oui" &
  qtnps$acup.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.grippe,useNA = "always")

#### Médecin-acupuncteur pour une grippe ou un syndrome grippal
acup.med.grippe <- (qtnps$acup == "Oui" &
    qtnps$acup.motif == "Grippe ou syndrome grippal") & 
  (qtnps$acup.med == "Oui" |
  (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))
table(acup.med.grippe,useNA = "always")

#### Acupuncteur non médecin pour une grippe ou un syndrome grippal
acup.nmed.grippe <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE) &
  qtnps$acup.motif == "Grippe ou syndrome grippal"
table(acup.nmed.grippe,useNA = "always")

#### Acupuncteur PS non médecin pour une grippe ou un syndrome grippal
acup.ps.nmed.grippe <- acup.ps.nmed == TRUE &
  qtnps$acup.motif == "Grippe ou syndrome grippal"
table(acup.ps.nmed.grippe,useNA = "always")

#### Chiropracteur pour une grippe ou un syndrome grippal
chiro.grippe <- qtnps$chiro == "Oui" &
  qtnps$chiro.motif == "Grippe ou syndrome grippal"
table(chiro.grippe,useNA = "always")

#### Chiropracteur médecin pour une grippe ou un syndrome grippal
chiro.med.grippe <- (qtnps$chiro == "Oui" &
    qtnps$chiro.motif == "Grippe ou syndrome grippal") & 
  (qtnps$chiro.med == "Oui" |
  (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))
table(chiro.med.grippe,useNA = "always")

#### Chiropracteur non médecin pour une grippe ou un syndrome grippal
chiro.nmed.grippe <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE) &
  qtnps$chiro.motif == "Grippe ou syndrome grippal"
table(chiro.nmed.grippe,useNA = "always")

#### Chiropracteur PS non médecin pour une grippe ou un syndrome grippal
chiro.ps.nmed.grippe <- chiro.ps.nmed == TRUE &
  qtnps$chiro.motif == "Grippe ou syndrome grippal"
table(chiro.ps.nmed.grippe,useNA = "always")

#### Homéopathe pour une grippe ou un syndrome grippal
homeo.grippe <- qtnps$homeo == "Oui" &
  qtnps$homeo.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.grippe,useNA = "always")

#### Homéopathe médecin pour une grippe ou un syndrome grippal
homeo.med.grippe <- (qtnps$homeo == "Oui" &
    qtnps$homeo.motif == "Grippe ou syndrome grippal") & 
  (qtnps$homeo.med == "Oui" |
  (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))
table(homeo.med.grippe,useNA = "always")

#### Homéopathe non médecin pour une grippe ou un syndrome grippal
homeo.nmed.grippe <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE) &
  qtnps$homeo.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.nmed.grippe,useNA = "always")

#### Homéopathe PS non médecin pour une grippe ou un syndrome grippal
homeo.ps.nmed.grippe <- homeo.ps.nmed == TRUE &
  qtnps$homeo.motif == "Grippe ou syndrome grippal"
table(homeo.ps.nmed.grippe,useNA = "always")

##### Magnétiseur pour une grippe ou un syndrome grippal
magne.grippe <- qtnps$magne == "Oui" &
  qtnps$magne.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.grippe,useNA = "always")

#### Magnétiseur médecin pour une grippe ou un syndrome grippal
magne.med.grippe <- (qtnps$magne == "Oui" &
    qtnps$magne.motif == "Grippe ou syndrome grippal") & 
  (qtnps$magne.med == "Oui" |
  (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))
table(magne.med.grippe,useNA = "always")

#### Magnétiseur non médecin pour une grippe ou un syndrome grippal
magne.nmed.grippe <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE) &
  qtnps$magne.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.nmed.grippe,useNA = "always")

#### Magnétiseur PS non médecin pour une grippe ou un syndrome grippal
magne.ps.nmed.grippe <- magne.ps.nmed == TRUE &
  qtnps$magne.motif == "Grippe ou syndrome grippal"
table(magne.ps.nmed.grippe,useNA = "always")

#### Ostéopathe pour une grippe ou un syndrome grippal
osteo.grippe <- qtnps$osteo == "Oui" &
  qtnps$osteo.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.grippe,useNA = "always")

#### Ostéopathe médecin pour une grippe ou un syndrome grippal
osteo.med.grippe <- (qtnps$osteo == "Oui" &
    qtnps$osteo.motif == "Grippe ou syndrome grippal") & 
  (qtnps$osteo.med == "Oui" |
  (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))
table(osteo.med.grippe,useNA = "always")

#### Ostéopathe non médecin pour une grippe ou un syndrome grippal
osteo.nmed.grippe <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE) &
  qtnps$osteo.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.nmed.grippe,useNA = "always")

#### Ostéopathe PS non médecin pour une grippe ou un syndrome grippal
osteo.ps.nmed.grippe <- osteo.ps.nmed == TRUE &
  qtnps$osteo.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.ps.nmed.grippe,useNA = "always")

#### Rebouteux pour une grippe ou un syndrome grippal
rebout.grippe <- qtnps$rebout == "Oui" &
  qtnps$rebout.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.grippe,useNA = "always")

#### Rebouteux médecin pour une grippe ou un syndrome grippal
rebout.med.grippe <- (qtnps$rebout == "Oui" &
    qtnps$rebout.motif == "Grippe ou syndrome grippal") & 
  (qtnps$rebout.med == "Oui" |
  (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin"))
table(rebout.med.grippe,useNA = "always")

#### Rebouteux non médecin pour une grippe ou un syndrome grippal
rebout.nmed.grippe <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE) &
  qtnps$rebout.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.nmed.grippe,useNA = "always")

#### Rebouteux PS non médecin pour une grippe ou un syndrome grippal
rebout.ps.nmed.grippe <- rebout.ps.nmed == TRUE &
  qtnps$rebout.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.ps.nmed.grippe,useNA = "always")

#### TA pour une grippe ou un syndrome grippal ----
camp.grippe <- acup.grippe|chiro.grippe|homeo.grippe|magne.grippe|osteo.grippe|
  rebout.grippe
table(camp.grippe,useNA = "always")

#### TA médecin pour une grippe ou un syndrome grippal ----
camp.med.grippe <- acup.med.grippe|chiro.med.grippe|homeo.med.grippe|magne.med.grippe|
  osteo.med.grippe|rebout.med.grippe
table(camp.med.grippe,useNA = "always")

#### TA non médecin pour une grippe ou un syndrome grippal ----
camp.nmed.grippe <- acup.nmed.grippe|chiro.nmed.grippe|homeo.nmed.grippe|
  magne.nmed.grippe|osteo.nmed.grippe|rebout.nmed.grippe
table(camp.nmed.grippe,useNA = "always")

#### TA-PS non médecin pour une grippe ou un syndrome grippal ----
camp.ps.nmed.grippe <- acup.ps.nmed.grippe|chiro.ps.nmed.grippe|
  homeo.ps.nmed.grippe|magne.ps.nmed.grippe|rebout.ps.nmed.grippe
table(camp.ps.nmed.grippe, useNA = "always")

### Recours à un TA pour un mal de gorge

#### Acupuncteur pour un mal de gorge
acup.gorge <- qtnps$acup == "Oui" & qtnps$acup.motif == "Mal de gorge" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.gorge,useNA = "always")

#### Médecin-acupuncteur pour un mal de gorge
acup.med.gorge <- (qtnps$acup == "Oui" & qtnps$acup.motif == "Mal de gorge") & 
  (qtnps$acup.med == "Oui" |
  (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))
table(acup.med.gorge,useNA = "always")

#### Acupuncteur non médecin pour un mal de gorge
acup.nmed.gorge <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE) &
  qtnps$acup.motif == "Mal de gorge"
table(acup.nmed.gorge,useNA = "always")

#### Acupuncteur PS non médecin pour un mal de gorge
acup.ps.nmed.gorge <- acup.ps.nmed == TRUE & qtnps$acup.motif == "Mal de gorge"
table(acup.ps.nmed.gorge,useNA = "always")

#### Chiropracteur pour un mal de gorge
chiro.gorge <- qtnps$chiro == "Oui" & qtnps$chiro.motif == "Mal de gorge"
table(chiro.gorge,useNA = "always")

#### Chiropracteur médecin pour un mal de gorge
chiro.med.gorge <- (qtnps$chiro == "Oui" & qtnps$chiro.motif == "Mal de gorge") & 
  (qtnps$chiro.med == "Oui" |
  (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))
table(chiro.med.gorge,useNA = "always")

#### Chiropracteur non médecin pour un mal de gorge
chiro.nmed.gorge <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE) &
  qtnps$chiro.motif == "Mal de gorge"
table(chiro.nmed.gorge,useNA = "always")

#### Chiropracteur PS non médecin pour un mal de gorge
chiro.ps.nmed.gorge <- chiro.ps.nmed == TRUE & qtnps$chiro.motif == "Mal de gorge"
table(chiro.ps.nmed.gorge,useNA = "always")

#### Homéopathe pour un mal de gorge
homeo.gorge <- qtnps$homeo == "Oui" & qtnps$homeo.motif == "Mal de gorge" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.gorge,useNA = "always")

#### Homéopathe médecin pour un mal de gorge
homeo.med.gorge <- (qtnps$homeo == "Oui" & qtnps$homeo.motif == "Mal de gorge") & 
  (qtnps$homeo.med == "Oui" |
  (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))
table(homeo.med.gorge,useNA = "always")

#### Homéopathe non médecin pour un mal de gorge
homeo.nmed.gorge <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE) &
  qtnps$homeo.motif == "Mal de gorge" & is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.nmed.gorge,useNA = "always")

#### Homéopathe PS non médecin pour un mal de gorge
homeo.ps.nmed.gorge <- homeo.ps.nmed == TRUE & qtnps$homeo.motif == "Mal de gorge"
table(homeo.ps.nmed.gorge,useNA = "always")

##### Magnétiseur pour un mal de gorge
magne.gorge <- qtnps$magne == "Oui" & qtnps$magne.motif == "Mal de gorge" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.gorge,useNA = "always")

#### Magnétiseur médecin pour un mal de gorge
magne.med.gorge <- (qtnps$magne == "Oui" & qtnps$magne.motif == "Mal de gorge") & 
  (qtnps$magne.med == "Oui" |
  (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))
table(magne.med.gorge,useNA = "always")

#### Magnétiseur non médecin pour un mal de gorge
magne.nmed.gorge <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE) &
  qtnps$magne.motif == "Mal de gorge" & is.na(qtnps$magne.motif.autre) == TRUE
table(magne.nmed.gorge,useNA = "always")

#### Magnétiseur PS non médecin pour un mal de gorge
magne.ps.nmed.gorge <- magne.ps.nmed == TRUE & qtnps$magne.motif == "Mal de gorge"
table(magne.ps.nmed.gorge,useNA = "always")

#### Ostéopathe pour un mal de gorge
osteo.gorge <- qtnps$osteo == "Oui" & qtnps$osteo.motif == "Mal de gorge" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.gorge,useNA = "always")

#### Ostéopathe médecin pour un mal de gorge
osteo.med.gorge <- (qtnps$osteo == "Oui" & qtnps$osteo.motif == "Mal de gorge") & 
  (qtnps$osteo.med == "Oui" |
  (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))
table(osteo.med.gorge,useNA = "always")

#### Ostéopathe non médecin pour un mal de gorge
osteo.nmed.gorge <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE) &
  qtnps$osteo.motif == "Mal de gorge" & is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.nmed.gorge,useNA = "always")

#### Ostéopathe PS non médecin pour un mal de gorge
osteo.ps.nmed.gorge <- osteo.ps.nmed == TRUE & qtnps$osteo.motif == "Mal de gorge" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.ps.nmed.gorge,useNA = "always")

#### Rebouteux pour un mal de gorge
rebout.gorge <- qtnps$rebout == "Oui" & qtnps$rebout.motif == "Mal de gorge" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.gorge,useNA = "always")

#### Rebouteux médecin pour un mal de gorge
rebout.med.gorge <- (qtnps$rebout == "Oui" & qtnps$rebout.motif == "Mal de gorge") & 
  (qtnps$rebout.med == "Oui" |
  (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin"))
table(rebout.med.gorge,useNA = "always")

#### Rebouteux non médecin pour un mal de gorge
rebout.nmed.gorge <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE) &
  qtnps$rebout.motif == "Mal de gorge" & is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.nmed.gorge,useNA = "always")

#### Rebouteux PS non médecin pour un mal de gorge
rebout.ps.nmed.gorge <- rebout.ps.nmed == TRUE & qtnps$rebout.motif == "Mal de gorge" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.ps.nmed.gorge,useNA = "always")

#### TA pour un mal de gorge ----
camp.gorge <- acup.gorge|chiro.gorge|homeo.gorge|magne.gorge|osteo.gorge|rebout.gorge
table(camp.gorge,useNA = "always")

#### TA médecin pour un mal de gorge ----
camp.med.gorge <- acup.med.gorge|chiro.med.gorge|homeo.med.gorge|magne.med.gorge|
  osteo.med.gorge|rebout.med.gorge
table(camp.med.gorge,useNA = "always")

#### TA non médecin pour un mal de gorge ----
camp.nmed.gorge <- acup.nmed.gorge|chiro.nmed.gorge|homeo.nmed.gorge|
  magne.nmed.gorge|osteo.nmed.gorge|rebout.nmed.gorge
table(camp.nmed.gorge,useNA = "always")

#### TA-PS non médecin pour un mal de gorge ----
camp.ps.nmed.gorge <- acup.ps.nmed.gorge|chiro.ps.nmed.gorge|
  homeo.ps.nmed.gorge|magne.ps.nmed.gorge|rebout.ps.nmed.gorge
table(camp.ps.nmed.gorge, useNA = "always")

### Recours à un TA pour des maux de tête ou migraines

#### Acupuncteur pour des maux de tête ou migraines
acup.migraine <- qtnps$acup == "Oui" & qtnps$acup.motif == "Maux de tête ou migraine" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.migraine,useNA = "always")

#### Médecin-acupuncteur pour des maux de tête ou migraines
acup.med.migraine <- (qtnps$acup == "Oui" &
    qtnps$acup.motif == "Maux de tête ou migraine") & 
  (qtnps$acup.med == "Oui" |
  (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))
table(acup.med.migraine,useNA = "always")

#### Acupuncteur non médecin pour des maux de tête ou migraines
acup.nmed.migraine <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE) &
  qtnps$acup.motif == "Maux de tête ou migraine"
table(acup.nmed.migraine,useNA = "always")

#### Acupuncteur PS non médecin pour des maux de tête ou migraines
acup.ps.nmed.migraine <- acup.ps.nmed == TRUE &
  qtnps$acup.motif == "Maux de tête ou migraine"
table(acup.ps.nmed.migraine,useNA = "always")

#### Chiropracteur pour des maux de tête ou migraines
chiro.migraine <- qtnps$chiro == "Oui" &
  qtnps$chiro.motif == "Maux de tête ou migraine"
table(chiro.migraine,useNA = "always")

#### Chiropracteur médecin pour des maux de tête ou migraines
chiro.med.migraine <- (qtnps$chiro == "Oui" &
    qtnps$chiro.motif == "Maux de tête ou migraine") & 
  (qtnps$chiro.med == "Oui" |
  (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))
table(chiro.med.migraine,useNA = "always")

#### Chiropracteur non médecin pour des maux de tête ou migraines
chiro.nmed.migraine <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE) &
  qtnps$chiro.motif == "Maux de tête ou migraine"
table(chiro.nmed.migraine,useNA = "always")

#### Chiropracteur PS non médecin pour des maux de tête ou migraines
chiro.ps.nmed.migraine <- chiro.ps.nmed == TRUE &
  qtnps$chiro.motif == "Maux de tête ou migraine"
table(chiro.ps.nmed.migraine,useNA = "always")

#### Homéopathe pour des maux de tête ou migraines
homeo.migraine <- qtnps$homeo == "Oui" &
  qtnps$homeo.motif == "Maux de tête ou migraine" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.migraine,useNA = "always")

#### Homéopathe médecin pour des maux de tête ou migraines
homeo.med.migraine <- (qtnps$homeo == "Oui" &
    qtnps$homeo.motif == "Maux de tête ou migraine") & 
  (qtnps$homeo.med == "Oui" |
  (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))
table(homeo.med.migraine,useNA = "always")

#### Homéopathe non médecin pour des maux de tête ou migraines
homeo.nmed.migraine <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE) &
  qtnps$homeo.motif == "Maux de tête ou migraine" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.nmed.migraine,useNA = "always")

#### Homéopathe PS non médecin pour des maux de tête ou migraines
homeo.ps.nmed.migraine <- homeo.ps.nmed == TRUE &
  qtnps$homeo.motif == "Maux de tête ou migraine"
table(homeo.ps.nmed.migraine,useNA = "always")

##### Magnétiseur pour des maux de tête ou migraines
magne.migraine <- qtnps$magne == "Oui" &
  qtnps$magne.motif == "Maux de tête ou migraine" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.migraine,useNA = "always")

#### Magnétiseur médecin pour des maux de tête ou migraines
magne.med.migraine <- (qtnps$magne == "Oui" &
    qtnps$magne.motif == "Maux de tête ou migraine") & 
  (qtnps$magne.med == "Oui" |
  (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))
table(magne.med.migraine,useNA = "always")

#### Magnétiseur non médecin pour des maux de tête ou migraines
magne.nmed.migraine <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE) &
  qtnps$magne.motif == "Maux de tête ou migraine" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.nmed.migraine,useNA = "always")

#### Magnétiseur PS non médecin pour des maux de tête ou migraines
magne.ps.nmed.migraine <- magne.ps.nmed == TRUE &
  qtnps$magne.motif == "Maux de tête ou migraine"
table(magne.ps.nmed.migraine,useNA = "always")

#### Ostéopathe pour des maux de tête ou migraines
osteo.migraine <- qtnps$osteo == "Oui" &
  qtnps$osteo.motif == "Maux de tête ou migraine" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.migraine,useNA = "always")

#### Ostéopathe médecin pour des maux de tête ou migraines
osteo.med.migraine <- (qtnps$osteo == "Oui" &
    qtnps$osteo.motif == "Maux de tête ou migraine") & 
  (qtnps$osteo.med == "Oui" |
  (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))
table(osteo.med.migraine,useNA = "always")

#### Ostéopathe non médecin pour des maux de tête ou migraines
osteo.nmed.migraine <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE) &
  qtnps$osteo.motif == "Maux de tête ou migraine" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.nmed.migraine,useNA = "always")

#### Ostéopathe PS non médecin pour des maux de tête ou migraines
osteo.ps.nmed.migraine <- osteo.ps.nmed == TRUE &
  qtnps$osteo.motif == "Maux de tête ou migraine" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.ps.nmed.migraine,useNA = "always")

#### Rebouteux pour des maux de tête ou migraines
rebout.migraine <- qtnps$rebout == "Oui" &
  qtnps$rebout.motif == "Maux de tête ou migraine" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.migraine,useNA = "always")

#### Rebouteux médecin pour des maux de tête ou migraines
rebout.med.migraine <- (qtnps$rebout == "Oui" &
    qtnps$rebout.motif == "Maux de tête ou migraine") & 
  (qtnps$rebout.med == "Oui" |
  (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin"))
table(rebout.med.migraine,useNA = "always")

#### Rebouteux non médecin pour des maux de tête ou migraines
rebout.nmed.migraine <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE) &
  qtnps$rebout.motif == "Maux de tête ou migraine" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.nmed.migraine,useNA = "always")

#### Rebouteux PS non médecin pour des maux de tête ou migraines
rebout.ps.nmed.migraine <- rebout.ps.nmed == TRUE &
  qtnps$rebout.motif == "Maux de tête ou migraine" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.ps.nmed.migraine,useNA = "always")

#### TA pour des maux de tête ou migraines ----
camp.migraine <- acup.migraine|chiro.migraine|homeo.migraine|magne.migraine|
  osteo.migraine|rebout.migraine
table(camp.migraine,useNA = "always")

#### TA médecin pour des maux de tête ou migraines ----
camp.med.migraine <- acup.med.migraine|chiro.med.migraine|homeo.med.migraine|
  magne.med.migraine|
  osteo.med.migraine|rebout.med.migraine
table(camp.med.migraine,useNA = "always")

#### TA non médecin pour des maux de tête ou migraines ----
camp.nmed.migraine <- acup.nmed.migraine|chiro.nmed.migraine|homeo.nmed.migraine|
  magne.nmed.migraine|osteo.nmed.migraine|rebout.nmed.migraine
table(camp.nmed.migraine,useNA = "always")

#### TA-PS non médecin pour des maux de tête ou migraines ----
camp.ps.nmed.migraine <- acup.ps.nmed.migraine|chiro.ps.nmed.migraine|
  homeo.ps.nmed.migraine|magne.ps.nmed.migraine|rebout.ps.nmed.migraine
table(camp.ps.nmed.migraine, useNA = "always")

### Recours à un TA pour une douleur au cou

#### Acupuncteur pour une douleur au cou
acup.cou <- qtnps$acup == "Oui" & qtnps$acup.motif == "Douleur au cou" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.cou,useNA = "always")

#### Médecin-acupuncteur pour une douleur au cou
acup.med.cou <- (qtnps$acup == "Oui" & qtnps$acup.motif == "Douleur au cou") & 
  (qtnps$acup.med == "Oui" |
  (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))
table(acup.med.cou,useNA = "always")

#### Acupuncteur non médecin pour une douleur au cou
acup.nmed.cou <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE) &
  qtnps$acup.motif == "Douleur au cou"
table(acup.nmed.cou,useNA = "always")

#### Acupuncteur PS non médecin pour une douleur au cou
acup.ps.nmed.cou <- acup.ps.nmed == TRUE & qtnps$acup.motif == "Douleur au cou"
table(acup.ps.nmed.cou,useNA = "always")

#### Chiropracteur pour une douleur au cou
chiro.cou <- qtnps$chiro == "Oui" & qtnps$chiro.motif == "Douleur au cou"
table(chiro.cou,useNA = "always")

#### Chiropracteur médecin pour une douleur au cou
chiro.med.cou <- (qtnps$chiro == "Oui" & qtnps$chiro.motif == "Douleur au cou") & 
  (qtnps$chiro.med == "Oui" |
  (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))
table(chiro.med.cou,useNA = "always")

#### Chiropracteur non médecin pour une douleur au cou
chiro.nmed.cou <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE) &
  qtnps$chiro.motif == "Douleur au cou"
table(chiro.nmed.cou,useNA = "always")

#### Chiropracteur PS non médecin pour une douleur au cou
chiro.ps.nmed.cou <- chiro.ps.nmed == TRUE & qtnps$chiro.motif == "Douleur au cou"
table(chiro.ps.nmed.cou,useNA = "always")

#### Homéopathe pour une douleur au cou
homeo.cou <- qtnps$homeo == "Oui" & qtnps$homeo.motif == "Douleur au cou" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.cou,useNA = "always")

#### Homéopathe médecin pour une douleur au cou
homeo.med.cou <- (qtnps$homeo == "Oui" & qtnps$homeo.motif == "Douleur au cou") & 
  (qtnps$homeo.med == "Oui" |
  (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))
table(homeo.med.cou,useNA = "always")

#### Homéopathe non médecin pour une douleur au cou
homeo.nmed.cou <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE) &
  qtnps$homeo.motif == "Douleur au cou" & is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.nmed.cou,useNA = "always")

#### Homéopathe PS non médecin pour une douleur au cou
homeo.ps.nmed.cou <- homeo.ps.nmed == TRUE & qtnps$homeo.motif == "Douleur au cou"
table(homeo.ps.nmed.cou,useNA = "always")

##### Magnétiseur pour une douleur au cou
magne.cou <- qtnps$magne == "Oui" & qtnps$magne.motif == "Douleur au cou" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.cou,useNA = "always")

#### Magnétiseur médecin pour une douleur au cou
magne.med.cou <- (qtnps$magne == "Oui" & qtnps$magne.motif == "Douleur au cou") & 
  (qtnps$magne.med == "Oui" |
  (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))
table(magne.med.cou,useNA = "always")

#### Magnétiseur non médecin pour une douleur au cou
magne.nmed.cou <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE) &
  qtnps$magne.motif == "Douleur au cou" & is.na(qtnps$magne.motif.autre) == TRUE
table(magne.nmed.cou,useNA = "always")

#### Magnétiseur PS non médecin pour une douleur au cou
magne.ps.nmed.cou <- magne.ps.nmed == TRUE & qtnps$magne.motif == "Douleur au cou"
table(magne.ps.nmed.cou,useNA = "always")

#### Ostéopathe pour une douleur au cou
osteo.cou <- qtnps$osteo == "Oui" & qtnps$osteo.motif == "Douleur au cou" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.cou,useNA = "always")

#### Ostéopathe médecin pour une douleur au cou
osteo.med.cou <- (qtnps$osteo == "Oui" & qtnps$osteo.motif == "Douleur au cou") & 
  (qtnps$osteo.med == "Oui" |
  (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))
table(osteo.med.cou,useNA = "always")

#### Ostéopathe non médecin pour une douleur au cou
osteo.nmed.cou <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE) &
  qtnps$osteo.motif == "Douleur au cou" & is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.nmed.cou,useNA = "always")

#### Ostéopathe PS non médecin pour une douleur au cou
osteo.ps.nmed.cou <- osteo.ps.nmed == TRUE & qtnps$osteo.motif == "Douleur au cou" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.ps.nmed.cou,useNA = "always")

#### Rebouteux pour une douleur au cou
rebout.cou <- qtnps$rebout == "Oui" & qtnps$rebout.motif == "Douleur au cou" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.cou,useNA = "always")

#### Rebouteux médecin pour une douleur au cou
rebout.med.cou <- (qtnps$rebout == "Oui" & qtnps$rebout.motif == "Douleur au cou") & 
  (qtnps$rebout.med == "Oui" |
  (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin"))
table(rebout.med.cou,useNA = "always")

#### Rebouteux non médecin pour une douleur au cou
rebout.nmed.cou <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE) &
  qtnps$rebout.motif == "Douleur au cou" & is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.nmed.cou,useNA = "always")

#### Rebouteux PS non médecin pour une douleur au cou
rebout.ps.nmed.cou <- rebout.ps.nmed == TRUE &
  qtnps$rebout.motif == "Douleur au cou" & is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.ps.nmed.cou,useNA = "always")

#### TA pour une douleur au cou ----
camp.cou <- acup.cou|chiro.cou|homeo.cou|magne.cou|osteo.cou|rebout.cou
table(camp.cou,useNA = "always")

#### TA médecin pour une douleur au cou ----
camp.med.cou <- acup.med.cou|chiro.med.cou|homeo.med.cou|magne.med.cou|
  osteo.med.cou|rebout.med.cou
table(camp.med.cou,useNA = "always")

#### TA non médecin pour une douleur au cou ----
camp.nmed.cou <- acup.nmed.cou|chiro.nmed.cou|homeo.nmed.cou|
  magne.nmed.cou|osteo.nmed.cou|rebout.nmed.cou
table(camp.nmed.cou,useNA = "always")

#### TA-PS non médecin pour une douleur au cou ----
camp.ps.nmed.cou <- acup.ps.nmed.cou|chiro.ps.nmed.cou|
  homeo.ps.nmed.cou|magne.ps.nmed.cou|rebout.ps.nmed.cou
table(camp.ps.nmed.cou, useNA = "always")

### Recours à un TA pour une douleur de membre supérieur

#### Acupuncteur pour une douleur de membre supérieur
acup.msup <- qtnps$acup == "Oui" &
  qtnps$acup.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.msup,useNA = "always")

#### Médecin-acupuncteur pour une douleur de membre supérieur
acup.med.msup <- (qtnps$acup == "Oui" &
    qtnps$acup.motif == "Douleur à l'épaule, au coude, au poignet ou à la main") & 
  (qtnps$acup.med == "Oui" |
  (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))
table(acup.med.msup,useNA = "always")

#### Acupuncteur non médecin pour une douleur de membre supérieur
acup.nmed.msup <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE) &
  qtnps$acup.motif == "Douleur à l'épaule, au coude, au poignet ou à la main"
table(acup.nmed.msup,useNA = "always")

#### Acupuncteur PS non médecin pour une douleur de membre supérieur
acup.ps.nmed.msup <- acup.ps.nmed == TRUE &
  qtnps$acup.motif == "Douleur à l'épaule, au coude, au poignet ou à la main"
table(acup.ps.nmed.msup,useNA = "always")

#### Chiropracteur pour une douleur de membre supérieur
chiro.msup <- qtnps$chiro == "Oui" &
  qtnps$chiro.motif == "Douleur à l'épaule, au coude, au poignet ou à la main"
table(chiro.msup,useNA = "always")

#### Chiropracteur médecin pour une douleur de membre supérieur
chiro.med.msup <- (qtnps$chiro == "Oui" &
    qtnps$chiro.motif == "Douleur à l'épaule, au coude, au poignet ou à la main") & 
  (qtnps$chiro.med == "Oui" |
  (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))
table(chiro.med.msup,useNA = "always")

#### Chiropracteur non médecin pour une douleur de membre supérieur
chiro.nmed.msup <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE) &
  qtnps$chiro.motif == "Douleur à l'épaule, au coude, au poignet ou à la main"
table(chiro.nmed.msup,useNA = "always")

#### Chiropracteur PS non médecin pour une douleur de membre supérieur
chiro.ps.nmed.msup <- chiro.ps.nmed == TRUE &
  qtnps$chiro.motif == "Douleur à l'épaule, au coude, au poignet ou à la main"
table(chiro.ps.nmed.msup,useNA = "always")

#### Homéopathe pour une douleur de membre supérieur
homeo.msup <- qtnps$homeo == "Oui" &
  qtnps$homeo.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.msup,useNA = "always")

#### Homéopathe médecin pour une douleur de membre supérieur
homeo.med.msup <- (qtnps$homeo == "Oui" &
    qtnps$homeo.motif == "Douleur à l'épaule, au coude, au poignet ou à la main") & 
  (qtnps$homeo.med == "Oui" |
  (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))
table(homeo.med.msup,useNA = "always")

#### Homéopathe non médecin pour une douleur de membre supérieur
homeo.nmed.msup <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE) &
  qtnps$homeo.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.nmed.msup,useNA = "always")

#### Homéopathe PS non médecin pour une douleur de membre supérieur
homeo.ps.nmed.msup <- homeo.ps.nmed == TRUE &
  qtnps$homeo.motif == "Douleur à l'épaule, au coude, au poignet ou à la main"
table(homeo.ps.nmed.msup,useNA = "always")

##### Magnétiseur pour une douleur de membre supérieur
magne.msup <- qtnps$magne == "Oui" &
  qtnps$magne.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.msup,useNA = "always")

#### Magnétiseur médecin pour une douleur de membre supérieur
magne.med.msup <- (qtnps$magne == "Oui" &
    qtnps$magne.motif == "Douleur à l'épaule, au coude, au poignet ou à la main") & 
  (qtnps$magne.med == "Oui" |
  (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))
table(magne.med.msup,useNA = "always")

#### Magnétiseur non médecin pour une douleur de membre supérieur
magne.nmed.msup <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE) &
  qtnps$magne.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.nmed.msup,useNA = "always")

#### Magnétiseur PS non médecin pour une douleur de membre supérieur
magne.ps.nmed.msup <- magne.ps.nmed == TRUE &
  qtnps$magne.motif == "Douleur à l'épaule, au coude, au poignet ou à la main"
table(magne.ps.nmed.msup,useNA = "always")

#### Ostéopathe pour une douleur de membre supérieur
osteo.msup <- qtnps$osteo == "Oui" &
  qtnps$osteo.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.msup,useNA = "always")

#### Ostéopathe médecin pour une douleur de membre supérieur
osteo.med.msup <- (qtnps$osteo == "Oui" &
    qtnps$osteo.motif == "Douleur à l'épaule, au coude, au poignet ou à la main") & 
  (qtnps$osteo.med == "Oui" |
  (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))
table(osteo.med.msup,useNA = "always")

#### Ostéopathe non médecin pour une douleur de membre supérieur
osteo.nmed.msup <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE) &
  qtnps$osteo.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.nmed.msup,useNA = "always")

#### Ostéopathe PS non médecin pour une douleur de membre supérieur
osteo.ps.nmed.msup <- osteo.ps.nmed == TRUE &
  qtnps$osteo.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.ps.nmed.msup,useNA = "always")

#### Rebouteux pour une douleur de membre supérieur
rebout.msup <- qtnps$rebout == "Oui" &
  qtnps$rebout.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.msup,useNA = "always")

#### Rebouteux médecin pour une douleur de membre supérieur
rebout.med.msup <- (qtnps$rebout == "Oui" &
    qtnps$rebout.motif == "Douleur à l'épaule, au coude, au poignet ou à la main") & 
  (qtnps$rebout.med == "Oui" |
  (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin"))
table(rebout.med.msup,useNA = "always")

#### Rebouteux non médecin pour une douleur de membre supérieur
rebout.nmed.msup <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE) &
  qtnps$rebout.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.nmed.msup,useNA = "always")

#### Rebouteux PS non médecin pour une douleur de membre supérieur
rebout.ps.nmed.msup <- rebout.ps.nmed == TRUE &
  qtnps$rebout.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.ps.nmed.msup,useNA = "always")

#### TA pour une douleur de membre supérieur ----
camp.msup <- acup.msup|chiro.msup|homeo.msup|magne.msup|osteo.msup|rebout.msup
table(camp.msup,useNA = "always")

#### TA médecin pour une douleur de membre supérieur ----
camp.med.msup <- acup.med.msup|chiro.med.msup|homeo.med.msup|magne.med.msup|
  osteo.med.msup|rebout.med.msup
table(camp.med.msup,useNA = "always")

#### TA non médecin pour une douleur de membre supérieur ----
camp.nmed.msup <- acup.nmed.msup|chiro.nmed.msup|homeo.nmed.msup|
  magne.nmed.msup|osteo.nmed.msup|rebout.nmed.msup
table(camp.nmed.msup,useNA = "always")

#### TA-PS non médecin pour une douleur de membre supérieur ----
camp.ps.nmed.msup <- acup.ps.nmed.msup|chiro.ps.nmed.msup|
  homeo.ps.nmed.msup|magne.ps.nmed.msup|rebout.ps.nmed.msup
table(camp.ps.nmed.msup, useNA = "always")

### Recours à un TA pour du stress ou de l'anxiété

#### Acupuncteur pour du stress ou de l'anxiété
acup.stress <- qtnps$acup == "Oui" & qtnps$acup.motif == "Stress ou anxiété" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.stress,useNA = "always")

#### Médecin-acupuncteur pour du stress ou de l'anxiété
acup.med.stress <- (qtnps$acup == "Oui" & qtnps$acup.motif == "Stress ou anxiété") & 
  (qtnps$acup.med == "Oui" |
  (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))
table(acup.med.stress,useNA = "always")

#### Acupuncteur non médecin pour du stress ou de l'anxiété
acup.nmed.stress <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE) &
  qtnps$acup.motif == "Stress ou anxiété"
table(acup.nmed.stress,useNA = "always")

#### Acupuncteur PS non médecin pour du stress ou de l'anxiété
acup.ps.nmed.stress <- acup.ps.nmed == TRUE & qtnps$acup.motif == "Stress ou anxiété"
table(acup.ps.nmed.stress,useNA = "always")

#### Chiropracteur pour du stress ou de l'anxiété
chiro.stress <- qtnps$chiro == "Oui" & qtnps$chiro.motif == "Stress ou anxiété"
table(chiro.stress,useNA = "always")

#### Chiropracteur médecin pour du stress ou de l'anxiété
chiro.med.stress <- (qtnps$chiro == "Oui" & qtnps$chiro.motif == "Stress ou anxiété") & 
  (qtnps$chiro.med == "Oui" |
  (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))
table(chiro.med.stress,useNA = "always")

#### Chiropracteur non médecin pour du stress ou de l'anxiété
chiro.nmed.stress <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE) &
  qtnps$chiro.motif == "Stress ou anxiété"
table(chiro.nmed.stress,useNA = "always")

#### Chiropracteur PS non médecin pour du stress ou de l'anxiété
chiro.ps.nmed.stress <- chiro.ps.nmed == TRUE &
  qtnps$chiro.motif == "Stress ou anxiété"
table(chiro.ps.nmed.stress,useNA = "always")

#### Homéopathe pour du stress ou de l'anxiété
homeo.stress <- qtnps$homeo == "Oui" & qtnps$homeo.motif == "Stress ou anxiété" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.stress,useNA = "always")

#### Homéopathe médecin pour du stress ou de l'anxiété
homeo.med.stress <- (qtnps$homeo == "Oui" &
    qtnps$homeo.motif == "Stress ou anxiété") &
  (qtnps$homeo.med == "Oui" |
  (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))
table(homeo.med.stress,useNA = "always")

#### Homéopathe non médecin pour du stress ou de l'anxiété
homeo.nmed.stress <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE) &
  qtnps$homeo.motif == "Stress ou anxiété" & is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.nmed.stress,useNA = "always")

#### Homéopathe PS non médecin pour du stress ou de l'anxiété
homeo.ps.nmed.stress <- homeo.ps.nmed == TRUE &
  qtnps$homeo.motif == "Stress ou anxiété"
table(homeo.ps.nmed.stress,useNA = "always")

##### Magnétiseur pour du stress ou de l'anxiété
magne.stress <- qtnps$magne == "Oui" & qtnps$magne.motif == "Stress ou anxiété" & 
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.stress,useNA = "always")

#### Magnétiseur médecin pour du stress ou de l'anxiété
magne.med.stress <- (qtnps$magne == "Oui" & qtnps$magne.motif == "Stress ou anxiété") & 
  (qtnps$magne.med == "Oui" |
  (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))
table(magne.med.stress,useNA = "always")

#### Magnétiseur non médecin pour du stress ou de l'anxiété
magne.nmed.stress <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE) &
  qtnps$magne.motif == "Stress ou anxiété" & is.na(qtnps$magne.motif.autre) == TRUE
table(magne.nmed.stress,useNA = "always")

#### Magnétiseur PS non médecin pour du stress ou de l'anxiété
magne.ps.nmed.stress <- magne.ps.nmed == TRUE &
  qtnps$magne.motif == "Stress ou anxiété"
table(magne.ps.nmed.stress,useNA = "always")

#### Ostéopathe pour du stress ou de l'anxiété
osteo.stress <- qtnps$osteo == "Oui" & qtnps$osteo.motif == "Stress ou anxiété" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.stress,useNA = "always")

#### Ostéopathe médecin pour du stress ou de l'anxiété
osteo.med.stress <- (qtnps$osteo == "Oui" &
    qtnps$osteo.motif == "Stress ou anxiété") & 
  (qtnps$osteo.med == "Oui" |
  (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))
table(osteo.med.stress,useNA = "always")

#### Ostéopathe non médecin pour du stress ou de l'anxiété
osteo.nmed.stress <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE) &
  qtnps$osteo.motif == "Stress ou anxiété" & is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.nmed.stress,useNA = "always")

#### Ostéopathe PS non médecin pour du stress ou de l'anxiété
osteo.ps.nmed.stress <- osteo.ps.nmed == TRUE &
  qtnps$osteo.motif == "Stress ou anxiété" & is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.ps.nmed.stress,useNA = "always")

#### Rebouteux pour du stress ou de l'anxiété
rebout.stress <- qtnps$rebout == "Oui" & qtnps$rebout.motif == "Stress ou anxiété" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.stress,useNA = "always")

#### Rebouteux médecin pour du stress ou de l'anxiété
rebout.med.stress <- (qtnps$rebout == "Oui" &
    qtnps$rebout.motif == "Stress ou anxiété") & 
  (qtnps$rebout.med == "Oui" |
  (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin"))
table(rebout.med.stress,useNA = "always")

#### Rebouteux non médecin pour du stress ou de l'anxiété
rebout.nmed.stress <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE) &
  qtnps$rebout.motif == "Stress ou anxiété" & is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.nmed.stress,useNA = "always")

#### Rebouteux PS non médecin pour du stress ou de l'anxiété
rebout.ps.nmed.stress <- rebout.ps.nmed == TRUE &
  qtnps$rebout.motif == "Stress ou anxiété" & is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.ps.nmed.stress,useNA = "always")

#### TA pour du stress ou de l'anxiété ----
camp.stress <- acup.stress|chiro.stress|homeo.stress|
  magne.stress|osteo.stress|rebout.stress
table(camp.stress,useNA = "always")

#### TA médecin pour du stress ou de l'anxiété ----
camp.med.stress <- acup.med.stress|chiro.med.stress|homeo.med.stress|magne.med.stress|
  osteo.med.stress|rebout.med.stress
table(camp.med.stress,useNA = "always")

#### TA non médecin pour du stress ou de l'anxiété ----
camp.nmed.stress <- acup.nmed.stress|chiro.nmed.stress|homeo.nmed.stress|
  magne.nmed.stress|osteo.nmed.stress|rebout.nmed.stress
table(camp.nmed.stress,useNA = "always")

#### TA-PS non médecin pour du stress ou de l'anxiété ----
camp.ps.nmed.stress <- acup.ps.nmed.stress|chiro.ps.nmed.stress|
  homeo.ps.nmed.stress|magne.ps.nmed.stress|rebout.ps.nmed.stress
table(camp.ps.nmed.stress, useNA = "always")

### Recours à un TA pour une douleur de membre inférieur

#### Acupuncteur pour une douleur de membre inférieur
acup.minf <- qtnps$acup == "Oui" &
  qtnps$acup.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.minf,useNA = "always")

#### Médecin-acupuncteur pour une douleur de membre inférieur
acup.med.minf <- (qtnps$acup == "Oui" &
    qtnps$acup.motif == "Douleur à la hanche, au genou, à la cheville ou au pied") & 
  (qtnps$acup.med == "Oui" |
  (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))
table(acup.med.minf,useNA = "always")

#### Acupuncteur non médecin pour une douleur de membre inférieur
acup.nmed.minf <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE) &
  qtnps$acup.motif == "Douleur à la hanche, au genou, à la cheville ou au pied"
table(acup.nmed.minf,useNA = "always")

#### Acupuncteur PS non médecin pour une douleur de membre inférieur
acup.ps.nmed.minf <- acup.ps.nmed == TRUE &
  qtnps$acup.motif == "Douleur à la hanche, au genou, à la cheville ou au pied"
table(acup.ps.nmed.minf,useNA = "always")

#### Chiropracteur pour une douleur de membre inférieur
chiro.minf <- qtnps$chiro == "Oui" &
  qtnps$chiro.motif == "Douleur à la hanche, au genou, à la cheville ou au pied"
table(chiro.minf,useNA = "always")

#### Chiropracteur médecin pour une douleur de membre inférieur
chiro.med.minf <- (qtnps$chiro == "Oui" &
    qtnps$chiro.motif == "Douleur à la hanche, au genou, à la cheville ou au pied") & 
  (qtnps$chiro.med == "Oui" |
  (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))
table(chiro.med.minf,useNA = "always")

#### Chiropracteur non médecin pour une douleur de membre inférieur
chiro.nmed.minf <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE) &
  qtnps$chiro.motif == "Douleur à la hanche, au genou, à la cheville ou au pied"
table(chiro.nmed.minf,useNA = "always")

#### Chiropracteur PS non médecin pour une douleur de membre inférieur
chiro.ps.nmed.minf <- chiro.ps.nmed == TRUE &
  qtnps$chiro.motif == "Douleur à la hanche, au genou, à la cheville ou au pied"
table(chiro.ps.nmed.minf,useNA = "always")

#### Homéopathe pour une douleur de membre inférieur
homeo.minf <- qtnps$homeo == "Oui" &
  qtnps$homeo.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.minf,useNA = "always")

#### Homéopathe médecin pour une douleur de membre inférieur
homeo.med.minf <- (qtnps$homeo == "Oui" &
    qtnps$homeo.motif == "Douleur à la hanche, au genou, à la cheville ou au pied") & 
  (qtnps$homeo.med == "Oui" |
  (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))
table(homeo.med.minf,useNA = "always")

#### Homéopathe non médecin pour une douleur de membre inférieur
homeo.nmed.minf <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE) &
  qtnps$homeo.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.nmed.minf,useNA = "always")

#### Homéopathe PS non médecin pour une douleur de membre inférieur
homeo.ps.nmed.minf <- homeo.ps.nmed == TRUE &
  qtnps$homeo.motif == "Douleur à la hanche, au genou, à la cheville ou au pied"
table(homeo.ps.nmed.minf,useNA = "always")

##### Magnétiseur pour une douleur de membre inférieur
magne.minf <- qtnps$magne == "Oui" &
  qtnps$magne.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.minf,useNA = "always")

#### Magnétiseur médecin pour une douleur de membre inférieur
magne.med.minf <- (qtnps$magne == "Oui" &
    qtnps$magne.motif == "Douleur à la hanche, au genou, à la cheville ou au pied") & 
  (qtnps$magne.med == "Oui" |
  (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))
table(magne.med.minf,useNA = "always")

#### Magnétiseur non médecin pour une douleur de membre inférieur
magne.nmed.minf <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE) &
  qtnps$magne.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.nmed.minf,useNA = "always")

#### Magnétiseur PS non médecin pour une douleur de membre inférieur
magne.ps.nmed.minf <- magne.ps.nmed == TRUE &
  qtnps$magne.motif == "Douleur à la hanche, au genou, à la cheville ou au pied"
table(magne.ps.nmed.minf,useNA = "always")

#### Ostéopathe pour une douleur de membre inférieur
osteo.minf <- qtnps$osteo == "Oui" &
  qtnps$osteo.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.minf,useNA = "always")

#### Ostéopathe médecin pour une douleur de membre inférieur
osteo.med.minf <- (qtnps$osteo == "Oui" &
    qtnps$osteo.motif == "Douleur à la hanche, au genou, à la cheville ou au pied") & 
  (qtnps$osteo.med == "Oui" |
  (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))
table(osteo.med.minf,useNA = "always")

#### Ostéopathe non médecin pour une douleur de membre inférieur
osteo.nmed.minf <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE) &
  qtnps$osteo.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.nmed.minf,useNA = "always")

#### Ostéopathe PS non médecin pour une douleur de membre inférieur
osteo.ps.nmed.minf <- osteo.ps.nmed == TRUE &
  qtnps$osteo.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.ps.nmed.minf,useNA = "always")

#### Rebouteux pour une douleur de membre inférieur
rebout.minf <- qtnps$rebout == "Oui" &
  qtnps$rebout.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.minf,useNA = "always")

#### Rebouteux médecin pour une douleur de membre inférieur
rebout.med.minf <- (qtnps$rebout == "Oui" &
    qtnps$rebout.motif == "Douleur à la hanche, au genou, à la cheville ou au pied") & 
  (qtnps$rebout.med == "Oui" |
  (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin"))
table(rebout.med.minf,useNA = "always")

#### Rebouteux non médecin pour une douleur de membre inférieur
rebout.nmed.minf <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE) &
  qtnps$rebout.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.nmed.minf,useNA = "always")

#### Rebouteux PS non médecin pour une douleur de membre inférieur
rebout.ps.nmed.minf <- rebout.ps.nmed == TRUE &
  qtnps$rebout.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.ps.nmed.minf,useNA = "always")

#### TA pour une douleur de membre inférieur ----
camp.minf <- acup.minf|chiro.minf|homeo.minf|magne.minf|osteo.minf|rebout.minf
table(camp.minf,useNA = "always")

#### TA médecin pour une douleur de membre inférieur ----
camp.med.minf <- acup.med.minf|chiro.med.minf|homeo.med.minf|magne.med.minf|
  osteo.med.minf|rebout.med.minf
table(camp.med.minf,useNA = "always")

#### TA non médecin pour une douleur de membre inférieur ----
camp.nmed.minf <- acup.nmed.minf|chiro.nmed.minf|homeo.nmed.minf|
  magne.nmed.minf|osteo.nmed.minf|rebout.nmed.minf
table(camp.nmed.minf,useNA = "always")

#### TA-PS non médecin pour une douleur de membre inférieur ----
camp.ps.nmed.minf <- acup.ps.nmed.minf|chiro.ps.nmed.minf|
  homeo.ps.nmed.minf|magne.ps.nmed.minf|rebout.ps.nmed.minf
table(camp.ps.nmed.minf, useNA = "always")

### Recours à un TA pour un autre motif

#### Acupuncteur pour un autre motif
acup.autre <- qtnps$acup == "Oui" & qtnps$acup.motif == "Autre" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.autre,useNA = "always")

#### Médecin-acupuncteur pour un autre motif
acup.med.autre <- (qtnps$acup == "Oui" & qtnps$acup.motif == "Autre") & 
  (qtnps$acup.med == "Oui" |
  (is.na(qtnps$acup.autre.r) == FALSE & qtnps$acup.autre.r == "medecin"))
table(acup.med.autre,useNA = "always")

#### Acupuncteur non médecin pour un autre motif
acup.nmed.autre <- qtnps$acup == "Oui" & qtnps$acup.med == "Non" & 
  (qtnps$acup.autre.r != "medecin" | is.na(qtnps$acup.autre.r) == TRUE) &
  qtnps$acup.motif == "Autre"
table(acup.nmed.autre,useNA = "always")

#### Acupuncteur PS non médecin pour un autre motif
acup.ps.nmed.autre <- acup.ps.nmed == TRUE & qtnps$acup.motif == "Autre"
table(acup.ps.nmed.autre,useNA = "always")

#### Chiropracteur pour un autre motif
chiro.autre <- qtnps$chiro == "Oui" & qtnps$chiro.motif == "Autre"
table(chiro.autre,useNA = "always")

#### Chiropracteur médecin pour un autre motif
chiro.med.autre <- (qtnps$chiro == "Oui" & qtnps$chiro.motif == "Autre") & 
  (qtnps$chiro.med == "Oui" |
  (is.na(qtnps$chiro.autre.r) == FALSE & qtnps$chiro.autre.r == "medecin"))
table(chiro.med.autre,useNA = "always")

#### Chiropracteur non médecin pour un autre motif
chiro.nmed.autre <- qtnps$chiro == "Oui" & qtnps$chiro.med == "Non" & 
  (qtnps$chiro.autre.r != "medecin" | is.na(qtnps$chiro.autre.r) == TRUE) &
  qtnps$chiro.motif == "Autre"
table(chiro.nmed.autre,useNA = "always")

#### Chiropracteur PS non médecin pour un autre motif
chiro.ps.nmed.autre <- chiro.ps.nmed == TRUE & qtnps$chiro.motif == "Autre"
table(chiro.ps.nmed.autre,useNA = "always")

#### Homéopathe pour un autre motif
homeo.autre <- qtnps$homeo == "Oui" & qtnps$homeo.motif == "Autre" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.autre,useNA = "always")

#### Homéopathe médecin pour un autre motif
homeo.med.autre <- (qtnps$homeo == "Oui" & qtnps$homeo.motif == "Autre") & 
  (qtnps$homeo.med == "Oui" |
  (is.na(qtnps$homeo.autre.r) == FALSE & qtnps$homeo.autre.r == "medecin"))
table(homeo.med.autre,useNA = "always")

#### Homéopathe non médecin pour un autre motif
homeo.nmed.autre <- qtnps$homeo == "Oui" & qtnps$homeo.med == "Non" & 
  (qtnps$homeo.autre.r != "medecin" | is.na(qtnps$homeo.autre.r) == TRUE) &
  qtnps$homeo.motif == "Autre" & is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.nmed.autre,useNA = "always")

#### Homéopathe PS non médecin pour un autre motif
homeo.ps.nmed.autre <- homeo.ps.nmed == TRUE & qtnps$homeo.motif == "Autre"
table(homeo.ps.nmed.autre,useNA = "always")

##### Magnétiseur pour un autre motif
magne.autre <- qtnps$magne == "Oui" & qtnps$magne.motif == "Autre" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.autre,useNA = "always")

#### Magnétiseur médecin pour un autre motif
magne.med.autre <- (qtnps$magne == "Oui" & qtnps$magne.motif == "Autre") & 
  (qtnps$magne.med == "Oui" |
  (is.na(qtnps$magne.autre.r) == FALSE & qtnps$magne.autre.r == "medecin"))
table(magne.med.autre,useNA = "always")

#### Magnétiseur non médecin pour un autre motif
magne.nmed.autre <- qtnps$magne == "Oui" & qtnps$magne.med == "Non" & 
  (qtnps$magne.autre.r != "medecin" | is.na(qtnps$magne.autre.r) == TRUE) &
  qtnps$magne.motif == "Autre" & is.na(qtnps$magne.motif.autre) == TRUE
table(magne.nmed.autre,useNA = "always")

#### Magnétiseur PS non médecin pour un autre motif
magne.ps.nmed.autre <- magne.ps.nmed == TRUE & qtnps$magne.motif == "Autre"
table(magne.ps.nmed.autre,useNA = "always")

#### Ostéopathe pour un autre motif
osteo.autre <- qtnps$osteo == "Oui" & qtnps$osteo.motif == "Autre" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.autre,useNA = "always")

#### Ostéopathe médecin pour un autre motif
osteo.med.autre <- (qtnps$osteo == "Oui" & qtnps$osteo.motif == "Autre") & 
  (qtnps$osteo.med == "Oui" |
  (is.na(qtnps$osteo.autre.r) == FALSE & qtnps$osteo.autre.r == "medecin"))
table(osteo.med.autre,useNA = "always")

#### Ostéopathe non médecin pour un autre motif
osteo.nmed.autre <- qtnps$osteo == "Oui" & qtnps$osteo.med == "Non" & 
  (qtnps$osteo.autre.r != "medecin" | is.na(qtnps$osteo.autre.r) == TRUE) &
  qtnps$osteo.motif == "Autre" & is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.nmed.autre,useNA = "always")

#### Ostéopathe PS non médecin pour un autre motif
osteo.ps.nmed.autre <- osteo.ps.nmed == TRUE & qtnps$osteo.motif == "Autre" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.ps.nmed.autre,useNA = "always")

#### Rebouteux pour un autre motif
rebout.autre <- qtnps$rebout == "Oui" & qtnps$rebout.motif == "Autre" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.autre,useNA = "always")

#### Rebouteux médecin pour un autre motif
rebout.med.autre <- (qtnps$rebout == "Oui" & qtnps$rebout.motif == "Autre") & 
  (qtnps$rebout.med == "Oui" |
  (is.na(qtnps$rebout.autre.r) == FALSE & qtnps$rebout.autre.r == "medecin"))
table(rebout.med.autre,useNA = "always")

#### Rebouteux non médecin pour un autre motif
rebout.nmed.autre <- qtnps$rebout == "Oui" & qtnps$rebout.med == "Non" & 
  (qtnps$rebout.autre.r != "medecin" | is.na(qtnps$rebout.autre.r) == TRUE) &
  qtnps$rebout.motif == "Autre" & is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.nmed.autre,useNA = "always")

#### Rebouteux PS non médecin pour un autre motif
rebout.ps.nmed.autre <- rebout.ps.nmed == TRUE &
  qtnps$rebout.motif == "Autre" & is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.ps.nmed.autre,useNA = "always")

#### TA pour un autre motif ----
camp.autre <- acup.autre|chiro.autre|homeo.autre|magne.autre|osteo.autre|rebout.autre
table(camp.autre,useNA = "always")

#### TA médecin pour un autre motif ----
camp.med.autre <- acup.med.autre|chiro.med.autre|homeo.med.autre|magne.med.autre|
  osteo.med.autre|rebout.med.autre

#### TA non médecin pour un autre motif ----
camp.nmed.autre <- acup.nmed.autre|chiro.nmed.autre|homeo.nmed.autre|
  magne.nmed.autre|osteo.nmed.autre|rebout.nmed.autre

#### TA-PS non médecin pour un autre motif ----
camp.ps.nmed.autre <- acup.ps.nmed.autre|chiro.ps.nmed.autre|
  homeo.ps.nmed.autre|magne.ps.nmed.autre|rebout.ps.nmed.autre

## Recours alternatif, isolé de toute prise en charge médicale ----

### Recours alternatif pour un motif « Autre »

#### Recours alternatif à un acupuncteur NPS pour un motif « Autre »
# Manipulation préalable : Recours à un acupuncteur TNPS pour un motif « Autre »
acup.tnps.autre <- acup.tnps == TRUE & qtnps$acup.motif == "Autre" &
  is.na(qtnps$acup.motif.autre) == FALSE
table(acup.tnps.autre,useNA = "always")
# Recours alternatif
acup.tnps.autre.alt <- acup.tnps.autre == TRUE & 
  qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$acup.rec.comp.med2) == TRUE | qtnps$acup.rec.comp.med2 == "Non") & 
  qtnps$med.autre == "Non" & camp.med.autre == FALSE
table(acup.tnps.autre.alt,useNA = "always")

#### Recours alternatif à un chiropracteur NPS pour un motif « Autre »
# Manipulation préalable : Recours à un chiropracteur TNPS pour un motif « Autre »
chiro.tnps.autre <- chiro.tnps == TRUE & qtnps$chiro.motif == "Autre" &
  is.na(qtnps$chiro.motif.autre) == FALSE
table(chiro.tnps.autre,useNA = "always")
# Recours alternatif
chiro.tnps.autre.alt <- chiro.tnps.autre == TRUE & 
  qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$chiro.rec.comp.med2) == TRUE | qtnps$chiro.rec.comp.med2 == "Non") & 
  qtnps$med.autre == "Non" & camp.med.autre == FALSE
table(chiro.tnps.autre.alt,useNA = "always")

#### Recours alternatif à un homéopathe NPS pour un motif « Autre »
# Manipulation préalable : Recours à un homéopathe TNPS pour un motif « Autre »
homeo.tnps.autre <- homeo.tnps == TRUE & qtnps$homeo.motif == "Autre" &
  is.na(qtnps$homeo.motif.autre) == FALSE
table(homeo.tnps.autre,useNA = "always")
# Recours alternatif
homeo.tnps.autre.alt <- homeo.tnps.autre == TRUE & 
  qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$homeo.rec.comp.med2) == TRUE | qtnps$homeo.rec.comp.med2 == "Non") & 
  qtnps$med.autre == "Non" & camp.med.autre == FALSE
table(homeo.tnps.autre.alt,useNA = "always")

#### Recours alternatif à un magnétiseur NPS pour un motif « Autre »
# Manipulation préalable : Recours à un magnétiseur TNPS pour un motif « Autre »
magne.tnps.autre <- magne.tnps == TRUE & qtnps$magne.motif == "Autre" &
  is.na(qtnps$magne.motif.autre) == FALSE
table(magne.tnps.autre,useNA = "always")
# Recours alternatif
magne.tnps.autre.alt <- magne.tnps.autre == TRUE & 
  qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$magne.rec.comp.med2) == TRUE | qtnps$magne.rec.comp.med2 == "Non") & 
  qtnps$med.autre == "Non" & camp.med.autre == FALSE
table(magne.tnps.autre.alt,useNA = "always")

#### Recours alternatif à un ostéopathe NPS pour un motif « Autre »
# Manipulation préalable : Recours à un ostéopathe TNPS pour un motif « Autre »
osteo.tnps.autre <- osteo.tnps == TRUE & qtnps$osteo.motif == "Autre" &
  is.na(qtnps$osteo.motif.autre) == FALSE
table(osteo.tnps.autre,useNA = "always")
# Recours alternatif
osteo.tnps.autre.alt <- osteo.tnps.autre == TRUE & 
  qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$osteo.rec.comp.med2) == TRUE | qtnps$osteo.rec.comp.med2 == "Non") & 
  qtnps$med.autre == "Non" & camp.med.autre == FALSE
table(osteo.tnps.autre.alt,useNA = "always")

#### Recours alternatif à un rebouteux NPS pour un motif « Autre »
# Manipulation préalable : Recours à un rebouteux TNPS pour un motif « Autre »
rebout.tnps.autre <- rebout.tnps == TRUE & qtnps$rebout.motif == "Autre" &
  is.na(qtnps$rebout.motif.autre) == FALSE
table(rebout.tnps.autre,useNA = "always")
# Recours alternatif
rebout.tnps.autre.alt <- rebout.tnps.autre == TRUE & 
  qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$rebout.rec.comp.med2) == TRUE | qtnps$rebout.rec.comp.med2 == "Non") & 
  qtnps$med.autre == "Non" & camp.med.autre == FALSE
table(rebout.tnps.autre.alt,useNA = "always")

#### Recours alternatif à un TA-NPS pour un motif « Autre »
# Manipulation préalable : recours à un TA-NPS pour un motif « Autre »
camp.tnps.autre <- acup.tnps.autre|chiro.tnps.autre|homeo.tnps.autre|magne.tnps.autre|
  osteo.tnps.autre|rebout.tnps.autre
table(camp.tnps.autre,useNA = "always")
# Recours alternatif
camp.tnps.autre.alt <- acup.tnps.autre.alt|chiro.tnps.autre.alt|homeo.tnps.autre.alt|
  magne.tnps.autre.alt|
  osteo.tnps.autre.alt|rebout.tnps.autre.alt
table(camp.tnps.autre.alt,useNA = "always")

### Recours alternatif pour un mal de dos

#### Recours alternatif à un acupuncteur NPS pour un mal de dos
# Manipulation préalable : Recours à un acupuncteur TNPS pour un mal de dos
acup.tnps.dos <- acup.tnps == TRUE & qtnps$acup.motif == "Douleur au dos" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.tnps.dos,useNA = "always")
# Recours alternatif
acup.tnps.dos.alt <- acup.tnps.dos == TRUE & 
  qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$acup.rec.comp.med2) == TRUE | qtnps$acup.rec.comp.med2 == "Non") & 
  qtnps$med.doul.dos == "Non" & camp.med.dos == FALSE
table(acup.tnps.dos.alt,useNA = "always")

#### Recours alternatif à un chiropracteur NPS pour un mal de dos
# Manipulation préalable : Recours à un chiropracteur TNPS pour un mal de dos
chiro.tnps.dos <- chiro.tnps == TRUE & qtnps$chiro.motif == "Douleur au dos" &
  is.na(qtnps$chiro.motif.autre) == TRUE
table(chiro.tnps.dos,useNA = "always")
# Recours alternatif
chiro.tnps.dos.alt <- chiro.tnps.dos == TRUE & 
  qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$chiro.rec.comp.med2) == TRUE | qtnps$chiro.rec.comp.med2 == "Non") & 
  qtnps$med.doul.dos == "Non" & camp.med.dos == FALSE
table(chiro.tnps.dos.alt,useNA = "always")

#### Recours alternatif à un homéopathe NPS pour un mal de dos
# Manipulation préalable : Recours à un homéopathe TNPS pour un mal de dos
homeo.tnps.dos <- homeo.tnps == TRUE & qtnps$homeo.motif == "Douleur au dos" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.tnps.dos,useNA = "always")
# Recours alternatif
homeo.tnps.dos.alt <- homeo.tnps.dos == TRUE & 
  qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$homeo.rec.comp.med2) == TRUE | qtnps$homeo.rec.comp.med2 == "Non") & 
  qtnps$med.doul.dos == "Non" & camp.med.dos == FALSE
table(homeo.tnps.dos.alt,useNA = "always")

#### Recours alternatif à un magnétiseur NPS pour un mal de dos
# Manipulation préalable : Recours à un magnétiseur TNPS pour un mal de dos
magne.tnps.dos <- magne.tnps == TRUE & qtnps$magne.motif == "Douleur au dos" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.tnps.dos,useNA = "always")
# Recours alternatif
magne.tnps.dos.alt <- magne.tnps.dos == TRUE & 
  qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$magne.rec.comp.med2) == TRUE | qtnps$magne.rec.comp.med2 == "Non") & 
  qtnps$med.doul.dos == "Non" & camp.med.dos == FALSE
table(magne.tnps.dos.alt,useNA = "always")

#### Recours alternatif à un ostéopathe NPS pour un mal de dos
# Manipulation préalable : Recours à un ostéopathe TNPS pour un mal de dos
osteo.tnps.dos <- osteo.tnps == TRUE & qtnps$osteo.motif == "Douleur au dos" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.tnps.dos,useNA = "always")
# Recours alternatif
osteo.tnps.dos.alt <- osteo.tnps.dos == TRUE & 
  qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$osteo.rec.comp.med2) == TRUE | qtnps$osteo.rec.comp.med2 == "Non") & 
  qtnps$med.doul.dos == "Non" & camp.med.dos == FALSE
table(osteo.tnps.dos.alt,useNA = "always")

#### Recours alternatif à un rebouteux NPS pour un mal de dos
# Manipulation préalable : Recours à un rebouteux TNPS pour un mal de dos
rebout.tnps.dos <- rebout.tnps == TRUE & qtnps$rebout.motif == "Douleur au dos" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.tnps.dos,useNA = "always")
# Recours alternatif
rebout.tnps.dos.alt <- rebout.tnps.dos == TRUE & 
  qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$rebout.rec.comp.med2) == TRUE | qtnps$rebout.rec.comp.med2 == "Non") & 
  qtnps$med.doul.dos == "Non" & camp.med.dos == FALSE
table(rebout.tnps.dos.alt,useNA = "always")

#### Recours alternatif à un TA-NPS pour un mal de dos
# Manipulation préalable : recours à un TA-NPS pour un mal de dos
camp.tnps.dos <- acup.tnps.dos|chiro.tnps.dos|homeo.tnps.dos|magne.tnps.dos|
  osteo.tnps.dos|rebout.tnps.dos
table(camp.tnps.dos,useNA = "always")
# Recours alternatif
camp.tnps.dos.alt <- acup.tnps.dos.alt|chiro.tnps.dos.alt|homeo.tnps.dos.alt|
  magne.tnps.dos.alt|
  osteo.tnps.dos.alt|rebout.tnps.dos.alt
table(camp.tnps.dos.alt,useNA = "always")

### Recours alternatif pour une bronchite

#### Recours alternatif à un acupuncteur NPS pour une bronchite
# Manipulation préalable : Recours à un acupuncteur TNPS pour une bronchite
acup.tnps.bronchite <- acup.tnps == TRUE & qtnps$acup.motif == "Bronchite" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.tnps.bronchite,useNA = "always")
# Recours alternatif
acup.tnps.bronchite.alt <- acup.tnps.bronchite == TRUE & 
  qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$acup.rec.comp.med2) == TRUE | qtnps$acup.rec.comp.med2 == "Non") & 
  qtnps$med.bronchite == "Non" & camp.med.bronchite == FALSE
table(acup.tnps.bronchite.alt,useNA = "always")

#### Recours alternatif à un chiropracteur NPS pour une bronchite
# Manipulation préalable : Recours à un chiropracteur TNPS pour une bronchite
chiro.tnps.bronchite <- chiro.tnps == TRUE & qtnps$chiro.motif == "Bronchite" &
  is.na(qtnps$chiro.motif.autre) == TRUE
table(chiro.tnps.bronchite,useNA = "always")
# Recours alternatif
chiro.tnps.bronchite.alt <- chiro.tnps.bronchite == TRUE & 
  qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$chiro.rec.comp.med2) == TRUE | qtnps$chiro.rec.comp.med2 == "Non") & 
  qtnps$med.bronchite == "Non" & camp.med.bronchite == FALSE
table(chiro.tnps.bronchite.alt,useNA = "always")

#### Recours alternatif à un homéopathe NPS pour une bronchite
# Manipulation préalable : Recours à un homéopathe TNPS pour une bronchite
homeo.tnps.bronchite <- homeo.tnps == TRUE & qtnps$homeo.motif == "Bronchite" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.tnps.bronchite,useNA = "always")
# Recours alternatif
homeo.tnps.bronchite.alt <- homeo.tnps.bronchite == TRUE & 
  qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$homeo.rec.comp.med2) == TRUE | qtnps$homeo.rec.comp.med2 == "Non") & 
  qtnps$med.bronchite == "Non" & camp.med.bronchite == FALSE
table(homeo.tnps.bronchite.alt,useNA = "always")

#### Recours alternatif à un magnétiseur NPS pour une bronchite
# Manipulation préalable : Recours à un magnétiseur TNPS pour une bronchite
magne.tnps.bronchite <- magne.tnps == TRUE & qtnps$magne.motif == "Bronchite" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.tnps.bronchite,useNA = "always")
# Recours alternatif
magne.tnps.bronchite.alt <- magne.tnps.bronchite == TRUE & 
  qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$magne.rec.comp.med2) == TRUE | qtnps$magne.rec.comp.med2 == "Non") & 
  qtnps$med.bronchite == "Non" & camp.med.bronchite == FALSE
table(magne.tnps.bronchite.alt,useNA = "always")

#### Recours alternatif à un ostéopathe NPS pour une bronchite
# Manipulation préalable : Recours à un ostéopathe TNPS pour une bronchite
osteo.tnps.bronchite <- osteo.tnps == TRUE & qtnps$osteo.motif == "Bronchite" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.tnps.bronchite,useNA = "always")
# Recours alternatif
osteo.tnps.bronchite.alt <- osteo.tnps.bronchite == TRUE & 
  qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$osteo.rec.comp.med2) == TRUE | qtnps$osteo.rec.comp.med2 == "Non") & 
  qtnps$med.bronchite == "Non" & camp.med.bronchite == FALSE
table(osteo.tnps.bronchite.alt,useNA = "always")

#### Recours alternatif à un rebouteux NPS pour une bronchite
# Manipulation préalable : Recours à un rebouteux TNPS pour une bronchite
rebout.tnps.bronchite <- rebout.tnps == TRUE & qtnps$rebout.motif == "Bronchite" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.tnps.bronchite,useNA = "always")
# Recours alternatif
rebout.tnps.bronchite.alt <- rebout.tnps.bronchite == TRUE & 
  qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$rebout.rec.comp.med2) == TRUE | qtnps$rebout.rec.comp.med2 == "Non") & 
  qtnps$med.bronchite == "Non" & camp.med.bronchite == FALSE
table(rebout.tnps.bronchite.alt,useNA = "always")

#### Recours alternatif à un TA-NPS pour une bronchite
# Manipulation préalable : recours à un TA-NPS pour une bronchite
camp.tnps.bronchite <- acup.tnps.bronchite|chiro.tnps.bronchite|homeo.tnps.bronchite|
  magne.tnps.bronchite|
  osteo.tnps.bronchite|rebout.tnps.bronchite
table(camp.tnps.bronchite,useNA = "always")
# Recours alternatif
camp.tnps.bronchite.alt <- acup.tnps.bronchite.alt|chiro.tnps.bronchite.alt|
  homeo.tnps.bronchite.alt|
  magne.tnps.bronchite.alt|
  osteo.tnps.bronchite.alt|rebout.tnps.bronchite.alt
table(camp.tnps.bronchite.alt,useNA = "always")

### Recours alternatif pour une dépression

#### Recours alternatif à un acupuncteur NPS pour une dépression
# Manipulation préalable : Recours à un acupuncteur TNPS pour une dépression
acup.tnps.depression <- acup.tnps == TRUE & qtnps$acup.motif == "Dépression" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.tnps.depression,useNA = "always")
# Recours alternatif
acup.tnps.depression.alt <- acup.tnps.depression == TRUE & 
  qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$acup.rec.comp.med2) == TRUE | qtnps$acup.rec.comp.med2 == "Non") & 
  qtnps$med.depression == "Non" & camp.med.depression == FALSE
table(acup.tnps.depression.alt,useNA = "always")

#### Recours alternatif à un chiropracteur NPS pour une dépression
# Manipulation préalable : Recours à un chiropracteur TNPS pour une dépression
chiro.tnps.depression <- chiro.tnps == TRUE & qtnps$chiro.motif == "Dépression" &
  is.na(qtnps$chiro.motif.autre) == TRUE
table(chiro.tnps.depression,useNA = "always")
# Recours alternatif
chiro.tnps.depression.alt <- chiro.tnps.depression == TRUE & 
  qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$chiro.rec.comp.med2) == TRUE | qtnps$chiro.rec.comp.med2 == "Non") & 
  qtnps$med.depression == "Non" & camp.med.depression == FALSE
table(chiro.tnps.depression.alt,useNA = "always")

#### Recours alternatif à un homéopathe NPS pour une dépression
# Manipulation préalable : Recours à un homéopathe TNPS pour une dépression
homeo.tnps.depression <- homeo.tnps == TRUE & qtnps$homeo.motif == "Dépression" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.tnps.depression,useNA = "always")
# Recours alternatif
homeo.tnps.depression.alt <- homeo.tnps.depression == TRUE & 
  qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$homeo.rec.comp.med2) == TRUE | qtnps$homeo.rec.comp.med2 == "Non") & 
  qtnps$med.depression == "Non" & camp.med.depression == FALSE
table(homeo.tnps.depression.alt,useNA = "always")

#### Recours alternatif à un magnétiseur NPS pour une dépression
# Manipulation préalable : Recours à un magnétiseur TNPS pour une dépression
magne.tnps.depression <- magne.tnps == TRUE & qtnps$magne.motif == "Dépression" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.tnps.depression,useNA = "always")
# Recours alternatif
magne.tnps.depression.alt <- magne.tnps.depression == TRUE & 
  qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$magne.rec.comp.med2) == TRUE | qtnps$magne.rec.comp.med2 == "Non") & 
  qtnps$med.depression == "Non" & camp.med.depression == FALSE
table(magne.tnps.depression.alt,useNA = "always")

#### Recours alternatif à un ostéopathe NPS pour une dépression
# Manipulation préalable : Recours à un ostéopathe TNPS pour une dépression
osteo.tnps.depression <- osteo.tnps == TRUE & qtnps$osteo.motif == "Dépression" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.tnps.depression,useNA = "always")
# Recours alternatif
osteo.tnps.depression.alt <- osteo.tnps.depression == TRUE & 
  qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$osteo.rec.comp.med2) == TRUE | qtnps$osteo.rec.comp.med2 == "Non") & 
  qtnps$med.depression == "Non" & camp.med.depression == FALSE
table(osteo.tnps.depression.alt,useNA = "always")

#### Recours alternatif à un rebouteux NPS pour une dépression
# Manipulation préalable : Recours à un rebouteux TNPS pour une dépression
rebout.tnps.depression <- rebout.tnps == TRUE & qtnps$rebout.motif == "Dépression" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.tnps.depression,useNA = "always")
# Recours alternatif
rebout.tnps.depression.alt <- rebout.tnps.depression == TRUE & 
  qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$rebout.rec.comp.med2) == TRUE | qtnps$rebout.rec.comp.med2 == "Non") & 
  qtnps$med.depression == "Non" & camp.med.depression == FALSE
table(rebout.tnps.depression.alt,useNA = "always")

#### Recours alternatif à un TA-NPS pour une dépression
# Manipulation préalable : recours à un TA-NPS pour une dépression
camp.tnps.depression <- acup.tnps.depression|chiro.tnps.depression|homeo.tnps.depression|
  magne.tnps.depression|
  osteo.tnps.depression|rebout.tnps.depression
table(camp.tnps.depression,useNA = "always")
# Recours alternatif
camp.tnps.depression.alt <- acup.tnps.depression.alt|chiro.tnps.depression.alt|
  homeo.tnps.depression.alt|
  magne.tnps.depression.alt|
  osteo.tnps.depression.alt|rebout.tnps.depression.alt
table(camp.tnps.depression.alt,useNA = "always")

### Recours alternatif pour une grippe ou un syndrome grippal

#### Recours alternatif à un acupuncteur NPS pour une grippe ou un syndrome grippal
# Manipulation préalable : Recours à un acupuncteur TNPS pour une grippe ou un 
#syndrome grippal
acup.tnps.grippe <- acup.tnps == TRUE &
  qtnps$acup.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.tnps.grippe,useNA = "always")
# Recours alternatif
acup.tnps.grippe.alt <- acup.tnps.grippe == TRUE & 
  qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$acup.rec.comp.med2) == TRUE | qtnps$acup.rec.comp.med2 == "Non") & 
  qtnps$med.grippe == "Non" & camp.med.grippe == FALSE
table(acup.tnps.grippe.alt,useNA = "always")

#### Recours alternatif à un chiropracteur NPS pour une grippe ou un syndrome grippal
# Manipulation préalable : Recours à un chiropracteur TNPS pour une grippe ou un 
#syndrome grippal
chiro.tnps.grippe <- chiro.tnps == TRUE &
  qtnps$chiro.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$chiro.motif.autre) == TRUE
table(chiro.tnps.grippe,useNA = "always")
# Recours alternatif
chiro.tnps.grippe.alt <- chiro.tnps.grippe == TRUE & 
  qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$chiro.rec.comp.med2) == TRUE | qtnps$chiro.rec.comp.med2 == "Non") & 
  qtnps$med.grippe == "Non" & camp.med.grippe == FALSE
table(chiro.tnps.grippe.alt,useNA = "always")

#### Recours alternatif à un homéopathe NPS pour une grippe ou un syndrome grippal
# Manipulation préalable : Recours à un homéopathe TNPS pour une grippe ou un
#syndrome grippal
homeo.tnps.grippe <- homeo.tnps == TRUE &
  qtnps$homeo.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.tnps.grippe,useNA = "always")
# Recours alternatif
homeo.tnps.grippe.alt <- homeo.tnps.grippe == TRUE & 
  qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$homeo.rec.comp.med2) == TRUE | qtnps$homeo.rec.comp.med2 == "Non") & 
  qtnps$med.grippe == "Non" & camp.med.grippe == FALSE
table(homeo.tnps.grippe.alt,useNA = "always")

#### Recours alternatif à un magnétiseur NPS pour une grippe ou un syndrome grippal
# Manipulation préalable : Recours à un magnétiseur TNPS pour une grippe ou un
#syndrome grippal
magne.tnps.grippe <- magne.tnps == TRUE &
  qtnps$magne.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.tnps.grippe,useNA = "always")
# Recours alternatif
magne.tnps.grippe.alt <- magne.tnps.grippe == TRUE & 
  qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$magne.rec.comp.med2) == TRUE | qtnps$magne.rec.comp.med2 == "Non") & 
  qtnps$med.grippe == "Non" & camp.med.grippe == FALSE
table(magne.tnps.grippe.alt,useNA = "always")

#### Recours alternatif à un ostéopathe NPS pour une grippe ou un syndrome grippal
# Manipulation préalable : Recours à un ostéopathe TNPS pour une grippe ou un
#syndrome grippal
osteo.tnps.grippe <- osteo.tnps == TRUE &
  qtnps$osteo.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.tnps.grippe,useNA = "always")
# Recours alternatif
osteo.tnps.grippe.alt <- osteo.tnps.grippe == TRUE & 
  qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$osteo.rec.comp.med2) == TRUE | qtnps$osteo.rec.comp.med2 == "Non") & 
  qtnps$med.grippe == "Non" & camp.med.grippe == FALSE
table(osteo.tnps.grippe.alt,useNA = "always")

#### Recours alternatif à un rebouteux NPS pour une grippe ou un syndrome grippal
# Manipulation préalable : Recours à un rebouteux TNPS pour une grippe ou un
#syndrome grippal
rebout.tnps.grippe <- rebout.tnps == TRUE &
  qtnps$rebout.motif == "Grippe ou syndrome grippal" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.tnps.grippe,useNA = "always")
# Recours alternatif
rebout.tnps.grippe.alt <- rebout.tnps.grippe == TRUE & 
  qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$rebout.rec.comp.med2) == TRUE | qtnps$rebout.rec.comp.med2 == "Non") & 
  qtnps$med.grippe == "Non" & camp.med.grippe == FALSE
table(rebout.tnps.grippe.alt,useNA = "always")

#### Recours alternatif à un TA-NPS pour une grippe ou un syndrome grippal
# Manipulation préalable : recours à un TA-NPS pour une grippe ou un syndrome
#grippal
camp.tnps.grippe <- acup.tnps.grippe|chiro.tnps.grippe|homeo.tnps.grippe|
  magne.tnps.grippe|
  osteo.tnps.grippe|rebout.tnps.grippe
table(camp.tnps.grippe,useNA = "always")
# Recours alternatif
camp.tnps.grippe.alt <- acup.tnps.grippe.alt|chiro.tnps.grippe.alt|
  homeo.tnps.grippe.alt|
  magne.tnps.grippe.alt|
  osteo.tnps.grippe.alt|rebout.tnps.grippe.alt
table(camp.tnps.grippe.alt,useNA = "always")

### Recours alternatif pour un mal de gorge

#### Recours alternatif à un acupuncteur NPS pour un mal de gorge
# Manipulation préalable : Recours à un acupuncteur TNPS pour un mal de gorge
acup.tnps.gorge <- acup.tnps == TRUE & qtnps$acup.motif == "Mal de gorge" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.tnps.gorge,useNA = "always")
# Recours alternatif
acup.tnps.gorge.alt <- acup.tnps.gorge == TRUE & 
  qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$acup.rec.comp.med2) == TRUE | qtnps$acup.rec.comp.med2 == "Non") & 
  qtnps$med.gorge == "Non" & camp.med.gorge == FALSE
table(acup.tnps.gorge.alt,useNA = "always")

#### Recours alternatif à un chiropracteur NPS pour un mal de gorge
# Manipulation préalable : Recours à un chiropracteur TNPS pour un mal de gorge
chiro.tnps.gorge <- chiro.tnps == TRUE & qtnps$chiro.motif == "Mal de gorge" &
  is.na(qtnps$chiro.motif.autre) == TRUE
table(chiro.tnps.gorge,useNA = "always")
# Recours alternatif
chiro.tnps.gorge.alt <- chiro.tnps.gorge == TRUE & 
  qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$chiro.rec.comp.med2) == TRUE | qtnps$chiro.rec.comp.med2 == "Non") & 
  qtnps$med.gorge == "Non" & camp.med.gorge == FALSE
table(chiro.tnps.gorge.alt,useNA = "always")

#### Recours alternatif à un homéopathe NPS pour un mal de gorge
# Manipulation préalable : Recours à un homéopathe TNPS pour un mal de gorge
homeo.tnps.gorge <- homeo.tnps == TRUE & qtnps$homeo.motif == "Mal de gorge" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.tnps.gorge,useNA = "always")
# Recours alternatif
homeo.tnps.gorge.alt <- homeo.tnps.gorge == TRUE & 
  qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$homeo.rec.comp.med2) == TRUE | qtnps$homeo.rec.comp.med2 == "Non") & 
  qtnps$med.gorge == "Non" & camp.med.gorge == FALSE
table(homeo.tnps.gorge.alt,useNA = "always")

#### Recours alternatif à un magnétiseur NPS pour un mal de gorge
# Manipulation préalable : Recours à un magnétiseur TNPS pour un mal de gorge
magne.tnps.gorge <- magne.tnps == TRUE & qtnps$magne.motif == "Mal de gorge" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.tnps.gorge,useNA = "always")
# Recours alternatif
magne.tnps.gorge.alt <- magne.tnps.gorge == TRUE & 
  qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$magne.rec.comp.med2) == TRUE | qtnps$magne.rec.comp.med2 == "Non") & 
  qtnps$med.gorge == "Non" & camp.med.gorge == FALSE
table(magne.tnps.gorge.alt,useNA = "always")

#### Recours alternatif à un ostéopathe NPS pour un mal de gorge
# Manipulation préalable : Recours à un ostéopathe TNPS pour un mal de gorge
osteo.tnps.gorge <- osteo.tnps == TRUE & qtnps$osteo.motif == "Mal de gorge" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.tnps.gorge,useNA = "always")
# Recours alternatif
osteo.tnps.gorge.alt <- osteo.tnps.gorge == TRUE & 
  qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$osteo.rec.comp.med2) == TRUE | qtnps$osteo.rec.comp.med2 == "Non") & 
  qtnps$med.gorge == "Non" & camp.med.gorge == FALSE
table(osteo.tnps.gorge.alt,useNA = "always")

#### Recours alternatif à un rebouteux NPS pour un mal de gorge
# Manipulation préalable : Recours à un rebouteux TNPS pour un mal de gorge
rebout.tnps.gorge <- rebout.tnps == TRUE & qtnps$rebout.motif == "Mal de gorge" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.tnps.gorge,useNA = "always")
# Recours alternatif
rebout.tnps.gorge.alt <- rebout.tnps.gorge == TRUE & 
  qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$rebout.rec.comp.med2) == TRUE | qtnps$rebout.rec.comp.med2 == "Non") & 
  qtnps$med.gorge == "Non" & camp.med.gorge == FALSE
table(rebout.tnps.gorge.alt,useNA = "always")

#### Recours alternatif à un TA-NPS pour un mal de gorge
# Manipulation préalable : recours à un TA-NPS pour un mal de gorge
camp.tnps.gorge <- acup.tnps.gorge|chiro.tnps.gorge|homeo.tnps.gorge|magne.tnps.gorge|
  osteo.tnps.gorge|rebout.tnps.gorge
table(camp.tnps.gorge,useNA = "always")
# Recours alternatif
camp.tnps.gorge.alt <- acup.tnps.gorge.alt|chiro.tnps.gorge.alt|homeo.tnps.gorge.alt|
  magne.tnps.gorge.alt|
  osteo.tnps.gorge.alt|rebout.tnps.gorge.alt
table(camp.tnps.gorge.alt,useNA = "always")

### Recours alternatif pour des maux de tête ou migraines

#### Recours alternatif à un acupuncteur NPS pour des maux de tête ou migraines
# Manipulation préalable : Recours à un acupuncteur TNPS 
#pour des maux de tête ou migraines
acup.tnps.migraine <- acup.tnps == TRUE &
  qtnps$acup.motif == "Maux de tête ou migraine" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.tnps.migraine,useNA = "always")
# Recours alternatif
acup.tnps.migraine.alt <- acup.tnps.migraine == TRUE & 
  qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$acup.rec.comp.med2) == TRUE | qtnps$acup.rec.comp.med2 == "Non") & 
  qtnps$med.migraine == "Non" & camp.med.migraine == FALSE
table(acup.tnps.migraine.alt,useNA = "always")

#### Recours alternatif à un chiropracteur NPS pour des maux de tête ou migraines
# Manipulation préalable : Recours à un chiropracteur TNPS 
#pour des maux de tête ou migraines
chiro.tnps.migraine <- chiro.tnps == TRUE &
  qtnps$chiro.motif == "Maux de tête ou migraine" &
  is.na(qtnps$chiro.motif.autre) == TRUE
table(chiro.tnps.migraine,useNA = "always")
# Recours alternatif
chiro.tnps.migraine.alt <- chiro.tnps.migraine == TRUE & 
  qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$chiro.rec.comp.med2) == TRUE | qtnps$chiro.rec.comp.med2 == "Non") & 
  qtnps$med.migraine == "Non" & camp.med.migraine == FALSE
table(chiro.tnps.migraine.alt,useNA = "always")

#### Recours alternatif à un homéopathe NPS pour des maux de tête ou migraines
# Manipulation préalable : Recours à un homéopathe TNPS 
#pour des maux de tête ou migraines
homeo.tnps.migraine <- homeo.tnps == TRUE &
  qtnps$homeo.motif == "Maux de tête ou migraine" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.tnps.migraine,useNA = "always")
# Recours alternatif
homeo.tnps.migraine.alt <- homeo.tnps.migraine == TRUE & 
  qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$homeo.rec.comp.med2) == TRUE | qtnps$homeo.rec.comp.med2 == "Non") & 
  qtnps$med.migraine == "Non" & camp.med.migraine == FALSE
table(homeo.tnps.migraine.alt,useNA = "always")

#### Recours alternatif à un magnétiseur NPS pour des maux de tête ou migraines
# Manipulation préalable : Recours à un magnétiseur TNPS pour des maux 
#de tête ou migraines
magne.tnps.migraine <- magne.tnps == TRUE &
  qtnps$magne.motif == "Maux de tête ou migraine" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.tnps.migraine,useNA = "always")
# Recours alternatif
magne.tnps.migraine.alt <- magne.tnps.migraine == TRUE & 
  qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$magne.rec.comp.med2) == TRUE | qtnps$magne.rec.comp.med2 == "Non") & 
  qtnps$med.migraine == "Non" & camp.med.migraine == FALSE
table(magne.tnps.migraine.alt,useNA = "always")

#### Recours alternatif à un ostéopathe NPS pour des maux de tête ou migraines
# Manipulation préalable : Recours à un ostéopathe TNPS 
#pour des maux de tête ou migraines
osteo.tnps.migraine <- osteo.tnps == TRUE &
  qtnps$osteo.motif == "Maux de tête ou migraine" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.tnps.migraine,useNA = "always")
# Recours alternatif
osteo.tnps.migraine.alt <- osteo.tnps.migraine == TRUE & 
  qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$osteo.rec.comp.med2) == TRUE | qtnps$osteo.rec.comp.med2 == "Non") & 
  qtnps$med.migraine == "Non" & camp.med.migraine == FALSE
table(osteo.tnps.migraine.alt,useNA = "always")

#### Recours alternatif à un rebouteux NPS pour des maux de tête ou migraines
# Manipulation préalable : Recours à un rebouteux TNPS pour des 
#maux de tête ou migraines
rebout.tnps.migraine <- rebout.tnps == TRUE &
  qtnps$rebout.motif == "Maux de tête ou migraine" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.tnps.migraine,useNA = "always")
# Recours alternatif
rebout.tnps.migraine.alt <- rebout.tnps.migraine == TRUE & 
  qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$rebout.rec.comp.med2) == TRUE | qtnps$rebout.rec.comp.med2 == "Non") & 
  qtnps$med.migraine == "Non" & camp.med.migraine == FALSE
table(rebout.tnps.migraine.alt,useNA = "always")

#### Recours alternatif à un TA-NPS pour des maux de tête ou migraines
# Manipulation préalable : recours à un TA-NPS pour des maux de tête ou migraines
camp.tnps.migraine <- acup.tnps.migraine|chiro.tnps.migraine|homeo.tnps.migraine|
  magne.tnps.migraine|
  osteo.tnps.migraine|rebout.tnps.migraine
table(camp.tnps.migraine,useNA = "always")
# Recours alternatif
camp.tnps.migraine.alt <- acup.tnps.migraine.alt|chiro.tnps.migraine.alt|
  homeo.tnps.migraine.alt|
  magne.tnps.migraine.alt|
  osteo.tnps.migraine.alt|rebout.tnps.migraine.alt
table(camp.tnps.migraine.alt,useNA = "always")

### Recours alternatif pour une douleur au cou

#### Recours alternatif à un acupuncteur NPS pour une douleur au cou
# Manipulation préalable : Recours à un acupuncteur TNPS pour une douleur au cou
acup.tnps.cou <- acup.tnps == TRUE &
  qtnps$acup.motif == "Douleur au cou" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.tnps.cou,useNA = "always")
# Recours alternatif
acup.tnps.cou.alt <- acup.tnps.cou == TRUE & 
  qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$acup.rec.comp.med2) == TRUE | qtnps$acup.rec.comp.med2 == "Non") & 
  qtnps$med.doul.cou == "Non" & camp.med.cou == FALSE
table(acup.tnps.cou.alt,useNA = "always")

#### Recours alternatif à un chiropracteur NPS pour une douleur au cou
# Manipulation préalable : Recours à un chiropracteur TNPS pour une douleur au cou
chiro.tnps.cou <- chiro.tnps == TRUE &
  qtnps$chiro.motif == "Douleur au cou" &
  is.na(qtnps$chiro.motif.autre) == TRUE
table(chiro.tnps.cou,useNA = "always")
# Recours alternatif
chiro.tnps.cou.alt <- chiro.tnps.cou == TRUE & 
  qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$chiro.rec.comp.med2) == TRUE | qtnps$chiro.rec.comp.med2 == "Non") & 
  qtnps$med.doul.cou == "Non" & camp.med.cou == FALSE
table(chiro.tnps.cou.alt,useNA = "always")

#### Recours alternatif à un homéopathe NPS pour une douleur au cou
# Manipulation préalable : Recours à un homéopathe TNPS pour douleur au cou
homeo.tnps.cou <- homeo.tnps == TRUE &
  qtnps$homeo.motif == "Douleur au cou" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.tnps.cou,useNA = "always")
# Recours alternatif
homeo.tnps.cou.alt <- homeo.tnps.cou == TRUE & 
  qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$homeo.rec.comp.med2) == TRUE | qtnps$homeo.rec.comp.med2 == "Non") & 
  qtnps$med.doul.cou == "Non" & camp.med.cou == FALSE
table(homeo.tnps.cou.alt,useNA = "always")

#### Recours alternatif à un magnétiseur NPS pour une douleur au cou
# Manipulation préalable : Recours à un magnétiseur TNPS pour une douleur au cou
magne.tnps.cou <- magne.tnps == TRUE &
  qtnps$magne.motif == "Douleur au cou" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.tnps.cou,useNA = "always")
# Recours alternatif
magne.tnps.cou.alt <- magne.tnps.cou == TRUE & 
  qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$magne.rec.comp.med2) == TRUE | qtnps$magne.rec.comp.med2 == "Non") & 
  qtnps$med.doul.cou == "Non" & camp.med.cou == FALSE
table(magne.tnps.cou.alt,useNA = "always")

#### Recours alternatif à un ostéopathe NPS pour une douleur au cou
# Manipulation préalable : Recours à un ostéopathe TNPS pour une douleur au cou
osteo.tnps.cou <- osteo.tnps == TRUE &
  qtnps$osteo.motif == "Douleur au cou" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.tnps.cou,useNA = "always")
# Recours alternatif
osteo.tnps.cou.alt <- osteo.tnps.cou == TRUE & 
  qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$osteo.rec.comp.med2) == TRUE | qtnps$osteo.rec.comp.med2 == "Non") & 
  qtnps$med.doul.cou == "Non" & camp.med.cou == FALSE
table(osteo.tnps.cou.alt,useNA = "always")

#### Recours alternatif à un rebouteux NPS pour une douleur au cou
# Manipulation préalable : Recours à un rebouteux TNPS pour une douleur au cou
rebout.tnps.cou <- rebout.tnps == TRUE &
  qtnps$rebout.motif == "Douleur au cou" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.tnps.cou,useNA = "always")
# Recours alternatif
rebout.tnps.cou.alt <- rebout.tnps.cou == TRUE & 
  qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$rebout.rec.comp.med2) == TRUE | qtnps$rebout.rec.comp.med2 == "Non") & 
  qtnps$med.doul.cou == "Non" & camp.med.cou == FALSE
table(rebout.tnps.cou.alt,useNA = "always")

#### Recours alternatif à un TA-NPS pour une douleur au cou
# Manipulation préalable : recours à un TA-NPS pour une douleur au cou
camp.tnps.cou <- acup.tnps.cou|chiro.tnps.cou|homeo.tnps.cou|
  magne.tnps.cou|
  osteo.tnps.cou|rebout.tnps.cou
table(camp.tnps.cou,useNA = "always")
# Recours alternatif
camp.tnps.cou.alt <- acup.tnps.cou.alt|chiro.tnps.cou.alt|
  homeo.tnps.cou.alt|
  magne.tnps.cou.alt|
  osteo.tnps.cou.alt|rebout.tnps.cou.alt
table(camp.tnps.cou.alt,useNA = "always")

### Recours alternatif pour une douleur de membre supérieur

#### Recours alternatif à un acupuncteur NPS pour une douleur de membre supérieur
# Manipulation préalable : Recours à un acupuncteur TNPS 
#pour une douleur de membre supérieur 

acup.tnps.msup <- acup.tnps == TRUE &
  qtnps$acup.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.tnps.msup,useNA = "always")
# Recours alternatif
acup.tnps.msup.alt <- acup.tnps.msup == TRUE & 
  qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$acup.rec.comp.med2) == TRUE | qtnps$acup.rec.comp.med2 == "Non") & 
  qtnps$med.doul.msup == "Non" & camp.med.msup == FALSE
table(acup.tnps.msup.alt,useNA = "always")

#### Recours alternatif à un chiropracteur NPS pour une douleur de membre supérieur
# Manipulation préalable : Recours à un chiropracteur TNPS 
#pour une douleur de membre supérieur 

chiro.tnps.msup <- chiro.tnps == TRUE &
  qtnps$chiro.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$chiro.motif.autre) == TRUE
table(chiro.tnps.msup,useNA = "always")
# Recours alternatif
chiro.tnps.msup.alt <- chiro.tnps.msup == TRUE & 
  qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$chiro.rec.comp.med2) == TRUE | qtnps$chiro.rec.comp.med2 == "Non") & 
  qtnps$med.doul.msup == "Non" & camp.med.msup == FALSE
table(chiro.tnps.msup.alt,useNA = "always")

#### Recours alternatif à un homéopathe NPS pour une douleur de membre supérieur
# Manipulation préalable : Recours à un homéopathe TNPS 
#pour une douleur de membre supérieur

homeo.tnps.msup <- homeo.tnps == TRUE &
  qtnps$homeo.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.tnps.msup,useNA = "always")
# Recours alternatif
homeo.tnps.msup.alt <- homeo.tnps.msup == TRUE & 
  qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$homeo.rec.comp.med2) == TRUE | qtnps$homeo.rec.comp.med2 == "Non") & 
  qtnps$med.doul.msup == "Non" & camp.med.msup == FALSE
table(homeo.tnps.msup.alt,useNA = "always")

#### Recours alternatif à un magnétiseur NPS pour une douleur de membre supérieur
# Manipulation préalable : Recours à un magnétiseur TNPS 
#pour une douleur de membre supérieur

magne.tnps.msup <- magne.tnps == TRUE &
  qtnps$magne.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.tnps.msup,useNA = "always")
# Recours alternatif
magne.tnps.msup.alt <- magne.tnps.msup == TRUE & 
  qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$magne.rec.comp.med2) == TRUE | qtnps$magne.rec.comp.med2 == "Non") & 
  qtnps$med.doul.msup == "Non" & camp.med.msup == FALSE
table(magne.tnps.msup.alt,useNA = "always")

#### Recours alternatif à un ostéopathe NPS pour une douleur de membre supérieur
# Manipulation préalable : Recours à un ostéopathe TNPS 
#pour une douleur de membre supérieur

osteo.tnps.msup <- osteo.tnps == TRUE &
  qtnps$osteo.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.tnps.msup,useNA = "always")
# Recours alternatif
osteo.tnps.msup.alt <- osteo.tnps.msup == TRUE & 
  qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$osteo.rec.comp.med2) == TRUE | qtnps$osteo.rec.comp.med2 == "Non") & 
  qtnps$med.doul.msup == "Non" & camp.med.msup == FALSE
table(osteo.tnps.msup.alt,useNA = "always")

#### Recours alternatif à un rebouteux NPS pour une douleur de membre supérieur
# Manipulation préalable : Recours à un rebouteux TNPS 
#pour une douleur de membre supérieur

rebout.tnps.msup <- rebout.tnps == TRUE &
  qtnps$rebout.motif == "Douleur à l'épaule, au coude, au poignet ou à la main" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.tnps.msup,useNA = "always")
# Recours alternatif
rebout.tnps.msup.alt <- rebout.tnps.msup == TRUE & 
  qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$rebout.rec.comp.med2) == TRUE | qtnps$rebout.rec.comp.med2 == "Non") & 
  qtnps$med.doul.msup == "Non" & camp.med.msup == FALSE
table(rebout.tnps.msup.alt,useNA = "always")

#### Recours alternatif à un TA-NPS pour une douleur de membre supérieur
# Manipulation préalable : recours à un TA-NPS 
#pour une douleur de membre supérieur
camp.tnps.msup <- acup.tnps.msup|chiro.tnps.msup|homeo.tnps.msup|
  magne.tnps.msup|
  osteo.tnps.msup|rebout.tnps.msup
table(camp.tnps.msup,useNA = "always")
# Recours alternatif
camp.tnps.msup.alt <- acup.tnps.msup.alt|chiro.tnps.msup.alt|
  homeo.tnps.msup.alt|
  magne.tnps.msup.alt|
  osteo.tnps.msup.alt|rebout.tnps.msup.alt
table(camp.tnps.msup.alt,useNA = "always")

### Recours alternatif pour du stress ou de l'anxiété

#### Recours alternatif à un acupuncteur NPS pour du stress ou de l'anxiété
# Manipulation préalable : Recours à un acupuncteur TNPS pour du stress ou de l'anxiété 

acup.tnps.stress <- acup.tnps == TRUE &
  qtnps$acup.motif == "Stress ou anxiété" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.tnps.stress,useNA = "always")
# Recours alternatif
acup.tnps.stress.alt <- acup.tnps.stress == TRUE & 
  qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$acup.rec.comp.med2) == TRUE | qtnps$acup.rec.comp.med2 == "Non") & 
  qtnps$med.stress == "Non" & camp.med.stress == FALSE
table(acup.tnps.stress.alt,useNA = "always")

#### Recours alternatif à un chiropracteur NPS pour du stress ou de l'anxiété
# Manipulation préalable : Recours à un chiropracteur TNPS pour du stress 
#ou de l'anxiété 

chiro.tnps.stress <- chiro.tnps == TRUE &
  qtnps$chiro.motif == "Stress ou anxiété" &
  is.na(qtnps$chiro.motif.autre) == TRUE
table(chiro.tnps.stress,useNA = "always")
# Recours alternatif
chiro.tnps.stress.alt <- chiro.tnps.stress == TRUE & 
  qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$chiro.rec.comp.med2) == TRUE | qtnps$chiro.rec.comp.med2 == "Non") & 
  qtnps$med.stress == "Non" & camp.med.stress == FALSE
table(chiro.tnps.stress.alt,useNA = "always")

#### Recours alternatif à un homéopathe NPS pour du stress ou de l'anxiété
# Manipulation préalable : Recours à un homéopathe TNPS pour du stress 
#ou de l'anxiété

homeo.tnps.stress <- homeo.tnps == TRUE &
  qtnps$homeo.motif == "Stress ou anxiété" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.tnps.stress,useNA = "always")
# Recours alternatif
homeo.tnps.stress.alt <- homeo.tnps.stress == TRUE & 
  qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$homeo.rec.comp.med2) == TRUE | qtnps$homeo.rec.comp.med2 == "Non") & 
  qtnps$med.stress == "Non" & camp.med.stress == FALSE
table(homeo.tnps.stress.alt,useNA = "always")

#### Recours alternatif à un magnétiseur NPS pour du stress ou de l'anxiété
# Manipulation préalable : Recours à un magnétiseur TNPS pour du stress 
#ou de l'anxiété

magne.tnps.stress <- magne.tnps == TRUE &
  qtnps$magne.motif == "Stress ou anxiété" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.tnps.stress,useNA = "always")
# Recours alternatif
magne.tnps.stress.alt <- magne.tnps.stress == TRUE & 
  qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$magne.rec.comp.med2) == TRUE | qtnps$magne.rec.comp.med2 == "Non") & 
  qtnps$med.stress == "Non" & camp.med.stress == FALSE
table(magne.tnps.stress.alt,useNA = "always")

#### Recours alternatif à un ostéopathe NPS pour du stress ou de l'anxiété
# Manipulation préalable : Recours à un ostéopathe TNPS pour du stress 
#ou de l'anxiété

osteo.tnps.stress <- osteo.tnps == TRUE &
  qtnps$osteo.motif == "Stress ou anxiété" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.tnps.stress,useNA = "always")
# Recours alternatif
osteo.tnps.stress.alt <- osteo.tnps.stress == TRUE & 
  qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$osteo.rec.comp.med2) == TRUE | qtnps$osteo.rec.comp.med2 == "Non") & 
  qtnps$med.stress == "Non" & camp.med.stress == FALSE
table(osteo.tnps.stress.alt,useNA = "always")

#### Recours alternatif à un rebouteux NPS pour du stress ou de l'anxiété
# Manipulation préalable : Recours à un rebouteux TNPS pour du stress 
#ou de l'anxiété

rebout.tnps.stress <- rebout.tnps == TRUE &
  qtnps$rebout.motif == "Stress ou anxiété" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.tnps.stress,useNA = "always")
# Recours alternatif
rebout.tnps.stress.alt <- rebout.tnps.stress == TRUE & 
  qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$rebout.rec.comp.med2) == TRUE | qtnps$rebout.rec.comp.med2 == "Non") & 
  qtnps$med.stress == "Non" & camp.med.stress == FALSE
table(rebout.tnps.stress.alt,useNA = "always")

#### Recours alternatif à un TA-NPS pour du stress ou de l'anxiété
# Manipulation préalable : recours à un TA-NPS pour du stress ou de l'anxiété

camp.tnps.stress <- acup.tnps.stress|chiro.tnps.stress|homeo.tnps.stress|
  magne.tnps.stress|
  osteo.tnps.stress|rebout.tnps.stress
table(camp.tnps.stress,useNA = "always")
# Recours alternatif
camp.tnps.stress.alt <- acup.tnps.stress.alt|chiro.tnps.stress.alt|
  homeo.tnps.stress.alt|
  magne.tnps.stress.alt|
  osteo.tnps.stress.alt|rebout.tnps.stress.alt
table(camp.tnps.stress.alt,useNA = "always")

### Recours alternatif pour une douleur de membre inférieur

#### Recours alternatif à un acupuncteur NPS pour une douleur de membre inférieur
# Manipulation préalable : Recours à un acupuncteur TNPS pour une douleur de 
#membre inférieur 

acup.tnps.minf <- acup.tnps == TRUE &
  qtnps$acup.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$acup.motif.autre) == TRUE
table(acup.tnps.minf,useNA = "always")
# Recours alternatif
acup.tnps.minf.alt <- acup.tnps.minf == TRUE & 
  qtnps$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$acup.rec.comp.med2) == TRUE | qtnps$acup.rec.comp.med2 == "Non") & 
  qtnps$med.doul.minf == "Non" & camp.med.minf == FALSE
table(acup.tnps.minf.alt,useNA = "always")

#### Recours alternatif à un chiropracteur NPS pour une douleur de membre inférieur
# Manipulation préalable : Recours à un chiropracteur TNPS pour une douleur de 
#membre inférieur 

chiro.tnps.minf <- chiro.tnps == TRUE &
  qtnps$chiro.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$chiro.motif.autre) == TRUE
table(chiro.tnps.minf,useNA = "always")
# Recours alternatif
chiro.tnps.minf.alt <- chiro.tnps.minf == TRUE & 
  qtnps$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$chiro.rec.comp.med2) == TRUE | qtnps$chiro.rec.comp.med2 == "Non") & 
  qtnps$med.doul.minf == "Non" & camp.med.minf == FALSE
table(chiro.tnps.minf.alt,useNA = "always")

#### Recours alternatif à un homéopathe NPS pour une douleur de membre inférieur
# Manipulation préalable : Recours à un homéopathe TNPS pour une douleur de 
#membre inférieur

homeo.tnps.minf <- homeo.tnps == TRUE &
  qtnps$homeo.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$homeo.motif.autre) == TRUE
table(homeo.tnps.minf,useNA = "always")
# Recours alternatif
homeo.tnps.minf.alt <- homeo.tnps.minf == TRUE & 
  qtnps$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$homeo.rec.comp.med2) == TRUE | qtnps$homeo.rec.comp.med2 == "Non") & 
  qtnps$med.doul.minf == "Non" & camp.med.minf == FALSE
table(homeo.tnps.minf.alt,useNA = "always")

#### Recours alternatif à un magnétiseur NPS pour une douleur de membre inférieur
# Manipulation préalable : Recours à un magnétiseur TNPS pour une douleur de 
#membre inférieur

magne.tnps.minf <- magne.tnps == TRUE &
  qtnps$magne.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$magne.motif.autre) == TRUE
table(magne.tnps.minf,useNA = "always")
# Recours alternatif
magne.tnps.minf.alt <- magne.tnps.minf == TRUE & 
  qtnps$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$magne.rec.comp.med2) == TRUE | qtnps$magne.rec.comp.med2 == "Non") & 
  qtnps$med.doul.minf == "Non" & camp.med.minf == FALSE
table(magne.tnps.minf.alt,useNA = "always")

#### Recours alternatif à un ostéopathe NPS pour une douleur de membre inférieur
# Manipulation préalable : Recours à un ostéopathe TNPS pour une douleur de 
#membre inférieur

osteo.tnps.minf <- osteo.tnps == TRUE &
  qtnps$osteo.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$osteo.motif.autre) == TRUE
table(osteo.tnps.minf,useNA = "always")
# Recours alternatif
osteo.tnps.minf.alt <- osteo.tnps.minf == TRUE & 
  qtnps$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$osteo.rec.comp.med2) == TRUE | qtnps$osteo.rec.comp.med2 == "Non") & 
  qtnps$med.doul.minf == "Non" & camp.med.minf == FALSE
table(osteo.tnps.minf.alt,useNA = "always")

#### Recours alternatif à un rebouteux NPS pour une douleur de membre inférieur
# Manipulation préalable : Recours à un rebouteux TNPS pour une douleur de 
#membre inférieur

rebout.tnps.minf <- rebout.tnps == TRUE &
  qtnps$rebout.motif == "Douleur à la hanche, au genou, à la cheville ou au pied" &
  is.na(qtnps$rebout.motif.autre) == TRUE
table(rebout.tnps.minf,useNA = "always")
# Recours alternatif
rebout.tnps.minf.alt <- rebout.tnps.minf == TRUE & 
  qtnps$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" &
  (is.na(qtnps$rebout.rec.comp.med2) == TRUE | qtnps$rebout.rec.comp.med2 == "Non") & 
  qtnps$med.doul.minf == "Non" & camp.med.minf == FALSE
table(rebout.tnps.minf.alt,useNA = "always")

#### Recours alternatif à un TA-NPS pour une douleur de membre inférieur
# Manipulation préalable : recours à un TA-NPS pour une douleur de membre inférieur

camp.tnps.minf <- acup.tnps.minf|chiro.tnps.minf|homeo.tnps.minf|
  magne.tnps.minf|
  osteo.tnps.minf|rebout.tnps.minf
table(camp.tnps.minf,useNA = "always")
# Recours alternatif
camp.tnps.minf.alt <- acup.tnps.minf.alt|chiro.tnps.minf.alt|
  homeo.tnps.minf.alt|
  magne.tnps.minf.alt|
  osteo.tnps.minf.alt|rebout.tnps.minf.alt
table(camp.tnps.minf.alt,useNA = "always")

## Prévalence du recours alternatif à un TA-NPS (Figure X) ----
camp.tnps.alt <- camp.tnps.stress.alt | camp.tnps.minf.alt |
  camp.tnps.dos.alt | camp.tnps.bronchite.alt |
  camp.tnps.depression.alt | camp.tnps.gorge.alt |
  camp.tnps.migraine.alt | camp.tnps.grippe.alt | camp.tnps.cou.alt | 
  camp.tnps.msup.alt | camp.tnps.autre.alt
table(camp.tnps.alt,useNA = "always")
# FALSE  TRUE  <NA> 
#  9055  1423     0 
(1423/10478)*100
# [1] 13.581

## Prévalence du recours alternatif à un acupuncteur NPS (Figure X) ----
acup.tnps.alt <- acup.tnps.stress.alt | acup.tnps.minf.alt |
  acup.tnps.dos.alt | acup.tnps.bronchite.alt |
  acup.tnps.depression.alt | acup.tnps.gorge.alt |
  acup.tnps.migraine.alt | acup.tnps.grippe.alt | acup.tnps.cou.alt | 
  acup.tnps.msup.alt | acup.tnps.autre.alt
table(acup.tnps.alt,useNA = "always")
(76/10478)*100
# [1] 0.72533

## Prévalence du recours alternatif à un chiropracteur NPS (Figure X) ----
chiro.tnps.alt <- chiro.tnps.stress.alt | chiro.tnps.minf.alt |
  chiro.tnps.dos.alt | chiro.tnps.bronchite.alt |
  chiro.tnps.depression.alt | chiro.tnps.gorge.alt |
  chiro.tnps.migraine.alt | chiro.tnps.grippe.alt | chiro.tnps.cou.alt | 
  chiro.tnps.msup.alt | chiro.tnps.autre.alt
table(chiro.tnps.alt,useNA = "always")
(59/10478)*100
# [1] 0.56308

## Prévalence du recours alternatif à un homéopathe NPS (Figure X) ----
homeo.tnps.alt <- homeo.tnps.stress.alt | homeo.tnps.minf.alt |
  homeo.tnps.dos.alt | homeo.tnps.bronchite.alt |
  homeo.tnps.depression.alt | homeo.tnps.gorge.alt |
  homeo.tnps.migraine.alt | homeo.tnps.grippe.alt | homeo.tnps.cou.alt | 
  homeo.tnps.msup.alt | homeo.tnps.autre.alt
table(homeo.tnps.alt,useNA = "always")
(40/10478)*100
# [1] 0.38175

## Prévalence du recours alternatif à un magnétiseur NPS (Figure X) ----
magne.tnps.alt <- magne.tnps.stress.alt | magne.tnps.minf.alt |
  magne.tnps.dos.alt | magne.tnps.bronchite.alt |
  magne.tnps.depression.alt | magne.tnps.gorge.alt |
  magne.tnps.migraine.alt | magne.tnps.grippe.alt | magne.tnps.cou.alt | 
  magne.tnps.msup.alt | magne.tnps.autre.alt
table(magne.tnps.alt,useNA = "always")
(104/10478)*100
# [1] 0.99256

## Prévalence du recours alternatif à un ostéopathe NPS (Figure X) ----
osteo.tnps.alt <- osteo.tnps.stress.alt | osteo.tnps.minf.alt |
  osteo.tnps.dos.alt | osteo.tnps.bronchite.alt |
  osteo.tnps.depression.alt | osteo.tnps.gorge.alt |
  osteo.tnps.migraine.alt | osteo.tnps.grippe.alt | osteo.tnps.cou.alt | 
  osteo.tnps.msup.alt | osteo.tnps.autre.alt
table(osteo.tnps.alt,useNA = "always")
# FALSE  TRUE  <NA> 
#  9247  1231     0
(1231/10478)*100
# [1] 11.748

## Prévalence du recours alternatif à un rebouteux NPS (Figure X) ----
rebout.tnps.alt <- rebout.tnps.stress.alt | rebout.tnps.minf.alt |
  rebout.tnps.dos.alt | rebout.tnps.bronchite.alt |
  rebout.tnps.depression.alt | rebout.tnps.gorge.alt |
  rebout.tnps.migraine.alt | rebout.tnps.grippe.alt | rebout.tnps.cou.alt | 
  rebout.tnps.msup.alt | rebout.tnps.autre.alt
table(rebout.tnps.alt,useNA = "always")
(31/10478)*100
# [1] 0.29586

## Recours complémentaire à un TA-NPS ----

### Recours complémentaire à un TA-NPS pour une douleur de dos : 
# manipulations préliminaires

#### Recours complémentaire à un acupuncteur NPS pour une douleur de dos
acup.tnps.dos.comp <- acup.tnps.dos == TRUE & 
  ((qtnps$acup.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$acup.rec.comp.med2) == FALSE & qtnps$acup.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.dos == "Oui") | camp.med.dos == TRUE)
table(acup.tnps.dos.comp,useNA = "always")

#### Recours complémentaire à un chiropracteur NPS pour une douleur de dos
chiro.tnps.dos.comp <- chiro.tnps.dos == TRUE & 
  ((qtnps$chiro.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$chiro.rec.comp.med2) == FALSE & qtnps$chiro.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.dos == "Oui") | camp.med.dos == TRUE)
table(chiro.tnps.dos.comp,useNA = "always")

#### Recours complémentaire à un homéopathe NPS pour une douleur de dos
homeo.tnps.dos.comp <- homeo.tnps.dos == TRUE & 
  ((qtnps$homeo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$homeo.rec.comp.med2) == FALSE & qtnps$homeo.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.dos == "Oui") | camp.med.dos == TRUE)
table(homeo.tnps.dos.comp,useNA = "always")

#### Recours complémentaire à un magnétiseur NPS pour une douleur de dos
magne.tnps.dos.comp <- magne.tnps.dos == TRUE & 
  ((qtnps$magne.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$magne.rec.comp.med2) == FALSE & qtnps$magne.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.dos == "Oui") | camp.med.dos == TRUE)
table(magne.tnps.dos.comp,useNA = "always")

#### Recours complémentaire à un ostéopathe NPS pour une douleur de dos
osteo.tnps.dos.comp <- osteo.tnps.dos == TRUE & 
  ((qtnps$osteo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$osteo.rec.comp.med2) == FALSE & qtnps$osteo.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.dos == "Oui") | camp.med.dos == TRUE)
table(osteo.tnps.dos.comp,useNA = "always")

#### Recours complémentaire à un rebouteux NPS pour une douleur de dos
rebout.tnps.dos.comp <- rebout.tnps.dos == TRUE & 
  ((qtnps$rebout.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$rebout.rec.comp.med2) == FALSE & qtnps$rebout.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.dos == "Oui") | camp.med.dos == TRUE)
table(rebout.tnps.dos.comp,useNA = "always")

#### Prévalence du recours complémentaire à un TA-NPS pour une douleur de dos
# Recours à un TA-NPS pour une douleur de dos
camp.tnps.dos <- acup.tnps.dos|chiro.tnps.dos|homeo.tnps.dos|magne.tnps.dos|
  osteo.tnps.dos|rebout.tnps.dos
table(camp.tnps.dos,useNA = "always")
# Recours complémentaire
camp.tnps.dos.comp <- acup.tnps.dos.comp|chiro.tnps.dos.comp|homeo.tnps.dos.comp|
  magne.tnps.dos.comp|osteo.tnps.dos.comp|rebout.tnps.dos.comp
table(camp.tnps.dos.comp,useNA = "always")

### Recours complémentaire à un TA-NPS pour un motif « Autre » : 
# manipulations préliminaires

#### Recours complémentaire à un acupuncteur NPS pour un motif « Autre »
acup.tnps.autre.comp <- acup.tnps.autre == TRUE & 
  ((qtnps$acup.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$acup.rec.comp.med2) == FALSE & qtnps$acup.rec.comp.med2 == "Oui") | 
  qtnps$med.autre == "Oui") | camp.med.autre == TRUE)
table(acup.tnps.autre.comp,useNA = "always")

#### Recours complémentaire à un chiropracteur NPS pour un motif « Autre »
chiro.tnps.autre.comp <- chiro.tnps.autre == TRUE & 
  ((qtnps$chiro.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$chiro.rec.comp.med2) == FALSE & qtnps$chiro.rec.comp.med2 == "Oui") | 
  qtnps$med.autre == "Oui") | camp.med.autre == TRUE)
table(chiro.tnps.autre.comp,useNA = "always")

#### Recours complémentaire à un homéopathe NPS pour un motif « Autre »
homeo.tnps.autre.comp <- homeo.tnps.autre == TRUE & 
  ((qtnps$homeo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$homeo.rec.comp.med2) == FALSE & qtnps$homeo.rec.comp.med2 == "Oui") | 
  qtnps$med.autre == "Oui") | camp.med.autre == TRUE)
table(homeo.tnps.autre.comp,useNA = "always")

#### Recours complémentaire à un magnétiseur NPS pour un motif « Autre »
magne.tnps.autre.comp <- magne.tnps.autre == TRUE & 
  ((qtnps$magne.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$magne.rec.comp.med2) == FALSE & qtnps$magne.rec.comp.med2 == "Oui") | 
  qtnps$med.autre == "Oui") | camp.med.autre == TRUE)
table(magne.tnps.autre.comp,useNA = "always")

#### Recours complémentaire à un ostéopathe NPS pour un motif « Autre »
osteo.tnps.autre.comp <- osteo.tnps.autre == TRUE & 
  ((qtnps$osteo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$osteo.rec.comp.med2) == FALSE & qtnps$osteo.rec.comp.med2 == "Oui") | 
  qtnps$med.autre == "Oui") | camp.med.autre == TRUE)
table(osteo.tnps.autre.comp,useNA = "always")

#### Recours complémentaire à un rebouteux NPS pour un motif « Autre »
rebout.tnps.autre.comp <- rebout.tnps.autre == TRUE & 
  ((qtnps$rebout.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$rebout.rec.comp.med2) == FALSE & qtnps$rebout.rec.comp.med2 == "Oui") | 
  qtnps$med.autre == "Oui") | camp.med.autre == TRUE)
table(rebout.tnps.autre.comp,useNA = "always")

#### Prévalence du recours complémentaire à un TA-NPS pour un motif « Autre »
# Recours à un TA-NPS pour un motif « Autre »
camp.tnps.autre <- acup.tnps.autre|chiro.tnps.autre|homeo.tnps.autre|
  magne.tnps.autre|
  osteo.tnps.autre|rebout.tnps.autre
table(camp.tnps.autre,useNA = "always")
# Recours complémentaire
camp.tnps.autre.comp <- acup.tnps.autre.comp|chiro.tnps.autre.comp|
  homeo.tnps.autre.comp|
  magne.tnps.autre.comp|osteo.tnps.autre.comp|rebout.tnps.autre.comp
table(camp.tnps.autre.comp,useNA = "always")

### Recours complémentaire à un TA-NPS pour une bronchite : 
# manipulations préliminaires

#### Recours complémentaire à un acupuncteur NPS pour une bronchite
acup.tnps.bronchite.comp <- acup.tnps.bronchite == TRUE & 
  ((qtnps$acup.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$acup.rec.comp.med2) == FALSE & qtnps$acup.rec.comp.med2 == "Oui") | 
  qtnps$med.bronchite == "Oui") | camp.med.bronchite == TRUE)
table(acup.tnps.bronchite.comp,useNA = "always")

#### Recours complémentaire à un chiropracteur NPS pour une bronchite
chiro.tnps.bronchite.comp <- chiro.tnps.bronchite == TRUE & 
  ((qtnps$chiro.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$chiro.rec.comp.med2) == FALSE & qtnps$chiro.rec.comp.med2 == "Oui") | 
  qtnps$med.bronchite == "Oui") | camp.med.bronchite == TRUE)
table(chiro.tnps.bronchite.comp,useNA = "always")

#### Recours complémentaire à un homéopathe NPS pour une bronchite
homeo.tnps.bronchite.comp <- homeo.tnps.bronchite == TRUE & 
  ((qtnps$homeo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$homeo.rec.comp.med2) == FALSE & qtnps$homeo.rec.comp.med2 == "Oui") | 
  qtnps$med.bronchite == "Oui") | camp.med.bronchite == TRUE)
table(homeo.tnps.bronchite.comp,useNA = "always")

#### Recours complémentaire à un magnétiseur NPS pour une bronchite
magne.tnps.bronchite.comp <- magne.tnps.bronchite == TRUE & 
  ((qtnps$magne.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$magne.rec.comp.med2) == FALSE & qtnps$magne.rec.comp.med2 == "Oui") | 
  qtnps$med.bronchite == "Oui") | camp.med.bronchite == TRUE)
table(magne.tnps.bronchite.comp,useNA = "always")

#### Recours complémentaire à un ostéopathe NPS pour une bronchite
osteo.tnps.bronchite.comp <- osteo.tnps.bronchite == TRUE & 
  ((qtnps$osteo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$osteo.rec.comp.med2) == FALSE & qtnps$osteo.rec.comp.med2 == "Oui") | 
  qtnps$med.bronchite == "Oui") | camp.med.bronchite == TRUE)
table(osteo.tnps.bronchite.comp,useNA = "always")

#### Recours complémentaire à un rebouteux NPS pour une bronchite
rebout.tnps.bronchite.comp <- rebout.tnps.bronchite == TRUE & 
  ((qtnps$rebout.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$rebout.rec.comp.med2) == FALSE & qtnps$rebout.rec.comp.med2 == "Oui") | 
  qtnps$med.bronchite == "Oui") | camp.med.bronchite == TRUE)
table(rebout.tnps.bronchite.comp,useNA = "always")

#### Prévalence du recours complémentaire à un TA-NPS pour une bronchite
# Recours à un TA-NPS pour une bronchite
camp.tnps.bronchite <- acup.tnps.bronchite|chiro.tnps.bronchite|
  homeo.tnps.bronchite|magne.tnps.bronchite|
  osteo.tnps.bronchite|rebout.tnps.bronchite
table(camp.tnps.bronchite,useNA = "always")
# Recours complémentaire
camp.tnps.bronchite.comp <- acup.tnps.bronchite.comp|chiro.tnps.bronchite.comp|
  homeo.tnps.bronchite.comp|
  magne.tnps.bronchite.comp|osteo.tnps.bronchite.comp|rebout.tnps.bronchite.comp
table(camp.tnps.bronchite.comp,useNA = "always")

### Recours complémentaire à un TA-NPS pour une dépression : 
# manipulations préliminaires

#### Recours complémentaire à un acupuncteur NPS pour une dépression
acup.tnps.depression.comp <- acup.tnps.depression == TRUE & 
  ((qtnps$acup.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$acup.rec.comp.med2) == FALSE & qtnps$acup.rec.comp.med2 == "Oui") | 
  qtnps$med.depression == "Oui") | camp.med.depression == TRUE)
table(acup.tnps.depression.comp,useNA = "always")

#### Recours complémentaire à un chiropracteur NPS pour une dépression
chiro.tnps.depression.comp <- chiro.tnps.depression == TRUE & 
  ((qtnps$chiro.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$chiro.rec.comp.med2) == FALSE & qtnps$chiro.rec.comp.med2 == "Oui") | 
  qtnps$med.depression == "Oui") | camp.med.depression == TRUE)
table(chiro.tnps.depression.comp,useNA = "always")

#### Recours complémentaire à un homéopathe NPS pour une dépression
homeo.tnps.depression.comp <- homeo.tnps.depression == TRUE & 
  ((qtnps$homeo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$homeo.rec.comp.med2) == FALSE & qtnps$homeo.rec.comp.med2 == "Oui") | 
  qtnps$med.depression == "Oui") | camp.med.depression == TRUE)
table(homeo.tnps.depression.comp,useNA = "always")

#### Recours complémentaire à un magnétiseur NPS pour une dépression
magne.tnps.depression.comp <- magne.tnps.depression == TRUE & 
  ((qtnps$magne.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$magne.rec.comp.med2) == FALSE & qtnps$magne.rec.comp.med2 == "Oui") | 
  qtnps$med.depression == "Oui") | camp.med.depression == TRUE)
table(magne.tnps.depression.comp,useNA = "always")

#### Recours complémentaire à un ostéopathe NPS pour une dépression
osteo.tnps.depression.comp <- osteo.tnps.depression == TRUE & 
  ((qtnps$osteo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$osteo.rec.comp.med2) == FALSE & qtnps$osteo.rec.comp.med2 == "Oui") | 
  qtnps$med.depression == "Oui") | camp.med.depression == TRUE)
table(osteo.tnps.depression.comp,useNA = "always")

#### Recours complémentaire à un rebouteux NPS pour une dépression
rebout.tnps.depression.comp <- rebout.tnps.depression == TRUE & 
  ((qtnps$rebout.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$rebout.rec.comp.med2) == FALSE & qtnps$rebout.rec.comp.med2 == "Oui") | 
  qtnps$med.depression == "Oui") | camp.med.depression == TRUE)
table(rebout.tnps.depression.comp,useNA = "always")

#### Prévalence du recours complémentaire à un TA-NPS pour une dépression
# Recours à un TA-NPS pour une dépression
camp.tnps.depression <- acup.tnps.depression|chiro.tnps.depression|
  homeo.tnps.depression|magne.tnps.depression|
  osteo.tnps.depression|rebout.tnps.depression
table(camp.tnps.depression,useNA = "always")
# Recours complémentaire
camp.tnps.depression.comp <- acup.tnps.depression.comp|chiro.tnps.depression.comp|
  homeo.tnps.depression.comp|
  magne.tnps.depression.comp|osteo.tnps.depression.comp|rebout.tnps.depression.comp
table(camp.tnps.depression.comp,useNA = "always")

### Recours complémentaire à un TA-NPS pour une grippe ou un syndrome grippal : 
# manipulations préliminaires

#### Recours complémentaire à un acupuncteur NPS pour une grippe 
#ou un syndrome grippal
acup.tnps.grippe.comp <- acup.tnps.grippe == TRUE & 
  ((qtnps$acup.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$acup.rec.comp.med2) == FALSE & qtnps$acup.rec.comp.med2 == "Oui") | 
  qtnps$med.grippe == "Oui") | camp.med.grippe == TRUE)
table(acup.tnps.grippe.comp,useNA = "always")

#### Recours complémentaire à un chiropracteur NPS pour une grippe 
#ou un syndrome grippal
chiro.tnps.grippe.comp <- chiro.tnps.grippe == TRUE & 
  ((qtnps$chiro.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$chiro.rec.comp.med2) == FALSE & qtnps$chiro.rec.comp.med2 == "Oui") | 
  qtnps$med.grippe == "Oui") | camp.med.grippe == TRUE)
table(chiro.tnps.grippe.comp,useNA = "always")

#### Recours complémentaire à un homéopathe NPS pour une grippe ou un syndrome grippal
homeo.tnps.grippe.comp <- homeo.tnps.grippe == TRUE & 
  ((qtnps$homeo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$homeo.rec.comp.med2) == FALSE & qtnps$homeo.rec.comp.med2 == "Oui") | 
  qtnps$med.grippe == "Oui") | camp.med.grippe == TRUE)
table(homeo.tnps.grippe.comp,useNA = "always")

#### Recours complémentaire à un magnétiseur NPS pour une grippe 
#ou un syndrome grippal
magne.tnps.grippe.comp <- magne.tnps.grippe == TRUE & 
  ((qtnps$magne.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$magne.rec.comp.med2) == FALSE & qtnps$magne.rec.comp.med2 == "Oui") | 
  qtnps$med.grippe == "Oui") | camp.med.grippe == TRUE)
table(magne.tnps.grippe.comp,useNA = "always")

#### Recours complémentaire à un ostéopathe NPS pour une grippe 
#ou un syndrome grippal
osteo.tnps.grippe.comp <- osteo.tnps.grippe == TRUE & 
  ((qtnps$osteo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$osteo.rec.comp.med2) == FALSE & qtnps$osteo.rec.comp.med2 == "Oui") | 
  qtnps$med.grippe == "Oui") | camp.med.grippe == TRUE)
table(osteo.tnps.grippe.comp,useNA = "always")

#### Recours complémentaire à un rebouteux NPS pour une grippe 
#ou un syndrome grippal
rebout.tnps.grippe.comp <- rebout.tnps.grippe == TRUE & 
  ((qtnps$rebout.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$rebout.rec.comp.med2) == FALSE & qtnps$rebout.rec.comp.med2 == "Oui") | 
  qtnps$med.grippe == "Oui") | camp.med.grippe == TRUE)
table(rebout.tnps.grippe.comp,useNA = "always")

#### Prévalence du recours complémentaire à un TA-NPS pour une grippe 
#ou un syndrome grippal
# Recours à un TA-NPS pour une grippe ou un syndrome grippal
camp.tnps.grippe <- acup.tnps.grippe|chiro.tnps.grippe|homeo.tnps.grippe|
  magne.tnps.grippe|
  osteo.tnps.grippe|rebout.tnps.grippe
table(camp.tnps.grippe,useNA = "always")
# Recours complémentaire
camp.tnps.grippe.comp <- acup.tnps.grippe.comp|chiro.tnps.grippe.comp|
  homeo.tnps.grippe.comp|
  magne.tnps.grippe.comp|osteo.tnps.grippe.comp|rebout.tnps.grippe.comp
table(camp.tnps.grippe.comp,useNA = "always")

### Recours complémentaire à un TA-NPS pour un mal de gorge : 
# manipulations préliminaires

#### Recours complémentaire à un acupuncteur NPS pour un mal de gorge
acup.tnps.gorge.comp <- acup.tnps.gorge == TRUE & 
  ((qtnps$acup.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$acup.rec.comp.med2) == FALSE & qtnps$acup.rec.comp.med2 == "Oui") | 
  qtnps$med.gorge == "Oui") | camp.med.gorge == TRUE)
table(acup.tnps.gorge.comp,useNA = "always")

#### Recours complémentaire à un chiropracteur NPS pour un mal de gorge
chiro.tnps.gorge.comp <- chiro.tnps.gorge == TRUE & 
  ((qtnps$chiro.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$chiro.rec.comp.med2) == FALSE & qtnps$chiro.rec.comp.med2 == "Oui") | 
  qtnps$med.gorge == "Oui") | camp.med.gorge == TRUE)
table(chiro.tnps.gorge.comp,useNA = "always")

#### Recours complémentaire à un homéopathe NPS pour un mal de gorge
homeo.tnps.gorge.comp <- homeo.tnps.gorge == TRUE & 
  ((qtnps$homeo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$homeo.rec.comp.med2) == FALSE & qtnps$homeo.rec.comp.med2 == "Oui") | 
  qtnps$med.gorge == "Oui") | camp.med.gorge == TRUE)
table(homeo.tnps.gorge.comp,useNA = "always")

#### Recours complémentaire à un magnétiseur NPS pour un mal de gorge
magne.tnps.gorge.comp <- magne.tnps.gorge == TRUE & 
  ((qtnps$magne.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$magne.rec.comp.med2) == FALSE & qtnps$magne.rec.comp.med2 == "Oui") | 
  qtnps$med.gorge == "Oui") | camp.med.gorge == TRUE)
table(magne.tnps.gorge.comp,useNA = "always")

#### Recours complémentaire à un ostéopathe NPS pour un mal de gorge
osteo.tnps.gorge.comp <- osteo.tnps.gorge == TRUE & 
  ((qtnps$osteo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$osteo.rec.comp.med2) == FALSE & qtnps$osteo.rec.comp.med2 == "Oui") | 
  qtnps$med.gorge == "Oui") | camp.med.gorge == TRUE)
table(osteo.tnps.gorge.comp,useNA = "always")

#### Recours complémentaire à un rebouteux NPS pour un mal de gorge
rebout.tnps.gorge.comp <- rebout.tnps.gorge == TRUE & 
  ((qtnps$rebout.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$rebout.rec.comp.med2) == FALSE & qtnps$rebout.rec.comp.med2 == "Oui") | 
  qtnps$med.gorge == "Oui") | camp.med.gorge == TRUE)
table(rebout.tnps.gorge.comp,useNA = "always")

#### Prévalence du recours complémentaire à un TA-NPS pour un mal de gorge
# Recours à un TA-NPS pour un mal de gorge
camp.tnps.gorge <- acup.tnps.gorge|chiro.tnps.gorge|homeo.tnps.gorge|
  magne.tnps.gorge|
  osteo.tnps.gorge|rebout.tnps.gorge
table(camp.tnps.gorge,useNA = "always")
# Recours complémentaire
camp.tnps.gorge.comp <- acup.tnps.gorge.comp|chiro.tnps.gorge.comp|
  homeo.tnps.gorge.comp|
  magne.tnps.gorge.comp|osteo.tnps.gorge.comp|rebout.tnps.gorge.comp
table(camp.tnps.gorge.comp,useNA = "always")

### Recours complémentaire à un TA-NPS pour des maux de tête ou migraines : 
# manipulations préliminaires

#### Recours complémentaire à un acupuncteur NPS pour des maux de tête ou migraines
acup.tnps.migraine.comp <- acup.tnps.migraine == TRUE & 
  ((qtnps$acup.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$acup.rec.comp.med2) == FALSE & qtnps$acup.rec.comp.med2 == "Oui") | 
  qtnps$med.migraine == "Oui") | camp.med.migraine == TRUE)
table(acup.tnps.migraine.comp,useNA = "always")

#### Recours complémentaire à un chiropracteur NPS pour des maux de tête ou migraines
chiro.tnps.migraine.comp <- chiro.tnps.migraine == TRUE & 
  ((qtnps$chiro.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$chiro.rec.comp.med2) == FALSE & qtnps$chiro.rec.comp.med2 == "Oui") | 
  qtnps$med.migraine == "Oui") | camp.med.migraine == TRUE)
table(chiro.tnps.migraine.comp,useNA = "always")

#### Recours complémentaire à un homéopathe NPS pour des maux de tête ou migraines
homeo.tnps.migraine.comp <- homeo.tnps.migraine == TRUE & 
  ((qtnps$homeo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$homeo.rec.comp.med2) == FALSE & qtnps$homeo.rec.comp.med2 == "Oui") | 
  qtnps$med.migraine == "Oui") | camp.med.migraine == TRUE)
table(homeo.tnps.migraine.comp,useNA = "always")

#### Recours complémentaire à un magnétiseur NPS pour des maux de tête ou migraines
magne.tnps.migraine.comp <- magne.tnps.migraine == TRUE & 
  ((qtnps$magne.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$magne.rec.comp.med2) == FALSE & qtnps$magne.rec.comp.med2 == "Oui") | 
  qtnps$med.migraine == "Oui") | camp.med.migraine == TRUE)
table(magne.tnps.migraine.comp,useNA = "always")

#### Recours complémentaire à un ostéopathe NPS pour des maux de tête ou migraines
osteo.tnps.migraine.comp <- osteo.tnps.migraine == TRUE & 
  ((qtnps$osteo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$osteo.rec.comp.med2) == FALSE & qtnps$osteo.rec.comp.med2 == "Oui") | 
  qtnps$med.migraine == "Oui") | camp.med.migraine == TRUE)
table(osteo.tnps.migraine.comp,useNA = "always")

#### Recours complémentaire à un rebouteux NPS pour des maux de tête ou migraines
rebout.tnps.migraine.comp <- rebout.tnps.migraine == TRUE & 
  ((qtnps$rebout.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$rebout.rec.comp.med2) == FALSE & qtnps$rebout.rec.comp.med2 == "Oui") | 
  qtnps$med.migraine == "Oui") | camp.med.migraine == TRUE)
table(rebout.tnps.migraine.comp,useNA = "always")

#### Prévalence du recours complémentaire à un TA-NPS pour des maux de tête
#ou migraines
# Recours à un TA-NPS pour des maux de tête ou migraines
camp.tnps.migraine <- acup.tnps.migraine|chiro.tnps.migraine|homeo.tnps.migraine|
  magne.tnps.migraine|
  osteo.tnps.migraine|rebout.tnps.migraine
table(camp.tnps.migraine,useNA = "always")
# Recours complémentaire
camp.tnps.migraine.comp <- acup.tnps.migraine.comp|chiro.tnps.migraine.comp|
  homeo.tnps.migraine.comp|
  magne.tnps.migraine.comp|osteo.tnps.migraine.comp|rebout.tnps.migraine.comp
table(camp.tnps.migraine.comp,useNA = "always")

### Recours complémentaire à un TA-NPS pour une douleur au cou : 
# manipulations préliminaires

#### Recours complémentaire à un acupuncteur NPS pour une douleur au cou
acup.tnps.cou.comp <- acup.tnps.cou == TRUE & 
  ((qtnps$acup.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$acup.rec.comp.med2) == FALSE & qtnps$acup.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.cou == "Oui") | camp.med.cou == TRUE)
table(acup.tnps.cou.comp,useNA = "always")

#### Recours complémentaire à un chiropracteur NPS pour une douleur au cou
chiro.tnps.cou.comp <- chiro.tnps.cou == TRUE & 
  ((qtnps$chiro.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$chiro.rec.comp.med2) == FALSE & qtnps$chiro.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.cou == "Oui") | camp.med.cou == TRUE)
table(chiro.tnps.cou.comp,useNA = "always")

#### Recours complémentaire à un homéopathe NPS pour une douleur au cou
homeo.tnps.cou.comp <- homeo.tnps.cou == TRUE & 
  ((qtnps$homeo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$homeo.rec.comp.med2) == FALSE & qtnps$homeo.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.cou == "Oui") | camp.med.cou == TRUE)
table(homeo.tnps.cou.comp,useNA = "always")

#### Recours complémentaire à un magnétiseur NPS pour une douleur au cou
magne.tnps.cou.comp <- magne.tnps.cou == TRUE & 
  ((qtnps$magne.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$magne.rec.comp.med2) == FALSE & qtnps$magne.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.cou == "Oui") | camp.med.cou == TRUE)
table(magne.tnps.cou.comp,useNA = "always")

#### Recours complémentaire à un ostéopathe NPS pour une douleur au cou
osteo.tnps.cou.comp <- osteo.tnps.cou == TRUE & 
  ((qtnps$osteo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$osteo.rec.comp.med2) == FALSE & qtnps$osteo.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.cou == "Oui") | camp.med.cou == TRUE)
table(osteo.tnps.cou.comp,useNA = "always")

#### Recours complémentaire à un rebouteux NPS pour une douleur au cou
rebout.tnps.cou.comp <- rebout.tnps.cou == TRUE & 
  ((qtnps$rebout.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$rebout.rec.comp.med2) == FALSE & qtnps$rebout.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.cou == "Oui") | camp.med.cou == TRUE)
table(rebout.tnps.cou.comp,useNA = "always")

#### Prévalence du recours complémentaire à un TA-NPS pour une douleur au cou
# Recours à un TA-NPS pour une douleur au cou
camp.tnps.cou <- acup.tnps.cou|chiro.tnps.cou|homeo.tnps.cou|
  magne.tnps.cou|
  osteo.tnps.cou|rebout.tnps.cou
table(camp.tnps.cou,useNA = "always")
# Recours complémentaire
camp.tnps.cou.comp <- acup.tnps.cou.comp|chiro.tnps.cou.comp|
  homeo.tnps.cou.comp|
  magne.tnps.cou.comp|osteo.tnps.cou.comp|rebout.tnps.cou.comp
table(camp.tnps.cou.comp,useNA = "always")

### Recours complémentaire à un TA-NPS pour une douleur de membre supérieur : 
# manipulations préliminaires

#### Recours complémentaire à un acupuncteur NPS pour une douleur de membre supérieur
acup.tnps.msup.comp <- acup.tnps.msup == TRUE & 
  ((qtnps$acup.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$acup.rec.comp.med2) == FALSE & qtnps$acup.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.msup == "Oui") | camp.med.msup == TRUE)
table(acup.tnps.msup.comp,useNA = "always")

#### Recours complémentaire à un chiropracteur NPS pour une douleur 
#de membre supérieur
chiro.tnps.msup.comp <- chiro.tnps.msup == TRUE & 
  ((qtnps$chiro.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$chiro.rec.comp.med2) == FALSE & qtnps$chiro.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.msup == "Oui") | camp.med.msup == TRUE)
table(chiro.tnps.msup.comp,useNA = "always")

#### Recours complémentaire à un homéopathe NPS pour une douleur de membre supérieur
homeo.tnps.msup.comp <- homeo.tnps.msup == TRUE & 
  ((qtnps$homeo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$homeo.rec.comp.med2) == FALSE & qtnps$homeo.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.msup == "Oui") | camp.med.msup == TRUE)
table(homeo.tnps.msup.comp,useNA = "always")

#### Recours complémentaire à un magnétiseur NPS pour une douleur de membre supérieur
magne.tnps.msup.comp <- magne.tnps.msup == TRUE & 
  ((qtnps$magne.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$magne.rec.comp.med2) == FALSE & qtnps$magne.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.msup == "Oui") | camp.med.msup == TRUE)
table(magne.tnps.msup.comp,useNA = "always")

#### Recours complémentaire à un ostéopathe NPS pour une douleur de membre supérieur
osteo.tnps.msup.comp <- osteo.tnps.msup == TRUE & 
  ((qtnps$osteo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$osteo.rec.comp.med2) == FALSE & qtnps$osteo.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.msup == "Oui") | camp.med.msup == TRUE)
table(osteo.tnps.msup.comp,useNA = "always")

#### Recours complémentaire à un rebouteux NPS pour une douleur de membre supérieur
rebout.tnps.msup.comp <- rebout.tnps.msup == TRUE & 
  ((qtnps$rebout.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$rebout.rec.comp.med2) == FALSE & qtnps$rebout.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.msup == "Oui") | camp.med.msup == TRUE)
table(rebout.tnps.msup.comp,useNA = "always")

#### Prévalence du recours complémentaire à un TA-NPS pour une douleur 
#de membre supérieur
# Recours à un TA-NPS pour une douleur de membre supérieur
camp.tnps.msup <- acup.tnps.msup|chiro.tnps.msup|homeo.tnps.msup|
  magne.tnps.msup|
  osteo.tnps.msup|rebout.tnps.msup
table(camp.tnps.msup,useNA = "always")
# Recours complémentaire
camp.tnps.msup.comp <- acup.tnps.msup.comp|chiro.tnps.msup.comp|
  homeo.tnps.msup.comp|
  magne.tnps.msup.comp|osteo.tnps.msup.comp|rebout.tnps.msup.comp
table(camp.tnps.msup.comp,useNA = "always")

### Recours complémentaire à un TA-NPS pour du stress ou de l'anxiété : 
# manipulations préliminaires

#### Recours complémentaire à un acupuncteur NPS pour du stress ou de l'anxiété
acup.tnps.stress.comp <- acup.tnps.stress == TRUE & 
  ((qtnps$acup.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$acup.rec.comp.med2) == FALSE & qtnps$acup.rec.comp.med2 == "Oui") | 
  qtnps$med.stress == "Oui") | camp.med.stress == TRUE)
table(acup.tnps.stress.comp,useNA = "always")

#### Recours complémentaire à un chiropracteur NPS pour du stress ou de l'anxiété
chiro.tnps.stress.comp <- chiro.tnps.stress == TRUE & 
  ((qtnps$chiro.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$chiro.rec.comp.med2) == FALSE & qtnps$chiro.rec.comp.med2 == "Oui") | 
  qtnps$med.stress == "Oui") | camp.med.stress == TRUE)
table(chiro.tnps.stress.comp,useNA = "always")

#### Recours complémentaire à un homéopathe NPS pour du stress ou de l'anxiété
homeo.tnps.stress.comp <- homeo.tnps.stress == TRUE & 
  ((qtnps$homeo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$homeo.rec.comp.med2) == FALSE & qtnps$homeo.rec.comp.med2 == "Oui") | 
  qtnps$med.stress == "Oui") | camp.med.stress == TRUE)
table(homeo.tnps.stress.comp,useNA = "always")

#### Recours complémentaire à un magnétiseur NPS pour du stress ou de l'anxiété
magne.tnps.stress.comp <- magne.tnps.stress == TRUE & 
  ((qtnps$magne.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$magne.rec.comp.med2) == FALSE & qtnps$magne.rec.comp.med2 == "Oui") | 
  qtnps$med.stress == "Oui") | camp.med.stress == TRUE)
table(magne.tnps.stress.comp,useNA = "always")

#### Recours complémentaire à un ostéopathe NPS pour du stress ou de l'anxiété
osteo.tnps.stress.comp <- osteo.tnps.stress == TRUE & 
  ((qtnps$osteo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$osteo.rec.comp.med2) == FALSE & qtnps$osteo.rec.comp.med2 == "Oui") | 
  qtnps$med.stress == "Oui") | camp.med.stress == TRUE)
table(osteo.tnps.stress.comp,useNA = "always")

#### Recours complémentaire à un rebouteux NPS pour du stress ou de l'anxiété
rebout.tnps.stress.comp <- rebout.tnps.stress == TRUE & 
  ((qtnps$rebout.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$rebout.rec.comp.med2) == FALSE & qtnps$rebout.rec.comp.med2 == "Oui") | 
  qtnps$med.stress == "Oui") | camp.med.stress == TRUE)
table(rebout.tnps.stress.comp,useNA = "always")

#### Prévalence du recours complémentaire à un TA-NPS pour du stress 
#ou de l'anxiété
# Recours à un TA-NPS pour du stress ou de l'anxiété
camp.tnps.stress <- acup.tnps.stress|chiro.tnps.stress|homeo.tnps.stress|
  magne.tnps.stress|
  osteo.tnps.stress|rebout.tnps.stress
table(camp.tnps.stress,useNA = "always")
# Recours complémentaire
camp.tnps.stress.comp <- acup.tnps.stress.comp|chiro.tnps.stress.comp|
  homeo.tnps.stress.comp|
  magne.tnps.stress.comp|osteo.tnps.stress.comp|rebout.tnps.stress.comp
table(camp.tnps.stress.comp,useNA = "always")

### Recours complémentaire à un TA-NPS pour une douleur de membre inférieur : 
# manipulations préliminaires

#### Recours complémentaire à un acupuncteur NPS pour une douleur de membre inférieur
acup.tnps.minf.comp <- acup.tnps.minf == TRUE & 
  ((qtnps$acup.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$acup.rec.comp.med2) == FALSE & qtnps$acup.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.minf == "Oui") | camp.med.minf == TRUE)
table(acup.tnps.minf.comp,useNA = "always")

#### Recours complémentaire à un chiropracteur NPS pour une douleur 
#de membre inférieur
chiro.tnps.minf.comp <- chiro.tnps.minf == TRUE & 
  ((qtnps$chiro.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$chiro.rec.comp.med2) == FALSE & qtnps$chiro.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.minf == "Oui") | camp.med.minf == TRUE)
table(chiro.tnps.minf.comp,useNA = "always")

#### Recours complémentaire à un homéopathe NPS pour une douleur de membre inférieur
homeo.tnps.minf.comp <- homeo.tnps.minf == TRUE & 
  ((qtnps$homeo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$homeo.rec.comp.med2) == FALSE & qtnps$homeo.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.minf == "Oui") | camp.med.minf == TRUE)
table(homeo.tnps.minf.comp,useNA = "always")

#### Recours complémentaire à un magnétiseur NPS pour une douleur de membre inférieur
magne.tnps.minf.comp <- magne.tnps.minf == TRUE & 
  ((qtnps$magne.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$magne.rec.comp.med2) == FALSE & qtnps$magne.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.minf == "Oui") | camp.med.minf == TRUE)
table(magne.tnps.minf.comp,useNA = "always")

#### Recours complémentaire à un ostéopathe NPS pour une douleur de membre inférieur
osteo.tnps.minf.comp <- osteo.tnps.minf == TRUE & 
  ((qtnps$osteo.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$osteo.rec.comp.med2) == FALSE & qtnps$osteo.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.minf == "Oui") | camp.med.minf == TRUE)
table(osteo.tnps.minf.comp,useNA = "always")

#### Recours complémentaire à un rebouteux NPS pour une douleur de membre inférieur
rebout.tnps.minf.comp <- rebout.tnps.minf == TRUE & 
  ((qtnps$rebout.rec.comp.med1 != "Je n'ai pas consulté de médecin" |
  (is.na(qtnps$rebout.rec.comp.med2) == FALSE & qtnps$rebout.rec.comp.med2 == "Oui") | 
  qtnps$med.doul.minf == "Oui") | camp.med.minf == TRUE)
table(rebout.tnps.minf.comp,useNA = "always")

#### Prévalence du recours complémentaire à un TA-NPS pour une douleur 
#de membre inférieur
# Recours à un TA-NPS pour une douleur de membre inférieur
camp.tnps.minf <- acup.tnps.minf|chiro.tnps.minf|homeo.tnps.minf|
  magne.tnps.minf|
  osteo.tnps.minf|rebout.tnps.minf
table(camp.tnps.minf,useNA = "always")
# Recours complémentaire
camp.tnps.minf.comp <- acup.tnps.minf.comp|chiro.tnps.minf.comp|
  homeo.tnps.minf.comp|
  magne.tnps.minf.comp|osteo.tnps.minf.comp|rebout.tnps.minf.comp
table(camp.tnps.minf.comp,useNA = "always")

## Prévalence du recours complémentaire à un TA-NPS (Figure X) ----
camp.tnps.comp <- camp.tnps.dos.comp|camp.tnps.stress.comp|camp.tnps.minf.comp|
  camp.tnps.bronchite.comp|camp.tnps.depression.comp|camp.tnps.grippe.comp|
  camp.tnps.gorge.comp|camp.tnps.cou.comp|camp.tnps.msup.comp|
  camp.tnps.migraine.comp|camp.tnps.autre
table(camp.tnps.comp,useNA = "always")
(2637/10478)*100
# [1] 25.167

## Prévalence du recours à un acupuncteur (Figure X) ----
acup.tnps.comp <- acup.tnps.dos.comp|acup.tnps.stress.comp|acup.tnps.minf.comp|
  acup.tnps.bronchite.comp|acup.tnps.depression.comp|acup.tnps.grippe.comp|
  acup.tnps.gorge.comp|acup.tnps.cou.comp|acup.tnps.msup.comp|
  acup.tnps.migraine.comp|acup.tnps.autre
table(acup.tnps.comp,useNA = "always")
(370/10478)*100
# [1] 3.5312

## Prévalence du recours complémentaire à un chiropracteur (Figure X) ----
chiro.tnps.comp <- chiro.tnps.dos.comp|chiro.tnps.stress.comp|chiro.tnps.minf.comp|
  chiro.tnps.bronchite.comp|chiro.tnps.depression.comp|chiro.tnps.grippe.comp|
  chiro.tnps.gorge.comp|chiro.tnps.cou.comp|chiro.tnps.msup.comp|
  chiro.tnps.migraine.comp|chiro.tnps.autre
table(chiro.tnps.comp,useNA = "always")
(142/10478)*100
# [1] 1.3552

## Prévalence du recours complémentaire à un homéopathe (Figure X) ----
homeo.tnps.comp <- homeo.tnps.dos.comp|homeo.tnps.stress.comp|homeo.tnps.minf.comp|
  homeo.tnps.bronchite.comp|homeo.tnps.depression.comp|homeo.tnps.grippe.comp|
  homeo.tnps.gorge.comp|homeo.tnps.cou.comp|homeo.tnps.msup.comp|
  homeo.tnps.migraine.comp|homeo.tnps.autre
table(homeo.tnps.comp,useNA = "always")
(111/10478)*100
# [1] 1.0594

## Prévalence du recours complémentaire à un magnétiseur (Figure X) ----
magne.tnps.comp <- magne.tnps.dos.comp|magne.tnps.stress.comp|magne.tnps.minf.comp|
  magne.tnps.bronchite.comp|magne.tnps.depression.comp|magne.tnps.grippe.comp|
  magne.tnps.gorge.comp|magne.tnps.cou.comp|magne.tnps.msup.comp|
  magne.tnps.migraine.comp|magne.tnps.autre
table(magne.tnps.comp,useNA = "always")
(488/10478)*100
# [1] 4.6574

## Prévalence du recours complémentaire à un ostéopathe (Figure X) ----
osteo.tnps.comp <- osteo.tnps.dos.comp|osteo.tnps.stress.comp|osteo.tnps.minf.comp|
  osteo.tnps.bronchite.comp|osteo.tnps.depression.comp|osteo.tnps.grippe.comp|
  osteo.tnps.gorge.comp|osteo.tnps.cou.comp|osteo.tnps.msup.comp|
  osteo.tnps.migraine.comp|osteo.tnps.autre
table(osteo.tnps.comp,useNA = "always")
(1964/10478)*100
# [1] 18.744

## Prévalence du recours complémentaire à un rebouteux (Figure X) ----
rebout.tnps.comp <- rebout.tnps.dos.comp|rebout.tnps.stress.comp|rebout.tnps.minf.comp|
  rebout.tnps.bronchite.comp|rebout.tnps.depression.comp|rebout.tnps.grippe.comp|
  rebout.tnps.gorge.comp|rebout.tnps.cou.comp|rebout.tnps.msup.comp|
  rebout.tnps.migraine.comp|rebout.tnps.autre
table(rebout.tnps.comp,useNA = "always")
(83/10478)*100
# [1] 0.79214

## Déclaration de recours ----

### Déclaration de recours pour un mal de dos
#### Déclaration de recours acupuncteur NPS pour un mal de dos
# Vu médecin depuis recours acupuncteur NPS pour un mal de dos
med.dep.acup.tnps.dos <- acup.tnps.dos == TRUE &
  ((is.na(qtnps$acup.rec.comp.med1) == FALSE &
      qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur") |
  (is.na(qtnps$med.depuis.acup) == FALSE & qtnps$med.depuis.acup == "Oui"))
table(med.dep.acup.tnps.dos,useNA = "always")
# Parlé médecin recours acupuncteur NPS
talk.med.dep.acup.tnps.dos <- med.dep.acup.tnps.dos == TRUE &
  (is.na(qtnps$talk.acup.med) == FALSE & qtnps$talk.acup.med == "Oui")
table(talk.med.dep.acup.tnps.dos,useNA = "always")

#### Déclaration de recours chiropracteur NPS pour un mal de dos
# Vu médecin depuis recours chiropracteur NPS pour un mal de dos
med.dep.chiro.tnps.dos <- chiro.tnps.dos == TRUE &
  ((is.na(qtnps$chiro.rec.comp.med1) == FALSE &
      qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur") |
  (is.na(qtnps$med.depuis.chiro) == FALSE & qtnps$med.depuis.chiro == "Oui"))
table(med.dep.chiro.tnps.dos,useNA = "always")
# Parlé médecin recours chiropracteur NPS
talk.med.dep.chiro.tnps.dos <- med.dep.chiro.tnps.dos == TRUE &
  (is.na(qtnps$talk.chiro.med) == FALSE & qtnps$talk.chiro.med == "Oui")
table(talk.med.dep.chiro.tnps.dos,useNA = "always")

#### Déclaration de recours homéopathe NPS pour un mal de dos
# Vu médecin depuis recours homéopathe NPS pour un mal de dos
med.dep.homeo.tnps.dos <- homeo.tnps.dos == TRUE &
  ((is.na(qtnps$homeo.rec.comp.med1) == FALSE &
      qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe") |
  (is.na(qtnps$med.depuis.homeo) == FALSE & qtnps$med.depuis.homeo == "Oui"))
table(med.dep.homeo.tnps.dos,useNA = "always")
# Parlé médecin recours homéopathe NPS
talk.med.dep.homeo.tnps.dos <- med.dep.homeo.tnps.dos == TRUE &
  (is.na(qtnps$talk.homeo.med) == FALSE & qtnps$talk.homeo.med == "Oui")
table(talk.med.dep.homeo.tnps.dos,useNA = "always")

#### Déclaration de recours magnétiseur NPS pour un mal de dos
# Vu médecin depuis recours magnétiseur NPS pour un mal de dos
med.dep.magne.tnps.dos <- magne.tnps.dos == TRUE &
  ((is.na(qtnps$magne.rec.comp.med1) == FALSE &
      qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur") |
  (is.na(qtnps$med.depuis.magne) == FALSE & qtnps$med.depuis.magne == "Oui"))
table(med.dep.magne.tnps.dos,useNA = "always")
# Parlé médecin recours magnétiseur NPS
talk.med.dep.magne.tnps.dos <- med.dep.magne.tnps.dos == TRUE &
  (is.na(qtnps$talk.magne.med) == FALSE & qtnps$talk.magne.med == "Oui")
table(talk.med.dep.magne.tnps.dos,useNA = "always")

#### Déclaration de recours ostéopathe NPS pour un mal de dos
# Vu médecin depuis recours ostéopathe NPS pour un mal de dos
med.dep.osteo.tnps.dos <- osteo.tnps.dos == TRUE &
  ((is.na(qtnps$osteo.rec.comp.med1) == FALSE &
      qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe") |
  (is.na(qtnps$med.depuis.osteo) == FALSE & qtnps$med.depuis.osteo == "Oui"))
table(med.dep.osteo.tnps.dos,useNA = "always")
# Parlé médecin recours ostéopathe NPS
talk.med.dep.osteo.tnps.dos <- med.dep.osteo.tnps.dos == TRUE &
  (is.na(qtnps$talk.osteo.med) == FALSE & qtnps$talk.osteo.med == "Oui")
table(talk.med.dep.osteo.tnps.dos,useNA = "always")

#### Déclaration de recours rebouteux NPS pour un mal de dos
# Vu médecin depuis recours rebouteux NPS pour un mal de dos
med.dep.rebout.tnps.dos <- rebout.tnps.dos == TRUE &
  ((is.na(qtnps$rebout.rec.comp.med1) == FALSE &
      qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux") |
  (is.na(qtnps$med.depuis.rebout) == FALSE & qtnps$med.depuis.rebout == "Oui"))
table(med.dep.rebout.tnps.dos,useNA = "always")
# Parlé médecin recours rebouteux NPS
talk.med.dep.rebout.tnps.dos <- med.dep.rebout.tnps.dos == TRUE &
  (is.na(qtnps$talk.rebout.med) == FALSE & qtnps$talk.rebout.med == "Oui")
table(talk.med.dep.rebout.tnps.dos,useNA = "always")

#### Déclaration de recours TA-NPS pour un mal de dos
# Vu médecin depuis recours TA-NPS pour un mal de dos
med.dep.tnps.dos <- med.dep.acup.tnps.dos|med.dep.chiro.tnps.dos|
  med.dep.homeo.tnps.dos|
  med.dep.magne.tnps.dos|med.dep.osteo.tnps.dos|med.dep.rebout.tnps.dos
table(med.dep.tnps.dos,useNA = "always")
# Parlé médecin recours TA-NPS pour un mal de dos
talk.med.dep.tnps.dos <- talk.med.dep.acup.tnps.dos|talk.med.dep.chiro.tnps.dos|
  talk.med.dep.homeo.tnps.dos|talk.med.dep.magne.tnps.dos|talk.med.dep.osteo.tnps.dos|
  talk.med.dep.rebout.tnps.dos
table(talk.med.dep.tnps.dos,useNA = "always")

### Déclaration de recours pour un motif « Autre »
#### Déclaration de recours acupuncteur NPS pour un motif « Autre »
# Vu médecin depuis recours acupuncteur NPS pour un motif « Autre »
med.dep.acup.tnps.autre <- acup.tnps.autre == TRUE &
  ((is.na(qtnps$acup.rec.comp.med1) == FALSE &
      qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur") |
  (is.na(qtnps$med.depuis.acup) == FALSE & qtnps$med.depuis.acup == "Oui"))
table(med.dep.acup.tnps.autre,useNA = "always")
# Parlé médecin recours acupuncteur NPS
talk.med.dep.acup.tnps.autre <- med.dep.acup.tnps.autre == TRUE &
  (is.na(qtnps$talk.acup.med) == FALSE & qtnps$talk.acup.med == "Oui")
table(talk.med.dep.acup.tnps.autre,useNA = "always")

#### Déclaration de recours chiropracteur NPS pour un motif « Autre »
# Vu médecin depuis recours chiropracteur NPS pour un motif « Autre »
med.dep.chiro.tnps.autre <- chiro.tnps.autre == TRUE &
  ((is.na(qtnps$chiro.rec.comp.med1) == FALSE &
      qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur") |
  (is.na(qtnps$med.depuis.chiro) == FALSE & qtnps$med.depuis.chiro == "Oui"))
table(med.dep.chiro.tnps.autre,useNA = "always")
# Parlé médecin recours chiropracteur NPS
talk.med.dep.chiro.tnps.autre <- med.dep.chiro.tnps.autre == TRUE &
  (is.na(qtnps$talk.chiro.med) == FALSE & qtnps$talk.chiro.med == "Oui")
table(talk.med.dep.chiro.tnps.autre,useNA = "always")

#### Déclaration de recours homéopathe NPS pour un motif « Autre »
# Vu médecin depuis recours homéopathe NPS pour un motif « Autre »
med.dep.homeo.tnps.autre <- homeo.tnps.autre == TRUE &
  ((is.na(qtnps$homeo.rec.comp.med1) == FALSE &
      qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe") |
  (is.na(qtnps$med.depuis.homeo) == FALSE & qtnps$med.depuis.homeo == "Oui"))
table(med.dep.homeo.tnps.autre,useNA = "always")
# Parlé médecin recours homéopathe NPS
talk.med.dep.homeo.tnps.autre <- med.dep.homeo.tnps.autre == TRUE &
  (is.na(qtnps$talk.homeo.med) == FALSE & qtnps$talk.homeo.med == "Oui")
table(talk.med.dep.homeo.tnps.autre,useNA = "always")

#### Déclaration de recours magnétiseur NPS pour un motif « Autre »
# Vu médecin depuis recours magnétiseur NPS pour un motif « Autre »
med.dep.magne.tnps.autre <- magne.tnps.autre == TRUE &
  ((is.na(qtnps$magne.rec.comp.med1) == FALSE &
      qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur") |
  (is.na(qtnps$med.depuis.magne) == FALSE & qtnps$med.depuis.magne == "Oui"))
table(med.dep.magne.tnps.autre,useNA = "always")
# Parlé médecin recours magnétiseur NPS
talk.med.dep.magne.tnps.autre <- med.dep.magne.tnps.autre == TRUE &
  (is.na(qtnps$talk.magne.med) == FALSE & qtnps$talk.magne.med == "Oui")
table(talk.med.dep.magne.tnps.autre,useNA = "always")

#### Déclaration de recours ostéopathe NPS pour un motif « Autre »
# Vu médecin depuis recours ostéopathe NPS pour un motif « Autre »
med.dep.osteo.tnps.autre <- osteo.tnps.autre == TRUE &
  ((is.na(qtnps$osteo.rec.comp.med1) == FALSE &
      qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe") |
  (is.na(qtnps$med.depuis.osteo) == FALSE & qtnps$med.depuis.osteo == "Oui"))
table(med.dep.osteo.tnps.autre,useNA = "always")
# Parlé médecin recours ostéopathe NPS
talk.med.dep.osteo.tnps.autre <- med.dep.osteo.tnps.autre == TRUE &
  (is.na(qtnps$talk.osteo.med) == FALSE & qtnps$talk.osteo.med == "Oui")
table(talk.med.dep.osteo.tnps.autre,useNA = "always")

#### Déclaration de recours rebouteux NPS pour un motif « Autre »
# Vu médecin depuis recours rebouteux NPS pour un motif « Autre »
med.dep.rebout.tnps.autre <- rebout.tnps.autre == TRUE &
  ((is.na(qtnps$rebout.rec.comp.med1) == FALSE &
      qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux") |
  (is.na(qtnps$med.depuis.rebout) == FALSE & qtnps$med.depuis.rebout == "Oui"))
table(med.dep.rebout.tnps.autre,useNA = "always")
# Parlé médecin recours rebouteux NPS
talk.med.dep.rebout.tnps.autre <- med.dep.rebout.tnps.autre == TRUE &
  (is.na(qtnps$talk.rebout.med) == FALSE & qtnps$talk.rebout.med == "Oui")
table(talk.med.dep.rebout.tnps.autre,useNA = "always")

#### Déclaration de recours TA-NPS pour un motif « Autre »
# Vu médecin depuis recours TA-NPS pour un motif « Autre »
med.dep.tnps.autre <- med.dep.acup.tnps.autre|med.dep.chiro.tnps.autre|
  med.dep.homeo.tnps.autre|
  med.dep.magne.tnps.autre|med.dep.osteo.tnps.autre|med.dep.rebout.tnps.autre
table(med.dep.tnps.autre,useNA = "always")
# Parlé médecin recours TA-NPS pour un motif « Autre »
talk.med.dep.tnps.autre <- talk.med.dep.acup.tnps.autre|talk.med.dep.chiro.tnps.autre|
  talk.med.dep.homeo.tnps.autre|talk.med.dep.magne.tnps.autre|
  talk.med.dep.osteo.tnps.autre|
  talk.med.dep.rebout.tnps.autre
table(talk.med.dep.tnps.autre,useNA = "always")

### Déclaration de recours pour une bronchite
#### Déclaration de recours acupuncteur NPS pour une bronchite
# Vu médecin depuis recours acupuncteur NPS pour une bronchite
med.dep.acup.tnps.bronchite <- acup.tnps.bronchite == TRUE &
  ((is.na(qtnps$acup.rec.comp.med1) == FALSE &
      qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur") |
  (is.na(qtnps$med.depuis.acup) == FALSE & qtnps$med.depuis.acup == "Oui"))
table(med.dep.acup.tnps.bronchite,useNA = "always")
# Parlé médecin recours acupuncteur NPS
talk.med.dep.acup.tnps.bronchite <- med.dep.acup.tnps.bronchite == TRUE &
  (is.na(qtnps$talk.acup.med) == FALSE & qtnps$talk.acup.med == "Oui")
table(talk.med.dep.acup.tnps.bronchite,useNA = "always")

#### Déclaration de recours chiropracteur NPS pour une bronchite
# Vu médecin depuis recours chiropracteur NPS pour une bronchite
med.dep.chiro.tnps.bronchite <- chiro.tnps.bronchite == TRUE &
  ((is.na(qtnps$chiro.rec.comp.med1) == FALSE &
      qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur") |
  (is.na(qtnps$med.depuis.chiro) == FALSE & qtnps$med.depuis.chiro == "Oui"))
table(med.dep.chiro.tnps.bronchite,useNA = "always")
# Parlé médecin recours chiropracteur NPS
talk.med.dep.chiro.tnps.bronchite <- med.dep.chiro.tnps.bronchite == TRUE &
  (is.na(qtnps$talk.chiro.med) == FALSE & qtnps$talk.chiro.med == "Oui")
table(talk.med.dep.chiro.tnps.bronchite,useNA = "always")

#### Déclaration de recours homéopathe NPS pour une bronchite
# Vu médecin depuis recours homéopathe NPS pour une bronchite
med.dep.homeo.tnps.bronchite <- homeo.tnps.bronchite == TRUE &
  ((is.na(qtnps$homeo.rec.comp.med1) == FALSE &
      qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe") |
  (is.na(qtnps$med.depuis.homeo) == FALSE & qtnps$med.depuis.homeo == "Oui"))
table(med.dep.homeo.tnps.bronchite,useNA = "always")
# Parlé médecin recours homéopathe NPS
talk.med.dep.homeo.tnps.bronchite <- med.dep.homeo.tnps.bronchite == TRUE &
  (is.na(qtnps$talk.homeo.med) == FALSE & qtnps$talk.homeo.med == "Oui")
table(talk.med.dep.homeo.tnps.bronchite,useNA = "always")

#### Déclaration de recours magnétiseur NPS pour une bronchite
# Vu médecin depuis recours magnétiseur NPS pour une bronchite
med.dep.magne.tnps.bronchite <- magne.tnps.bronchite == TRUE &
  ((is.na(qtnps$magne.rec.comp.med1) == FALSE &
      qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur") |
  (is.na(qtnps$med.depuis.magne) == FALSE & qtnps$med.depuis.magne == "Oui"))
table(med.dep.magne.tnps.bronchite,useNA = "always")
# Parlé médecin recours magnétiseur NPS
talk.med.dep.magne.tnps.bronchite <- med.dep.magne.tnps.bronchite == TRUE &
  (is.na(qtnps$talk.magne.med) == FALSE & qtnps$talk.magne.med == "Oui")
table(talk.med.dep.magne.tnps.bronchite,useNA = "always")

#### Déclaration de recours ostéopathe NPS pour une bronchite
# Vu médecin depuis recours ostéopathe NPS pour une bronchite
med.dep.osteo.tnps.bronchite <- osteo.tnps.bronchite == TRUE &
  ((is.na(qtnps$osteo.rec.comp.med1) == FALSE &
      qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe") |
  (is.na(qtnps$med.depuis.osteo) == FALSE & qtnps$med.depuis.osteo == "Oui"))
table(med.dep.osteo.tnps.bronchite,useNA = "always")
# Parlé médecin recours ostéopathe NPS
talk.med.dep.osteo.tnps.bronchite <- med.dep.osteo.tnps.bronchite == TRUE &
  (is.na(qtnps$talk.osteo.med) == FALSE & qtnps$talk.osteo.med == "Oui")
table(talk.med.dep.osteo.tnps.bronchite,useNA = "always")

#### Déclaration de recours rebouteux NPS pour une bronchite
# Vu médecin depuis recours rebouteux NPS pour une bronchite
med.dep.rebout.tnps.bronchite <- rebout.tnps.bronchite == TRUE &
  ((is.na(qtnps$rebout.rec.comp.med1) == FALSE &
      qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux") |
  (is.na(qtnps$med.depuis.rebout) == FALSE & qtnps$med.depuis.rebout == "Oui"))
table(med.dep.rebout.tnps.bronchite,useNA = "always")
# Parlé médecin recours rebouteux NPS
talk.med.dep.rebout.tnps.bronchite <- med.dep.rebout.tnps.bronchite == TRUE &
  (is.na(qtnps$talk.rebout.med) == FALSE & qtnps$talk.rebout.med == "Oui")
table(talk.med.dep.rebout.tnps.bronchite,useNA = "always")

#### Déclaration de recours TA-NPS pour une bronchite
# Vu médecin depuis recours TA-NPS pour une bronchite
med.dep.tnps.bronchite <- med.dep.acup.tnps.bronchite|med.dep.chiro.tnps.bronchite|
  med.dep.homeo.tnps.bronchite|
  med.dep.magne.tnps.bronchite|med.dep.osteo.tnps.bronchite|
  med.dep.rebout.tnps.bronchite
table(med.dep.tnps.bronchite,useNA = "always")
# Parlé médecin recours TA-NPS pour une bronchite
talk.med.dep.tnps.bronchite <- talk.med.dep.acup.tnps.bronchite|
  talk.med.dep.chiro.tnps.bronchite|
  talk.med.dep.homeo.tnps.bronchite|talk.med.dep.magne.tnps.bronchite|
  talk.med.dep.osteo.tnps.bronchite|
  talk.med.dep.rebout.tnps.bronchite
table(talk.med.dep.tnps.bronchite,useNA = "always")

### Déclaration de recours pour une dépression
#### Déclaration de recours acupuncteur NPS pour une dépression
# Vu médecin depuis recours acupuncteur NPS pour une dépression
med.dep.acup.tnps.depression <- acup.tnps.depression == TRUE &
  ((is.na(qtnps$acup.rec.comp.med1) == FALSE &
      qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur") |
  (is.na(qtnps$med.depuis.acup) == FALSE & qtnps$med.depuis.acup == "Oui"))
table(med.dep.acup.tnps.depression,useNA = "always")
# Parlé médecin recours acupuncteur NPS
talk.med.dep.acup.tnps.depression <- med.dep.acup.tnps.depression == TRUE &
  (is.na(qtnps$talk.acup.med) == FALSE & qtnps$talk.acup.med == "Oui")
table(talk.med.dep.acup.tnps.depression,useNA = "always")

#### Déclaration de recours chiropracteur NPS pour une dépression
# Vu médecin depuis recours chiropracteur NPS pour une dépression
med.dep.chiro.tnps.depression <- chiro.tnps.depression == TRUE &
  ((is.na(qtnps$chiro.rec.comp.med1) == FALSE &
      qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur") |
  (is.na(qtnps$med.depuis.chiro) == FALSE & qtnps$med.depuis.chiro == "Oui"))
table(med.dep.chiro.tnps.depression,useNA = "always")
# Parlé médecin recours chiropracteur NPS
talk.med.dep.chiro.tnps.depression <- med.dep.chiro.tnps.depression == TRUE &
  (is.na(qtnps$talk.chiro.med) == FALSE & qtnps$talk.chiro.med == "Oui")
table(talk.med.dep.chiro.tnps.depression,useNA = "always")

#### Déclaration de recours homéopathe NPS pour une dépression
# Vu médecin depuis recours homéopathe NPS pour une dépression
med.dep.homeo.tnps.depression <- homeo.tnps.depression == TRUE &
  ((is.na(qtnps$homeo.rec.comp.med1) == FALSE &
      qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe") |
  (is.na(qtnps$med.depuis.homeo) == FALSE & qtnps$med.depuis.homeo == "Oui"))
table(med.dep.homeo.tnps.depression,useNA = "always")
# Parlé médecin recours homéopathe NPS
talk.med.dep.homeo.tnps.depression <- med.dep.homeo.tnps.depression == TRUE &
  (is.na(qtnps$talk.homeo.med) == FALSE & qtnps$talk.homeo.med == "Oui")
table(talk.med.dep.homeo.tnps.depression,useNA = "always")

#### Déclaration de recours magnétiseur NPS pour une dépression
# Vu médecin depuis recours magnétiseur NPS pour une dépression
med.dep.magne.tnps.depression <- magne.tnps.depression == TRUE &
  ((is.na(qtnps$magne.rec.comp.med1) == FALSE &
      qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur") |
  (is.na(qtnps$med.depuis.magne) == FALSE & qtnps$med.depuis.magne == "Oui"))
table(med.dep.magne.tnps.depression,useNA = "always")
# Parlé médecin recours magnétiseur NPS
talk.med.dep.magne.tnps.depression <- med.dep.magne.tnps.depression == TRUE &
  (is.na(qtnps$talk.magne.med) == FALSE & qtnps$talk.magne.med == "Oui")
table(talk.med.dep.magne.tnps.depression,useNA = "always")

#### Déclaration de recours ostéopathe NPS pour une dépression
# Vu médecin depuis recours ostéopathe NPS pour une dépression
med.dep.osteo.tnps.depression <- osteo.tnps.depression == TRUE &
  ((is.na(qtnps$osteo.rec.comp.med1) == FALSE &
      qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe") |
  (is.na(qtnps$med.depuis.osteo) == FALSE & qtnps$med.depuis.osteo == "Oui"))
table(med.dep.osteo.tnps.depression,useNA = "always")
# Parlé médecin recours ostéopathe NPS
talk.med.dep.osteo.tnps.depression <- med.dep.osteo.tnps.depression == TRUE &
  (is.na(qtnps$talk.osteo.med) == FALSE & qtnps$talk.osteo.med == "Oui")
table(talk.med.dep.osteo.tnps.depression,useNA = "always")

#### Déclaration de recours rebouteux NPS pour une dépression
# Vu médecin depuis recours rebouteux NPS pour une dépression
med.dep.rebout.tnps.depression <- rebout.tnps.depression == TRUE &
  ((is.na(qtnps$rebout.rec.comp.med1) == FALSE &
      qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux") |
  (is.na(qtnps$med.depuis.rebout) == FALSE & qtnps$med.depuis.rebout == "Oui"))
table(med.dep.rebout.tnps.depression,useNA = "always")
# Parlé médecin recours rebouteux NPS
talk.med.dep.rebout.tnps.depression <- med.dep.rebout.tnps.depression == TRUE &
  (is.na(qtnps$talk.rebout.med) == FALSE & qtnps$talk.rebout.med == "Oui")
table(talk.med.dep.rebout.tnps.depression,useNA = "always")

#### Déclaration de recours TA-NPS pour une dépression
# Vu médecin depuis recours TA-NPS pour une dépression
med.dep.tnps.depression <- med.dep.acup.tnps.depression|med.dep.chiro.tnps.depression|
  med.dep.homeo.tnps.depression|
  med.dep.magne.tnps.depression|med.dep.osteo.tnps.depression|
  med.dep.rebout.tnps.depression
table(med.dep.tnps.depression,useNA = "always")
# Parlé médecin recours TA-NPS pour une dépression
talk.med.dep.tnps.depression <- talk.med.dep.acup.tnps.depression|
  talk.med.dep.chiro.tnps.depression|
  talk.med.dep.homeo.tnps.depression|talk.med.dep.magne.tnps.depression|
  talk.med.dep.osteo.tnps.depression|
  talk.med.dep.rebout.tnps.depression
table(talk.med.dep.tnps.depression,useNA = "always")

### Déclaration de recours pour une grippe ou un syndrome grippal
#### Déclaration de recours acupuncteur NPS pour une grippe ou un syndrome grippal
# Vu médecin depuis recours acupuncteur NPS pour une grippe ou un syndrome grippal
med.dep.acup.tnps.grippe <- acup.tnps.grippe == TRUE &
  ((is.na(qtnps$acup.rec.comp.med1) == FALSE &
      qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur") |
  (is.na(qtnps$med.depuis.acup) == FALSE & qtnps$med.depuis.acup == "Oui"))
table(med.dep.acup.tnps.grippe,useNA = "always")
# Parlé médecin recours acupuncteur NPS
talk.med.dep.acup.tnps.grippe <- med.dep.acup.tnps.grippe == TRUE &
  (is.na(qtnps$talk.acup.med) == FALSE & qtnps$talk.acup.med == "Oui")
table(talk.med.dep.acup.tnps.grippe,useNA = "always")

#### Déclaration de recours chiropracteur NPS pour une grippe ou un syndrome grippal
# Vu médecin depuis recours chiropracteur NPS pour une grippe ou un syndrome grippal
med.dep.chiro.tnps.grippe <- chiro.tnps.grippe == TRUE &
  ((is.na(qtnps$chiro.rec.comp.med1) == FALSE &
      qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur") |
  (is.na(qtnps$med.depuis.chiro) == FALSE & qtnps$med.depuis.chiro == "Oui"))
table(med.dep.chiro.tnps.grippe,useNA = "always")
# Parlé médecin recours chiropracteur NPS
talk.med.dep.chiro.tnps.grippe <- med.dep.chiro.tnps.grippe == TRUE &
  (is.na(qtnps$talk.chiro.med) == FALSE & qtnps$talk.chiro.med == "Oui")
table(talk.med.dep.chiro.tnps.grippe,useNA = "always")

#### Déclaration de recours homéopathe NPS pour une grippe ou un syndrome grippal
# Vu médecin depuis recours homéopathe NPS pour une grippe ou un syndrome grippal
med.dep.homeo.tnps.grippe <- homeo.tnps.grippe == TRUE &
  ((is.na(qtnps$homeo.rec.comp.med1) == FALSE &
      qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe") |
  (is.na(qtnps$med.depuis.homeo) == FALSE & qtnps$med.depuis.homeo == "Oui"))
table(med.dep.homeo.tnps.grippe,useNA = "always")
# Parlé médecin recours homéopathe NPS
talk.med.dep.homeo.tnps.grippe <- med.dep.homeo.tnps.grippe == TRUE &
  (is.na(qtnps$talk.homeo.med) == FALSE & qtnps$talk.homeo.med == "Oui")
table(talk.med.dep.homeo.tnps.grippe,useNA = "always")

#### Déclaration de recours magnétiseur NPS pour une grippe ou un syndrome grippal
# Vu médecin depuis recours magnétiseur NPS pour une grippe ou un syndrome grippal
med.dep.magne.tnps.grippe <- magne.tnps.grippe == TRUE &
  ((is.na(qtnps$magne.rec.comp.med1) == FALSE &
      qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur") |
  (is.na(qtnps$med.depuis.magne) == FALSE & qtnps$med.depuis.magne == "Oui"))
table(med.dep.magne.tnps.grippe,useNA = "always")
# Parlé médecin recours magnétiseur NPS
talk.med.dep.magne.tnps.grippe <- med.dep.magne.tnps.grippe == TRUE &
  (is.na(qtnps$talk.magne.med) == FALSE & qtnps$talk.magne.med == "Oui")
table(talk.med.dep.magne.tnps.grippe,useNA = "always")

#### Déclaration de recours ostéopathe NPS pour une grippe ou un syndrome grippal
# Vu médecin depuis recours ostéopathe NPS pour une grippe ou un syndrome grippal
med.dep.osteo.tnps.grippe <- osteo.tnps.grippe == TRUE &
  ((is.na(qtnps$osteo.rec.comp.med1) == FALSE &
      qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe") |
  (is.na(qtnps$med.depuis.osteo) == FALSE & qtnps$med.depuis.osteo == "Oui"))
table(med.dep.osteo.tnps.grippe,useNA = "always")
# Parlé médecin recours ostéopathe NPS
talk.med.dep.osteo.tnps.grippe <- med.dep.osteo.tnps.grippe == TRUE &
  (is.na(qtnps$talk.osteo.med) == FALSE & qtnps$talk.osteo.med == "Oui")
table(talk.med.dep.osteo.tnps.grippe,useNA = "always")

#### Déclaration de recours rebouteux NPS pour une grippe ou un syndrome grippal
# Vu médecin depuis recours rebouteux NPS pour une grippe ou un syndrome grippal
med.dep.rebout.tnps.grippe <- rebout.tnps.grippe == TRUE &
  ((is.na(qtnps$rebout.rec.comp.med1) == FALSE &
      qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux") |
  (is.na(qtnps$med.depuis.rebout) == FALSE & qtnps$med.depuis.rebout == "Oui"))
table(med.dep.rebout.tnps.grippe,useNA = "always")
# Parlé médecin recours rebouteux NPS
talk.med.dep.rebout.tnps.grippe <- med.dep.rebout.tnps.grippe == TRUE &
  (is.na(qtnps$talk.rebout.med) == FALSE & qtnps$talk.rebout.med == "Oui")
table(talk.med.dep.rebout.tnps.grippe,useNA = "always")

#### Déclaration de recours TA-NPS pour une grippe ou un syndrome grippal
# Vu médecin depuis recours TA-NPS pour une grippe ou un syndrome grippal
med.dep.tnps.grippe <- med.dep.acup.tnps.grippe|med.dep.chiro.tnps.grippe|
  med.dep.homeo.tnps.grippe|
  med.dep.magne.tnps.grippe|med.dep.osteo.tnps.grippe|med.dep.rebout.tnps.grippe
table(med.dep.tnps.grippe,useNA = "always")
# Parlé médecin recours TA-NPS pour une grippe ou un syndrome grippal
talk.med.dep.tnps.grippe <- talk.med.dep.acup.tnps.grippe|
  talk.med.dep.chiro.tnps.grippe|
  talk.med.dep.homeo.tnps.grippe|talk.med.dep.magne.tnps.grippe|
  talk.med.dep.osteo.tnps.grippe|
  talk.med.dep.rebout.tnps.grippe
table(talk.med.dep.tnps.grippe,useNA = "always")

### Déclaration de recours pour un mal de gorge
#### Déclaration de recours acupuncteur NPS pour un mal de gorge
# Vu médecin depuis recours acupuncteur NPS pour un mal de gorge
med.dep.acup.tnps.gorge <- acup.tnps.gorge == TRUE &
  ((is.na(qtnps$acup.rec.comp.med1) == FALSE &
      qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur") |
  (is.na(qtnps$med.depuis.acup) == FALSE & qtnps$med.depuis.acup == "Oui"))
table(med.dep.acup.tnps.gorge,useNA = "always")
# Parlé médecin recours acupuncteur NPS
talk.med.dep.acup.tnps.gorge <- med.dep.acup.tnps.gorge == TRUE &
  (is.na(qtnps$talk.acup.med) == FALSE & qtnps$talk.acup.med == "Oui")
table(talk.med.dep.acup.tnps.gorge,useNA = "always")

#### Déclaration de recours chiropracteur NPS pour un mal de gorge
# Vu médecin depuis recours chiropracteur NPS pour un mal de gorge
med.dep.chiro.tnps.gorge <- chiro.tnps.gorge == TRUE &
  ((is.na(qtnps$chiro.rec.comp.med1) == FALSE &
      qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur") |
  (is.na(qtnps$med.depuis.chiro) == FALSE & qtnps$med.depuis.chiro == "Oui"))
table(med.dep.chiro.tnps.gorge,useNA = "always")
# Parlé médecin recours chiropracteur NPS
talk.med.dep.chiro.tnps.gorge <- med.dep.chiro.tnps.gorge == TRUE &
  (is.na(qtnps$talk.chiro.med) == FALSE & qtnps$talk.chiro.med == "Oui")
table(talk.med.dep.chiro.tnps.gorge,useNA = "always")

#### Déclaration de recours homéopathe NPS pour un mal de gorge
# Vu médecin depuis recours homéopathe NPS pour un mal de gorge
med.dep.homeo.tnps.gorge <- homeo.tnps.gorge == TRUE &
  ((is.na(qtnps$homeo.rec.comp.med1) == FALSE &
      qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe") |
  (is.na(qtnps$med.depuis.homeo) == FALSE & qtnps$med.depuis.homeo == "Oui"))
table(med.dep.homeo.tnps.gorge,useNA = "always")
# Parlé médecin recours homéopathe NPS
talk.med.dep.homeo.tnps.gorge <- med.dep.homeo.tnps.gorge == TRUE &
  (is.na(qtnps$talk.homeo.med) == FALSE & qtnps$talk.homeo.med == "Oui")
table(talk.med.dep.homeo.tnps.gorge,useNA = "always")

#### Déclaration de recours magnétiseur NPS pour un mal de gorge
# Vu médecin depuis recours magnétiseur NPS pour un mal de gorge
med.dep.magne.tnps.gorge <- magne.tnps.gorge == TRUE &
  ((is.na(qtnps$magne.rec.comp.med1) == FALSE &
      qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur") |
  (is.na(qtnps$med.depuis.magne) == FALSE & qtnps$med.depuis.magne == "Oui"))
table(med.dep.magne.tnps.gorge,useNA = "always")
# Parlé médecin recours magnétiseur NPS
talk.med.dep.magne.tnps.gorge <- med.dep.magne.tnps.gorge == TRUE &
  (is.na(qtnps$talk.magne.med) == FALSE & qtnps$talk.magne.med == "Oui")
table(talk.med.dep.magne.tnps.gorge,useNA = "always")

#### Déclaration de recours ostéopathe NPS pour un mal de gorge
# Vu médecin depuis recours ostéopathe NPS pour un mal de gorge
med.dep.osteo.tnps.gorge <- osteo.tnps.gorge == TRUE &
  ((is.na(qtnps$osteo.rec.comp.med1) == FALSE &
      qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe") |
  (is.na(qtnps$med.depuis.osteo) == FALSE & qtnps$med.depuis.osteo == "Oui"))
table(med.dep.osteo.tnps.gorge,useNA = "always")
# Parlé médecin recours ostéopathe NPS
talk.med.dep.osteo.tnps.gorge <- med.dep.osteo.tnps.gorge == TRUE &
  (is.na(qtnps$talk.osteo.med) == FALSE & qtnps$talk.osteo.med == "Oui")
table(talk.med.dep.osteo.tnps.gorge,useNA = "always")

#### Déclaration de recours rebouteux NPS pour un mal de gorge
# Vu médecin depuis recours rebouteux NPS pour un mal de gorge
med.dep.rebout.tnps.gorge <- rebout.tnps.gorge == TRUE &
  ((is.na(qtnps$rebout.rec.comp.med1) == FALSE &
      qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux") |
  (is.na(qtnps$med.depuis.rebout) == FALSE & qtnps$med.depuis.rebout == "Oui"))
table(med.dep.rebout.tnps.gorge,useNA = "always")
# Parlé médecin recours rebouteux NPS
talk.med.dep.rebout.tnps.gorge <- med.dep.rebout.tnps.gorge == TRUE &
  (is.na(qtnps$talk.rebout.med) == FALSE & qtnps$talk.rebout.med == "Oui")
table(talk.med.dep.rebout.tnps.gorge,useNA = "always")

#### Déclaration de recours TA-NPS pour un mal de gorge
# Vu médecin depuis recours TA-NPS pour un mal de gorge
med.dep.tnps.gorge <- med.dep.acup.tnps.gorge|med.dep.chiro.tnps.gorge|
  med.dep.homeo.tnps.gorge|
  med.dep.magne.tnps.gorge|med.dep.osteo.tnps.gorge|med.dep.rebout.tnps.gorge
table(med.dep.tnps.gorge,useNA = "always")
# Parlé médecin recours TA-NPS pour un mal de gorge
talk.med.dep.tnps.gorge <- talk.med.dep.acup.tnps.gorge|
  talk.med.dep.chiro.tnps.gorge|
  talk.med.dep.homeo.tnps.gorge|talk.med.dep.magne.tnps.gorge|
  talk.med.dep.osteo.tnps.gorge|
  talk.med.dep.rebout.tnps.gorge
table(talk.med.dep.tnps.gorge,useNA = "always")

### Déclaration de recours pour des maux de tête ou migraines
#### Déclaration de recours acupuncteur NPS pour des maux de tête ou migraines
# Vu médecin depuis recours acupuncteur NPS pour des maux de tête ou migraines
med.dep.acup.tnps.migraine <- acup.tnps.migraine == TRUE &
  ((is.na(qtnps$acup.rec.comp.med1) == FALSE &
      qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur") |
  (is.na(qtnps$med.depuis.acup) == FALSE & qtnps$med.depuis.acup == "Oui"))
table(med.dep.acup.tnps.migraine,useNA = "always")
# Parlé médecin recours acupuncteur NPS
talk.med.dep.acup.tnps.migraine <- med.dep.acup.tnps.migraine == TRUE &
  (is.na(qtnps$talk.acup.med) == FALSE & qtnps$talk.acup.med == "Oui")
table(talk.med.dep.acup.tnps.migraine,useNA = "always")

#### Déclaration de recours chiropracteur NPS pour des maux de tête ou migraines
# Vu médecin depuis recours chiropracteur NPS pour des maux de tête ou migraines
med.dep.chiro.tnps.migraine <- chiro.tnps.migraine == TRUE &
  ((is.na(qtnps$chiro.rec.comp.med1) == FALSE &
      qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur") |
  (is.na(qtnps$med.depuis.chiro) == FALSE & qtnps$med.depuis.chiro == "Oui"))
table(med.dep.chiro.tnps.migraine,useNA = "always")
# Parlé médecin recours chiropracteur NPS
talk.med.dep.chiro.tnps.migraine <- med.dep.chiro.tnps.migraine == TRUE &
  (is.na(qtnps$talk.chiro.med) == FALSE & qtnps$talk.chiro.med == "Oui")
table(talk.med.dep.chiro.tnps.migraine,useNA = "always")

#### Déclaration de recours homéopathe NPS pour des maux de tête ou migraines
# Vu médecin depuis recours homéopathe NPS pour des maux de tête ou migraines
med.dep.homeo.tnps.migraine <- homeo.tnps.migraine == TRUE &
  ((is.na(qtnps$homeo.rec.comp.med1) == FALSE &
      qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe") |
  (is.na(qtnps$med.depuis.homeo) == FALSE & qtnps$med.depuis.homeo == "Oui"))
table(med.dep.homeo.tnps.migraine,useNA = "always")
# Parlé médecin recours homéopathe NPS
talk.med.dep.homeo.tnps.migraine <- med.dep.homeo.tnps.migraine == TRUE &
  (is.na(qtnps$talk.homeo.med) == FALSE & qtnps$talk.homeo.med == "Oui")
table(talk.med.dep.homeo.tnps.migraine,useNA = "always")

#### Déclaration de recours magnétiseur NPS pour des maux de tête ou migraines
# Vu médecin depuis recours magnétiseur NPS pour des maux de tête ou migraines
med.dep.magne.tnps.migraine <- magne.tnps.migraine == TRUE &
  ((is.na(qtnps$magne.rec.comp.med1) == FALSE &
      qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur") |
  (is.na(qtnps$med.depuis.magne) == FALSE & qtnps$med.depuis.magne == "Oui"))
table(med.dep.magne.tnps.migraine,useNA = "always")
# Parlé médecin recours magnétiseur NPS
talk.med.dep.magne.tnps.migraine <- med.dep.magne.tnps.migraine == TRUE &
  (is.na(qtnps$talk.magne.med) == FALSE & qtnps$talk.magne.med == "Oui")
table(talk.med.dep.magne.tnps.migraine,useNA = "always")

#### Déclaration de recours ostéopathe NPS pour des maux de tête ou migraines
# Vu médecin depuis recours ostéopathe NPS pour des maux de tête ou migraines
med.dep.osteo.tnps.migraine <- osteo.tnps.migraine == TRUE &
  ((is.na(qtnps$osteo.rec.comp.med1) == FALSE &
      qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe") |
  (is.na(qtnps$med.depuis.osteo) == FALSE & qtnps$med.depuis.osteo == "Oui"))
table(med.dep.osteo.tnps.migraine,useNA = "always")
# Parlé médecin recours ostéopathe NPS
talk.med.dep.osteo.tnps.migraine <- med.dep.osteo.tnps.migraine == TRUE &
  (is.na(qtnps$talk.osteo.med) == FALSE & qtnps$talk.osteo.med == "Oui")
table(talk.med.dep.osteo.tnps.migraine,useNA = "always")

#### Déclaration de recours rebouteux NPS pour des maux de tête ou migraines
# Vu médecin depuis recours rebouteux NPS pour des maux de tête ou migraines
med.dep.rebout.tnps.migraine <- rebout.tnps.migraine == TRUE &
  ((is.na(qtnps$rebout.rec.comp.med1) == FALSE &
      qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux") |
  (is.na(qtnps$med.depuis.rebout) == FALSE & qtnps$med.depuis.rebout == "Oui"))
table(med.dep.rebout.tnps.migraine,useNA = "always")
# Parlé médecin recours rebouteux NPS
talk.med.dep.rebout.tnps.migraine <- med.dep.rebout.tnps.migraine == TRUE &
  (is.na(qtnps$talk.rebout.med) == FALSE & qtnps$talk.rebout.med == "Oui")
table(talk.med.dep.rebout.tnps.migraine,useNA = "always")

#### Déclaration de recours TA-NPS pour des maux de tête ou migraines
# Vu médecin depuis recours TA-NPS pour des maux de tête ou migraines
med.dep.tnps.migraine <- med.dep.acup.tnps.migraine|med.dep.chiro.tnps.migraine|
  med.dep.homeo.tnps.migraine|
  med.dep.magne.tnps.migraine|med.dep.osteo.tnps.migraine|med.dep.rebout.tnps.migraine
table(med.dep.tnps.migraine,useNA = "always")
# Parlé médecin recours TA-NPS pour des maux de tête ou migraines
talk.med.dep.tnps.migraine <- talk.med.dep.acup.tnps.migraine|
  talk.med.dep.chiro.tnps.migraine|
  talk.med.dep.homeo.tnps.migraine|talk.med.dep.magne.tnps.migraine|
  talk.med.dep.osteo.tnps.migraine|
  talk.med.dep.rebout.tnps.migraine
table(talk.med.dep.tnps.migraine,useNA = "always")

### Déclaration de recours pour une douleur au cou
#### Déclaration de recours acupuncteur NPS pour une douleur au cou
# Vu médecin depuis recours acupuncteur NPS pour une douleur au cou
med.dep.acup.tnps.cou <- acup.tnps.cou == TRUE &
  ((is.na(qtnps$acup.rec.comp.med1) == FALSE &
      qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur") |
  (is.na(qtnps$med.depuis.acup) == FALSE & qtnps$med.depuis.acup == "Oui"))
table(med.dep.acup.tnps.cou,useNA = "always")
# Parlé médecin recours acupuncteur NPS
talk.med.dep.acup.tnps.cou <- med.dep.acup.tnps.cou == TRUE &
  (is.na(qtnps$talk.acup.med) == FALSE & qtnps$talk.acup.med == "Oui")
table(talk.med.dep.acup.tnps.cou,useNA = "always")

#### Déclaration de recours chiropracteur NPS pour une douleur au cou
# Vu médecin depuis recours chiropracteur NPS pour une douleur au cou
med.dep.chiro.tnps.cou <- chiro.tnps.cou == TRUE &
  ((is.na(qtnps$chiro.rec.comp.med1) == FALSE &
      qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur") |
  (is.na(qtnps$med.depuis.chiro) == FALSE & qtnps$med.depuis.chiro == "Oui"))
table(med.dep.chiro.tnps.cou,useNA = "always")
# Parlé médecin recours chiropracteur NPS
talk.med.dep.chiro.tnps.cou <- med.dep.chiro.tnps.cou == TRUE &
  (is.na(qtnps$talk.chiro.med) == FALSE & qtnps$talk.chiro.med == "Oui")
table(talk.med.dep.chiro.tnps.cou,useNA = "always")

#### Déclaration de recours homéopathe NPS pour une douleur au cou
# Vu médecin depuis recours homéopathe NPS pour une douleur au cou
med.dep.homeo.tnps.cou <- homeo.tnps.cou == TRUE &
  ((is.na(qtnps$homeo.rec.comp.med1) == FALSE &
      qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe") |
  (is.na(qtnps$med.depuis.homeo) == FALSE & qtnps$med.depuis.homeo == "Oui"))
table(med.dep.homeo.tnps.cou,useNA = "always")
# Parlé médecin recours homéopathe NPS
talk.med.dep.homeo.tnps.cou <- med.dep.homeo.tnps.cou == TRUE &
  (is.na(qtnps$talk.homeo.med) == FALSE & qtnps$talk.homeo.med == "Oui")
table(talk.med.dep.homeo.tnps.cou,useNA = "always")

#### Déclaration de recours magnétiseur NPS pour une douleur au cou
# Vu médecin depuis recours magnétiseur NPS pour une douleur au cou
med.dep.magne.tnps.cou <- magne.tnps.cou == TRUE &
  ((is.na(qtnps$magne.rec.comp.med1) == FALSE &
      qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur") |
  (is.na(qtnps$med.depuis.magne) == FALSE & qtnps$med.depuis.magne == "Oui"))
table(med.dep.magne.tnps.cou,useNA = "always")
# Parlé médecin recours magnétiseur NPS
talk.med.dep.magne.tnps.cou <- med.dep.magne.tnps.cou == TRUE &
  (is.na(qtnps$talk.magne.med) == FALSE & qtnps$talk.magne.med == "Oui")
table(talk.med.dep.magne.tnps.cou,useNA = "always")

#### Déclaration de recours ostéopathe NPS pour une douleur au cou
# Vu médecin depuis recours ostéopathe NPS pour une douleur au cou
med.dep.osteo.tnps.cou <- osteo.tnps.cou == TRUE &
  ((is.na(qtnps$osteo.rec.comp.med1) == FALSE &
      qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe") |
  (is.na(qtnps$med.depuis.osteo) == FALSE & qtnps$med.depuis.osteo == "Oui"))
table(med.dep.osteo.tnps.cou,useNA = "always")
# Parlé médecin recours ostéopathe NPS
talk.med.dep.osteo.tnps.cou <- med.dep.osteo.tnps.cou == TRUE &
  (is.na(qtnps$talk.osteo.med) == FALSE & qtnps$talk.osteo.med == "Oui")
table(talk.med.dep.osteo.tnps.cou,useNA = "always")

#### Déclaration de recours rebouteux NPS pour une douleur au cou
# Vu médecin depuis recours rebouteux NPS pour une douleur au cou
med.dep.rebout.tnps.cou <- rebout.tnps.cou == TRUE &
  ((is.na(qtnps$rebout.rec.comp.med1) == FALSE &
      qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux") |
  (is.na(qtnps$med.depuis.rebout) == FALSE & qtnps$med.depuis.rebout == "Oui"))
table(med.dep.rebout.tnps.cou,useNA = "always")
# Parlé médecin recours rebouteux NPS
talk.med.dep.rebout.tnps.cou <- med.dep.rebout.tnps.cou == TRUE &
  (is.na(qtnps$talk.rebout.med) == FALSE & qtnps$talk.rebout.med == "Oui")
table(talk.med.dep.rebout.tnps.cou,useNA = "always")

#### Déclaration de recours TA-NPS pour une douleur au cou
# Vu médecin depuis recours TA-NPS pour une douleur au cou
med.dep.tnps.cou <- med.dep.acup.tnps.cou|med.dep.chiro.tnps.cou|
  med.dep.homeo.tnps.cou|
  med.dep.magne.tnps.cou|med.dep.osteo.tnps.cou|med.dep.rebout.tnps.cou
table(med.dep.tnps.cou,useNA = "always")
# Parlé médecin recours TA-NPS pour une douleur au cou
talk.med.dep.tnps.cou <- talk.med.dep.acup.tnps.cou|talk.med.dep.chiro.tnps.cou|
  talk.med.dep.homeo.tnps.cou|talk.med.dep.magne.tnps.cou|talk.med.dep.osteo.tnps.cou|
  talk.med.dep.rebout.tnps.cou
table(talk.med.dep.tnps.cou,useNA = "always")

### Déclaration de recours pour une douleur de membre supérieur
#### Déclaration de recours acupuncteur NPS pour une douleur de membre supérieur
# Vu médecin depuis recours acupuncteur NPS pour une douleur de membre supérieur
med.dep.acup.tnps.msup <- acup.tnps.msup == TRUE &
  ((is.na(qtnps$acup.rec.comp.med1) == FALSE &
      qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur") |
  (is.na(qtnps$med.depuis.acup) == FALSE & qtnps$med.depuis.acup == "Oui"))
table(med.dep.acup.tnps.msup,useNA = "always")
# Parlé médecin recours acupuncteur NPS
talk.med.dep.acup.tnps.msup <- med.dep.acup.tnps.msup == TRUE &
  (is.na(qtnps$talk.acup.med) == FALSE & qtnps$talk.acup.med == "Oui")
table(talk.med.dep.acup.tnps.msup,useNA = "always")

#### Déclaration de recours chiropracteur NPS pour une douleur de membre supérieur
# Vu médecin depuis recours chiropracteur NPS pour une douleur de membre supérieur
med.dep.chiro.tnps.msup <- chiro.tnps.msup == TRUE &
  ((is.na(qtnps$chiro.rec.comp.med1) == FALSE &
      qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur") |
  (is.na(qtnps$med.depuis.chiro) == FALSE & qtnps$med.depuis.chiro == "Oui"))
table(med.dep.chiro.tnps.msup,useNA = "always")
# Parlé médecin recours chiropracteur NPS
talk.med.dep.chiro.tnps.msup <- med.dep.chiro.tnps.msup == TRUE &
  (is.na(qtnps$talk.chiro.med) == FALSE & qtnps$talk.chiro.med == "Oui")
table(talk.med.dep.chiro.tnps.msup,useNA = "always")

#### Déclaration de recours homéopathe NPS pour une douleur de membre supérieur
# Vu médecin depuis recours homéopathe NPS pour une douleur de membre supérieur
med.dep.homeo.tnps.msup <- homeo.tnps.msup == TRUE &
  ((is.na(qtnps$homeo.rec.comp.med1) == FALSE &
      qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe") |
  (is.na(qtnps$med.depuis.homeo) == FALSE & qtnps$med.depuis.homeo == "Oui"))
table(med.dep.homeo.tnps.msup,useNA = "always")
# Parlé médecin recours homéopathe NPS
talk.med.dep.homeo.tnps.msup <- med.dep.homeo.tnps.msup == TRUE &
  (is.na(qtnps$talk.homeo.med) == FALSE & qtnps$talk.homeo.med == "Oui")
table(talk.med.dep.homeo.tnps.msup,useNA = "always")

#### Déclaration de recours magnétiseur NPS pour une douleur de membre supérieur
# Vu médecin depuis recours magnétiseur NPS pour une douleur de membre supérieur
med.dep.magne.tnps.msup <- magne.tnps.msup == TRUE &
  ((is.na(qtnps$magne.rec.comp.med1) == FALSE &
      qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur") |
  (is.na(qtnps$med.depuis.magne) == FALSE & qtnps$med.depuis.magne == "Oui"))
table(med.dep.magne.tnps.msup,useNA = "always")
# Parlé médecin recours magnétiseur NPS
talk.med.dep.magne.tnps.msup <- med.dep.magne.tnps.msup == TRUE &
  (is.na(qtnps$talk.magne.med) == FALSE & qtnps$talk.magne.med == "Oui")
table(talk.med.dep.magne.tnps.msup,useNA = "always")

#### Déclaration de recours ostéopathe NPS pour une douleur de membre supérieur
# Vu médecin depuis recours ostéopathe NPS pour une douleur de membre supérieur
med.dep.osteo.tnps.msup <- osteo.tnps.msup == TRUE &
  ((is.na(qtnps$osteo.rec.comp.med1) == FALSE &
      qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe") |
  (is.na(qtnps$med.depuis.osteo) == FALSE & qtnps$med.depuis.osteo == "Oui"))
table(med.dep.osteo.tnps.msup,useNA = "always")
# Parlé médecin recours ostéopathe NPS
talk.med.dep.osteo.tnps.msup <- med.dep.osteo.tnps.msup == TRUE &
  (is.na(qtnps$talk.osteo.med) == FALSE & qtnps$talk.osteo.med == "Oui")
table(talk.med.dep.osteo.tnps.msup,useNA = "always")

#### Déclaration de recours rebouteux NPS pour une douleur de membre supérieur
# Vu médecin depuis recours rebouteux NPS pour une douleur de membre supérieur
med.dep.rebout.tnps.msup <- rebout.tnps.msup == TRUE &
  ((is.na(qtnps$rebout.rec.comp.med1) == FALSE &
      qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux") |
  (is.na(qtnps$med.depuis.rebout) == FALSE & qtnps$med.depuis.rebout == "Oui"))
table(med.dep.rebout.tnps.msup,useNA = "always")
# Parlé médecin recours rebouteux NPS
talk.med.dep.rebout.tnps.msup <- med.dep.rebout.tnps.msup == TRUE &
  (is.na(qtnps$talk.rebout.med) == FALSE & qtnps$talk.rebout.med == "Oui")
table(talk.med.dep.rebout.tnps.msup,useNA = "always")

#### Déclaration de recours TA-NPS pour une douleur de membre supérieur
# Vu médecin depuis recours TA-NPS pour une douleur de membre supérieur
med.dep.tnps.msup <- med.dep.acup.tnps.msup|med.dep.chiro.tnps.msup|
  med.dep.homeo.tnps.msup|
  med.dep.magne.tnps.msup|med.dep.osteo.tnps.msup|med.dep.rebout.tnps.msup
table(med.dep.tnps.msup,useNA = "always")
# Parlé médecin recours TA-NPS pour une douleur de membre supérieur
talk.med.dep.tnps.msup <- talk.med.dep.acup.tnps.msup|
  talk.med.dep.chiro.tnps.msup|
  talk.med.dep.homeo.tnps.msup|talk.med.dep.magne.tnps.msup|
  talk.med.dep.osteo.tnps.msup|
  talk.med.dep.rebout.tnps.msup
table(talk.med.dep.tnps.msup,useNA = "always")

### Déclaration de recours pour du stress ou de l'anxiété
#### Déclaration de recours acupuncteur NPS pour du stress ou de l'anxiété
# Vu médecin depuis recours acupuncteur NPS pour du stress ou de l'anxiété
med.dep.acup.tnps.stress <- acup.tnps.stress == TRUE &
  ((is.na(qtnps$acup.rec.comp.med1) == FALSE &
      qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur") |
  (is.na(qtnps$med.depuis.acup) == FALSE & qtnps$med.depuis.acup == "Oui"))
table(med.dep.acup.tnps.stress,useNA = "always")
# Parlé médecin recours acupuncteur NPS
talk.med.dep.acup.tnps.stress <- med.dep.acup.tnps.stress == TRUE &
  (is.na(qtnps$talk.acup.med) == FALSE & qtnps$talk.acup.med == "Oui")
table(talk.med.dep.acup.tnps.stress,useNA = "always")

#### Déclaration de recours chiropracteur NPS pour du stress ou de l'anxiété
# Vu médecin depuis recours chiropracteur NPS pour du stress ou de l'anxiété
med.dep.chiro.tnps.stress <- chiro.tnps.stress == TRUE &
  ((is.na(qtnps$chiro.rec.comp.med1) == FALSE &
      qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur") |
  (is.na(qtnps$med.depuis.chiro) == FALSE & qtnps$med.depuis.chiro == "Oui"))
table(med.dep.chiro.tnps.stress,useNA = "always")
# Parlé médecin recours chiropracteur NPS
talk.med.dep.chiro.tnps.stress <- med.dep.chiro.tnps.stress == TRUE &
  (is.na(qtnps$talk.chiro.med) == FALSE & qtnps$talk.chiro.med == "Oui")
table(talk.med.dep.chiro.tnps.stress,useNA = "always")

#### Déclaration de recours homéopathe NPS pour du stress ou de l'anxiété
# Vu médecin depuis recours homéopathe NPS pour du stress ou de l'anxiété
med.dep.homeo.tnps.stress <- homeo.tnps.stress == TRUE &
  ((is.na(qtnps$homeo.rec.comp.med1) == FALSE &
      qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe") |
  (is.na(qtnps$med.depuis.homeo) == FALSE & qtnps$med.depuis.homeo == "Oui"))
table(med.dep.homeo.tnps.stress,useNA = "always")
# Parlé médecin recours homéopathe NPS
talk.med.dep.homeo.tnps.stress <- med.dep.homeo.tnps.stress == TRUE &
  (is.na(qtnps$talk.homeo.med) == FALSE & qtnps$talk.homeo.med == "Oui")
table(talk.med.dep.homeo.tnps.stress,useNA = "always")

#### Déclaration de recours magnétiseur NPS pour du stress ou de l'anxiété
# Vu médecin depuis recours magnétiseur NPS pour du stress ou de l'anxiété
med.dep.magne.tnps.stress <- magne.tnps.stress == TRUE &
  ((is.na(qtnps$magne.rec.comp.med1) == FALSE &
      qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur") |
  (is.na(qtnps$med.depuis.magne) == FALSE & qtnps$med.depuis.magne == "Oui"))
table(med.dep.magne.tnps.stress,useNA = "always")
# Parlé médecin recours magnétiseur NPS
talk.med.dep.magne.tnps.stress <- med.dep.magne.tnps.stress == TRUE &
  (is.na(qtnps$talk.magne.med) == FALSE & qtnps$talk.magne.med == "Oui")
table(talk.med.dep.magne.tnps.stress,useNA = "always")

#### Déclaration de recours ostéopathe NPS pour du stress ou de l'anxiété
# Vu médecin depuis recours ostéopathe NPS pour du stress ou de l'anxiété
med.dep.osteo.tnps.stress <- osteo.tnps.stress == TRUE &
  ((is.na(qtnps$osteo.rec.comp.med1) == FALSE &
      qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe") |
  (is.na(qtnps$med.depuis.osteo) == FALSE & qtnps$med.depuis.osteo == "Oui"))
table(med.dep.osteo.tnps.stress,useNA = "always")
# Parlé médecin recours ostéopathe NPS
talk.med.dep.osteo.tnps.stress <- med.dep.osteo.tnps.stress == TRUE &
  (is.na(qtnps$talk.osteo.med) == FALSE & qtnps$talk.osteo.med == "Oui")
table(talk.med.dep.osteo.tnps.stress,useNA = "always")

#### Déclaration de recours rebouteux NPS pour du stress ou de l'anxiété
# Vu médecin depuis recours rebouteux NPS pour du stress ou de l'anxiété
med.dep.rebout.tnps.stress <- rebout.tnps.stress == TRUE &
  ((is.na(qtnps$rebout.rec.comp.med1) == FALSE &
      qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux") |
  (is.na(qtnps$med.depuis.rebout) == FALSE & qtnps$med.depuis.rebout == "Oui"))
table(med.dep.rebout.tnps.stress,useNA = "always")
# Parlé médecin recours rebouteux NPS
talk.med.dep.rebout.tnps.stress <- med.dep.rebout.tnps.stress == TRUE &
  (is.na(qtnps$talk.rebout.med) == FALSE & qtnps$talk.rebout.med == "Oui")
table(talk.med.dep.rebout.tnps.stress,useNA = "always")

#### Déclaration de recours TA-NPS pour du stress ou de l'anxiété
# Vu médecin depuis recours TA-NPS pour du stress ou de l'anxiété
med.dep.tnps.stress <- med.dep.acup.tnps.stress|med.dep.chiro.tnps.stress|
  med.dep.homeo.tnps.stress|
  med.dep.magne.tnps.stress|med.dep.osteo.tnps.stress|med.dep.rebout.tnps.stress
table(med.dep.tnps.stress,useNA = "always")
# Parlé médecin recours TA-NPS pour du stress ou de l'anxiété
talk.med.dep.tnps.stress <- talk.med.dep.acup.tnps.stress|
  talk.med.dep.chiro.tnps.stress|
  talk.med.dep.homeo.tnps.stress|talk.med.dep.magne.tnps.stress|
  talk.med.dep.osteo.tnps.stress|
  talk.med.dep.rebout.tnps.stress
table(talk.med.dep.tnps.stress,useNA = "always")

### Déclaration de recours pour une douleur de membre inférieur
#### Déclaration de recours acupuncteur NPS pour une douleur de membre inférieur
# Vu médecin depuis recours acupuncteur NPS pour une douleur de membre inférieur
med.dep.acup.tnps.minf <- acup.tnps.minf == TRUE &
  ((is.na(qtnps$acup.rec.comp.med1) == FALSE &
      qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur") |
  (is.na(qtnps$med.depuis.acup) == FALSE & qtnps$med.depuis.acup == "Oui"))
table(med.dep.acup.tnps.minf,useNA = "always")
# Parlé médecin recours acupuncteur NPS
talk.med.dep.acup.tnps.minf <- med.dep.acup.tnps.minf == TRUE &
  (is.na(qtnps$talk.acup.med) == FALSE & qtnps$talk.acup.med == "Oui")
table(talk.med.dep.acup.tnps.minf,useNA = "always")

#### Déclaration de recours chiropracteur NPS pour une douleur de membre inférieur
# Vu médecin depuis recours chiropracteur NPS pour une douleur de membre inférieur
med.dep.chiro.tnps.minf <- chiro.tnps.minf == TRUE &
  ((is.na(qtnps$chiro.rec.comp.med1) == FALSE &
      qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur") |
  (is.na(qtnps$med.depuis.chiro) == FALSE & qtnps$med.depuis.chiro == "Oui"))
table(med.dep.chiro.tnps.minf,useNA = "always")
# Parlé médecin recours chiropracteur NPS
talk.med.dep.chiro.tnps.minf <- med.dep.chiro.tnps.minf == TRUE &
  (is.na(qtnps$talk.chiro.med) == FALSE & qtnps$talk.chiro.med == "Oui")
table(talk.med.dep.chiro.tnps.minf,useNA = "always")

#### Déclaration de recours homéopathe NPS pour une douleur de membre inférieur
# Vu médecin depuis recours homéopathe NPS pour une douleur de membre inférieur
med.dep.homeo.tnps.minf <- homeo.tnps.minf == TRUE &
  ((is.na(qtnps$homeo.rec.comp.med1) == FALSE &
      qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe") |
  (is.na(qtnps$med.depuis.homeo) == FALSE & qtnps$med.depuis.homeo == "Oui"))
table(med.dep.homeo.tnps.minf,useNA = "always")
# Parlé médecin recours homéopathe NPS
talk.med.dep.homeo.tnps.minf <- med.dep.homeo.tnps.minf == TRUE &
  (is.na(qtnps$talk.homeo.med) == FALSE & qtnps$talk.homeo.med == "Oui")
table(talk.med.dep.homeo.tnps.minf,useNA = "always")

#### Déclaration de recours magnétiseur NPS pour une douleur de membre inférieur
# Vu médecin depuis recours magnétiseur NPS pour une douleur de membre inférieur
med.dep.magne.tnps.minf <- magne.tnps.minf == TRUE &
  ((is.na(qtnps$magne.rec.comp.med1) == FALSE &
      qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur") |
  (is.na(qtnps$med.depuis.magne) == FALSE & qtnps$med.depuis.magne == "Oui"))
table(med.dep.magne.tnps.minf,useNA = "always")
# Parlé médecin recours magnétiseur NPS
talk.med.dep.magne.tnps.minf <- med.dep.magne.tnps.minf == TRUE &
  (is.na(qtnps$talk.magne.med) == FALSE & qtnps$talk.magne.med == "Oui")
table(talk.med.dep.magne.tnps.minf,useNA = "always")

#### Déclaration de recours ostéopathe NPS pour une douleur de membre inférieur
# Vu médecin depuis recours ostéopathe NPS pour une douleur de membre inférieur
med.dep.osteo.tnps.minf <- osteo.tnps.minf == TRUE &
  ((is.na(qtnps$osteo.rec.comp.med1) == FALSE &
      qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe") |
  (is.na(qtnps$med.depuis.osteo) == FALSE & qtnps$med.depuis.osteo == "Oui"))
table(med.dep.osteo.tnps.minf,useNA = "always")
# Parlé médecin recours ostéopathe NPS
talk.med.dep.osteo.tnps.minf <- med.dep.osteo.tnps.minf == TRUE &
  (is.na(qtnps$talk.osteo.med) == FALSE & qtnps$talk.osteo.med == "Oui")
table(talk.med.dep.osteo.tnps.minf,useNA = "always")

#### Déclaration de recours rebouteux NPS pour une douleur de membre inférieur
# Vu médecin depuis recours rebouteux NPS pour une douleur de membre inférieur
med.dep.rebout.tnps.minf <- rebout.tnps.minf == TRUE &
  ((is.na(qtnps$rebout.rec.comp.med1) == FALSE &
      qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux") |
  (is.na(qtnps$med.depuis.rebout) == FALSE & qtnps$med.depuis.rebout == "Oui"))
table(med.dep.rebout.tnps.minf,useNA = "always")
# Parlé médecin recours rebouteux NPS
talk.med.dep.rebout.tnps.minf <- med.dep.rebout.tnps.minf == TRUE &
  (is.na(qtnps$talk.rebout.med) == FALSE & qtnps$talk.rebout.med == "Oui")
table(talk.med.dep.rebout.tnps.minf,useNA = "always")

#### Déclaration de recours TA-NPS pour une douleur de membre inférieur
# Vu médecin depuis recours TA-NPS pour une douleur de membre inférieur
med.dep.tnps.minf <- med.dep.acup.tnps.minf|med.dep.chiro.tnps.minf|
  med.dep.homeo.tnps.minf|
  med.dep.magne.tnps.minf|med.dep.osteo.tnps.minf|med.dep.rebout.tnps.minf
table(med.dep.tnps.minf,useNA = "always")
# Parlé médecin recours TA-NPS pour une douleur de membre inférieur
talk.med.dep.tnps.minf <- talk.med.dep.acup.tnps.minf|talk.med.dep.chiro.tnps.minf|
  talk.med.dep.homeo.tnps.minf|talk.med.dep.magne.tnps.minf|
  talk.med.dep.osteo.tnps.minf|
  talk.med.dep.rebout.tnps.minf
table(talk.med.dep.tnps.minf,useNA = "always")

## Taux de déclaration de recours à son médecin (Figure X) ----
# Médecin vu depuis le recours au TA-NPS
med.dep.tnps <- med.dep.tnps.dos|med.dep.tnps.stress|med.dep.tnps.minf|
  med.dep.tnps.bronchite|med.dep.tnps.depression|med.dep.tnps.autre|
  med.dep.tnps.msup|med.dep.tnps.cou|med.dep.tnps.migraine|
  med.dep.tnps.gorge|med.dep.tnps.grippe
table(med.dep.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
#  9282  1196     0 
# Taux de déclaration
talk.med.dep.tnps <- talk.med.dep.tnps.dos|talk.med.dep.tnps.stress|
  talk.med.dep.tnps.minf|talk.med.dep.tnps.bronchite|
  talk.med.dep.tnps.depression|talk.med.dep.tnps.autre|
  talk.med.dep.tnps.grippe|talk.med.dep.tnps.gorge|
  talk.med.dep.tnps.msup|talk.med.dep.tnps.cou|
  talk.med.dep.tnps.migraine
table(talk.med.dep.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
#  9782   696     0
(696/1196)*100
# [1] 58.194

## Taux de déclaration pour un acupuncteur NPS (Figure X) ----
# Médecin vu depuis l'acupuncteur NPS
med.dep.acup.tnps <- med.dep.acup.tnps.dos|med.dep.acup.tnps.stress|
  med.dep.acup.tnps.minf|
  med.dep.acup.tnps.bronchite|med.dep.acup.tnps.depression|med.dep.acup.tnps.autre|
  med.dep.acup.tnps.msup|med.dep.acup.tnps.cou|med.dep.acup.tnps.migraine|
  med.dep.acup.tnps.gorge|med.dep.acup.tnps.grippe
table(med.dep.acup.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10298   180     0
# Taux de déclaration
talk.med.dep.acup.tnps <- talk.med.dep.acup.tnps.dos|talk.med.dep.acup.tnps.stress|
  talk.med.dep.acup.tnps.minf|talk.med.dep.acup.tnps.bronchite|
  talk.med.dep.acup.tnps.depression|talk.med.dep.acup.tnps.autre|
  talk.med.dep.acup.tnps.grippe|talk.med.dep.acup.tnps.gorge|
  talk.med.dep.acup.tnps.msup|talk.med.dep.acup.tnps.cou|
  talk.med.dep.acup.tnps.migraine
table(talk.med.dep.acup.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10385    93     0
(93/180)*100
# [1] 51.667

## Taux de déclaration pour un chiropracteur NPS (Figure X) ----
# Médecin vu depuis le chiropracteur NPS
med.dep.chiro.tnps <- med.dep.chiro.tnps.dos|med.dep.chiro.tnps.stress|
  med.dep.chiro.tnps.minf|
  med.dep.chiro.tnps.bronchite|med.dep.chiro.tnps.depression|med.dep.chiro.tnps.autre|
  med.dep.chiro.tnps.msup|med.dep.chiro.tnps.cou|med.dep.chiro.tnps.migraine|
  med.dep.chiro.tnps.gorge|med.dep.chiro.tnps.grippe
table(med.dep.chiro.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10407    71     0 
# Taux de déclaration
talk.med.dep.chiro.tnps <- talk.med.dep.chiro.tnps.dos|talk.med.dep.chiro.tnps.stress|
  talk.med.dep.chiro.tnps.minf|talk.med.dep.chiro.tnps.bronchite|
  talk.med.dep.chiro.tnps.depression|talk.med.dep.chiro.tnps.autre|
  talk.med.dep.chiro.tnps.grippe|talk.med.dep.chiro.tnps.gorge|
  talk.med.dep.chiro.tnps.msup|talk.med.dep.chiro.tnps.cou|
  talk.med.dep.chiro.tnps.migraine
table(talk.med.dep.chiro.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10437    41     0
(41/71)*100
# [1] 57.746

## Taux de déclaration pour un homéopathe NPS (Figure X) ----
# Médecin vu depuis l'homéopathe NPS
med.dep.homeo.tnps <- med.dep.homeo.tnps.dos|med.dep.homeo.tnps.stress|
  med.dep.homeo.tnps.minf|
  med.dep.homeo.tnps.bronchite|med.dep.homeo.tnps.depression|med.dep.homeo.tnps.autre|
  med.dep.homeo.tnps.msup|med.dep.homeo.tnps.cou|med.dep.homeo.tnps.migraine|
  med.dep.homeo.tnps.gorge|med.dep.homeo.tnps.grippe
table(med.dep.homeo.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10433    45     0
# Taux de déclaration
talk.med.dep.homeo.tnps <- talk.med.dep.homeo.tnps.dos|talk.med.dep.homeo.tnps.stress|
  talk.med.dep.homeo.tnps.minf|talk.med.dep.homeo.tnps.bronchite|
  talk.med.dep.homeo.tnps.depression|talk.med.dep.homeo.tnps.autre|
  talk.med.dep.homeo.tnps.grippe|talk.med.dep.homeo.tnps.gorge|
  talk.med.dep.homeo.tnps.msup|talk.med.dep.homeo.tnps.cou|
  talk.med.dep.homeo.tnps.migraine
table(talk.med.dep.homeo.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10452    26     0
(26/45)*100
# [1] 57.778

## Taux de déclaration pour un magnétiseur NPS (Figure X) ----
# Médecin vu depuis le magnétiseur NPS
med.dep.magne.tnps <- med.dep.magne.tnps.dos|med.dep.magne.tnps.stress|
  med.dep.magne.tnps.minf|
  med.dep.magne.tnps.bronchite|med.dep.magne.tnps.depression|med.dep.magne.tnps.autre|
  med.dep.magne.tnps.msup|med.dep.magne.tnps.cou|med.dep.magne.tnps.migraine|
  med.dep.magne.tnps.gorge|med.dep.magne.tnps.grippe
table(med.dep.magne.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10210   268     0
# Taux de déclaration
talk.med.dep.magne.tnps <- talk.med.dep.magne.tnps.dos|talk.med.dep.magne.tnps.stress|
  talk.med.dep.magne.tnps.minf|talk.med.dep.magne.tnps.bronchite|
  talk.med.dep.magne.tnps.depression|talk.med.dep.magne.tnps.autre|
  talk.med.dep.magne.tnps.grippe|talk.med.dep.magne.tnps.gorge|
  talk.med.dep.magne.tnps.msup|talk.med.dep.magne.tnps.cou|
  talk.med.dep.magne.tnps.migraine
table(talk.med.dep.magne.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10388    90     0
(90/268)*100
# [1] 33.582

## Taux de déclaration pour un ostéopathe NPS (Figure X) ----
# Médecin vu depuis l'ostéopathe NPS
med.dep.osteo.tnps <- med.dep.osteo.tnps.dos|med.dep.osteo.tnps.stress|
  med.dep.osteo.tnps.minf|
  med.dep.osteo.tnps.bronchite|med.dep.osteo.tnps.depression|med.dep.osteo.tnps.autre|
  med.dep.osteo.tnps.msup|med.dep.osteo.tnps.cou|med.dep.osteo.tnps.migraine|
  med.dep.osteo.tnps.gorge|med.dep.osteo.tnps.grippe
table(med.dep.osteo.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
#  9721   757     0
# Taux de déclaration
talk.med.dep.osteo.tnps <- talk.med.dep.osteo.tnps.dos|talk.med.dep.osteo.tnps.stress|
  talk.med.dep.osteo.tnps.minf|talk.med.dep.osteo.tnps.bronchite|
  talk.med.dep.osteo.tnps.depression|talk.med.dep.osteo.tnps.autre|
  talk.med.dep.osteo.tnps.grippe|talk.med.dep.osteo.tnps.gorge|
  talk.med.dep.osteo.tnps.msup|talk.med.dep.osteo.tnps.cou|
  talk.med.dep.osteo.tnps.migraine
table(talk.med.dep.osteo.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
#  9998   480     0
(480/757)*100
# [1] 63.408

## Taux de déclaration pour un rebouteux NPS (Figure X) ----
# Médecin vu depuis le rebouteux NPS
med.dep.rebout.tnps <- med.dep.rebout.tnps.dos|med.dep.rebout.tnps.stress|
  med.dep.rebout.tnps.minf|
  med.dep.rebout.tnps.bronchite|med.dep.rebout.tnps.depression|med.dep.rebout.tnps.autre|
  med.dep.rebout.tnps.msup|med.dep.rebout.tnps.cou|med.dep.rebout.tnps.migraine|
  med.dep.rebout.tnps.gorge|med.dep.rebout.tnps.grippe
table(med.dep.rebout.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10426    52     0
# Taux de déclaration
talk.med.dep.rebout.tnps <- talk.med.dep.rebout.tnps.dos|talk.med.dep.rebout.tnps.stress|
  talk.med.dep.rebout.tnps.minf|talk.med.dep.rebout.tnps.bronchite|
  talk.med.dep.rebout.tnps.depression|talk.med.dep.rebout.tnps.autre|
  talk.med.dep.rebout.tnps.grippe|talk.med.dep.rebout.tnps.gorge|
  talk.med.dep.rebout.tnps.msup|talk.med.dep.rebout.tnps.cou|
  talk.med.dep.rebout.tnps.migraine
table(talk.med.dep.rebout.tnps,useNA = "always")
# FALSE  TRUE  <NA> 
# 10457    21     0
(21/52)*100
# [1] 40.385


## TA-NPS ayant recommandé de consulter un médecin ----

### TA-NPS ayant recommandé pour un mal de dos
#### Acupuncteur NPS ayant recommandé pour un mal de dos
# Acupuncteur NPS vu avant ou isolément d'un médecin
acup.tnps.dos.avalt.med <- acup.tnps.dos.alt == TRUE |
  (acup.tnps.dos == TRUE & 
      (is.na(qtnps$acup.rec.comp.med1)== FALSE & 
          qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur"))
table(acup.tnps.dos.avalt.med,useNA = "always")
# Taux de recommandation
acup.tnps.dos.avalt.med.recom.med <- acup.tnps.dos.avalt.med == TRUE &
  ((is.na(qtnps$acup.recom.med1)==FALSE & qtnps$acup.recom.med1 == "Oui") |
  (is.na(qtnps$acup.recom.med2)==FALSE & qtnps$acup.recom.med2 == "Oui"))
table(acup.tnps.dos.avalt.med.recom.med,useNA = "always")

#### Chiropracteur NPS ayant recommandé pour un mal de dos
# Chiropracteur NPS vu avant ou isolément d'un médecin
chiro.tnps.dos.avalt.med <- chiro.tnps.dos.alt == TRUE |
  (chiro.tnps.dos == TRUE & 
      (is.na(qtnps$chiro.rec.comp.med1)== FALSE & 
          qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur"))
table(chiro.tnps.dos.avalt.med,useNA = "always")
# Taux de recommandation
chiro.tnps.dos.avalt.med.recom.med <- chiro.tnps.dos.avalt.med == TRUE &
  ((is.na(qtnps$chiro.recom.med1)==FALSE & qtnps$chiro.recom.med1 == "Oui") |
  (is.na(qtnps$chiro.recom.med2)==FALSE & qtnps$chiro.recom.med2 == "Oui"))
table(chiro.tnps.dos.avalt.med.recom.med,useNA = "always")

#### Homéopathe NPS ayant recommandé pour un mal de dos
# Homéopathe NPS vu avant ou isolément d'un médecin
homeo.tnps.dos.avalt.med <- homeo.tnps.dos.alt == TRUE |
  (homeo.tnps.dos == TRUE & 
      (is.na(qtnps$homeo.rec.comp.med1)== FALSE & 
          qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe"))
table(homeo.tnps.dos.avalt.med,useNA = "always")
# Taux de recommandation
homeo.tnps.dos.avalt.med.recom.med <- homeo.tnps.dos.avalt.med == TRUE &
  ((is.na(qtnps$homeo.recom.med1)==FALSE & qtnps$homeo.recom.med1 == "Oui") |
  (is.na(qtnps$homeo.recom.med2)==FALSE & qtnps$homeo.recom.med2 == "Oui"))
table(homeo.tnps.dos.avalt.med.recom.med,useNA = "always")

#### Magnétiseur NPS ayant recommandé pour un mal de dos
# Magnétiseur NPS vu avant ou isolément d'un médecin
magne.tnps.dos.avalt.med <- magne.tnps.dos.alt == TRUE |
  (magne.tnps.dos == TRUE & 
      (is.na(qtnps$magne.rec.comp.med1)== FALSE & 
          qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur"))
table(magne.tnps.dos.avalt.med,useNA = "always")
# Taux de recommandation
magne.tnps.dos.avalt.med.recom.med <- magne.tnps.dos.avalt.med == TRUE &
  ((is.na(qtnps$magne.recom.med1)==FALSE & qtnps$magne.recom.med1 == "Oui") |
  (is.na(qtnps$magne.recom.med2)==FALSE & qtnps$magne.recom.med2 == "Oui"))
table(magne.tnps.dos.avalt.med.recom.med,useNA = "always")

#### Ostéopathe NPS ayant recommandé pour un mal de dos
# Ostéopathe NPS vu avant ou isolément d'un médecin
osteo.tnps.dos.avalt.med <- osteo.tnps.dos.alt == TRUE |
  (osteo.tnps.dos == TRUE & 
      (is.na(qtnps$osteo.rec.comp.med1)== FALSE & 
          qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe"))
table(osteo.tnps.dos.avalt.med,useNA = "always")
# Taux de recommandation
osteo.tnps.dos.avalt.med.recom.med <- osteo.tnps.dos.avalt.med == TRUE &
  ((is.na(qtnps$osteo.recom.med1)==FALSE & qtnps$osteo.recom.med1 == "Oui") |
  (is.na(qtnps$osteo.recom.med2)==FALSE & qtnps$osteo.recom.med2 == "Oui"))
table(osteo.tnps.dos.avalt.med.recom.med,useNA = "always")

#### Rebouteux NPS ayant recommandé pour un mal de dos
# Rebouteux NPS vu avant ou isolément d'un médecin
rebout.tnps.dos.avalt.med <- rebout.tnps.dos.alt == TRUE |
  (rebout.tnps.dos == TRUE & 
      (is.na(qtnps$rebout.rec.comp.med1)== FALSE & 
          qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux"))
table(rebout.tnps.dos.avalt.med,useNA = "always")
# Taux de recommandation
rebout.tnps.dos.avalt.med.recom.med <- rebout.tnps.dos.avalt.med == TRUE &
  ((is.na(qtnps$rebout.recom.med1)==FALSE & qtnps$rebout.recom.med1 == "Oui") |
  (is.na(qtnps$rebout.recom.med2)==FALSE & qtnps$rebout.recom.med2 == "Oui"))
table(rebout.tnps.dos.avalt.med.recom.med,useNA = "always")

## TA-NPS ayant recommandé pour un mal de dos
# TA-NPS vu avant ou isolément d'un médecin
tnps.dos.avalt.med <- acup.tnps.dos.avalt.med|chiro.tnps.dos.avalt.med|
  homeo.tnps.dos.avalt.med|magne.tnps.dos.avalt.med|osteo.tnps.dos.avalt.med|
  rebout.tnps.dos.avalt.med
table(tnps.dos.avalt.med,useNA = "always")
# Taux de recommandation
tnps.dos.avalt.med.recom.med <- acup.tnps.dos.avalt.med.recom.med|
  chiro.tnps.dos.avalt.med.recom.med|
  homeo.tnps.dos.avalt.med.recom.med|
  magne.tnps.dos.avalt.med.recom.med|
  osteo.tnps.dos.avalt.med.recom.med|
  rebout.tnps.dos.avalt.med.recom.med
table(tnps.dos.avalt.med.recom.med,useNA = "always")

#### Acupuncteur NPS ayant recommandé pour un motif « Autre »
# Acupuncteur NPS vu avant ou isolément d'un médecin
acup.tnps.autre.avalt.med <- acup.tnps.autre.alt == TRUE |
  (acup.tnps.autre == TRUE & 
      (is.na(qtnps$acup.rec.comp.med1)== FALSE & 
          qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur"))
table(acup.tnps.autre.avalt.med,useNA = "always")
# Taux de recommandation
acup.tnps.autre.avalt.med.recom.med <- acup.tnps.autre.avalt.med == TRUE &
  ((is.na(qtnps$acup.recom.med1)==FALSE & qtnps$acup.recom.med1 == "Oui") |
  (is.na(qtnps$acup.recom.med2)==FALSE & qtnps$acup.recom.med2 == "Oui"))
table(acup.tnps.autre.avalt.med.recom.med,useNA = "always")

#### Chiropracteur NPS ayant recommandé pour un motif « Autre »
# Chiropracteur NPS vu avant ou isolément d'un médecin
chiro.tnps.autre.avalt.med <- chiro.tnps.autre.alt == TRUE |
  (chiro.tnps.autre == TRUE & 
      (is.na(qtnps$chiro.rec.comp.med1)== FALSE & 
          qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur"))
table(chiro.tnps.autre.avalt.med,useNA = "always")
# Taux de recommandation
chiro.tnps.autre.avalt.med.recom.med <- chiro.tnps.autre.avalt.med == TRUE &
  ((is.na(qtnps$chiro.recom.med1)==FALSE & qtnps$chiro.recom.med1 == "Oui") |
  (is.na(qtnps$chiro.recom.med2)==FALSE & qtnps$chiro.recom.med2 == "Oui"))
table(chiro.tnps.autre.avalt.med.recom.med,useNA = "always")

#### Homéopathe NPS ayant recommandé pour un motif « Autre »
# Homéopathe NPS vu avant ou isolément d'un médecin
homeo.tnps.autre.avalt.med <- homeo.tnps.autre.alt == TRUE |
  (homeo.tnps.autre == TRUE & 
      (is.na(qtnps$homeo.rec.comp.med1)== FALSE & 
          qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe"))
table(homeo.tnps.autre.avalt.med,useNA = "always")
# Taux de recommandation
homeo.tnps.autre.avalt.med.recom.med <- homeo.tnps.autre.avalt.med == TRUE &
  ((is.na(qtnps$homeo.recom.med1)==FALSE & qtnps$homeo.recom.med1 == "Oui") |
  (is.na(qtnps$homeo.recom.med2)==FALSE & qtnps$homeo.recom.med2 == "Oui"))
table(homeo.tnps.autre.avalt.med.recom.med,useNA = "always")

#### Magnétiseur NPS ayant recommandé pour un motif « Autre »
# Magnétiseur NPS vu avant ou isolément d'un médecin
magne.tnps.autre.avalt.med <- magne.tnps.autre.alt == TRUE |
  (magne.tnps.autre == TRUE & 
      (is.na(qtnps$magne.rec.comp.med1)== FALSE & 
          qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur"))
table(magne.tnps.autre.avalt.med,useNA = "always")
# Taux de recommandation
magne.tnps.autre.avalt.med.recom.med <- magne.tnps.autre.avalt.med == TRUE &
  ((is.na(qtnps$magne.recom.med1)==FALSE & qtnps$magne.recom.med1 == "Oui") |
  (is.na(qtnps$magne.recom.med2)==FALSE & qtnps$magne.recom.med2 == "Oui"))
table(magne.tnps.autre.avalt.med.recom.med,useNA = "always")

#### Ostéopathe NPS ayant recommandé pour un motif « Autre »
# Ostéopathe NPS vu avant ou isolément d'un médecin
osteo.tnps.autre.avalt.med <- osteo.tnps.autre.alt == TRUE |
  (osteo.tnps.autre == TRUE & 
      (is.na(qtnps$osteo.rec.comp.med1)== FALSE & 
          qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe"))
table(osteo.tnps.autre.avalt.med,useNA = "always")
# Taux de recommandation
osteo.tnps.autre.avalt.med.recom.med <- osteo.tnps.autre.avalt.med == TRUE &
  ((is.na(qtnps$osteo.recom.med1)==FALSE & qtnps$osteo.recom.med1 == "Oui") |
  (is.na(qtnps$osteo.recom.med2)==FALSE & qtnps$osteo.recom.med2 == "Oui"))
table(osteo.tnps.autre.avalt.med.recom.med,useNA = "always")

#### Rebouteux NPS ayant recommandé pour un motif « Autre »
# Rebouteux NPS vu avant ou isolément d'un médecin
rebout.tnps.autre.avalt.med <- rebout.tnps.autre.alt == TRUE |
  (rebout.tnps.autre == TRUE & 
      (is.na(qtnps$rebout.rec.comp.med1)== FALSE & 
          qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux"))
table(rebout.tnps.autre.avalt.med,useNA = "always")
# Taux de recommandation
rebout.tnps.autre.avalt.med.recom.med <- rebout.tnps.autre.avalt.med == TRUE &
  ((is.na(qtnps$rebout.recom.med1)==FALSE & qtnps$rebout.recom.med1 == "Oui") |
  (is.na(qtnps$rebout.recom.med2)==FALSE & qtnps$rebout.recom.med2 == "Oui"))
table(rebout.tnps.autre.avalt.med.recom.med,useNA = "always")

## TA-NPS ayant recommandé pour un motif « Autre »
# TA-NPS vu avant ou isolément d'un médecin
tnps.autre.avalt.med <- acup.tnps.autre.avalt.med|chiro.tnps.autre.avalt.med|
  homeo.tnps.autre.avalt.med|magne.tnps.autre.avalt.med|osteo.tnps.autre.avalt.med|
  rebout.tnps.autre.avalt.med
table(tnps.autre.avalt.med,useNA = "always")
# Taux de recommandation
tnps.autre.avalt.med.recom.med <- acup.tnps.autre.avalt.med.recom.med|
  chiro.tnps.autre.avalt.med.recom.med|
  homeo.tnps.autre.avalt.med.recom.med|
  magne.tnps.autre.avalt.med.recom.med|
  osteo.tnps.autre.avalt.med.recom.med|
  rebout.tnps.autre.avalt.med.recom.med
table(tnps.autre.avalt.med.recom.med,useNA = "always")

#### Acupuncteur NPS ayant recommandé pour une bronchite
# Acupuncteur NPS vu avant ou isolément d'un médecin
acup.tnps.bronchite.avalt.med <- acup.tnps.bronchite.alt == TRUE |
  (acup.tnps.bronchite == TRUE & 
      (is.na(qtnps$acup.rec.comp.med1)== FALSE & 
          qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur"))
table(acup.tnps.bronchite.avalt.med,useNA = "always")
# Taux de recommandation
acup.tnps.bronchite.avalt.med.recom.med <- acup.tnps.bronchite.avalt.med == TRUE &
  ((is.na(qtnps$acup.recom.med1)==FALSE & qtnps$acup.recom.med1 == "Oui") |
  (is.na(qtnps$acup.recom.med2)==FALSE & qtnps$acup.recom.med2 == "Oui"))
table(acup.tnps.bronchite.avalt.med.recom.med,useNA = "always")

#### Chiropracteur NPS ayant recommandé pour une bronchite
# Chiropracteur NPS vu avant ou isolément d'un médecin
chiro.tnps.bronchite.avalt.med <- chiro.tnps.bronchite.alt == TRUE |
  (chiro.tnps.bronchite == TRUE & 
      (is.na(qtnps$chiro.rec.comp.med1)== FALSE & 
          qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur"))
table(chiro.tnps.bronchite.avalt.med,useNA = "always")
# Taux de recommandation
chiro.tnps.bronchite.avalt.med.recom.med <- chiro.tnps.bronchite.avalt.med == TRUE &
  ((is.na(qtnps$chiro.recom.med1)==FALSE & qtnps$chiro.recom.med1 == "Oui") |
  (is.na(qtnps$chiro.recom.med2)==FALSE & qtnps$chiro.recom.med2 == "Oui"))
table(chiro.tnps.bronchite.avalt.med.recom.med,useNA = "always")

#### Homéopathe NPS ayant recommandé pour une bronchite
# Homéopathe NPS vu avant ou isolément d'un médecin
homeo.tnps.bronchite.avalt.med <- homeo.tnps.bronchite.alt == TRUE |
  (homeo.tnps.bronchite == TRUE & 
      (is.na(qtnps$homeo.rec.comp.med1)== FALSE & 
          qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe"))
table(homeo.tnps.bronchite.avalt.med,useNA = "always")
# Taux de recommandation
homeo.tnps.bronchite.avalt.med.recom.med <- homeo.tnps.bronchite.avalt.med == TRUE &
  ((is.na(qtnps$homeo.recom.med1)==FALSE & qtnps$homeo.recom.med1 == "Oui") |
  (is.na(qtnps$homeo.recom.med2)==FALSE & qtnps$homeo.recom.med2 == "Oui"))
table(homeo.tnps.bronchite.avalt.med.recom.med,useNA = "always")

#### Magnétiseur NPS ayant recommandé pour une bronchite
# Magnétiseur NPS vu avant ou isolément d'un médecin
magne.tnps.bronchite.avalt.med <- magne.tnps.bronchite.alt == TRUE |
  (magne.tnps.bronchite == TRUE & 
      (is.na(qtnps$magne.rec.comp.med1)== FALSE & 
          qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur"))
table(magne.tnps.bronchite.avalt.med,useNA = "always")
# Taux de recommandation
magne.tnps.bronchite.avalt.med.recom.med <- magne.tnps.bronchite.avalt.med == TRUE &
  ((is.na(qtnps$magne.recom.med1)==FALSE & qtnps$magne.recom.med1 == "Oui") |
  (is.na(qtnps$magne.recom.med2)==FALSE & qtnps$magne.recom.med2 == "Oui"))
table(magne.tnps.bronchite.avalt.med.recom.med,useNA = "always")

#### Ostéopathe NPS ayant recommandé pour une bronchite
# Ostéopathe NPS vu avant ou isolément d'un médecin
osteo.tnps.bronchite.avalt.med <- osteo.tnps.bronchite.alt == TRUE |
  (osteo.tnps.bronchite == TRUE & 
      (is.na(qtnps$osteo.rec.comp.med1)== FALSE & 
          qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe"))
table(osteo.tnps.bronchite.avalt.med,useNA = "always")
# Taux de recommandation
osteo.tnps.bronchite.avalt.med.recom.med <- osteo.tnps.bronchite.avalt.med == TRUE &
  ((is.na(qtnps$osteo.recom.med1)==FALSE & qtnps$osteo.recom.med1 == "Oui") |
  (is.na(qtnps$osteo.recom.med2)==FALSE & qtnps$osteo.recom.med2 == "Oui"))
table(osteo.tnps.bronchite.avalt.med.recom.med,useNA = "always")

#### Rebouteux NPS ayant recommandé pour une bronchite
# Rebouteux NPS vu avant ou isolément d'un médecin
rebout.tnps.bronchite.avalt.med <- rebout.tnps.bronchite.alt == TRUE |
  (rebout.tnps.bronchite == TRUE & 
      (is.na(qtnps$rebout.rec.comp.med1)== FALSE & 
          qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux"))
table(rebout.tnps.bronchite.avalt.med,useNA = "always")
# Taux de recommandation
rebout.tnps.bronchite.avalt.med.recom.med <- rebout.tnps.bronchite.avalt.med == TRUE &
  ((is.na(qtnps$rebout.recom.med1)==FALSE & qtnps$rebout.recom.med1 == "Oui") |
  (is.na(qtnps$rebout.recom.med2)==FALSE & qtnps$rebout.recom.med2 == "Oui"))
table(rebout.tnps.bronchite.avalt.med.recom.med,useNA = "always")

## TA-NPS ayant recommandé pour une bronchite
# TA-NPS vu avant ou isolément d'un médecin
tnps.bronchite.avalt.med <- acup.tnps.bronchite.avalt.med|
  chiro.tnps.bronchite.avalt.med|
  homeo.tnps.bronchite.avalt.med|magne.tnps.bronchite.avalt.med|
  osteo.tnps.bronchite.avalt.med|
  rebout.tnps.bronchite.avalt.med
table(tnps.bronchite.avalt.med,useNA = "always")
# Taux de recommandation
tnps.bronchite.avalt.med.recom.med <- acup.tnps.bronchite.avalt.med.recom.med|
  chiro.tnps.bronchite.avalt.med.recom.med|
  homeo.tnps.bronchite.avalt.med.recom.med|
  magne.tnps.bronchite.avalt.med.recom.med|
  osteo.tnps.bronchite.avalt.med.recom.med|
  rebout.tnps.bronchite.avalt.med.recom.med
table(tnps.bronchite.avalt.med.recom.med,useNA = "always")

#### Acupuncteur NPS ayant recommandé pour une dépression
# Acupuncteur NPS vu avant ou isolément d'un médecin
acup.tnps.depression.avalt.med <- acup.tnps.depression.alt == TRUE |
  (acup.tnps.depression == TRUE & 
      (is.na(qtnps$acup.rec.comp.med1)== FALSE & 
          qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur"))
table(acup.tnps.depression.avalt.med,useNA = "always")
# Taux de recommandation
acup.tnps.depression.avalt.med.recom.med <- acup.tnps.depression.avalt.med == TRUE &
  ((is.na(qtnps$acup.recom.med1)==FALSE & qtnps$acup.recom.med1 == "Oui") |
  (is.na(qtnps$acup.recom.med2)==FALSE & qtnps$acup.recom.med2 == "Oui"))
table(acup.tnps.depression.avalt.med.recom.med,useNA = "always")

#### Chiropracteur NPS ayant recommandé pour une dépression
# Chiropracteur NPS vu avant ou isolément d'un médecin
chiro.tnps.depression.avalt.med <- chiro.tnps.depression.alt == TRUE |
  (chiro.tnps.depression == TRUE & 
      (is.na(qtnps$chiro.rec.comp.med1)== FALSE & 
          qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur"))
table(chiro.tnps.depression.avalt.med,useNA = "always")
# Taux de recommandation
chiro.tnps.depression.avalt.med.recom.med <- chiro.tnps.depression.avalt.med == TRUE &
  ((is.na(qtnps$chiro.recom.med1)==FALSE & qtnps$chiro.recom.med1 == "Oui") |
  (is.na(qtnps$chiro.recom.med2)==FALSE & qtnps$chiro.recom.med2 == "Oui"))
table(chiro.tnps.depression.avalt.med.recom.med,useNA = "always")

#### Homéopathe NPS ayant recommandé pour une dépression
# Homéopathe NPS vu avant ou isolément d'un médecin
homeo.tnps.depression.avalt.med <- homeo.tnps.depression.alt == TRUE |
  (homeo.tnps.depression == TRUE & 
      (is.na(qtnps$homeo.rec.comp.med1)== FALSE & 
          qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe"))
table(homeo.tnps.depression.avalt.med,useNA = "always")
# Taux de recommandation
homeo.tnps.depression.avalt.med.recom.med <- homeo.tnps.depression.avalt.med == TRUE &
  ((is.na(qtnps$homeo.recom.med1)==FALSE & qtnps$homeo.recom.med1 == "Oui") |
  (is.na(qtnps$homeo.recom.med2)==FALSE & qtnps$homeo.recom.med2 == "Oui"))
table(homeo.tnps.depression.avalt.med.recom.med,useNA = "always")

#### Magnétiseur NPS ayant recommandé pour une dépression
# Magnétiseur NPS vu avant ou isolément d'un médecin
magne.tnps.depression.avalt.med <- magne.tnps.depression.alt == TRUE |
  (magne.tnps.depression == TRUE & 
      (is.na(qtnps$magne.rec.comp.med1)== FALSE & 
          qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur"))
table(magne.tnps.depression.avalt.med,useNA = "always")
# Taux de recommandation
magne.tnps.depression.avalt.med.recom.med <- magne.tnps.depression.avalt.med == TRUE &
  ((is.na(qtnps$magne.recom.med1)==FALSE & qtnps$magne.recom.med1 == "Oui") |
  (is.na(qtnps$magne.recom.med2)==FALSE & qtnps$magne.recom.med2 == "Oui"))
table(magne.tnps.depression.avalt.med.recom.med,useNA = "always")

#### Ostéopathe NPS ayant recommandé pour une dépression
# Ostéopathe NPS vu avant ou isolément d'un médecin
osteo.tnps.depression.avalt.med <- osteo.tnps.depression.alt == TRUE |
  (osteo.tnps.depression == TRUE & 
      (is.na(qtnps$osteo.rec.comp.med1)== FALSE & 
          qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe"))
table(osteo.tnps.depression.avalt.med,useNA = "always")
# Taux de recommandation
osteo.tnps.depression.avalt.med.recom.med <- osteo.tnps.depression.avalt.med == TRUE &
  ((is.na(qtnps$osteo.recom.med1)==FALSE & qtnps$osteo.recom.med1 == "Oui") |
  (is.na(qtnps$osteo.recom.med2)==FALSE & qtnps$osteo.recom.med2 == "Oui"))
table(osteo.tnps.depression.avalt.med.recom.med,useNA = "always")

#### Rebouteux NPS ayant recommandé pour une dépression
# Rebouteux NPS vu avant ou isolément d'un médecin
rebout.tnps.depression.avalt.med <- rebout.tnps.depression.alt == TRUE |
  (rebout.tnps.depression == TRUE & 
      (is.na(qtnps$rebout.rec.comp.med1)== FALSE & 
          qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux"))
table(rebout.tnps.depression.avalt.med,useNA = "always")
# Taux de recommandation
rebout.tnps.depression.avalt.med.recom.med <- rebout.tnps.depression.avalt.med==TRUE &
  ((is.na(qtnps$rebout.recom.med1)==FALSE & qtnps$rebout.recom.med1 == "Oui") |
  (is.na(qtnps$rebout.recom.med2)==FALSE & qtnps$rebout.recom.med2 == "Oui"))
table(rebout.tnps.depression.avalt.med.recom.med,useNA = "always")

## TA-NPS ayant recommandé pour une dépression
# TA-NPS vu avant ou isolément d'un médecin
tnps.depression.avalt.med <- acup.tnps.depression.avalt.med|
  chiro.tnps.depression.avalt.med|
  homeo.tnps.depression.avalt.med|magne.tnps.depression.avalt.med|
  osteo.tnps.depression.avalt.med|
  rebout.tnps.depression.avalt.med
table(tnps.depression.avalt.med,useNA = "always")
# Taux de recommandation
tnps.depression.avalt.med.recom.med <- acup.tnps.depression.avalt.med.recom.med|
  chiro.tnps.depression.avalt.med.recom.med|
  homeo.tnps.depression.avalt.med.recom.med|
  magne.tnps.depression.avalt.med.recom.med|
  osteo.tnps.depression.avalt.med.recom.med|
  rebout.tnps.depression.avalt.med.recom.med
table(tnps.depression.avalt.med.recom.med,useNA = "always")

#### Acupuncteur NPS ayant recommandé pour une grippe ou un syndrome grippal
# Acupuncteur NPS vu avant ou isolément d'un médecin
acup.tnps.grippe.avalt.med <- acup.tnps.grippe.alt == TRUE |
  (acup.tnps.grippe == TRUE & 
      (is.na(qtnps$acup.rec.comp.med1)== FALSE & 
          qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur"))
table(acup.tnps.grippe.avalt.med,useNA = "always")
# Taux de recommandation
acup.tnps.grippe.avalt.med.recom.med <- acup.tnps.grippe.avalt.med == TRUE &
  ((is.na(qtnps$acup.recom.med1)==FALSE & qtnps$acup.recom.med1 == "Oui") |
  (is.na(qtnps$acup.recom.med2)==FALSE & qtnps$acup.recom.med2 == "Oui"))
table(acup.tnps.grippe.avalt.med.recom.med,useNA = "always")

#### Chiropracteur NPS ayant recommandé pour une grippe ou un syndrome grippal
# Chiropracteur NPS vu avant ou isolément d'un médecin
chiro.tnps.grippe.avalt.med <- chiro.tnps.grippe.alt == TRUE |
  (chiro.tnps.grippe == TRUE & 
      (is.na(qtnps$chiro.rec.comp.med1)== FALSE & 
          qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur"))
table(chiro.tnps.grippe.avalt.med,useNA = "always")
# Taux de recommandation
chiro.tnps.grippe.avalt.med.recom.med <- chiro.tnps.grippe.avalt.med == TRUE &
  ((is.na(qtnps$chiro.recom.med1)==FALSE & qtnps$chiro.recom.med1 == "Oui") |
  (is.na(qtnps$chiro.recom.med2)==FALSE & qtnps$chiro.recom.med2 == "Oui"))
table(chiro.tnps.grippe.avalt.med.recom.med,useNA = "always")

#### Homéopathe NPS ayant recommandé pour une grippe ou un syndrome grippal
# Homéopathe NPS vu avant ou isolément d'un médecin
homeo.tnps.grippe.avalt.med <- homeo.tnps.grippe.alt == TRUE |
  (homeo.tnps.grippe == TRUE & 
      (is.na(qtnps$homeo.rec.comp.med1)== FALSE & 
          qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe"))
table(homeo.tnps.grippe.avalt.med,useNA = "always")
# Taux de recommandation
homeo.tnps.grippe.avalt.med.recom.med <- homeo.tnps.grippe.avalt.med == TRUE &
  ((is.na(qtnps$homeo.recom.med1)==FALSE & qtnps$homeo.recom.med1 == "Oui") |
  (is.na(qtnps$homeo.recom.med2)==FALSE & qtnps$homeo.recom.med2 == "Oui"))
table(homeo.tnps.grippe.avalt.med.recom.med,useNA = "always")

#### Magnétiseur NPS ayant recommandé pour une grippe ou un syndrome grippal
# Magnétiseur NPS vu avant ou isolément d'un médecin
magne.tnps.grippe.avalt.med <- magne.tnps.grippe.alt == TRUE |
  (magne.tnps.grippe == TRUE & 
      (is.na(qtnps$magne.rec.comp.med1)== FALSE & 
          qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur"))
table(magne.tnps.grippe.avalt.med,useNA = "always")
# Taux de recommandation
magne.tnps.grippe.avalt.med.recom.med <- magne.tnps.grippe.avalt.med == TRUE &
  ((is.na(qtnps$magne.recom.med1)==FALSE & qtnps$magne.recom.med1 == "Oui") |
  (is.na(qtnps$magne.recom.med2)==FALSE & qtnps$magne.recom.med2 == "Oui"))
table(magne.tnps.grippe.avalt.med.recom.med,useNA = "always")

#### Ostéopathe NPS ayant recommandé pour une grippe ou un syndrome grippal
# Ostéopathe NPS vu avant ou isolément d'un médecin
osteo.tnps.grippe.avalt.med <- osteo.tnps.grippe.alt == TRUE |
  (osteo.tnps.grippe == TRUE & 
      (is.na(qtnps$osteo.rec.comp.med1)== FALSE & 
          qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe"))
table(osteo.tnps.grippe.avalt.med,useNA = "always")
# Taux de recommandation
osteo.tnps.grippe.avalt.med.recom.med <- osteo.tnps.grippe.avalt.med == TRUE &
  ((is.na(qtnps$osteo.recom.med1)==FALSE & qtnps$osteo.recom.med1 == "Oui") |
  (is.na(qtnps$osteo.recom.med2)==FALSE & qtnps$osteo.recom.med2 == "Oui"))
table(osteo.tnps.grippe.avalt.med.recom.med,useNA = "always")

#### Rebouteux NPS ayant recommandé pour une grippe ou un syndrome grippal
# Rebouteux NPS vu avant ou isolément d'un médecin
rebout.tnps.grippe.avalt.med <- rebout.tnps.grippe.alt == TRUE |
  (rebout.tnps.grippe == TRUE & 
      (is.na(qtnps$rebout.rec.comp.med1)== FALSE & 
          qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux"))
table(rebout.tnps.grippe.avalt.med,useNA = "always")
# Taux de recommandation
rebout.tnps.grippe.avalt.med.recom.med <- rebout.tnps.grippe.avalt.med == TRUE &
  ((is.na(qtnps$rebout.recom.med1)==FALSE & qtnps$rebout.recom.med1 == "Oui") |
  (is.na(qtnps$rebout.recom.med2)==FALSE & qtnps$rebout.recom.med2 == "Oui"))
table(rebout.tnps.grippe.avalt.med.recom.med,useNA = "always")

## TA-NPS ayant recommandé pour une grippe ou un syndrome grippal
# TA-NPS vu avant ou isolément d'un médecin
tnps.grippe.avalt.med <- acup.tnps.grippe.avalt.med|chiro.tnps.grippe.avalt.med|
  homeo.tnps.grippe.avalt.med|magne.tnps.grippe.avalt.med|osteo.tnps.grippe.avalt.med|
  rebout.tnps.grippe.avalt.med
table(tnps.grippe.avalt.med,useNA = "always")
# Taux de recommandation
tnps.grippe.avalt.med.recom.med <- acup.tnps.grippe.avalt.med.recom.med|
  chiro.tnps.grippe.avalt.med.recom.med|
  homeo.tnps.grippe.avalt.med.recom.med|
  magne.tnps.grippe.avalt.med.recom.med|
  osteo.tnps.grippe.avalt.med.recom.med|
  rebout.tnps.grippe.avalt.med.recom.med
table(tnps.grippe.avalt.med.recom.med,useNA = "always")

#### Acupuncteur NPS ayant recommandé pour un mal de gorge
# Acupuncteur NPS vu avant ou isolément d'un médecin
acup.tnps.gorge.avalt.med <- acup.tnps.gorge.alt == TRUE |
  (acup.tnps.gorge == TRUE & 
      (is.na(qtnps$acup.rec.comp.med1)== FALSE & 
          qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur"))
table(acup.tnps.gorge.avalt.med,useNA = "always")
# Taux de recommandation
acup.tnps.gorge.avalt.med.recom.med <- acup.tnps.gorge.avalt.med == TRUE &
  ((is.na(qtnps$acup.recom.med1)==FALSE & qtnps$acup.recom.med1 == "Oui") |
  (is.na(qtnps$acup.recom.med2)==FALSE & qtnps$acup.recom.med2 == "Oui"))
table(acup.tnps.gorge.avalt.med.recom.med,useNA = "always")

#### Chiropracteur NPS ayant recommandé pour un mal de gorge
# Chiropracteur NPS vu avant ou isolément d'un médecin
chiro.tnps.gorge.avalt.med <- chiro.tnps.gorge.alt == TRUE |
  (chiro.tnps.gorge == TRUE & 
      (is.na(qtnps$chiro.rec.comp.med1)== FALSE & 
          qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur"))
table(chiro.tnps.gorge.avalt.med,useNA = "always")
# Taux de recommandation
chiro.tnps.gorge.avalt.med.recom.med <- chiro.tnps.gorge.avalt.med == TRUE &
  ((is.na(qtnps$chiro.recom.med1)==FALSE & qtnps$chiro.recom.med1 == "Oui") |
  (is.na(qtnps$chiro.recom.med2)==FALSE & qtnps$chiro.recom.med2 == "Oui"))
table(chiro.tnps.gorge.avalt.med.recom.med,useNA = "always")

#### Homéopathe NPS ayant recommandé pour un mal de gorge
# Homéopathe NPS vu avant ou isolément d'un médecin
homeo.tnps.gorge.avalt.med <- homeo.tnps.gorge.alt == TRUE |
  (homeo.tnps.gorge == TRUE & 
      (is.na(qtnps$homeo.rec.comp.med1)== FALSE & 
          qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe"))
table(homeo.tnps.gorge.avalt.med,useNA = "always")
# Taux de recommandation
homeo.tnps.gorge.avalt.med.recom.med <- homeo.tnps.gorge.avalt.med == TRUE &
  ((is.na(qtnps$homeo.recom.med1)==FALSE & qtnps$homeo.recom.med1 == "Oui") |
  (is.na(qtnps$homeo.recom.med2)==FALSE & qtnps$homeo.recom.med2 == "Oui"))
table(homeo.tnps.gorge.avalt.med.recom.med,useNA = "always")

#### Magnétiseur NPS ayant recommandé pour un mal de gorge
# Magnétiseur NPS vu avant ou isolément d'un médecin
magne.tnps.gorge.avalt.med <- magne.tnps.gorge.alt == TRUE |
  (magne.tnps.gorge == TRUE & 
      (is.na(qtnps$magne.rec.comp.med1)== FALSE & 
          qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur"))
table(magne.tnps.gorge.avalt.med,useNA = "always")
# Taux de recommandation
magne.tnps.gorge.avalt.med.recom.med <- magne.tnps.gorge.avalt.med == TRUE &
  ((is.na(qtnps$magne.recom.med1)==FALSE & qtnps$magne.recom.med1 == "Oui") |
  (is.na(qtnps$magne.recom.med2)==FALSE & qtnps$magne.recom.med2 == "Oui"))
table(magne.tnps.gorge.avalt.med.recom.med,useNA = "always")

#### Ostéopathe NPS ayant recommandé pour un mal de gorge
# Ostéopathe NPS vu avant ou isolément d'un médecin
osteo.tnps.gorge.avalt.med <- osteo.tnps.gorge.alt == TRUE |
  (osteo.tnps.gorge == TRUE & 
      (is.na(qtnps$osteo.rec.comp.med1)== FALSE & 
          qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe"))
table(osteo.tnps.gorge.avalt.med,useNA = "always")
# Taux de recommandation
osteo.tnps.gorge.avalt.med.recom.med <- osteo.tnps.gorge.avalt.med == TRUE &
  ((is.na(qtnps$osteo.recom.med1)==FALSE & qtnps$osteo.recom.med1 == "Oui") |
  (is.na(qtnps$osteo.recom.med2)==FALSE & qtnps$osteo.recom.med2 == "Oui"))
table(osteo.tnps.gorge.avalt.med.recom.med,useNA = "always")

#### Rebouteux NPS ayant recommandé pour un mal de gorge
# Rebouteux NPS vu avant ou isolément d'un médecin
rebout.tnps.gorge.avalt.med <- rebout.tnps.gorge.alt == TRUE |
  (rebout.tnps.gorge == TRUE & 
      (is.na(qtnps$rebout.rec.comp.med1)== FALSE & 
          qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux"))
table(rebout.tnps.gorge.avalt.med,useNA = "always")
# Taux de recommandation
rebout.tnps.gorge.avalt.med.recom.med <- rebout.tnps.gorge.avalt.med == TRUE &
  ((is.na(qtnps$rebout.recom.med1)==FALSE & qtnps$rebout.recom.med1 == "Oui") |
  (is.na(qtnps$rebout.recom.med2)==FALSE & qtnps$rebout.recom.med2 == "Oui"))
table(rebout.tnps.gorge.avalt.med.recom.med,useNA = "always")

## TA-NPS ayant recommandé pour un mal de gorge
# TA-NPS vu avant ou isolément d'un médecin
tnps.gorge.avalt.med <- acup.tnps.gorge.avalt.med|chiro.tnps.gorge.avalt.med|
  homeo.tnps.gorge.avalt.med|magne.tnps.gorge.avalt.med|osteo.tnps.gorge.avalt.med|
  rebout.tnps.gorge.avalt.med
table(tnps.gorge.avalt.med,useNA = "always")
# Taux de recommandation
tnps.gorge.avalt.med.recom.med <- acup.tnps.gorge.avalt.med.recom.med|
  chiro.tnps.gorge.avalt.med.recom.med|
  homeo.tnps.gorge.avalt.med.recom.med|
  magne.tnps.gorge.avalt.med.recom.med|
  osteo.tnps.gorge.avalt.med.recom.med|
  rebout.tnps.gorge.avalt.med.recom.med
table(tnps.gorge.avalt.med.recom.med,useNA = "always")

#### Acupuncteur NPS ayant recommandé pour des maux de tête ou migraines
# Acupuncteur NPS vu avant ou isolément d'un médecin
acup.tnps.migraine.avalt.med <- acup.tnps.migraine.alt == TRUE |
  (acup.tnps.migraine == TRUE & 
      (is.na(qtnps$acup.rec.comp.med1)== FALSE & 
          qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur"))
table(acup.tnps.migraine.avalt.med,useNA = "always")
# Taux de recommandation
acup.tnps.migraine.avalt.med.recom.med <- acup.tnps.migraine.avalt.med == TRUE &
  ((is.na(qtnps$acup.recom.med1)==FALSE & qtnps$acup.recom.med1 == "Oui") |
  (is.na(qtnps$acup.recom.med2)==FALSE & qtnps$acup.recom.med2 == "Oui"))
table(acup.tnps.migraine.avalt.med.recom.med,useNA = "always")

#### Chiropracteur NPS ayant recommandé pour des maux de tête ou migraines
# Chiropracteur NPS vu avant ou isolément d'un médecin
chiro.tnps.migraine.avalt.med <- chiro.tnps.migraine.alt == TRUE |
  (chiro.tnps.migraine == TRUE & 
      (is.na(qtnps$chiro.rec.comp.med1)== FALSE & 
          qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur"))
table(chiro.tnps.migraine.avalt.med,useNA = "always")
# Taux de recommandation
chiro.tnps.migraine.avalt.med.recom.med <- chiro.tnps.migraine.avalt.med == TRUE &
  ((is.na(qtnps$chiro.recom.med1)==FALSE & qtnps$chiro.recom.med1 == "Oui") |
  (is.na(qtnps$chiro.recom.med2)==FALSE & qtnps$chiro.recom.med2 == "Oui"))
table(chiro.tnps.migraine.avalt.med.recom.med,useNA = "always")

#### Homéopathe NPS ayant recommandé pour des maux de tête ou migraines
# Homéopathe NPS vu avant ou isolément d'un médecin
homeo.tnps.migraine.avalt.med <- homeo.tnps.migraine.alt == TRUE |
  (homeo.tnps.migraine == TRUE & 
      (is.na(qtnps$homeo.rec.comp.med1)== FALSE & 
          qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe"))
table(homeo.tnps.migraine.avalt.med,useNA = "always")
# Taux de recommandation
homeo.tnps.migraine.avalt.med.recom.med <- homeo.tnps.migraine.avalt.med == TRUE &
  ((is.na(qtnps$homeo.recom.med1)==FALSE & qtnps$homeo.recom.med1 == "Oui") |
  (is.na(qtnps$homeo.recom.med2)==FALSE & qtnps$homeo.recom.med2 == "Oui"))
table(homeo.tnps.migraine.avalt.med.recom.med,useNA = "always")

#### Magnétiseur NPS ayant recommandé pour des maux de tête ou migraines
# Magnétiseur NPS vu avant ou isolément d'un médecin
magne.tnps.migraine.avalt.med <- magne.tnps.migraine.alt == TRUE |
  (magne.tnps.migraine == TRUE & 
      (is.na(qtnps$magne.rec.comp.med1)== FALSE & 
          qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur"))
table(magne.tnps.migraine.avalt.med,useNA = "always")
# Taux de recommandation
magne.tnps.migraine.avalt.med.recom.med <- magne.tnps.migraine.avalt.med == TRUE &
  ((is.na(qtnps$magne.recom.med1)==FALSE & qtnps$magne.recom.med1 == "Oui") |
  (is.na(qtnps$magne.recom.med2)==FALSE & qtnps$magne.recom.med2 == "Oui"))
table(magne.tnps.migraine.avalt.med.recom.med,useNA = "always")

#### Ostéopathe NPS ayant recommandé pour des maux de tête ou migraines
# Ostéopathe NPS vu avant ou isolément d'un médecin
osteo.tnps.migraine.avalt.med <- osteo.tnps.migraine.alt == TRUE |
  (osteo.tnps.migraine == TRUE & 
      (is.na(qtnps$osteo.rec.comp.med1)== FALSE & 
          qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe"))
table(osteo.tnps.migraine.avalt.med,useNA = "always")
# Taux de recommandation
osteo.tnps.migraine.avalt.med.recom.med <- osteo.tnps.migraine.avalt.med == TRUE &
  ((is.na(qtnps$osteo.recom.med1)==FALSE & qtnps$osteo.recom.med1 == "Oui") |
  (is.na(qtnps$osteo.recom.med2)==FALSE & qtnps$osteo.recom.med2 == "Oui"))
table(osteo.tnps.migraine.avalt.med.recom.med,useNA = "always")

#### Rebouteux NPS ayant recommandé pour des maux de tête ou migraines
# Rebouteux NPS vu avant ou isolément d'un médecin
rebout.tnps.migraine.avalt.med <- rebout.tnps.migraine.alt == TRUE |
  (rebout.tnps.migraine == TRUE & 
      (is.na(qtnps$rebout.rec.comp.med1)== FALSE & 
          qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux"))
table(rebout.tnps.migraine.avalt.med,useNA = "always")
# Taux de recommandation
rebout.tnps.migraine.avalt.med.recom.med <- rebout.tnps.migraine.avalt.med == TRUE &
  ((is.na(qtnps$rebout.recom.med1)==FALSE & qtnps$rebout.recom.med1 == "Oui") |
  (is.na(qtnps$rebout.recom.med2)==FALSE & qtnps$rebout.recom.med2 == "Oui"))
table(rebout.tnps.migraine.avalt.med.recom.med,useNA = "always")

## TA-NPS ayant recommandé pour des maux de tête ou migraines
# TA-NPS vu avant ou isolément d'un médecin
tnps.migraine.avalt.med <- acup.tnps.migraine.avalt.med|chiro.tnps.migraine.avalt.med|
  homeo.tnps.migraine.avalt.med|magne.tnps.migraine.avalt.med|
  osteo.tnps.migraine.avalt.med|
  rebout.tnps.migraine.avalt.med
table(tnps.migraine.avalt.med,useNA = "always")
# Taux de recommandation
tnps.migraine.avalt.med.recom.med <- acup.tnps.migraine.avalt.med.recom.med|
  chiro.tnps.migraine.avalt.med.recom.med|
  homeo.tnps.migraine.avalt.med.recom.med|
  magne.tnps.migraine.avalt.med.recom.med|
  osteo.tnps.migraine.avalt.med.recom.med|
  rebout.tnps.migraine.avalt.med.recom.med
table(tnps.migraine.avalt.med.recom.med,useNA = "always") 

#### Acupuncteur NPS ayant recommandé pour une douleur au cou
# Acupuncteur NPS vu avant ou isolément d'un médecin
acup.tnps.cou.avalt.med <- acup.tnps.cou.alt == TRUE |
  (acup.tnps.cou == TRUE & 
      (is.na(qtnps$acup.rec.comp.med1)== FALSE & 
          qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur"))
table(acup.tnps.cou.avalt.med,useNA = "always")
# Taux de recommandation
acup.tnps.cou.avalt.med.recom.med <- acup.tnps.cou.avalt.med == TRUE &
  ((is.na(qtnps$acup.recom.med1)==FALSE & qtnps$acup.recom.med1 == "Oui") |
  (is.na(qtnps$acup.recom.med2)==FALSE & qtnps$acup.recom.med2 == "Oui"))
table(acup.tnps.cou.avalt.med.recom.med,useNA = "always")

#### Chiropracteur NPS ayant recommandé pour une douleur au cou
# Chiropracteur NPS vu avant ou isolément d'un médecin
chiro.tnps.cou.avalt.med <- chiro.tnps.cou.alt == TRUE |
  (chiro.tnps.cou == TRUE & 
      (is.na(qtnps$chiro.rec.comp.med1)== FALSE & 
          qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur"))
table(chiro.tnps.cou.avalt.med,useNA = "always")
# Taux de recommandation
chiro.tnps.cou.avalt.med.recom.med <- chiro.tnps.cou.avalt.med == TRUE &
  ((is.na(qtnps$chiro.recom.med1)==FALSE & qtnps$chiro.recom.med1 == "Oui") |
  (is.na(qtnps$chiro.recom.med2)==FALSE & qtnps$chiro.recom.med2 == "Oui"))
table(chiro.tnps.cou.avalt.med.recom.med,useNA = "always")

#### Homéopathe NPS ayant recommandé pour une douleur au cou
# Homéopathe NPS vu avant ou isolément d'un médecin
homeo.tnps.cou.avalt.med <- homeo.tnps.cou.alt == TRUE |
  (homeo.tnps.cou == TRUE & 
      (is.na(qtnps$homeo.rec.comp.med1)== FALSE & 
          qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe"))
table(homeo.tnps.cou.avalt.med,useNA = "always")
# Taux de recommandation
homeo.tnps.cou.avalt.med.recom.med <- homeo.tnps.cou.avalt.med == TRUE &
  ((is.na(qtnps$homeo.recom.med1)==FALSE & qtnps$homeo.recom.med1 == "Oui") |
  (is.na(qtnps$homeo.recom.med2)==FALSE & qtnps$homeo.recom.med2 == "Oui"))
table(homeo.tnps.cou.avalt.med.recom.med,useNA = "always")

#### Magnétiseur NPS ayant recommandé pour une douleur au cou
# Magnétiseur NPS vu avant ou isolément d'un médecin
magne.tnps.cou.avalt.med <- magne.tnps.cou.alt == TRUE |
  (magne.tnps.cou == TRUE & 
      (is.na(qtnps$magne.rec.comp.med1)== FALSE & 
          qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur"))
table(magne.tnps.cou.avalt.med,useNA = "always")
# Taux de recommandation
magne.tnps.cou.avalt.med.recom.med <- magne.tnps.cou.avalt.med == TRUE &
  ((is.na(qtnps$magne.recom.med1)==FALSE & qtnps$magne.recom.med1 == "Oui") |
  (is.na(qtnps$magne.recom.med2)==FALSE & qtnps$magne.recom.med2 == "Oui"))
table(magne.tnps.cou.avalt.med.recom.med,useNA = "always")

#### Ostéopathe NPS ayant recommandé pour une douleur au cou
# Ostéopathe NPS vu avant ou isolément d'un médecin
osteo.tnps.cou.avalt.med <- osteo.tnps.cou.alt == TRUE |
  (osteo.tnps.cou == TRUE & 
      (is.na(qtnps$osteo.rec.comp.med1)== FALSE & 
          qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe"))
table(osteo.tnps.cou.avalt.med,useNA = "always")
# Taux de recommandation
osteo.tnps.cou.avalt.med.recom.med <- osteo.tnps.cou.avalt.med == TRUE &
  ((is.na(qtnps$osteo.recom.med1)==FALSE & qtnps$osteo.recom.med1 == "Oui") |
  (is.na(qtnps$osteo.recom.med2)==FALSE & qtnps$osteo.recom.med2 == "Oui"))
table(osteo.tnps.cou.avalt.med.recom.med,useNA = "always")

#### Rebouteux NPS ayant recommandé pour une douleur au cou
# Rebouteux NPS vu avant ou isolément d'un médecin
rebout.tnps.cou.avalt.med <- rebout.tnps.cou.alt == TRUE |
  (rebout.tnps.cou == TRUE & 
      (is.na(qtnps$rebout.rec.comp.med1)== FALSE & 
          qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux"))
table(rebout.tnps.cou.avalt.med,useNA = "always")
# Taux de recommandation
rebout.tnps.cou.avalt.med.recom.med <- rebout.tnps.cou.avalt.med == TRUE &
  ((is.na(qtnps$rebout.recom.med1)==FALSE & qtnps$rebout.recom.med1 == "Oui") |
  (is.na(qtnps$rebout.recom.med2)==FALSE & qtnps$rebout.recom.med2 == "Oui"))
table(rebout.tnps.cou.avalt.med.recom.med,useNA = "always")

## TA-NPS ayant recommandé pour une douleur au cou
# TA-NPS vu avant ou isolément d'un médecin
tnps.cou.avalt.med <- acup.tnps.cou.avalt.med|chiro.tnps.cou.avalt.med|
  homeo.tnps.cou.avalt.med|magne.tnps.cou.avalt.med|osteo.tnps.cou.avalt.med|
  rebout.tnps.cou.avalt.med
table(tnps.cou.avalt.med,useNA = "always")
# Taux de recommandation
tnps.cou.avalt.med.recom.med <- acup.tnps.cou.avalt.med.recom.med|
  chiro.tnps.cou.avalt.med.recom.med|
  homeo.tnps.cou.avalt.med.recom.med|
  magne.tnps.cou.avalt.med.recom.med|
  osteo.tnps.cou.avalt.med.recom.med|
  rebout.tnps.cou.avalt.med.recom.med
table(tnps.cou.avalt.med.recom.med,useNA = "always")

#### Acupuncteur NPS ayant recommandé pour une douleur de membre supérieur
# Acupuncteur NPS vu avant ou isolément d'un médecin
acup.tnps.msup.avalt.med <- acup.tnps.msup.alt == TRUE |
  (acup.tnps.msup == TRUE & 
      (is.na(qtnps$acup.rec.comp.med1)== FALSE & 
          qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur"))
table(acup.tnps.msup.avalt.med,useNA = "always")
# Taux de recommandation
acup.tnps.msup.avalt.med.recom.med <- acup.tnps.msup.avalt.med == TRUE &
  ((is.na(qtnps$acup.recom.med1)==FALSE & qtnps$acup.recom.med1 == "Oui") |
  (is.na(qtnps$acup.recom.med2)==FALSE & qtnps$acup.recom.med2 == "Oui"))
table(acup.tnps.msup.avalt.med.recom.med,useNA = "always")

#### Chiropracteur NPS ayant recommandé pour une douleur de membre supérieur
# Chiropracteur NPS vu avant ou isolément d'un médecin
chiro.tnps.msup.avalt.med <- chiro.tnps.msup.alt == TRUE |
  (chiro.tnps.msup == TRUE & 
      (is.na(qtnps$chiro.rec.comp.med1)== FALSE & 
          qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur"))
table(chiro.tnps.msup.avalt.med,useNA = "always")
# Taux de recommandation
chiro.tnps.msup.avalt.med.recom.med <- chiro.tnps.msup.avalt.med == TRUE &
  ((is.na(qtnps$chiro.recom.med1)==FALSE & qtnps$chiro.recom.med1 == "Oui") |
  (is.na(qtnps$chiro.recom.med2)==FALSE & qtnps$chiro.recom.med2 == "Oui"))
table(chiro.tnps.msup.avalt.med.recom.med,useNA = "always")

#### Homéopathe NPS ayant recommandé pour une douleur de membre supérieur
# Homéopathe NPS vu avant ou isolément d'un médecin
homeo.tnps.msup.avalt.med <- homeo.tnps.msup.alt == TRUE |
  (homeo.tnps.msup == TRUE & 
      (is.na(qtnps$homeo.rec.comp.med1)== FALSE & 
          qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe"))
table(homeo.tnps.msup.avalt.med,useNA = "always")
# Taux de recommandation
homeo.tnps.msup.avalt.med.recom.med <- homeo.tnps.msup.avalt.med == TRUE &
  ((is.na(qtnps$homeo.recom.med1)==FALSE & qtnps$homeo.recom.med1 == "Oui") |
  (is.na(qtnps$homeo.recom.med2)==FALSE & qtnps$homeo.recom.med2 == "Oui"))
table(homeo.tnps.msup.avalt.med.recom.med,useNA = "always")

#### Magnétiseur NPS ayant recommandé pour une douleur de membre supérieur
# Magnétiseur NPS vu avant ou isolément d'un médecin
magne.tnps.msup.avalt.med <- magne.tnps.msup.alt == TRUE |
  (magne.tnps.msup == TRUE & 
      (is.na(qtnps$magne.rec.comp.med1)== FALSE & 
          qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur"))
table(magne.tnps.msup.avalt.med,useNA = "always")
# Taux de recommandation
magne.tnps.msup.avalt.med.recom.med <- magne.tnps.msup.avalt.med == TRUE &
  ((is.na(qtnps$magne.recom.med1)==FALSE & qtnps$magne.recom.med1 == "Oui") |
  (is.na(qtnps$magne.recom.med2)==FALSE & qtnps$magne.recom.med2 == "Oui"))
table(magne.tnps.msup.avalt.med.recom.med,useNA = "always")

#### Ostéopathe NPS ayant recommandé pour une douleur de membre supérieur
# Ostéopathe NPS vu avant ou isolément d'un médecin
osteo.tnps.msup.avalt.med <- osteo.tnps.msup.alt == TRUE |
  (osteo.tnps.msup == TRUE & 
      (is.na(qtnps$osteo.rec.comp.med1)== FALSE & 
          qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe"))
table(osteo.tnps.msup.avalt.med,useNA = "always")
# Taux de recommandation
osteo.tnps.msup.avalt.med.recom.med <- osteo.tnps.msup.avalt.med == TRUE &
  ((is.na(qtnps$osteo.recom.med1)==FALSE & qtnps$osteo.recom.med1 == "Oui") |
  (is.na(qtnps$osteo.recom.med2)==FALSE & qtnps$osteo.recom.med2 == "Oui"))
table(osteo.tnps.msup.avalt.med.recom.med,useNA = "always")

#### Rebouteux NPS ayant recommandé pour une douleur de membre supérieur
# Rebouteux NPS vu avant ou isolément d'un médecin
rebout.tnps.msup.avalt.med <- rebout.tnps.msup.alt == TRUE |
  (rebout.tnps.msup == TRUE & 
      (is.na(qtnps$rebout.rec.comp.med1)== FALSE & 
          qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux"))
table(rebout.tnps.msup.avalt.med,useNA = "always")
# Taux de recommandation
rebout.tnps.msup.avalt.med.recom.med <- rebout.tnps.msup.avalt.med == TRUE &
  ((is.na(qtnps$rebout.recom.med1)==FALSE & qtnps$rebout.recom.med1 == "Oui") |
  (is.na(qtnps$rebout.recom.med2)==FALSE & qtnps$rebout.recom.med2 == "Oui"))
table(rebout.tnps.msup.avalt.med.recom.med,useNA = "always")

## TA-NPS ayant recommandé pour une douleur de membre supérieur
# TA-NPS vu avant ou isolément d'un médecin
tnps.msup.avalt.med <- acup.tnps.msup.avalt.med|chiro.tnps.msup.avalt.med|
  homeo.tnps.msup.avalt.med|magne.tnps.msup.avalt.med|osteo.tnps.msup.avalt.med|
  rebout.tnps.msup.avalt.med
table(tnps.msup.avalt.med,useNA = "always")
# Taux de recommandation
tnps.msup.avalt.med.recom.med <- acup.tnps.msup.avalt.med.recom.med|
  chiro.tnps.msup.avalt.med.recom.med|
  homeo.tnps.msup.avalt.med.recom.med|
  magne.tnps.msup.avalt.med.recom.med|
  osteo.tnps.msup.avalt.med.recom.med|
  rebout.tnps.msup.avalt.med.recom.med
table(tnps.msup.avalt.med.recom.med,useNA = "always")

#### Acupuncteur NPS ayant recommandé pour du stress ou de l'anxiété
# Acupuncteur NPS vu avant ou isolément d'un médecin
acup.tnps.stress.avalt.med <- acup.tnps.stress.alt == TRUE |
  (acup.tnps.stress == TRUE & 
      (is.na(qtnps$acup.rec.comp.med1)== FALSE & 
          qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur"))
table(acup.tnps.stress.avalt.med,useNA = "always")
# Taux de recommandation
acup.tnps.stress.avalt.med.recom.med <- acup.tnps.stress.avalt.med == TRUE &
  ((is.na(qtnps$acup.recom.med1)==FALSE & qtnps$acup.recom.med1 == "Oui") |
  (is.na(qtnps$acup.recom.med2)==FALSE & qtnps$acup.recom.med2 == "Oui"))
table(acup.tnps.stress.avalt.med.recom.med,useNA = "always")

#### Chiropracteur NPS ayant recommandé pour du stress ou de l'anxiété
# Chiropracteur NPS vu avant ou isolément d'un médecin
chiro.tnps.stress.avalt.med <- chiro.tnps.stress.alt == TRUE |
  (chiro.tnps.stress == TRUE & 
      (is.na(qtnps$chiro.rec.comp.med1)== FALSE & 
          qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur"))
table(chiro.tnps.stress.avalt.med,useNA = "always")
# Taux de recommandation
chiro.tnps.stress.avalt.med.recom.med <- chiro.tnps.stress.avalt.med == TRUE &
  ((is.na(qtnps$chiro.recom.med1)==FALSE & qtnps$chiro.recom.med1 == "Oui") |
  (is.na(qtnps$chiro.recom.med2)==FALSE & qtnps$chiro.recom.med2 == "Oui"))
table(chiro.tnps.stress.avalt.med.recom.med,useNA = "always")

#### Homéopathe NPS ayant recommandé pour du stress ou de l'anxiété
# Homéopathe NPS vu avant ou isolément d'un médecin
homeo.tnps.stress.avalt.med <- homeo.tnps.stress.alt == TRUE |
  (homeo.tnps.stress == TRUE & 
      (is.na(qtnps$homeo.rec.comp.med1)== FALSE & 
          qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe"))
table(homeo.tnps.stress.avalt.med,useNA = "always")
# Taux de recommandation
homeo.tnps.stress.avalt.med.recom.med <- homeo.tnps.stress.avalt.med == TRUE &
  ((is.na(qtnps$homeo.recom.med1)==FALSE & qtnps$homeo.recom.med1 == "Oui") |
  (is.na(qtnps$homeo.recom.med2)==FALSE & qtnps$homeo.recom.med2 == "Oui"))
table(homeo.tnps.stress.avalt.med.recom.med,useNA = "always")

#### Magnétiseur NPS ayant recommandé pour du stress ou de l'anxiété
# Magnétiseur NPS vu avant ou isolément d'un médecin
magne.tnps.stress.avalt.med <- magne.tnps.stress.alt == TRUE |
  (magne.tnps.stress == TRUE & 
      (is.na(qtnps$magne.rec.comp.med1)== FALSE & 
          qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur"))
table(magne.tnps.stress.avalt.med,useNA = "always")
# Taux de recommandation
magne.tnps.stress.avalt.med.recom.med <- magne.tnps.stress.avalt.med == TRUE &
  ((is.na(qtnps$magne.recom.med1)==FALSE & qtnps$magne.recom.med1 == "Oui") |
  (is.na(qtnps$magne.recom.med2)==FALSE & qtnps$magne.recom.med2 == "Oui"))
table(magne.tnps.stress.avalt.med.recom.med,useNA = "always")

#### Ostéopathe NPS ayant recommandé pour du stress ou de l'anxiété
# Ostéopathe NPS vu avant ou isolément d'un médecin
osteo.tnps.stress.avalt.med <- osteo.tnps.stress.alt == TRUE |
  (osteo.tnps.stress == TRUE & 
      (is.na(qtnps$osteo.rec.comp.med1)== FALSE & 
          qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe"))
table(osteo.tnps.stress.avalt.med,useNA = "always")
# Taux de recommandation
osteo.tnps.stress.avalt.med.recom.med <- osteo.tnps.stress.avalt.med == TRUE &
  ((is.na(qtnps$osteo.recom.med1)==FALSE & qtnps$osteo.recom.med1 == "Oui") |
  (is.na(qtnps$osteo.recom.med2)==FALSE & qtnps$osteo.recom.med2 == "Oui"))
table(osteo.tnps.stress.avalt.med.recom.med,useNA = "always")

#### Rebouteux NPS ayant recommandé pour du stress ou de l'anxiété
# Rebouteux NPS vu avant ou isolément d'un médecin
rebout.tnps.stress.avalt.med <- rebout.tnps.stress.alt == TRUE |
  (rebout.tnps.stress == TRUE & 
      (is.na(qtnps$rebout.rec.comp.med1)== FALSE & 
          qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux"))
table(rebout.tnps.stress.avalt.med,useNA = "always")
# Taux de recommandation
rebout.tnps.stress.avalt.med.recom.med <- rebout.tnps.stress.avalt.med == TRUE &
  ((is.na(qtnps$rebout.recom.med1)==FALSE & qtnps$rebout.recom.med1 == "Oui") |
  (is.na(qtnps$rebout.recom.med2)==FALSE & qtnps$rebout.recom.med2 == "Oui"))
table(rebout.tnps.stress.avalt.med.recom.med,useNA = "always")

## TA-NPS ayant recommandé pour du stress ou de l'anxiété
# TA-NPS vu avant ou isolément d'un médecin
tnps.stress.avalt.med <- acup.tnps.stress.avalt.med|chiro.tnps.stress.avalt.med|
  homeo.tnps.stress.avalt.med|magne.tnps.stress.avalt.med|osteo.tnps.stress.avalt.med|
  rebout.tnps.stress.avalt.med
table(tnps.stress.avalt.med,useNA = "always")
# Taux de recommandation
tnps.stress.avalt.med.recom.med <- acup.tnps.stress.avalt.med.recom.med|
  chiro.tnps.stress.avalt.med.recom.med|
  homeo.tnps.stress.avalt.med.recom.med|
  magne.tnps.stress.avalt.med.recom.med|
  osteo.tnps.stress.avalt.med.recom.med|
  rebout.tnps.stress.avalt.med.recom.med
table(tnps.stress.avalt.med.recom.med,useNA = "always")

#### Acupuncteur NPS ayant recommandé pour une douleur de membre inférieur
# Acupuncteur NPS vu avant ou isolément d'un médecin
acup.tnps.minf.avalt.med <- acup.tnps.minf.alt == TRUE |
  (acup.tnps.minf == TRUE & 
      (is.na(qtnps$acup.rec.comp.med1)== FALSE & 
          qtnps$acup.rec.comp.med1 == "Après avoir consulté l'acupuncteur"))
table(acup.tnps.minf.avalt.med,useNA = "always")
# Taux de recommandation
acup.tnps.minf.avalt.med.recom.med <- acup.tnps.minf.avalt.med == TRUE &
  ((is.na(qtnps$acup.recom.med1)==FALSE & qtnps$acup.recom.med1 == "Oui") |
  (is.na(qtnps$acup.recom.med2)==FALSE & qtnps$acup.recom.med2 == "Oui"))
table(acup.tnps.minf.avalt.med.recom.med,useNA = "always")

#### Chiropracteur NPS ayant recommandé pour une douleur de membre inférieur
# Chiropracteur NPS vu avant ou isolément d'un médecin
chiro.tnps.minf.avalt.med <- chiro.tnps.minf.alt == TRUE |
  (chiro.tnps.minf == TRUE & 
      (is.na(qtnps$chiro.rec.comp.med1)== FALSE & 
          qtnps$chiro.rec.comp.med1 == "Après avoir consulté le chiropracteur"))
table(chiro.tnps.minf.avalt.med,useNA = "always")
# Taux de recommandation
chiro.tnps.minf.avalt.med.recom.med <- chiro.tnps.minf.avalt.med == TRUE &
  ((is.na(qtnps$chiro.recom.med1)==FALSE & qtnps$chiro.recom.med1 == "Oui") |
  (is.na(qtnps$chiro.recom.med2)==FALSE & qtnps$chiro.recom.med2 == "Oui"))
table(chiro.tnps.minf.avalt.med.recom.med,useNA = "always")

#### Homéopathe NPS ayant recommandé pour une douleur de membre inférieur
# Homéopathe NPS vu avant ou isolément d'un médecin
homeo.tnps.minf.avalt.med <- homeo.tnps.minf.alt == TRUE |
  (homeo.tnps.minf == TRUE & 
      (is.na(qtnps$homeo.rec.comp.med1)== FALSE & 
          qtnps$homeo.rec.comp.med1 == "Après avoir consulté l'homéopathe"))
table(homeo.tnps.minf.avalt.med,useNA = "always")
# Taux de recommandation
homeo.tnps.minf.avalt.med.recom.med <- homeo.tnps.minf.avalt.med == TRUE &
  ((is.na(qtnps$homeo.recom.med1)==FALSE & qtnps$homeo.recom.med1 == "Oui") |
  (is.na(qtnps$homeo.recom.med2)==FALSE & qtnps$homeo.recom.med2 == "Oui"))
table(homeo.tnps.minf.avalt.med.recom.med,useNA = "always")

#### Magnétiseur NPS ayant recommandé pour une douleur de membre inférieur
# Magnétiseur NPS vu avant ou isolément d'un médecin
magne.tnps.minf.avalt.med <- magne.tnps.minf.alt == TRUE |
  (magne.tnps.minf == TRUE & 
      (is.na(qtnps$magne.rec.comp.med1)== FALSE & 
          qtnps$magne.rec.comp.med1 == "Après avoir consulté le magnétiseur"))
table(magne.tnps.minf.avalt.med,useNA = "always")
# Taux de recommandation
magne.tnps.minf.avalt.med.recom.med <- magne.tnps.minf.avalt.med == TRUE &
  ((is.na(qtnps$magne.recom.med1)==FALSE & qtnps$magne.recom.med1 == "Oui") |
  (is.na(qtnps$magne.recom.med2)==FALSE & qtnps$magne.recom.med2 == "Oui"))
table(magne.tnps.minf.avalt.med.recom.med,useNA = "always")

#### Ostéopathe NPS ayant recommandé pour une douleur de membre inférieur
# Ostéopathe NPS vu avant ou isolément d'un médecin
osteo.tnps.minf.avalt.med <- osteo.tnps.minf.alt == TRUE |
  (osteo.tnps.minf == TRUE & 
      (is.na(qtnps$osteo.rec.comp.med1)== FALSE & 
          qtnps$osteo.rec.comp.med1 == "Après avoir consulté l'ostéopathe"))
table(osteo.tnps.minf.avalt.med,useNA = "always")
# Taux de recommandation
osteo.tnps.minf.avalt.med.recom.med <- osteo.tnps.minf.avalt.med == TRUE &
  ((is.na(qtnps$osteo.recom.med1)==FALSE & qtnps$osteo.recom.med1 == "Oui") |
  (is.na(qtnps$osteo.recom.med2)==FALSE & qtnps$osteo.recom.med2 == "Oui"))
table(osteo.tnps.minf.avalt.med.recom.med,useNA = "always")

#### Rebouteux NPS ayant recommandé pour une douleur de membre inférieur
# Rebouteux NPS vu avant ou isolément d'un médecin
rebout.tnps.minf.avalt.med <- rebout.tnps.minf.alt == TRUE |
  (rebout.tnps.minf == TRUE & 
      (is.na(qtnps$rebout.rec.comp.med1)== FALSE & 
          qtnps$rebout.rec.comp.med1 == "Après avoir consulté le rebouteux"))
table(rebout.tnps.minf.avalt.med,useNA = "always")
# Taux de recommandation
rebout.tnps.minf.avalt.med.recom.med <- rebout.tnps.minf.avalt.med == TRUE &
  ((is.na(qtnps$rebout.recom.med1)==FALSE & qtnps$rebout.recom.med1 == "Oui") |
  (is.na(qtnps$rebout.recom.med2)==FALSE & qtnps$rebout.recom.med2 == "Oui"))
table(rebout.tnps.minf.avalt.med.recom.med,useNA = "always")

## TA-NPS ayant recommandé pour une douleur de membre inférieur
# TA-NPS vu avant ou isolément d'un médecin
tnps.minf.avalt.med <- acup.tnps.minf.avalt.med|chiro.tnps.minf.avalt.med|
  homeo.tnps.minf.avalt.med|magne.tnps.minf.avalt.med|osteo.tnps.minf.avalt.med|
  rebout.tnps.minf.avalt.med
table(tnps.minf.avalt.med,useNA = "always")
# Taux de recommandation
tnps.minf.avalt.med.recom.med <- acup.tnps.minf.avalt.med.recom.med|
  chiro.tnps.minf.avalt.med.recom.med|
  homeo.tnps.minf.avalt.med.recom.med|
  magne.tnps.minf.avalt.med.recom.med|
  osteo.tnps.minf.avalt.med.recom.med|
  rebout.tnps.minf.avalt.med.recom.med
table(tnps.minf.avalt.med.recom.med,useNA = "always")

## Taux de TA-NPS ayant recommandé de consulter un médecin (Figure X) ----
# TA-NPS vus avant ou isolément d'un médecin
tnps.avalt.med <- tnps.dos.avalt.med|
  tnps.stress.avalt.med|
  tnps.minf.avalt.med|tnps.autre.avalt.med|tnps.bronchite.avalt.med|
  tnps.depression.avalt.med|tnps.gorge.avalt.med|tnps.migraine.avalt.med|
  tnps.msup.avalt.med|tnps.cou.avalt.med|tnps.grippe.avalt.med
table(tnps.avalt.med,useNA = "always")
# FALSE  TRUE  <NA> 
#  8801  1677     0
# Taux de recommandation
tnps.avalt.med.recom.med <- tnps.dos.avalt.med.recom.med|
  tnps.autre.avalt.med.recom.med|
  tnps.bronchite.avalt.med.recom.med|
  tnps.msup.avalt.med.recom.med|
  tnps.minf.avalt.med.recom.med|
  tnps.cou.avalt.med.recom.med|
  tnps.stress.avalt.med.recom.med|
  tnps.migraine.avalt.med.recom.med|
  tnps.gorge.avalt.med.recom.med|
  tnps.grippe.avalt.med.recom.med|
  tnps.depression.avalt.med.recom.med
table(tnps.avalt.med.recom.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10316   162     0
(162/1677)*100
# [1] 9.6601

## Taux d'acupuncteurs NPS ayant recommandé de consuter un médecin (Figure X) ----
# Acupuncteurs NPS vus avant ou isolément d'un médecin
acup.tnps.avalt.med <- acup.tnps.dos.avalt.med|
  acup.tnps.stress.avalt.med|
  acup.tnps.minf.avalt.med|acup.tnps.autre.avalt.med|acup.tnps.bronchite.avalt.med|
  acup.tnps.depression.avalt.med|acup.tnps.gorge.avalt.med|
  acup.tnps.migraine.avalt.med|
  acup.tnps.msup.avalt.med|acup.tnps.cou.avalt.med|acup.tnps.grippe.avalt.med
table(acup.tnps.avalt.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10376   102     0
# Taux de recommandation
acup.tnps.avalt.med.recom.med <- acup.tnps.dos.avalt.med.recom.med|
  acup.tnps.autre.avalt.med.recom.med|
  acup.tnps.bronchite.avalt.med.recom.med|
  acup.tnps.msup.avalt.med.recom.med|
  acup.tnps.minf.avalt.med.recom.med|
  acup.tnps.cou.avalt.med.recom.med|
  acup.tnps.stress.avalt.med.recom.med|
  acup.tnps.migraine.avalt.med.recom.med|
  acup.tnps.gorge.avalt.med.recom.med|
  acup.tnps.grippe.avalt.med.recom.med|
  acup.tnps.depression.avalt.med.recom.med
table(acup.tnps.avalt.med.recom.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10463    15     0
(15/102)*100
# [1] 14.706

## Taux de chiropracteurs NPS ayant recommandé de consuter un médecin (Figure X) ----
# Chiropracteurs NPS vus avant ou isolément d'un médecin (Figure X)
chiro.tnps.avalt.med <- chiro.tnps.dos.avalt.med|
  chiro.tnps.stress.avalt.med|
  chiro.tnps.minf.avalt.med|chiro.tnps.autre.avalt.med|chiro.tnps.bronchite.avalt.med|
  chiro.tnps.depression.avalt.med|chiro.tnps.gorge.avalt.med|
  chiro.tnps.migraine.avalt.med|
  chiro.tnps.msup.avalt.med|chiro.tnps.cou.avalt.med|chiro.tnps.grippe.avalt.med
table(chiro.tnps.avalt.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10409    69     0 
# Taux de recommandation
chiro.tnps.avalt.med.recom.med <- chiro.tnps.dos.avalt.med.recom.med|
  chiro.tnps.autre.avalt.med.recom.med|
  chiro.tnps.bronchite.avalt.med.recom.med|
  chiro.tnps.msup.avalt.med.recom.med|
  chiro.tnps.minf.avalt.med.recom.med|
  chiro.tnps.cou.avalt.med.recom.med|
  chiro.tnps.stress.avalt.med.recom.med|
  chiro.tnps.migraine.avalt.med.recom.med|
  chiro.tnps.gorge.avalt.med.recom.med|
  chiro.tnps.grippe.avalt.med.recom.med|
  chiro.tnps.depression.avalt.med.recom.med
table(chiro.tnps.avalt.med.recom.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10475     3     0
(3/69)*100
# [1] 4.3478

## Taux d'homéopathes NPS ayant recommandé de consuter un médecin (Figure X) ----
# Homéopathe NPS vus avant ou isolément d'un médecin (Figure X)
homeo.tnps.avalt.med <- homeo.tnps.dos.avalt.med|
  homeo.tnps.stress.avalt.med|
  homeo.tnps.minf.avalt.med|homeo.tnps.autre.avalt.med|homeo.tnps.bronchite.avalt.med|
  homeo.tnps.depression.avalt.med|homeo.tnps.gorge.avalt.med|
  homeo.tnps.migraine.avalt.med|
  homeo.tnps.msup.avalt.med|homeo.tnps.cou.avalt.med|homeo.tnps.grippe.avalt.med
table(homeo.tnps.avalt.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10435    43     0
# Taux de recommandation
homeo.tnps.avalt.med.recom.med <- homeo.tnps.dos.avalt.med.recom.med|
  homeo.tnps.autre.avalt.med.recom.med|
  homeo.tnps.bronchite.avalt.med.recom.med|
  homeo.tnps.msup.avalt.med.recom.med|
  homeo.tnps.minf.avalt.med.recom.med|
  homeo.tnps.cou.avalt.med.recom.med|
  homeo.tnps.stress.avalt.med.recom.med|
  homeo.tnps.migraine.avalt.med.recom.med|
  homeo.tnps.gorge.avalt.med.recom.med|
  homeo.tnps.grippe.avalt.med.recom.med|
  homeo.tnps.depression.avalt.med.recom.med
table(homeo.tnps.avalt.med.recom.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10472     6     0
(6/43)*100
# [1] 13.953

## Taux de magnétiseurs NPS ayant recommandé de consuter un médecin (Figure X) ----
# Magnétiseurs NPS vus avant ou isolément d'un médecin (Figure X)
magne.tnps.avalt.med <- magne.tnps.dos.avalt.med|
  magne.tnps.stress.avalt.med|
  magne.tnps.minf.avalt.med|magne.tnps.autre.avalt.med|magne.tnps.bronchite.avalt.med|
  magne.tnps.depression.avalt.med|magne.tnps.gorge.avalt.med|magne.tnps.migraine.avalt.med|
  magne.tnps.msup.avalt.med|magne.tnps.cou.avalt.med|magne.tnps.grippe.avalt.med
table(magne.tnps.avalt.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10349   129     0
# Taux de déclaration
magne.tnps.avalt.med.recom.med <- magne.tnps.dos.avalt.med.recom.med|
  magne.tnps.autre.avalt.med.recom.med|
  magne.tnps.bronchite.avalt.med.recom.med|
  magne.tnps.msup.avalt.med.recom.med|
  magne.tnps.minf.avalt.med.recom.med|
  magne.tnps.cou.avalt.med.recom.med|
  magne.tnps.stress.avalt.med.recom.med|
  magne.tnps.migraine.avalt.med.recom.med|
  magne.tnps.gorge.avalt.med.recom.med|
  magne.tnps.grippe.avalt.med.recom.med|
  magne.tnps.depression.avalt.med.recom.med
table(magne.tnps.avalt.med.recom.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10462    16     0
(16/129)*100
# [1] 12.403

## Taux d'ostéopathes NPS ayant recommandé de consuter un médecin (Figure X) ----
# Ostéopathes NPS vus avant ou isolément d'un médecin (Figure X)
osteo.tnps.avalt.med <- osteo.tnps.dos.avalt.med|
  osteo.tnps.stress.avalt.med|
  osteo.tnps.minf.avalt.med|osteo.tnps.autre.avalt.med|osteo.tnps.bronchite.avalt.med|
  osteo.tnps.depression.avalt.med|osteo.tnps.gorge.avalt.med|osteo.tnps.migraine.avalt.med|
  osteo.tnps.msup.avalt.med|osteo.tnps.cou.avalt.med|osteo.tnps.grippe.avalt.med
table(osteo.tnps.avalt.med,useNA = "always")
# FALSE  TRUE  <NA> 
#  9040  1438     0
# Taux de déclaration
osteo.tnps.avalt.med.recom.med <- osteo.tnps.dos.avalt.med.recom.med|
  osteo.tnps.autre.avalt.med.recom.med|
  osteo.tnps.bronchite.avalt.med.recom.med|
  osteo.tnps.msup.avalt.med.recom.med|
  osteo.tnps.minf.avalt.med.recom.med|
  osteo.tnps.cou.avalt.med.recom.med|
  osteo.tnps.stress.avalt.med.recom.med|
  osteo.tnps.migraine.avalt.med.recom.med|
  osteo.tnps.gorge.avalt.med.recom.med|
  osteo.tnps.grippe.avalt.med.recom.med|
  osteo.tnps.depression.avalt.med.recom.med
table(osteo.tnps.avalt.med.recom.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10350   128     0
(128/1438)*100
# [1] 8.9013

## Taux de rebouteux NPS ayant recommandé de consuter un médecin (Figure X) ----
# Rebouteux NPS vus avant ou isolément d'un médecin (Figure X)
rebout.tnps.avalt.med <- rebout.tnps.dos.avalt.med|
  rebout.tnps.stress.avalt.med|
  rebout.tnps.minf.avalt.med|rebout.tnps.autre.avalt.med|rebout.tnps.bronchite.avalt.med|
  rebout.tnps.depression.avalt.med|rebout.tnps.gorge.avalt.med|rebout.tnps.migraine.avalt.med|
  rebout.tnps.msup.avalt.med|rebout.tnps.cou.avalt.med|rebout.tnps.grippe.avalt.med
table(rebout.tnps.avalt.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10444    34     0
# Taux de recommandation
rebout.tnps.avalt.med.recom.med <- rebout.tnps.dos.avalt.med.recom.med|
  rebout.tnps.autre.avalt.med.recom.med|
  rebout.tnps.bronchite.avalt.med.recom.med|
  rebout.tnps.msup.avalt.med.recom.med|
  rebout.tnps.minf.avalt.med.recom.med|
  rebout.tnps.cou.avalt.med.recom.med|
  rebout.tnps.stress.avalt.med.recom.med|
  rebout.tnps.migraine.avalt.med.recom.med|
  rebout.tnps.gorge.avalt.med.recom.med|
  rebout.tnps.grippe.avalt.med.recom.med|
  rebout.tnps.depression.avalt.med.recom.med
table(rebout.tnps.avalt.med.recom.med,useNA = "always")
# FALSE  TRUE  <NA> 
# 10475     3     0
(3/34)*100
# [1] 8.8235
