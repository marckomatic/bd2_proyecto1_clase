CREATE TABLE REGION(
    id_region          INTEGER         NOT NULL,
    name_r             VARCHAR2(300)   NOT NULL,
   
    
    CONSTRAINT region_pk PRIMARY KEY(id_region)
);

CREATE TABLE POKEMON_SPECIE(
    id_especie        INTEGER         NOT NULL,
    name_specie       VARCHAR2(300)   NOT NULL,
    genus             VARCHAR(2000)   NULL,
    id_preevo         INTEGER         NULL,


    CONSTRAINT specie_pk PRIMARY KEY(id_especie),
    CONSTRAINT Pokemonpreevo_fk FOREIGN KEY (id_preevo) REFERENCES POKEMON_SPECIE(id_especie) on delete cascade

);


CREATE TABLE STATS(
    id_stat            INTEGER         NOT NULL,
    name_stats         VARCHAR2(100)   NULL,
    is_battle_only     CHAR(1)         NULL,
   

    CONSTRAINT stats_pk PRIMARY KEY(id_stat)
);


CREATE TABLE DAMAGE_CLASS(
    id_damage_class          INTEGER         NOT NULL,
    name_damage_class        VARCHAR2(100)   NOT NULL,

    CONSTRAINT damage_class_pk PRIMARY KEY(id_damage_class)
);

CREATE TABLE MOVE_EFFECT(
    id_move_effect          INTEGER          NOT NULL,
    effect                  VARCHAR2(500)          NOT NULL,

    CONSTRAINT move_effect_pk PRIMARY KEY(id_move_effect)
);

CREATE TABLE MOVE_METHOD(
    id_move_method                     INTEGER          NOT NULL,
    name_move_method                   VARCHAR2(2000)   NOT NULL,

    CONSTRAINT move_method_pk PRIMARY KEY(id_move_method)
);

--  ---------------------

CREATE TABLE TYPEMOVE(
    id_type             INTEGER         NOT NULL,
    name_type           VARCHAR2(250)   NOT NULL,
    generation          INTEGER         NOT NULL,
    region              INTEGER         NULL,

    CONSTRAINT type_pk PRIMARY KEY(id_type),
    CONSTRAINT type_region_fk FOREIGN KEY (region) REFERENCES REGION(id_region) on delete cascade
    
);

CREATE TABLE TYPE_EFFICACY(
    damage_factor       INTEGER         NOT NULL,
    damage_type         INTEGER         NOT NULL,
    target_type         INTEGER         NOT NULL,

    CONSTRAINT type_efficacy_pk PRIMARY KEY(damage_type,target_type),
    CONSTRAINT damage_type_fk FOREIGN KEY (damage_type) REFERENCES TYPEMOVE(id_type) on delete cascade,
    CONSTRAINT target_type_fk FOREIGN KEY (target_type) REFERENCES TYPEMOVE(id_type) on delete cascade
);
-- ----------------------------------
CREATE TABLE MOVEP(
    id_move               INTEGER         NOT NULL,
    name_move             VARCHAR2(500)   NOT NULL,
    priority_move         INTEGER         NOT NULL,
    power_move            INTEGER         NULL, 
    pp                    INTEGER         NULL,
    accuracy              INTEGER         NULL,
    effect_chance         INTEGER         NULL,
    type_move             INTEGER         NOT NULL,
    region                INTEGER         NOT NULL,
    damage_class          INTEGER         NOT NULL,
    move_effect           INTEGER         NOT NULL,

    CONSTRAINT move_pk PRIMARY KEY(id_move),
    CONSTRAINT move_type_fk FOREIGN KEY (type_move) REFERENCES TYPEMOVE(id_type) on delete cascade,
    CONSTRAINT move_region_fk FOREIGN KEY (region) REFERENCES REGION(id_region) on delete cascade,
    CONSTRAINT move_damage_fk FOREIGN KEY (damage_class) REFERENCES DAMAGE_CLASS(id_damage_class) on delete cascade,
    CONSTRAINT move_effect_fk FOREIGN KEY (move_effect) REFERENCES MOVE_EFFECT(id_move_effect) on delete cascade
);


CREATE TABLE LOCATION_P(
    id_location         INTEGER         NOT NULL,
    region              INTEGER         NULL,
    name_l              VARCHAR2(300)   NOT NULL,

    CONSTRAINT location_pk PRIMARY KEY(id_location),
    CONSTRAINT location_fk FOREIGN KEY (region) REFERENCES REGION(id_region) on delete cascade
    
);

CREATE TABLE ABILITY(
    id_ability          INTEGER         NOT NULL,
    name_a              VARCHAR2(300)   NOT NULL,
    region              INTEGER         NULL,

    CONSTRAINT ability_pk PRIMARY KEY(id_ability),
    CONSTRAINT ability_fk FOREIGN KEY (region) REFERENCES REGION(id_region) on delete cascade
    
);


CREATE TABLE POKEMON(
    id_pokemon          INTEGER         NOT NULL,
    name_p              VARCHAR2(300)   NOT NULL,
    height_p            INTEGER         NOT NULL,
    weight_p            INTEGER         NOT NULL,
    base_exp            INTEGER         NOT NULL,
    order_p             INTEGER         NOT NULL,
    specie              INTEGER         NULL,
    
    
    CONSTRAINT pokemon_pk PRIMARY KEY(id_pokemon),
    CONSTRAINT Pokemonspecie_fk FOREIGN KEY (specie) REFERENCES POKEMON_SPECIE(id_especie) on delete cascade
    
);



CREATE TABLE POKEMON_LOCATION(
    min_level         INTEGER         NULL,
    max_level         INTEGER         NULL,
    location_p        INTEGER         NOT NULL,
    pokemon           INTEGER         NOT NULL,

    CONSTRAINT poke_location_pk PRIMARY KEY(location_p,pokemon),
    CONSTRAINT poke_locl_fk FOREIGN KEY (location_p) REFERENCES LOCATION_P(id_location) on delete cascade,
    CONSTRAINT poke_locp_fk FOREIGN KEY (pokemon) REFERENCES POKEMON(id_pokemon) on delete cascade
);

CREATE TABLE POKEMON_ABILITY(
    is_hidden         CHAR(1)         NULL,
    pokemon           INTEGER         NOT NULL,
    ability           INTEGER         NOT NULL,

    CONSTRAINT pokemon_ability_pk PRIMARY KEY(pokemon, ability),
    CONSTRAINT poke_abilityA_fk FOREIGN KEY (ability) REFERENCES ABILITY(id_ability) on delete cascade,
    CONSTRAINT poke_abilityP_fk FOREIGN KEY (pokemon) REFERENCES POKEMON(id_pokemon) on delete cascade
);



CREATE TABLE POKEMON_STATS(
    base_stat        INTEGER        NOT NULL,
    effort           CHAR(1)        NOT NULL,
    pokemon          INTEGER        NOT NULL,
    stats            INTEGER        NOT NULL,

    CONSTRAINT pokemon_stats_pk PRIMARY KEY(pokemon, stats),
    CONSTRAINT poke_statsS_fk FOREIGN KEY (stats) REFERENCES STATS(id_stat) on delete cascade,
    CONSTRAINT poke_statsP_fk FOREIGN KEY (pokemon) REFERENCES POKEMON(id_pokemon) on delete cascade
);


CREATE TABLE POKEMON_MOVE(
    level_move       INTEGER        NOT NULL,
    region           INTEGER        NULL,
    move_pokemon     INTEGER        NOT NULL,
    method_move      INTEGER        NOT NULL,
    pokemon          INTEGER        NOT NULL,
    

    CONSTRAINT poke_move_pk PRIMARY KEY(region, move_pokemon, method_move,pokemon),
    CONSTRAINT poke_move_region_fk FOREIGN KEY (region) REFERENCES REGION(id_region) on delete cascade,
    CONSTRAINT poke_move_fk FOREIGN KEY (move_pokemon) REFERENCES MOVEP(id_move) on delete cascade,
    CONSTRAINT poke_move_method_fk FOREIGN KEY (method_move) REFERENCES MOVE_METHOD(id_move_method) on delete cascade,
    CONSTRAINT poke_move_pokemon_fk FOREIGN KEY (pokemon) REFERENCES POKEMON(id_pokemon) on delete cascade
);
