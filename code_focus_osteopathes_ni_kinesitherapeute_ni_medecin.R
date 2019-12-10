##################################################################################
#Does dissatisfaction with physicians lead patients to alternative practitioners?#
##################################################################################

# Code used for data manipulations and analyses #
#################################################

# Loading the working directory
setwd("repertoire_a_specifier")

# Dataset assignment
dts <- read.csv("q2_all.csv", dec = ",")

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
dts$sr.health.r[dts$sr.health %in% c("Fair")] <- "1"
dts$sr.health.r[dts$sr.health %in% c("Good")] <- "2"
dts$sr.health.r[dts$sr.health %in% c("Very good")] <- "3"
dts$sr.health.r[dts$sr.health %in% c("Excellent")] <- "4"
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

#### Effective construction of the "complementary use" group B (osteopaths)
dos.osteo.nmedk.comp <-(dts$osteo == "Oui" & dts$osteo.med == "Non" & dts$osteo.kin == "Non" & (is.na(dts$osteo.motif) == FALSE 
  & dts$osteo.motif == "Douleur au dos") 
  & (dts$osteo.rec.comp.med1 == "Avant d'avoir consulté l'ostéopathe" 
    | dts$osteo.rec.comp.med2 == "Oui") 
  & dts$osteo.rec.comp.med1 != "Après avoir consulté l'ostéopathe")
table(dos.osteo.nmedk.comp, useNA = "always")
# FALSE  TRUE  <NA> 
#  5505   378     0

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
dos.med.seul <- ((dts$med.doul.dos == "Oui" | dos.camp.med == TRUE) & dos.camp.nmed.comp == FALSE)
table(dos.med.seul, useNA = "always")
# FALSE  TRUE  <NA> 
#  4962   921     0 

# Data analyses ----

## Regression analyses (satisfaction variables treated as continuous) ----
library(mice)

### First hypothesis

#### Dependent variable construction
a <- (dos.med.seul == TRUE)
b <- (dos.osteo.nmedk.comp == TRUE)
dts$newcolumn <- NA
names(dts)[318] <- c("vd1")
names(dts)[318]
dts$vd1 <- factor(dts$vd1, levels = c("dos.osteo.nmedk.comp", "dos.med.seul"))
table(dts$vd1)
dts[(which(a == TRUE)),318] <- "dos.med.seul"
dts[(which(b == TRUE)),318] <- "dos.osteo.nmedk.comp"
table(dts$vd1, useNA = "always")
# dos.osteo.nmedk.comp         dos.med.seul                 <NA> 
#                  378                  884                 4621

#### First hypothesis testing

###### Missing data imputation
a <- data.frame(
  dts$vd1,dts$sat.pec.med,dts$chr.disease.r,dts$educ.att.r,dts$income.r,dts$sr.health.r,
  dts$ssex.r)
a <- a[-which(is.na(a$dts.vd1)==TRUE),]
a$dts.vd1.r <- ifelse(a$dts.vd1=="dos.med.seul",0,1)
a$dts.vd1 <- NULL
impute.a <- mice(a, m=10, seed = 1)

###### Bivariate analysis
aimp <- glm.mids(dts.vd1.r~dts.sat.pec.med, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)
#                 estimate std.error statistic     df    p.value   2.5 % 97.5 %
# (Intercept)      0.50884 0.1520775   -4.4426 72.741 3.1166e-05 0.37579 0.6890
# dts.sat.pec.med  1.00508 0.0022759    2.2285 62.813 2.9436e-02 1.00052 1.0097

###### Multivariate analyses

####### Variable "chronic disease" added
aimp <- glm.mids(
  dts.vd1.r~dts.sat.pec.med+dts.chr.disease.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)
#                    estimate std.error statistic       df   p.value   2.5 %  97.5 %
# (Intercept)         0.65235 0.1806892   -2.3641   92.919 0.0201542 0.45567 0.93393
# dts.sat.pec.med     1.00425 0.0023142    1.8344   61.739 0.0714125 0.99962 1.00891
# dts.chr.disease.r1  0.73543 0.1097879   -2.7990 1463.540 0.0051932 0.59294 0.91216

####### Variable "educational attainment" added
aimp <- glm.mids(dts.vd1.r~dts.sat.pec.med+dts.chr.disease.r
  +dts.educ.att.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)
#                    estimate std.error statistic       df   p.value   2.5 %  97.5 %
# (Intercept)         0.53413 0.2094993   -2.9934  145.988 0.0032406 0.35304 0.80809
# dts.sat.pec.med     1.00421 0.0023306    1.8033   59.686 0.0763883 0.99954 1.00890
# dts.chr.disease.r1  0.75793 0.1109188   -2.4988 1460.311 0.0125709 0.60973 0.94215
# dts.educ.att.r1     1.24459 0.1314062    1.6651 1553.229 0.0960905 0.96180 1.61052
# dts.educ.att.r2     1.31982 0.1476129    1.8799 1553.200 0.0603112 0.98803 1.76303

####### Variable "income" added
aimp <- glm.mids(
  dts.vd1.r~dts.sat.pec.med+dts.chr.disease.r+dts.educ.att.r+dts.income.r,
  data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)
#                   estimate std.error statistic      df    p.value   2.5 %  97.5 %
# (Intercept)         0.44565 0.2302374  -3.51041  210.63 0.00054714 0.28306 0.70162
# dts.sat.pec.med     1.00391 0.0023339   1.67010   61.12 0.10001351 0.99923 1.00860
# dts.chr.disease.r1  0.78563 0.1119493  -2.15511 1514.88 0.03131007 0.63074 0.97856
# dts.educ.att.r1     1.15355 0.1349386   1.05857 1545.67 0.28996225 0.88529 1.50309
# dts.educ.att.r2     1.18411 0.1594899   1.05957 1490.51 0.28951082 0.86601 1.61905
# dts.income.r1       1.17681 0.1756520   0.92687  175.03 0.35527153 0.83205 1.66442
# dts.income.r2       1.52802 0.1578780   2.68545  956.84 0.00736856 1.12092 2.08298
# dts.income.r3       1.32467 0.2029116   1.38564  481.10 0.16650023 0.88910 1.97361

####### Variable "self-rated health" added
aimp <- glm.mids(dts.vd1.r~dts.sat.pec.med+dts.chr.disease.r
  +dts.educ.att.r+dts.income.r+dts.sr.health.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)
#                    estimate std.error statistic       df    p.value   2.5 %  97.5 %
# (Intercept)         0.26232 0.2674508  -5.00353  661.993 7.2219e-07 0.15515 0.44351
# dts.sat.pec.med     1.00129 0.0024352   0.52778   62.344 5.9953e-01 0.99642 1.00617
# dts.chr.disease.r1  1.10774 0.1309311   0.78148 1546.444 4.3464e-01 0.85684 1.43210
# dts.educ.att.r1     1.11046 0.1364061   0.76809 1541.392 4.4255e-01 0.84977 1.45112
# dts.educ.att.r2     1.13961 0.1609597   0.81189 1488.565 4.1698e-01 0.83106 1.56270
# dts.income.r1       1.11638 0.1773296   0.62083  184.794 5.3548e-01 0.78682 1.58398
# dts.income.r2       1.37325 0.1609745   1.97037  994.060 4.9073e-02 1.00129 1.88338
# dts.income.r3       1.09169 0.2061136   0.42563  612.056 6.7053e-01 0.72830 1.63641
# dts.sr.health.r1    1.32005 0.1897378   1.46343 1540.748 1.4355e-01 0.90982 1.91523
# dts.sr.health.r2    2.11389 0.1982190   3.77629 1472.995 1.6551e-04 1.43291 3.11850
# dts.sr.health.r3    2.75007 0.2390590   4.23170 1325.417 2.4789e-05 1.72056 4.39558
# dts.sr.health.r4    3.15926 0.3490618   3.29551 1439.170 1.0063e-03 1.59299 6.26552

####### First hypothesis, complete model ----
####### (Variable "sex" added)
aimp <- glm.mids(dts.vd1.r~dts.sat.pec.med+dts.chr.disease.r+dts.educ.att.r+
    dts.income.r+dts.sr.health.r+dts.ssex.r, data=impute.a,family=binomial(logit))
options(digits=5)
summary(pool(aimp), conf.int = TRUE, exponentiate = TRUE)
#                    estimate std.error statistic       df    p.value   2.5 %  97.5 %
# (Intercept)         0.09046 0.3722615  -6.45474  484.598 2.6347e-10 0.04353 0.18798
# dts.sat.pec.med     0.99893 0.0033642  -0.31754   30.289 7.5302e-01 0.99210 1.00582
# dts.chr.disease.r1  1.25366 0.1554202   1.45458 1281.982 1.4603e-01 0.92419 1.70059
# dts.educ.att.r1     1.24083 0.1701740   1.26799 1261.529 2.0504e-01 0.88863 1.73262
# dts.educ.att.r2     1.23939 0.1994439   1.07609 1210.360 2.8210e-01 0.83805 1.83292
# dts.income.r1       1.37303 0.2219299   1.42847  182.782 1.5486e-01 0.88616 2.12739
# dts.income.r2       1.72109 0.2154385   2.52025  271.027 1.2302e-02 1.12616 2.63032
# dts.income.r3       1.34362 0.2712129   1.08907  343.720 2.7689e-01 0.78814 2.29060
# dts.sr.health.r1    1.69743 0.2425112   2.18183 1279.827 2.9304e-02 1.05480 2.73158
# dts.sr.health.r2    2.67453 0.2562650   3.83890 1066.701 1.3086e-04 1.61758 4.42210
# dts.sr.health.r3    3.94545 0.3029041   4.53135  836.200 6.7143e-06 2.17716 7.14994
# dts.sr.health.r4    3.94833 0.4327941   3.17308 1124.474 1.5492e-03 1.68897 9.23007
# dts.ssex.r1         1.15262 0.1477616   0.96128 1256.202 3.3660e-01 0.86256 1.54022

