/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de cr�ation :  03/06/2016 08:28:57                      */
/*==============================================================*/
use ticketshackds;

drop table if exists ASSOCIER;

drop table if exists CATEGORIE;

drop table if exists CIVILITE;

drop table if exists COMMANDE;

drop table if exists DEPARTEMENT;

drop table if exists EVENEMENT;

drop table if exists LIGNE_COMMANDE;

drop table if exists OCCURENCE;

drop table if exists PREFERER;

drop table if exists QUALIFIER;

drop table if exists REDUCTION;

drop table if exists STATUT_UTILISATEUR;

drop table if exists TARIF;

drop table if exists THEME;

drop table if exists UTILISATEUR;

/*==============================================================*/
/* Table : ASSOCIER                                             */
/*==============================================================*/
create table ASSOCIER
(
   ID_CATEGORIE         int not null,
   ID_THEME             int not null,
   primary key (ID_CATEGORIE, ID_THEME)
);

/*==============================================================*/
/* Table : CATEGORIE                                            */
/*==============================================================*/
create table CATEGORIE
(
   ID_CATEGORIE         int not null,
   LIBELLE_CATEGORIE    varchar(50) not null,
   primary key (ID_CATEGORIE)
);

/*==============================================================*/
/* Table : CIVILITE                                             */
/*==============================================================*/
create table CIVILITE
(
   ID_CIVILITE          int not null,
   LIBELLE_CIVILITE     varchar(30) not null,
   primary key (ID_CIVILITE)
);

/*==============================================================*/
/* Table : COMMANDE                                             */
/*==============================================================*/
create table COMMANDE
(
   ID_COMMANDE          int not null,
   ID_UTILISATEUR       int not null,
   REFERENCE            varchar(50) not null,
   DATE_CREATION        date not null,
   primary key (ID_COMMANDE)
);

/*==============================================================*/
/* Table : DEPARTEMENT                                          */
/*==============================================================*/
create table DEPARTEMENT
(
   ID_DEP               int not null,
   LIBELLE_DEP          varchar(100) not null,
   primary key (ID_DEP)
);

/*==============================================================*/
/* Table : EVENEMENT                                            */
/*==============================================================*/
create table EVENEMENT
(
   ID_EVENEMENT         int not null,
   ID_CATEGORIE         int not null,
   LIBELLE_EVENEMENT    varchar(100) not null,
   DESCRIPTIF           text,
   PARUTION             date not null,
   AFFICHE              varchar(100),
   VIDEO                varchar(100),
   PERSONNAGE1          varchar(100),
   PERSONNAGE2          varchar(100),
   PERSONNAGE3          varchar(100),
   primary key (ID_EVENEMENT)
);

/*==============================================================*/
/* Table : LIGNE_COMMANDE                                       */
/*==============================================================*/
create table LIGNE_COMMANDE
(
   ID_LIGNE_COMMANDE    int not null,
   ID_COMMANDE          int not null,
   ID_TARIF             int not null,
   ID_OCCURENCE         int not null,
   QUANTITIE            int not null,
   primary key (ID_LIGNE_COMMANDE)
);

/*==============================================================*/
/* Table : OCCURENCE                                            */
/*==============================================================*/
create table OCCURENCE
(
   ID_OCCURENCE         int not null,
   ID_DEP               int not null,
   ID_EVENEMENT         int not null,
   DATE_                datetime,
   LIEU_                varchar(200) not null,
   NOMBRE_PLACES        int,
   DATE_FIN             date,
   primary key (ID_OCCURENCE)
);

/*==============================================================*/
/* Table : PREFERER                                             */
/*==============================================================*/
create table PREFERER
(
   ID_THEME             int not null,
   ID_UTILISATEUR       int not null,
   primary key (ID_THEME, ID_UTILISATEUR)
);

/*==============================================================*/
/* Table : QUALIFIER                                            */
/*==============================================================*/
create table QUALIFIER
(
   ID_EVENEMENT         int not null,
   ID_THEME             int not null,
   primary key (ID_EVENEMENT, ID_THEME)
);

/*==============================================================*/
/* Table : REDUCTION                                            */
/*==============================================================*/
create table REDUCTION
(
   ID_REDUCTION         int not null,
   LIBELLE_REDUCTION    varchar(50),
   POURCENTAGE          decimal not null,
   SEUIL                decimal not null,
   primary key (ID_REDUCTION)
);

/*==============================================================*/
/* Table : STATUT_UTILISATEUR                                   */
/*==============================================================*/
create table STATUT_UTILISATEUR
(
   ID_STATUT_UTILISATEUR int not null,
   LIBELLE_STATUT_UTILISATEUR varchar(50) not null,
   primary key (ID_STATUT_UTILISATEUR)
);

/*==============================================================*/
/* Table : TARIF                                                */
/*==============================================================*/
create table TARIF
(
   ID_TARIF             int not null,
   ID_OCCURENCE         int not null,
   LIBELLE_TARIF        varchar(50) not null,
   PRIX                 decimal not null,
   primary key (ID_TARIF)
);

/*==============================================================*/
/* Table : THEME                                                */
/*==============================================================*/
create table THEME
(
   ID_THEME             int not null,
   LIBELLE_THEME        varchar(50) not null,
   primary key (ID_THEME)
);

/*==============================================================*/
/* Table : UTILISATEUR                                          */
/*==============================================================*/
create table UTILISATEUR
(
   ID_UTILISATEUR       int not null,
   ID_REDUCTION         int,
   ID_STATUT_UTILISATEUR int not null,
   ID_CIVILITE          int,
   NOM                  varchar(50) not null,
   PRENOM_              varchar(50) not null,
   MAIL_                varchar(50) not null,
   MDP_                 varchar(50) not null,
   MOBILE_              varchar(50),
   NAISSANCE_           date,
   INSCRIPTION          date not null,
   primary key (ID_UTILISATEUR)
);

alter table ASSOCIER add constraint FK_ASSOCIER foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE) on delete restrict on update restrict;

alter table ASSOCIER add constraint FK_ASSOCIER2 foreign key (ID_THEME)
      references THEME (ID_THEME) on delete restrict on update restrict;

alter table COMMANDE add constraint FK_PASSER foreign key (ID_UTILISATEUR)
      references UTILISATEUR (ID_UTILISATEUR) on delete restrict on update restrict;

alter table EVENEMENT add constraint FK_CATEGORISER foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE) on delete restrict on update restrict;

alter table LIGNE_COMMANDE add constraint FK_CONCERNER foreign key (ID_OCCURENCE)
      references OCCURENCE (ID_OCCURENCE) on delete restrict on update restrict;

alter table LIGNE_COMMANDE add constraint FK_CONTENIR foreign key (ID_COMMANDE)
      references COMMANDE (ID_COMMANDE) on delete restrict on update restrict;

alter table LIGNE_COMMANDE add constraint FK_COUTER foreign key (ID_TARIF)
      references TARIF (ID_TARIF) on delete restrict on update restrict;

alter table OCCURENCE add constraint FK_AVOIR foreign key (ID_EVENEMENT)
      references EVENEMENT (ID_EVENEMENT) on delete restrict on update restrict;

alter table OCCURENCE add constraint FK_LOCALISER foreign key (ID_DEP)
      references DEPARTEMENT (ID_DEP) on delete restrict on update restrict;

alter table PREFERER add constraint FK_PREFERER foreign key (ID_THEME)
      references THEME (ID_THEME) on delete restrict on update restrict;

alter table PREFERER add constraint FK_PREFERER2 foreign key (ID_UTILISATEUR)
      references UTILISATEUR (ID_UTILISATEUR) on delete restrict on update restrict;

alter table QUALIFIER add constraint FK_QUALIFIER foreign key (ID_EVENEMENT)
      references EVENEMENT (ID_EVENEMENT) on delete restrict on update restrict;

alter table QUALIFIER add constraint FK_QUALIFIER2 foreign key (ID_THEME)
      references THEME (ID_THEME) on delete restrict on update restrict;

alter table TARIF add constraint FK_RESCENCER foreign key (ID_OCCURENCE)
      references OCCURENCE (ID_OCCURENCE) on delete restrict on update restrict;

alter table UTILISATEUR add constraint FK_BENEFICIER foreign key (ID_REDUCTION)
      references REDUCTION (ID_REDUCTION) on delete restrict on update restrict;

alter table UTILISATEUR add constraint FK_CARACTERISER foreign key (ID_CIVILITE)
      references CIVILITE (ID_CIVILITE) on delete restrict on update restrict;

alter table UTILISATEUR add constraint FK_POSSEDER foreign key (ID_STATUT_UTILISATEUR)
      references STATUT_UTILISATEUR (ID_STATUT_UTILISATEUR) on delete restrict on update restrict;
