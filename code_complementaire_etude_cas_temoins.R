##################################################################################
#Does dissatisfaction with physicians lead patients to alternative practitioners?#
##################################################################################

# Code used for data manipulations and analyses #
#################################################

# Loading the working directory
setwd("/home/albin/data/pro/these/Traitement\ des\ données")

# Dataset assignment
dts <- read.csv("dataset.csv", dec = ",")

# Data manipulations ----

## Data preparation

### Column renaming
names(dts)[c(3, 9:11)] <- c("dern.page", "form.non.opp","resid.fr","sup.18ans")
names(dts)[12:20] <- c("duree.mg","sat.mg1", "fr.mg","sat.mg2","auto.sante","vie.saine",
  "san.chr","doul.chr","compl.san1")
names(dts)[21:27] <- c("acup", "chiro", "homeo", "magne", "osteo","rebout","autre.rec")
names(dts)[28:47] <- c("acup.tnps","acup.chir.d","acup.inf","acup.kin","acup.med",
  "acup.pod","acup.pharm","acup.sfemme","acup.na","acup.autre","acup.motif",
  "acup.motif.autre","acup.rec.comp.med1","acup.rec.comp.med2","acup.recom.med1",
  "acup.recom.med2","med.recom.acup","med.depuis.acup","talk.acup.med","acup.comp.san")
names(dts)[48:73] <- c("chiro.tnps","chiro.chir.d","chiro.inf","chiro.kin","chiro.med",
  "chiro.pod","chiro.pharm","chiro.sfemme","chiro.na","chiro.autre","chiro.motif",
  "chiro.motif.autre","chiro.rec.comp.med1","chiro.rec.comp.med2","chiro.recom.med1",
  "chiro.recom.med2","med.recom.chiro","med.depuis.chiro","talk.chiro.med",
  "chiro.rec.comp.kin1","kin.is.chiro","sat.kin.chiro","chiro.rec.comp.kin2",
  "chiro.sat.pec.kin","kin.recom.chiro","chiro.comp.san")
names(dts)[74:93] <- c("homeo.tnps","homeo.chir.d","homeo.inf","homeo.kin","homeo.med",
  "homeo.pod","homeo.pharm","homeo.sfemme","homeo.na","homeo.autre","homeo.motif",
  "homeo.motif.autre","homeo.rec.comp.med1","homeo.rec.comp.med2","homeo.recom.med1",
  "homeo.recom.med2","med.recom.homeo","med.depuis.homeo","talk.homeo.med",
  "homeo.comp.san")
names(dts)[94:113] <- c("magne.tnps","magne.chir.d","magne.inf","magne.kin","magne.med",
  "magne.pod","magne.pharm","magne.sfemme","magne.na","magne.autre","magne.motif",
  "magne.motif.autre","magne.rec.comp.med1","magne.rec.comp.med2","magne.recom.med1",
  "magne.recom.med2","med.recom.magne","med.depuis.magne","talk.magne.med",
  "magne.comp.san")
names(dts)[114:133] <- c("rebout.tnps","rebout.chir.d","rebout.inf","rebout.kin",
  "rebout.med","rebout.pod","rebout.pharm","rebout.sfemme","rebout.na","rebout.autre",
  "rebout.motif","rebout.motif.autre","rebout.rec.comp.med1","rebout.rec.comp.med2",
  "rebout.recom.med1","rebout.recom.med2","med.recom.rebout","med.depuis.rebout",
  "talk.rebout.med","rebout.comp.san")
names(dts)[134:158] <- c("osteo.tnps","osteo.chir.d","osteo.inf","osteo.kin",
  "osteo.med","osteo.pod","osteo.pharm","osteo.sfemme","osteo.na","osteo.autre",
  "osteo.motif","osteo.motif.autre","osteo.rec.comp.med1","osteo.rec.comp.med2",
  "osteo.recom.med1","osteo.recom.med2","med.recom.osteo1","med.depuis.osteo",
  "talk.osteo.med","osteo.rec.comp.kin1","kin.is.osteo","sat.kin.osteo",
  "osteo.rec.comp.kin2","osteo.sat.pec.kin","kin.recom.osteo1")
names(dts)[159:172] <- c("med.non","med.bronchite","med.grippe","med.gorge",
  "med.migraine","med.doul.msup","med.doul.minf","med.doul.cou","med.doul.dos",
  "med.depression","med.stress","med.autre","sat.pec.med","med.recom.osteo2")
names(dts)[173:182] <- c("kin.non","kin.migraine","kin.doul.msup","kin.doul.minf",
  "kin.doul.cou","kin.doul.dos","kin.autre","sat.pec.kin","kin.recom.osteo2",
  "osteo.comp.san")
names(dts)[183:195] <- c("age","sit.matri","emploi","prof","lieu.de.vie","diplome",
  "diplome.autre","revenu","sexe","dep.resid","support","remarques","temps.total")

### Replacement of all "N/A" values with "NA"
dts[dts[ , ] == "N/A"] <- NA

### Replacement of all empty values "" with "NA"
dts[dts[ , ] == ""] <- NA

### Data cleaning

#### Removal of incomplete questionnaires (n=2726)
dts <- dts[-which((dts$dern.page < 5) | is.na(dts$dern.page)), ]

#### Removal of questionnaires with unapproved no objection forms (n=135)
dts <- dts[-which(dts$form.non.opp == "Non"), ]

#### Removal of subjects not meeting the inclusion criteria (n=36)
dts <- dts[-which(dts$resid.fr == "Non"), ] # n=21
dts <- dts[-which(dts$sup.18ans == "Non"), ] # n=14
dts <- dts[-which(((2018-dts$age) < 18 ) | ((2019-dts$age) < 18)), ] # n=1

#### Duplicate identification and removal
duplicated2 <- function(x){ 
  if (sum(dup <- duplicated(x))==0) 
    return(dup) 
  if (class(x) %in% c("data.frame","matrix")) 
    duplicated(rbind(x[dup,],x))[-(1:sum(dup))] 
  else duplicated(c(x[dup],x))[-(1:sum(dup))] 
} # Source: http://forums.cirad.fr/logiciel-R/viewtopic.php?p=2968
dts <- dts[-which(duplicated2(dts[c(183:186, 188:192)])),]

## Co-variable preparation

### Creation of the variable "educational attainement"
dts$educ.att[dts$diplome %in% 
    c("2e ou 3e cycle universitaire (Master, Doctorat), Grande École")
  ] <- "Master's degree or doctorate"
dts$educ.att[dts$diplome %in% 
    c("Baccalauréat général ou DAEU", "Baccalauréat technologique ou professionnel"
      ,"BTS, DUT, DEST, DEUG, Licence")
  ] <- "Bachelor's degree or short cycle tertiary education"
dts$educ.att[dts$diplome %in%
    c("Brevet de technicien, Brevet professionnel, BEI, BEC, BEA"
  ,"CAP, BEP, BEPC, Brevet élémentaire, Brevet des collèges",
      "Certificat d'étude primaire (CEP), diplôme de fin d'études obligatoires")
  ] <- "Upper secondary education or less"

#### Level renaming of the variable "diplome.autre"
library(stringr)
infir <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "infir") == TRUE
  ))
    ]
)

Infir <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "Infir") == TRUE
  ))
    ]
)

INFIR <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "INFIR") == TRUE
  ))
    ]
)

kin <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "kin") == TRUE
  ))
    ]
)

Kin <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "Kin") == TRUE
  ))
    ]
)

KIN <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "KIN") == TRUE
  ))
    ]
)

ing <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "ing") == TRUE
  ))
    ]
)

Ing <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "Ing") == TRUE
  ))
    ]
)

agreg <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "gation") == TRUE
  ))
    ]
)

bac2 <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "\\+2") == TRUE
  ))
    ]
)

bac3 <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "\\+3") == TRUE
  ))
    ]
)

bac4 <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "\\+4") == TRUE
  ))
    ]
)

bac5 <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "\\+5") == TRUE
  ))
    ]
)

doctorat <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "doct") == TRUE
  ))
    ]
)

Doctorat <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "Doct") == TRUE
  ))
    ]
)

cadre <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "cadre") == TRUE
  ))
    ]
)

Cadre <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "Cadre") == TRUE
  ))
    ]
)

CADRE <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "CADRE") == TRUE
  ))
    ]
)

cape <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "cape") == TRUE
  ))
    ]
)

CAPE <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "CAPE") == TRUE
  ))
    ]
)

dea <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "dea") == TRUE
  ))
    ]
)

DEA <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "DEA") == TRUE
  ))
    ]
)

licence <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "licence") == TRUE
  ))
    ]
)

Licence <- as.character(
  dts$diplome.autre[
    (which
      (str_detect(dts$diplome.autre, "Licence") == TRUE
  ))
    ]
)
  
dts$diplome.autre.r[dts$diplome.autre %in%
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
      
dts$diplome.autre.r[dts$diplome.autre %in%
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
      
dts$diplome.autre.r[dts$diplome.autre %in% 
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
      "diplôme de l'école d'administration de strasbourg","DTS",
      "Ecole sup de filature et tissage",
      "ENADEP (réservée aux salariés des cabinets d'avocats)",
      "ENSAD Paris","pupitreur", "Ki ","D.E  KINÉSITHÉRAPIE"
      ,Infir,INFIR,Kin,KIN,"DE puericultrice","BAC + 2 ans École Normale",
      "JE VEUT FAIRE UN MASTER EN VAE ET J AI UNE LICENCE EN VAE JE N AI PAS LE BAC MON NIVEAU SCOLAIRE EST CAP"
      ,"DE infimière","ITB","DEISP"
      )] <- "Bachelor's degree or short cycle tertiary education"
      
dts$diplome.autre.r[dts$diplome.autre %in% 
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
dts$educ.att[which(
  dts$diplome.autre.r == "Upper secondary education or less"
  )] <- "Upper secondary education or less"
dts$educ.att[which(
  dts$diplome.autre.r == "Bachelor's degree or short cycle tertiary education"
  )] <- "Bachelor's degree or short cycle tertiary education"
dts$educ.att[which(
  dts$diplome.autre.r == "Master's degree or doctorate"
  )] <- "Master's degree or doctorate"

#### Rearrangement and factorization of the "educational attainement" variable levels
dts$educ.att <- factor(dts$educ.att, levels=c("Upper secondary education or less",
  "Bachelor's degree or short cycle tertiary education","Master's degree or doctorate"))

### English translation of the variable "presence of a chronic disease"
dts$chr.disease[dts$san.chr %in% c("Non")] <- "No"
dts$chr.disease[dts$san.chr %in% c("Oui")] <- "Yes"

### English translation of the variable "presence of a chronic pain"
dts$chr.pain[dts$doul.chr %in% c("Non")] <- "No"
dts$chr.pain[dts$doul.chr %in% c("Oui")] <- "Yes"

### English translation of the variable "self-rated health" variable
dts$sr.health[dts$auto.sante %in% c("Mauvaise")] <- "Poor"
dts$sr.health[dts$auto.sante %in% c("Passable")] <- "Fair"
dts$sr.health[dts$auto.sante %in% c("Bonne")] <- "Good"
dts$sr.health[dts$auto.sante %in% c("Très bonne")] <- "Very good"
dts$sr.health[dts$auto.sante %in% c("Excellente")] <- "Excellent"

### Rearrangement of the variable "self-rated health" variable
dts$sr.health <- factor(dts$sr.health, levels = c("Poor","Fair","Good",
  "Very good","Excellent"))

### Creation of the variable "income"
dts$income[dts$revenu %in%
    c("Moins de 1 135 euros/mois OU moins de 13600/an")] <- "<1135€"
dts$income[dts$revenu %in%
    c("De 1135 à moins de 1500 euros/mois OU de 13600 à moins de 18000/an"
      )] <- "1135-1800€"
dts$income[dts$revenu %in%
    c("De 1500 à moins de 1800 euros/mois OU de 18000 à moins de 21600/an"
      )] <- "1135-1800€"
dts$income[dts$revenu %in%
    c("De 1800 à moins de 2000 euros/mois OU de 21600 à moins de 24000/an"
      )] <- "1800-3000€"
dts$income[dts$revenu %in%
    c("De 2000 à moins de 3000 euros/mois OU de 24000 à moins de 42000/an"
      )] <- "1800-3000€"
dts$income[dts$revenu %in%
    c("De 3000 à moins de 4000 euros/mois OU de 42000 à moins de 48000/an"
      )] <- ">3000€"
dts$income[dts$revenu %in%
    c("Plus de 4000 euros/mois OU plus de 48000/an"
      )] <- ">3000€"
dts$income[dts$revenu %in%
    c("Je ne sais pas","Je ne souhaite pas répondre")] <- NA

#### Rearrangement and factorization of the variable "income"
dts$income <- factor(dts$income, levels = c("<1135€","1135-1800€","1800-3000€",
  ">3000€"))

### English translation of the variable "sex"
dts$ssex[dts$sexe %in% c("Homme")] <- "Male"
dts$ssex[dts$sexe %in% c("Femme")] <- "Female"

### Factorization of all variables
dts$ssex <- factor(dts$ssex)
dts$educ.att <- factor(dts$educ.att)
dts$income <- factor(dts$income)
dts$chr.disease <- factor(dts$chr.disease)
dts$chr.pain <- factor(dts$chr.disease)
dts$sr.health <- factor(dts$sr.health)

### Creation of the variable "age"
dts$age <- (2018 - dts$age)

### Creation of the variable "sat.gp" (satisfaction with the general practitioner)
dts$newcolumn <- NA
names(dts)[311] <- c("sat.gp")
dts$sat.gp <- as.numeric(dts$sat.gp)
dts$sat.gp[1:5883] <- dts$sat.mg1[1:5883]
dts$sat.gp[which((is.na(dts$sat.gp) == TRUE) &
    (is.na(dts$sat.mg2)==FALSE))] <- dts$sat.mg2[which(is.na(dts$sat.mg2) == FALSE)]

### Variable renaming for presentation of the analyses

#### Chronic disease
dts$chr.disease.r[dts$chr.disease %in% c("No")] <- "0"
dts$chr.disease.r[dts$chr.disease %in% c("Yes")] <- "1"
dts$chr.disease.r <- factor(dts$chr.disease.r)

#### Chronic pain
dts$chr.pain.r[dts$chr.pain %in% c("No")] <- "0"
dts$chr.pain.r[dts$chr.pain %in% c("Yes")] <- "1"
dts$chr.pain.r <- factor(dts$chr.pain.r)

#### Educational attainement
dts$educ.att.r[dts$educ.att %in% c("Upper secondary education or less")] <- "0"
dts$educ.att.r[dts$educ.att %in% 
    c("Bachelor's degree or short cycle tertiary education")] <- "1"
dts$educ.att.r[dts$educ.att %in% c("Master's degree or doctorate")] <- "2"
dts$educ.att.r <- factor(dts$educ.att.r)

#### Income
dts$income.r[dts$income %in% c("<1135€")] <- "0"
dts$income.r[dts$income %in% c("1135-1800€")] <- "1"
dts$income.r[dts$income %in% c("1800-3000€")] <- "2"
dts$income.r[dts$income %in% c(">3000€")] <- "3"
dts$income.r <- factor(dts$income.r)

#### Self-rated health
dts$sr.health.r[dts$sr.health %in% c("Poor")] <- "0"
dts$sr.health.r[dts$sr.health %in% c("Fair")] <- "0"
dts$sr.health.r[dts$sr.health %in% c("Good")] <- "1"
dts$sr.health.r[dts$sr.health %in% c("Very good")] <- "2"
dts$sr.health.r[dts$sr.health %in% c("Excellent")] <- "3"
dts$sr.health.r <- factor(dts$sr.health.r)

#### Sex
dts$ssex.r[dts$ssex %in% c("Male")] <- "0"
dts$ssex.r[dts$ssex %in% c("Female")] <- "1"
dts$ssex.r <- factor(dts$ssex.r)

## Dependent variable preparation

### Construction of the "complementary use" group B (all CAM practitioners)

#### Preliminary construction of a group "use of a non-physician CAM practitioner for 
#### low back pain"
dos.camp.nmed <- (
    (dts$acup == "Oui" & dts$acup.med == "Non" & (is.na(dts$acup.motif) == FALSE 
      & dts$acup.motif == "Douleur au dos")) 
  | (dts$chiro == "Oui" & dts$chiro.med == "Non" & (is.na(dts$chiro.motif) == FALSE 
    & dts$chiro.motif == "Douleur au dos"))
  | (dts$homeo == "Oui" & dts$homeo.med == "Non" & (is.na(dts$homeo.motif) == FALSE 
    & dts$homeo.motif == "Douleur au dos"))
  | (dts$magne == "Oui" & dts$magne.med == "Non" & (is.na(dts$magne.motif) == FALSE 
    & dts$magne.motif == "Douleur au dos"))
  | (dts$osteo == "Oui" & dts$osteo.med == "Non" & (is.na(dts$osteo.motif) == FALSE 
    & dts$osteo.motif == "Douleur au dos"))
  | (dts$rebout == "Oui" & dts$rebout.med == "Non" & (is.na(dts$rebout.motif) == FALSE 
    & dts$rebout.motif == "Douleur au dos"))
  )
table(dos.camp.nmed, useNA = "always")
# dos.camp.nmed
# FALSE  TRUE  <NA> 
#  4652  1231     0

#### Effective construction of the "complementary use" group B (all CAM practitioners)
dos.camp.nmed.comp <-(
  (dts$acup == "Oui" & dts$acup.med == "Non" & (is.na(dts$acup.motif) == FALSE 
    & dts$acup.motif == "Douleur au dos") 
    & (dts$acup.rec.comp.med1 == "Avant d'avoir consulté l'acupuncteur" 
      | dts$acup.rec.comp.med2 == "Oui") 
    & dts$acup.rec.comp.med1 != "Après avoir consulté l'acupuncteur")
| (dts$chiro == "Oui" & dts$chiro.med == "Non" & (is.na(dts$chiro.motif) == FALSE 
  & dts$chiro.motif == "Douleur au dos") 
  & (dts$chiro.rec.comp.med1 == "Avant d'avoir consulté le chiropracteur" 
    | dts$chiro.rec.comp.med2 == "Oui") 
  & dts$chiro.rec.comp.med1 != "Après avoir consulté le chiropracteur")
| (dts$homeo == "Oui" & dts$homeo.med == "Non" & (is.na(dts$homeo.motif) == FALSE 
  & dts$homeo.motif == "Douleur au dos") 
  & (dts$homeo.rec.comp.med1 == "Avant d'avoir consulté l'homéopathe" 
    | dts$homeo.rec.comp.med2 == "Oui") 
  & dts$homeo.rec.comp.med1 != "Après avoir consulté l'homéopathe")
| (dts$magne == "Oui" & dts$magne.med == "Non" & (is.na(dts$magne.motif) == FALSE 
  & dts$magne.motif == "Douleur au dos") 
  & (dts$magne.rec.comp.med1 == "Avant d'avoir consulté le magnétiseur" 
    | dts$magne.rec.comp.med2 == "Oui") 
  & dts$magne.rec.comp.med1 != "Après avoir consulté le magnétiseur")
| (dts$osteo == "Oui" & dts$osteo.med == "Non" & (is.na(dts$osteo.motif) == FALSE 
  & dts$osteo.motif == "Douleur au dos") 
  & (dts$osteo.rec.comp.med1 == "Avant d'avoir consulté l'ostéopathe" 
    | dts$osteo.rec.comp.med2 == "Oui") 
  & dts$osteo.rec.comp.med1 != "Après avoir consulté l'ostéopathe")
| (dts$rebout == "Oui" & dts$rebout.med == "Non" & (is.na(dts$rebout.motif) == FALSE 
  & dts$rebout.motif == "Douleur au dos") 
  & (dts$rebout.rec.comp.med1 == "Avant d'avoir consulté le rebouteux" 
    | dts$rebout.rec.comp.med2 == "Oui") 
  & dts$rebout.rec.comp.med1 != "Après avoir consulté le rebouteux")
  )
table(dos.camp.nmed.comp, useNA = "always")
# FALSE  TRUE  <NA> 
#  5242   641     0

### Construction of the reference group A (physician only)

#### Preliminary construction of a group "use of a CAM practitioner physician for 
#### low back pain"
dos.camp.med <- (dts$acup == "Oui" & dts$acup.med == "Oui" 
  & dts$acup.motif == "Douleur au dos"
  | dts$chiro == "Oui" & dts$chiro.med == "Oui" & dts$chiro.motif == "Douleur au dos"
  | dts$homeo == "Oui" & dts$homeo.med == "Oui" & dts$homeo.motif == "Douleur au dos"
  | dts$magne == "Oui" & dts$magne.med == "Oui" & dts$magne.motif == "Douleur au dos"
  | dts$osteo == "Oui" & dts$osteo.med == "Oui" & dts$osteo.motif == "Douleur au dos"
  | dts$rebout == "Oui" & dts$rebout.med == "Oui" 
  & dts$rebout.motif == "Douleur au dos")
table(dos.camp.med, useNA = "always")
# dos.camp.med
# FALSE  TRUE  <NA> 
#  5724   159     0

#### Effective construction of the reference group A (physician only)
dos.med.seul <- ((
  dts$med.doul.dos == "Oui" | dos.camp.med == TRUE) & dos.camp.nmed.comp == FALSE)
table(dos.med.seul, useNA = "always")
# dos.med.seul
# FALSE  TRUE  <NA> 
#  4962   921     0

### Construction of the "alternative use" group C (all CAM practitioners)
dos.camp.nmed.alt <- ((
  (dts$acup == "Oui" & dts$acup.med == "Non" & (is.na(dts$acup.motif) == FALSE 
    & dts$acup.motif == "Douleur au dos") 
    & (dts$acup.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
      | dts$acup.rec.comp.med2 == "Non") 
    & dts$acup.rec.comp.med1 != "Après avoir consulté l'acupuncteur")
| (dts$chiro == "Oui" & dts$chiro.med == "Non" & (is.na(dts$chiro.motif) == FALSE 
  & dts$chiro.motif == "Douleur au dos") 
  & (dts$chiro.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | dts$chiro.rec.comp.med2 == "Non") 
  & dts$chiro.rec.comp.med1 != "Après avoir consulté le chiropracteur")
| (dts$homeo == "Oui" & dts$homeo.med == "Non" & (is.na(dts$homeo.motif) == FALSE 
  & dts$homeo.motif == "Douleur au dos") 
  & (dts$homeo.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | dts$homeo.rec.comp.med2 == "Non") 
  & dts$homeo.rec.comp.med1 != "Après avoir consulté l'homéopathe")
| (dts$magne == "Oui" & dts$magne.med == "Non" & (is.na(dts$magne.motif) == FALSE 
  & dts$magne.motif == "Douleur au dos") 
  & (dts$magne.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | dts$magne.rec.comp.med2 == "Non") 
  & dts$magne.rec.comp.med1 != "Après avoir consulté le magnétiseur")
| (dts$osteo == "Oui" & dts$osteo.med == "Non" & (is.na(dts$osteo.motif) == FALSE 
  & dts$osteo.motif == "Douleur au dos") 
  & (dts$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | dts$osteo.rec.comp.med2 == "Non") 
  & dts$osteo.rec.comp.med1 != "Après avoir consulté l'ostéopathe")
| (dts$rebout == "Oui" & dts$rebout.med == "Non" & (is.na(dts$rebout.motif) == FALSE 
  & dts$rebout.motif == "Douleur au dos") 
  & (dts$rebout.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | dts$rebout.rec.comp.med2 == "Non") 
  & dts$rebout.rec.comp.med1 != "Après avoir consulté le rebouteux"))
  & dos.med.seul == FALSE
  & dos.camp.nmed.comp == FALSE)
table(dos.camp.nmed.alt, useNA = "always")
# dos.camp.nmed.alt
# FALSE  TRUE  <NA> 
#  5389   494     0

### Construction of the "complementary use" group D (CAM practitioners without 
### osteopaths)

#### Preliminary construction of a group "complementary use of a non-physician osteopath 
#### for low back pain"
dos.osteo.nmed.comp <- (dts$osteo == "Oui" & dts$osteo.med == "Non" 
  & (is.na(dts$osteo.motif) == FALSE & dts$osteo.motif == "Douleur au dos") 
  & (dts$osteo.rec.comp.med1 == "Avant d'avoir consulté l'ostéopathe" 
    | dts$osteo.rec.comp.med2 == "Oui") 
  & dts$osteo.rec.comp.med1 != "Après avoir consulté l'ostéopathe")
table(dos.osteo.nmed.comp, useNA = "always")
# dos.osteo.nmed.comp
# FALSE  TRUE  <NA> 
#  5314   569     0

#### Effective construction of the "complementary use" group D (CAM practitioners without
#### osteopaths)
dos.camp_o.nmed.comp <- (dos.camp.nmed.comp == TRUE & dos.osteo.nmed.comp == FALSE)
table(dos.camp_o.nmed.comp)
# FALSE  TRUE  <NA>
#  5811    72     0

### Construction of the "alternative use" group E (CAM practitioners without osteopaths)

#### Preliminary construction of a group "alternative use of a non-physician osteopath 
#### for low back pain"
dos.osteo.nmed.alt <- (dts$osteo == "Oui" & dts$osteo.med == "Non" 
  & (is.na(dts$osteo.motif) == FALSE & dts$osteo.motif == "Douleur au dos") 
  & (dts$osteo.rec.comp.med1 == "Je n'ai pas consulté de médecin" 
    | dts$osteo.rec.comp.med2 == "Non") 
  & dts$osteo.rec.comp.med1 != "Après avoir consulté l'ostéopathe")
table(dos.osteo.nmed.alt, useNA = "always")
# dos.osteo.nmed
# FALSE  TRUE  <NA> 
#  4814   593   476

#### Effective construction of the "alternative use" group E (CAM practitioners 
#### without osteopaths)
dos.camp_o.nmed.alt <- (dos.camp.nmed.alt == TRUE & dos.osteo.nmed.alt == FALSE)
table(dos.camp_o.nmed.alt, useNA = "always")
# dos.camp_o.nmed.alt
# FALSE  TRUE  <NA> 
#  5852    31     0

# Data analyses ----

## Regression analyses (satisfaction variables treated as continuous) ----
library(mice)

### First hypothesis

#### Dependent variable construction
a <- (dos.med.seul == TRUE)
b <- (dos.camp.nmed.comp == TRUE)
dts$newcolumn <- NA
names(dts)[318] <- c("vd1")
names(dts)[318]
dts$vd1 <- factor(dts$vd1, levels = c("dos.camp.nmed.comp", "dos.med.seul"))
table(dts$vd1)
dts[(which(a == TRUE)),318] <- "dos.med.seul"
dts[(which(b == TRUE)),318] <- "dos.camp.nmed.comp"
table(dts$vd1, useNA = "always")
# dos.camp.nmed.comp       dos.med.seul               <NA> 
#                641                921               4321 

### Second hypothesis

#### Dependent variable construction
a <- (dos.med.seul == TRUE)
b <- (dos.camp.nmed.alt == TRUE)
dts$newcolumn <- NA
names(dts)[319] <- c("vd2")
dts$vd2 <- factor(dts$vd2, levels = c("dos.camp.nmed.alt", "dos.med.seul"))
table(dts$vd2)
dts[(which(a == TRUE)),319] <- "dos.med.seul"
dts[(which(b == TRUE)),319] <- "dos.camp.nmed.alt"
table(dts$vd2, useNA = "always")
# dos.camp.nmed.alt      dos.med.seul              <NA> 
#               494               921              4468

### Fourth hypothesis

#### Dependent variable construction
a <- (dos.med.seul == TRUE)
b <- (dos.camp_o.nmed.alt == TRUE)
dts$newcolumn <- NA
names(dts)[318] <- c("vde2")
dts$vde2 <- factor(dts$vde2, levels = c("dos.med.seul","dos.camp_o.nmed.alt"))
table(dts$vde2)
dts[(which(a == TRUE)),318] <- "dos.med.seul"
dts[(which(b == TRUE)),318] <- "dos.camp_o.nmed.alt"
table(dts$vde2,useNA = "always")
# dos.med.seul dos.camp_o.nmed.alt                <NA> 
#          921                  31                4931 

#### Fourth hypothesis testing

###### Missing data imputation
a <- data.frame(dts$vde2,dts$sat.gp,dts$chr.disease.r,dts$educ.att.r,dts$income.r,
  dts$sr.health.r,dts$ssex.r)
a <- a[-which(is.na(a$dts.vde2)==TRUE),]
a$dts.vde2.r <- ifelse(a$dts.vde2=="dos.med.seul",0,1)
a$dts.vde2 <- NULL
impute.a <- mice(a, m =10, seed = 1)

###### Multivariate analysis

####### Fourth hypothesis, complete model ----
####### (Variable "sex" added)
aimp <- glm.mids(dts.vde2.r~dts.sat.gp+dts.chr.disease.r+dts.educ.att.r+dts.income.r+
    dts.sr.health.r+dts.ssex.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)
#                      estimate std.error statistic     df    p.value      2.5 %     97.5 %
# (Intercept)         0.0013182  1.371119  -4.83658 812.15 1.5803e-06 8.9357e-05   0.019445
# dts.sat.gp          1.0098096  0.011104   0.87910 504.72 3.7977e-01 9.8802e-01   1.032082
# dts.chr.disease.r1  1.2871855  0.416575   0.60603 937.39 5.4464e-01 5.6832e-01   2.915339
# dts.educ.att.r1     1.3863623  0.619273   0.52753 921.21 5.9795e-01 4.1120e-01   4.674078
# dts.educ.att.r2     1.3731652  0.671187   0.47247 888.53 6.3670e-01 3.6781e-01   5.126455
# dts.income.r1       0.3783490  0.706165  -1.37636 759.30 1.6912e-01 9.4590e-02   1.513357
# dts.income.r2       0.7481767  0.609104  -0.47630 662.47 6.3402e-01 2.2625e-01   2.474133
# dts.income.r3       1.1915303  0.686389   0.25530 607.55 7.9857e-01 3.0952e-01   4.586977
# dts.sr.health.r1    9.7666982  0.803644   2.83581 935.34 4.6696e-03 2.0174e+00  47.282098
# dts.sr.health.r2   21.8826249  0.856480   3.60276 933.07 3.3148e-04 4.0749e+00 117.512269
# dts.sr.health.r3   43.3559975  0.995422   3.78678 936.17 1.6234e-04 6.1468e+00 305.809288
# dts.ssex.r1         1.4265121  0.428485   0.82904 905.39 4.0730e-01 6.1526e-01   3.307429

